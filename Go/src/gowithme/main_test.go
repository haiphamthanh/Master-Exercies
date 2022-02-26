import (
	"encoding/json"
	"net/http"
)

/*
// Cover testing -v -cover
package main

import (
	"testing"
	"time"
)

// Unit-testing
func TestDecode(t *testing.T) {
	// Load file
	post, err := decode("post.json")
	if err != nil {
		t.Error(err)
	}

	// Check result
	// Test case 1: Test Id
	if post.Id != 1 {
		t.Error("Wrong id, was expecting 1 but got ", post.Id)
	}

	// Test case 2: Test Content
	if post.Content != "Hello world" {
		t.Error("Wrong content, was expecting 'Hello world' but got ", post.Content)
	}
}

func TestEncode(t *testing.T) {
	t.Skip("Skipping encoding for now")
}

// Skip long running -short(skip long running)
func TestLongRunningTest(t *testing.T) {
	if testing.Short() {
		t.Skip("Skipping long-running test in short mode")
	}
	time.Sleep(10 * time.Second)
}

// Parallel testing -parallel
func TestParallel_1(t *testing.T) {
	t.Parallel()
	time.Sleep(1 * time.Second)
}

func TestParallel_2(t *testing.T) {
	t.Parallel()
	time.Sleep(2 * time.Second)
}

func TestParallel_3(t *testing.T) {
	t.Parallel()
	time.Sleep(3 * time.Second)
}

// Benchmark testing -bench .
func BenchmarkDecode(b *testing.B) {
	for i := 0; i < b.N; i++ {
		decode("post.json")
	}
}

func BenchmarkUnmarshal(b *testing.B) {
	for i := 0; i < b.N; i++ {
		unmarshal("post.json")
	}
}
*/

// HTTP Testing


// Main function
var mux *http.ServerMux
var writer *http.ResponseRecoder
func TestMain() {
	setUp()
	code := m.Run()
	os.Exit(code)	
}

func setUp() {
	mux = http.NewServeMux()
	mux.handlerFunc("/post/", handleRequest)
	writer.httptest.NewRecoder()
}

// List unit-functions
func TestHandleGet(t *tesing.T) {
	// Create a multiplexer
	mux := http.NewServeMux()

	// Attachs handler
	mux.HandleFunc("/post/", handleRequest)

	// Create captures
	writer.NewRecorder()

	// Create tested requests
	request, _ = http.NewRequest("GET", "/post/1", nil)

	// Sends to tested handler
	mux.ServeHTTP(writer, request)

	// Check response
	if writer.Code != 200 {
		t.Error("Response code is %v", w
		riter.Code)
	}

	//Unmarshal data
	var post post
	json.Unmarshal(writer, Body.bytes(), &post) {
		if post.Id != 1 {
			t.Error("Can not retrive JSON post")
		}
	}
}
