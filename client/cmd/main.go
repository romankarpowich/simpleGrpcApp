package main

import (
	"github.com/simpleGrpcApp/client/internal/app/client"
	"net/http"
)

func main() {
	i := &client.Implementation{}

	http.HandleFunc("/", i.ListUsers)
}
