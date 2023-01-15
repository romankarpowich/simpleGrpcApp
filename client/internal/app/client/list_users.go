package client

import (
	"encoding/json"
	users2 "github.com/romankarpowich/simpleGrpcApp/client/internal/pb/github.com/romankarpowich/simpleGrpcApp/users/pkg/api/users"
	"net/http"
)

func (i *Implementation) ListUsers(w http.ResponseWriter, r *http.Request) {
	users, err := i.usersClient.List(r.Context(), &users2.ListRequest{})
	w.Header().Set("Content-Type", "application/json")
	if err != nil {
		w.WriteHeader(http.StatusInternalServerError)
	} else {
		w.WriteHeader(http.StatusOK)
		json.NewEncoder(w).Encode(&users.Items)
	}
}
