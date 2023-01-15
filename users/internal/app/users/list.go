package users

import (
	"context"
	"github.com/google/uuid"
	"github.com/simpleGrpcApp/users/pkg/api/groups"
	"github.com/simpleGrpcApp/users/pkg/api/users"
	"gopkg.in/guregu/null.v4/zero"
)

func (i *Implementation) List(ctx context.Context, request *users.ListRequest) (*users.ListResponse, error) {
	return &users.ListResponse{
		Items: []*users.User{
			{
				Id:      uuid.NewString(),
				Name:    zero.StringFrom("admin").Ptr(),
				GroupId: zero.StringFrom(uuid.NewString()).Ptr(),
				Type:    users.UserType_ADMIN,
				Group: &groups.Group{
					Id: uuid.NewString(),
				},
			},
		},
		Total: 1,
	}, nil
}
