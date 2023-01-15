LOCAL_DB_HOST:=localhost
LOCAL_DB_NAME:=users
LOCAL_DB_DSN:="host=$(LOCAL_DB_HOST) dbname=$(LOCAL_DB_NAME) sslmode=disable"
CUR_DIR:=$(shell pwd)
LOCAL_BIN:=$(CUR_DIR)/bin

bin-deps:
	GOBIN=$(LOCAL_BIN) go install github.com/pressly/goose/v3/cmd/goose@latest && \
  	GOBIN=$(LOCAL_BIN) go install github.com/golang/mock/mockgen@v1.6.0

generate:
	protoc --go_out=pkg/api --go_opt=paths=source_relative \
               --go-grpc_out=pkg/api --go-grpc_opt=paths=source_relative \
               --proto_path=api/ \
               api/users/users.proto api/groups/groups.proto

schema:
	pg_dump -d ron_development --schema-only --no-owner --no-privileges --no-tablespaces --no-security-labels > schema.sql

db:
	psql -c "drop database if exists $(LOCAL_DB_NAME)"
	createdb $(LOCAL_DB_NAME)
	$(LOCAL_BIN)/goose -allow-missing -dir migrations postgres $(LOCAL_DB_DSN) up
	make schema

create-migration:
	@(printf "Enter name for migration: "; read arg; $(LOCAL_BIN)/goose -dir migrations create $$arg sql)
