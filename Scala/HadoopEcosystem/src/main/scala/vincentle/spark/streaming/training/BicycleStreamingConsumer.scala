package vincentle.spark.streaming.training

import com.google.gson.Gson
import com.mongodb.spark.MongoSpark
import org.apache.kafka.clients.producer.{KafkaProducer, ProducerRecord}
import vincentle.utils.SparkCommon
import org.apache.spark.sql.{SQLContext, SaveMode}
import org.apache.spark.streaming.kafka010.ConsumerStrategies.Subscribe
import org.apache.spark.streaming.kafka010.KafkaUtils
import org.apache.spark.streaming.kafka010.LocationStrategies.PreferConsistent
import org.apache.spark.streaming.{Seconds, StreamingContext}

import java.text.SimpleDateFormat
import java.util.{Calendar, Properties, UUID}


/**
 * Created by vincent on 1/16/2017.
 */
object BicycleStreamingConsumer {
  case class BikeAggreration(bike_name: String, total: Int, date_time: String)

  var brokers = ""
  var inTopic = ""

  def main(args: Array[String]): Unit = {
    //Get the Kafka broker node
    brokers = util.Try(args(0)).getOrElse("localhost:9092")

    //Get the topic for consumer
    val outTopic = util.Try(args(1)).getOrElse("bike-data")

    //Get the topic for producer
    inTopic = util.Try(args(2)).getOrElse("bike-data-visualization")

    val batchDuration = util.Try(args(3)).getOrElse("30").toInt //in second


    //Create streaming context from Spark
    val streamCtx = new StreamingContext(SparkCommon.conf, Seconds(batchDuration))

    //Create Direct Kafka Streaming for Consumer
    val outTopicSet = Set(outTopic)
    val kafkaParams = Map[String, String](
      "bootstrap.servers" -> brokers,
      "key.deserializer" -> "org.apache.kafka.common.serialization.StringDeserializer",
      "value.deserializer" -> "org.apache.kafka.common.serialization.StringDeserializer"
    )

    val msg = KafkaUtils.createDirectStream[String, String](
      streamCtx,
      PreferConsistent,
      Subscribe[String, String](outTopicSet, kafkaParams)
    )

    /*----Code for process received data here---*/
    val values = msg.map(record => (record.key, record.value))
    val bicycles = values.map(x => x._2.split(",")(1))

    //Calculate the total bicycle brand name
    val bicyclesDStream = bicycles.map(bike => Tuple2(bike, 1))
    val aggregatedBicycles = bicyclesDStream.reduceByKey(_+_)

    //Print received data or data transformed from the received data
    aggregatedBicycles.print()

    //Retrieve each RDD and transform to create DataFrame with the schema is BikeAggreration class
    aggregatedBicycles.foreachRDD( rdd => {

      val today = Calendar.getInstance.getTime
      val formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")

      //Mapping the RDD in the stream to new RDD with BikeAggreration class and convert to DataFrame
      val data = rdd.map(
        x => BikeAggreration(x._1, x._2, formatter.format(today))
      )

      //Insert data back to Kafka
      data.foreachPartition(pushBikeInfoInKafka)
    })

    /*----Code for process received data here---*/
    //Start the stream
    streamCtx.start()
    streamCtx.awaitTermination()
  }

  def pushBikeInfoInKafka(items: Iterator[BikeAggreration]): Unit = {

    //Create some properties
    val props = new Properties()
    props.put("bootstrap.servers", brokers)
    props.put("client.id", UUID.randomUUID().toString())
    props.put("key.serializer", "org.apache.kafka.common.serialization.StringSerializer")
    props.put("value.serializer", "org.apache.kafka.common.serialization.StringSerializer")


    val producer = new KafkaProducer[String, String](props)

    items.foreach( obj => {
      val key = UUID.randomUUID().toString().split("-")(0)
      val gson = new Gson()
      val value = gson.toJson(obj)

      val data = new ProducerRecord[String, String](inTopic, key, value)

      println("--- topic: " + inTopic + " ---")
      println("key: " + data.key())
      println("value: " + data.value() + "\n")

      producer.send(data)

    })
    producer.close()
  }
}