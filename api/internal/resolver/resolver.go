//go:generate go run github.com/99designs/gqlgen

package resolver

import "github.com/mqnoy/cookingman/internal/entity"

// This file will not be regenerated automatically.
//
// It serves as dependency injection for your app, add any dependencies you require here.

// Resolver resolve graphql query and mutation
type Resolver struct {
	UserUc entity.UserUsecase
}
