package users

import (
	"context"
	"github.com/google/uuid"
	"github.com/simpleGrpcApp/users/internal/pkg/models"
	groups2 "github.com/simpleGrpcApp/users/internal/pkg/models/groups"
	users2 "github.com/simpleGrpcApp/users/internal/pkg/models/users"
	"github.com/simpleGrpcApp/users/pkg/api/users"
	"gopkg.in/guregu/null.v4/zero"
)

func (i *Implementation) List(ctx context.Context, request *users.ListRequest) (*users.ListResponse, error) {
	return &users.ListResponse{
		Items: models.ConvertToSliceOfProto[*users2.User, *users.User]([]*users2.User{
			{
				ID:      uuid.New(),
				Name:    zero.StringFrom("admin"),
				GroupID: zero.StringFrom(uuid.NewString()),
				Type:    users.UserType_ADMIN,
				Group: &groups2.Group{
					ID: uuid.New(),
				},
			},
		}),
		Total: 1,
	}, nil
}
