-- +goose Up
-- +goose StatementBegin
CREATE TABLE groups
(
    id         UUID PRIMARY KEY   DEFAULT uuid_generate_v4(),
    name       TEXT               DEFAULT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT (now() at time zone 'utc'),
    updated_at TIMESTAMP          DEFAULT NULL,
    deleted_at TIMESTAMP          DEFAULT NULL
);

ALTER TABLE users
    ADD CONSTRAINT fk_users_groups FOREIGN KEY (group_id) REFERENCES groups(id);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
SELECT 'down SQL query';
-- +goose StatementEnd
