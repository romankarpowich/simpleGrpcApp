package groups

import (
	"context"
	"github.com/google/uuid"
	"gopkg.in/guregu/null.v4/zero"

	groups2 "github.com/simpleGrpcApp/users/pkg/api/groups"
)

func (i *Implementation) List(ctx context.Context, request *groups2.ListRequest) (*groups2.ListResponse, error) {
	return &groups2.ListResponse{
		Items: []*groups2.Group{
			{
				Id:   uuid.NewString(),
				Name: zero.StringFrom("group 1").Ptr(),
			},
		},
		Total: 1,
	}, nil
}
