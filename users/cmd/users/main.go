package main

import (
	"fmt"
	app2 "github.com/simpleGrpcApp/users/internal/app"
	groups2 "github.com/simpleGrpcApp/users/internal/app/groups"
	users2 "github.com/simpleGrpcApp/users/internal/app/users"
	"github.com/simpleGrpcApp/users/internal/pkg/store"
	"google.golang.org/grpc"
	"google.golang.org/grpc/reflection"
	"log"
	"net"
)

func main() {
	lis, err := net.Listen("tcp", fmt.Sprintf("localhost:%d", 8000))
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}

	storage, err := store.NewStore()
	if err != nil {
		log.Fatalf("store.NewStore: %w")
	}
	defer func() {
		if err := storage.Db.Close(); err != nil {
			log.Fatalf("storege.Db.Close: %v", err)
		}
	}()

	app := grpc.NewServer()
	reflection.Register(app)

	api := []app2.RegisterServer{
		users2.NewUsers(storage),
		groups2.NewGroups(storage),
	}
	for _, v := range api {
		v.Register(app)
	}
	if err := app.Serve(lis); err != nil {
		log.Fatalf("failed to Serve app: %v", err)
	}

}
