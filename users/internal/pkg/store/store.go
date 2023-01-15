package store

import (
	"database/sql"
	"errors"
	"fmt"
	_ "github.com/lib/pq"
)

const (
	dbDsn = "host=localhost port=5432 dbname=users sslmode=disable"
)

type Store struct {
	Db *sql.DB
}

//NewStore .
func NewStore() (*Store, error) {
	db, err := sql.Open("postgres", dbDsn)
	if err != nil {
		return nil, fmt.Errorf("sql.Open: %w", err)
	}
	if err := db.Ping(); err != nil {
		return nil, fmt.Errorf("ping: %w", err)
	}
	return &Store{Db: db}, nil
}

func handleError(err error, isSlice bool) error {
	if errors.Is(err, sql.ErrNoRows) && isSlice {
		return nil
	}
	return err
}
