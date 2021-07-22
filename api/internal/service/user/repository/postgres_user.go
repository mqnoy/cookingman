package repository

import (
	"context"

	"github.com/mqnoy/cookingman/ent"
	"github.com/mqnoy/cookingman/ent/user"
	"github.com/mqnoy/cookingman/internal/entity"
)

// UserRepository is the reposotiry that holds all user repository value.
type UserRepository struct {
	Client *ent.Client
}

// NewUserRepository return of user repository implementation
func NewUserRepository(client *ent.Client) entity.UserRepository {
	return &UserRepository{
		Client: client,
	}
}

// Fetch get all data user from database
func (ur *UserRepository) Fetch(ctx context.Context) ([]*ent.User, error) {
	users, err := ur.Client.User.Query().
		All(ctx)
	if err != nil {
		return nil, err
	}

	return users, nil
}

// GetByUsername get data user that match with username from database
func (ur *UserRepository) GetByUsername(ctx context.Context, username string) (*ent.User, error) {
	user, err := ur.Client.User.Query().
		Where(user.UsernameEQ(username)).
		Only(ctx)
	if err != nil {
		return nil, err
	}

	return user, nil
}

// Create new user to database
func (ur *UserRepository) Create(ctx context.Context, input entity.UserInput) (*ent.User, error) {
	user, err := ur.Client.User.Create().
		SetUsername(input.Username).
		SetPassword(input.Password).
		SetEmail(input.Email).
		Save(ctx)
	if err != nil {
		return nil, err
	}

	return user, nil
}
