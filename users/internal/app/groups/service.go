package groups

import (
	"github.com/simpleGrpcApp/users/pkg/api/groups"
	"google.golang.org/grpc"
)

// Implementation implement groups interface
type Implementation struct {
	groups.UnimplementedGroupsServer
}

func (i *Implementation) Register(server *grpc.Server) {
	groups.RegisterGroupsServer(server, i)
}

// NewGroups return new Implementation instance
func NewGroups() *Implementation {
	return &Implementation{}
}
