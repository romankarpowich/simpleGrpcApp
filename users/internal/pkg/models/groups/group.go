package groups

import (
	"github.com/google/uuid"
	"github.com/simpleGrpcApp/users/internal/pkg/helpers"
	"github.com/simpleGrpcApp/users/pkg/api/groups"
	"gopkg.in/guregu/null.v4/zero"
	"time"
)

type Group struct {
	ID        uuid.UUID   `db:"id" json:"id"`
	Name      zero.String `db:"name" json:"name"`
	CreatedAt time.Time   `db:"created_at" json:"created_at"`
	UpdatedAt zero.Time   `db:"updated_at" json:"updated_at"`
	DeletedAt zero.Time   `db:"deleted_at" json:"deleted_at"`
}

func (g *Group) ConvertToProto() *groups.Group {
	if g == nil {
		return nil
	}
	return &groups.Group{
		Id:        g.ID.String(),
		Name:      g.Name.Ptr(),
		CreatedAt: helpers.TimestamppbPtrTime(g.CreatedAt),
		UpdatedAt: helpers.TimestamppbPtrFromZeroTime(g.UpdatedAt),
		DeletedAt: helpers.TimestamppbPtrFromZeroTime(g.DeletedAt),
	}
}
