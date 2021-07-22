package resolver

import (
	"context"

	"github.com/mqnoy/cookingman/internal/entity"
)

func (r *queryResolver) Users(ctx context.Context) ([]*entity.User, error) {
	u, err := r.Resolver.UserUc.AllUser(ctx)
	if err != nil {
		return nil, err
	}

	return u, nil
}

func (r *queryResolver) Login(ctx context.Context, username string, password string) (*entity.User, error) {
	u, err := r.Resolver.UserUc.Login(ctx, username, password)
	if err != nil {
		return nil, err
	}

	return u, nil
}

func (r *mutationResolver) CreateUser(ctx context.Context, input entity.UserInput) (*entity.User, error) {
	u, err := r.Resolver.UserUc.Registration(ctx, input)
	if err != nil {
		return nil, err
	}

	return u, nil
}
