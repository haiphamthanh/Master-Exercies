from pystiche import enc, loss, ops

multi_layer_encoder = enc.vgg19_multi_layer_encoder()

criterion = loss.PerceptualLoss(
    content_loss=ops.FeatureReconstructionOperator(
        multi_layer_encoder.extract_encoder("relu4_2")
    ),
    style_loss=ops.MultiLayerEncodingOperator(
        multi_layer_encoder,
        ("relu1_1", "relu2_1", "relu3_1", "relu4_1", "relu5_1"),
        lambda encoder, layer_weight: ops.GramOperator(
            encoder, score_weight=layer_weight
        ),
        score_weight=1e3,
    ),
)
