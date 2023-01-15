package users

import (
	"github.com/romankarpowich/simpleGrpcApp/users/internal/pkg/store"
	"github.com/romankarpowich/simpleGrpcApp/users/pkg/api/users"
	"google.golang.org/grpc"
)

// Implementation implement users interface
type Implementation struct {
	users.UnimplementedUsersServer

	storage *store.Store
}

func (i *Implementation) Register(server *grpc.Server) {
	users.RegisterUsersServer(server, i)
}

// NewUsers return new Implementation instance
func NewUsers(storage *store.Store) *Implementation {
	return &Implementation{storage: storage}
}
