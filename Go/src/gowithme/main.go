package main

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"os"
	"net/http"
	"path"
)

type Post struct {
	Id      int       `json:"id"`
	Content string    `json:"content"`
	Author  Author    `json:"author"`
	Comment []Comment `json:"comments"`
}

type Author struct {
	Id   int    `json:"id"`
	Name string `json:"name"`
}

type Comment struct {
	Id      int    `json:"id"`
	Content string `json:"content"`
	Author  string `json:"author"`
}

func decode(filename string) (post Post, err error) {
	// Open file
	file, err := os.Open(filename)
	if err != nil {
		fmt.Println("Error opening JSON file: ", err)
		return
	}
	defer file.Close()

	// Create decoder
	decoder := json.NewDecoder(file)

	// Use decoder to write data to post item
	err = decoder.Decode(&post)
	if err != nil {
		fmt.Println("Error decoding Json: ", err)
		return
	}
	return
}

func unmarshal(filename string) (post Post, err error) {
	// Open file
	file, err := os.Open(filename)
	if err != nil {
		fmt.Println("Error opening JSON file: ", err)
		return
	}
	defer file.Close()

	// Read file
	jsonData, err := ioutil.ReadAll(file)
	if err != nil {
		fmt.Println("Error reading JSON file: ", err)
		return
	}

	// Unmarshal file to variable
	json.Unmarshal(jsonData, &post)
	return
}

// Handle all request
func handleRequest(w http.ResponseWriter, r *http.Request) {
	var err error
	switch r.Method {
	case "GET":
		err = handleGet(w, r)
	case "POST":
		err = handlePost(w, r)
	case "PUT":
		err = handlePut(w, r)
	case "DELETE":
		err = handleDelete(w, r)
	}

	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
}

// List unit-functions
func handleGet(w http.ResponseWriter, r *http.Request) (err error) {
	id, err := strconv.Atoi(path.Base(r.URL.Path))
	if err != nil {
		return
	}

	post, err := retrieve(id)
	if err != nil {
		return
	}

	output, err := json.MarshalIndent(&post, "", "\t\t")
	if err != nil {
		return
	}

	w.Header().Set("Content-Type", "application/json")
	w.Write(output)
	return
}

func handlePost(w http.ResponseWriter, r *http.Request) (err error) {
	return
}

func handlePut(w http.ResponseWriter, r *http.Request) (err error) {
	return
}

func handleDelete(w http.ResponseWriter, r *http.Request) (err error) {
	return
}

// Main function
var mux *http.ServerMux
var writer *http.ResponseRecoder
func main() {
	_, err := decode("post.json")
	if err != nil {
		fmt.Println("Error: ", err)
	}
}