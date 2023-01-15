package store

import (
	"context"
	"github.com/Masterminds/squirrel"
	groups2 "github.com/simpleGrpcApp/users/internal/pkg/models/groups"
)

func (s *Store) ListGroups(ctx context.Context) ([]*groups2.Group, error) {
	sq := squirrel.StatementBuilder.PlaceholderFormat(squirrel.Dollar)
	var groups []*groups2.Group
	if err := sq.Select("*").From("groups").RunWith(s.Db).QueryRow().Scan(&groups); err != nil {
		return nil, handleError(err, true)
	}
	return groups, nil
}
