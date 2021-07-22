package entity

import (
	"context"

	"github.com/mqnoy/cookingman/ent"
)

// User is the user that holds all value of users.
type User struct {
	ID       string
	Username string
	Password string
	Email    string
}

// UserInput is the input that holds all value of user input.
type UserInput struct {
	ID       string
	Username string
	Password string
	Email    string
}

// UserUsecase is the interface that wraps the user usecase method.
type UserUsecase interface {
	Registration(ctx context.Context, input UserInput) (*User, error)
	Login(ctx context.Context, username, password string) (*User, error)
	AllUser(ctx context.Context) ([]*User, error)
}

// UserRepository is the interface that wraps the user repository method.
type UserRepository interface {
	Create(ctx context.Context, input UserInput) (*ent.User, error)
	Fetch(ctx context.Context) ([]*ent.User, error)
	GetByUsername(ctx context.Context, username string) (*ent.User, error)
}
