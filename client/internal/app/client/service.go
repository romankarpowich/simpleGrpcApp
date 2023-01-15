package client

import "github.com/romankarpowich/simpleGrpcApp/client/internal/pb/github.com/romankarpowich/simpleGrpcApp/users/pkg/api/users"

type Implementation struct {
	usersClient users.UsersClient
}

func NewClient(client users.UsersClient) *Implementation {
	return &Implementation{usersClient: client}
}
