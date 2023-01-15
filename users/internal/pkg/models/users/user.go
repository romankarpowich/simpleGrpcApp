package users

import (
	"github.com/google/uuid"
	"github.com/romankarpowich/simpleGrpcApp/users/internal/pkg/helpers"
	groups2 "github.com/romankarpowich/simpleGrpcApp/users/internal/pkg/models/groups"
	"github.com/romankarpowich/simpleGrpcApp/users/pkg/api/users"
	"gopkg.in/guregu/null.v4/zero"
	"time"
)

type User struct {
	ID        uuid.UUID      `db:"id" json:"id"`
	Name      zero.String    `db:"name" json:"name"`
	GroupID   zero.String    `db:"group_id" json:"group_id"`
	Type      users.UserType `db:"type" json:"type"`
	CreatedAt time.Time      `db:"created_at" json:"created_at"`
	UpdatedAt zero.Time      `db:"updated_at" json:"updated_at"`
	DeletedAt zero.Time      `db:"deleted_at" json:"deleted_at"`

	Group *groups2.Group `db:"-" json:"group"`
}

func (u *User) ConvertToProto() *users.User {
	if u == nil {
		return nil
	}
	return &users.User{
		Id:        u.ID.String(),
		Name:      u.Name.Ptr(),
		GroupId:   u.GroupID.Ptr(),
		Type:      u.Type,
		CreatedAt: helpers.TimestamppbPtrTime(u.CreatedAt),
		UpdatedAt: helpers.TimestamppbPtrFromZeroTime(u.UpdatedAt),
		DeletedAt: helpers.TimestamppbPtrFromZeroTime(u.DeletedAt),
		Group:     u.Group.ConvertToProto(),
	}
}
