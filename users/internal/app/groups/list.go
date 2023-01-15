package groups

import (
	"context"
	"github.com/google/uuid"
	"github.com/simpleGrpcApp/users/pkg/api/groups"
	"gopkg.in/guregu/null.v4/zero"
)

func (i *Implementation) List(ctx context.Context, request *groups.ListRequest) (*groups.ListResponse, error) {
	return &groups.ListResponse{
		Items: []*groups.Group{
			{
				Id:   uuid.NewString(),
				Name: zero.StringFrom("group 1").Ptr(),
			},
		},
		Total: 1,
	}, nil
}
