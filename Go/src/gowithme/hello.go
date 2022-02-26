/*
// To install the driver: Go get "<path>"

package main

import (
	"encoding/json"
	"net/http"
	"path"
	"strconv"
)

type Post struct {
	Id      int    `json: "id"`
	Content string `json:"content"`
	Author  string `json:"author"`
}

func main() {
	server := http.Server{
		Addr: "127.0.0.1:8080",
	}

	http.HandleFunc("/post/", handleRequest)
	server.ListenAndServe()
}

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

func handleGet(w http.ResponseWriter, r *http.Request) (err error) {
	// Get id
	id, err := strconv.Atoi(path.Base(r.URL.Path))
	if err != nil {
		return
	}

	// Retrieve post by id
	post, err := retrieve(id)
	if err != nil {
		return
	}

	// Marshal data
	output, err := json.MarshalIndent(&post, "", "\t\t")
	if err != nil {
		return
	}

	// Set content-type
	w.Header().Set("Content-Type", "application/json")

	// Write output
	w.Write(output)
	return
}

func handlePost(w http.ResponseWriter, r *http.Request) (err error) {
	// Get len body
	len := r.ContentLength
	body := make([]byte, len)

	// Get body with length
	r.Body.Read(body)

	// Unmarshal data
	var post Post
	json.Unmarshal(body, &post)
	err = post.create()
	if err != nil {
		return
	}

	w.WriteHeader(200)
	return
}

func handlePut(w http.ResponseWriter, r *http.Request) (err error) {
	// Retrieve item from id
	id, err := strconv.Atoi(path.Base(r.URL.Path))
	if err != nil {
		return
	}

	post, err := retrieve(id)
	if err != nil {
		return
	}

	// Get data to update
	len := r.ContentLength
	body := make([]byte, len)
	r.Body.Read(body)
	json.Unmarshal(body, &post)

	// Update
	post.update()
	if err != nil {
		return
	}

	w.WriteHeader(200)
	return
}

func handleDelete(w http.ResponseWriter, r *http.Request) (err error) {
	// Retrieve item by id
	id, err := strconv.Atoi(path.Base(r.URL.Path))
	if err != nil {
		return
	}

	post, err := retrieve(id)
	if err != nil {
		return
	}

	// Delete item
	err = post.delete()
	if err != nil {
		return
	}

	w.WriteHeader(200)
	return
}
*/