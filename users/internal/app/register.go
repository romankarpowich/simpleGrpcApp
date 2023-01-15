package app

import "google.golang.org/grpc"

type RegisterServer interface {
	Register(server *grpc.Server)
}
