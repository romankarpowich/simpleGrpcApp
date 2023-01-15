package groups

import (
	"github.com/simpleGrpcApp/users/internal/pkg/store"
	"github.com/simpleGrpcApp/users/pkg/api/groups"
	"google.golang.org/grpc"
)

// Implementation implement groups interface
type Implementation struct {
	groups.UnimplementedGroupsServer

	storage *store.Store
}

func (i *Implementation) Register(server *grpc.Server) {
	groups.RegisterGroupsServer(server, i)
}

// NewGroups return new Implementation instance
func NewGroups(storage *store.Store) *Implementation {
	return &Implementation{storage: storage}
}
