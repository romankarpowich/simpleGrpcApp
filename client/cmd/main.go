package main

import (
	"fmt"
	client2 "github.com/romankarpowich/simpleGrpcApp/client/internal/app/client"
	"github.com/romankarpowich/simpleGrpcApp/client/internal/pb/github.com/romankarpowich/simpleGrpcApp/users/pkg/api/users"
	"google.golang.org/grpc"
	"google.golang.org/grpc/credentials/insecure"
	"log"
	"net/http"
)

func main() {
	opts := []grpc.DialOption{
		grpc.WithTransportCredentials(insecure.NewCredentials()),
	}
	conn, err := getDial(opts...)
	if err != nil {
		log.Fatal(err)
	}
	client := client2.NewClient(users.NewUsersClient(conn))
	http.HandleFunc("/", client.ListUsers)
	if err := http.ListenAndServe("localhost:50051", nil); err != nil {
		panic(err)
	}
}

func getDial(opts ...grpc.DialOption) (*grpc.ClientConn, error) {
	dial, err := grpc.Dial("localhost:8000", opts...)
	if err != nil {
		return nil, fmt.Errorf("grpc.Dial: %w", err)
	}
	return dial, nil
}
