-- +goose Up
-- +goose StatementBegin
CREATE TABLE users
(
    id         UUID PRIMARY KEY   DEFAULT uuid_generate_v4(),
    name       TEXT               DEFAULT NULL,
    group_id   UUID               DEFAULT NULL,
    type       INT                DEFAULT 0,
    created_at TIMESTAMP NOT NULL DEFAULT (now() at time zone 'utc'),
    updated_at TIMESTAMP          DEFAULT NULL,
    deleted_at TIMESTAMP          DEFAULT NULL
);

CREATE TRIGGER update_users_updated_at
    BEFORE UPDATE
    ON users
    FOR EACH ROW
EXECUTE PROCEDURE set_updated_at_column();

CREATE INDEX ix_users_on_id ON users using btree (id);
CREATE INDEX ix_users_on_type ON users using btree (type);
CREATE INDEX ix_users_on_name ON users using btree (name);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP INDEX ix_users_on_name;
DROP INDEX ix_users_on_type;
DROP INDEX ix_users_on_id;

DROP TRIGGER update_users_updated_at on users;

DROP TABLE users;
-- +goose StatementEnd
