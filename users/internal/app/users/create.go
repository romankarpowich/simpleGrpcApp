package users

import (
	"context"
	"github.com/simpleGrpcApp/users/pkg/api/users"
)

func (i *Implementation) Create(ctx context.Context, request *users.CreateRequest) (*users.CreateResponse, error) {
	return nil, nil
}
