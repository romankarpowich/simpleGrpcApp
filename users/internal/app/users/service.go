package users

import (
	"github.com/simpleGrpcApp/users/pkg/api/users"
	"google.golang.org/grpc"
)

// Implementation implement users interface
type Implementation struct {
	users.UnimplementedUsersServer
}

func (i *Implementation) Register(server *grpc.Server) {
	users.RegisterUsersServer(server, i)
}

// NewUsers return new Implementation instance
func NewUsers() *Implementation {
	return &Implementation{}
}
