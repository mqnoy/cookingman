package usecase

import (
	"context"
	"fmt"

	"github.com/mqnoy/cookingman/internal/entity"
	"golang.org/x/crypto/bcrypt"
)

// UserUsecase is the usecase that holds all user usecase value.
type UserUsecase struct {
	UserRepo entity.UserRepository
}

// NewUserUsecase return of user usecase implementation
func NewUserUsecase(userRepo entity.UserRepository) entity.UserUsecase {
	return &UserUsecase{
		UserRepo: userRepo,
	}
}

// AllUser validate and get all data user from user repository
func (uu *UserUsecase) AllUser(ctx context.Context) ([]*entity.User, error) {
	u, err := uu.UserRepo.Fetch(ctx)
	if err != nil {
		return nil, err
	}

	users := make([]*entity.User, len(u))

	for i := 0; i < len(users); i++ {
		user := &entity.User{
			ID:       u[i].ID.String(),
			Email:    u[i].Email,
			Username: u[i].Username,
			Password: u[i].Password,
		}

		users[i] = user
	}

	return users, nil
}

// Login validate and get data user
// that match with username and password from repository user
func (uu *UserUsecase) Login(ctx context.Context, username, password string) (*entity.User, error) {
	u, err := uu.UserRepo.GetByUsername(ctx, username)
	if err != nil {
		return nil, err
	}

	err = bcrypt.CompareHashAndPassword([]byte(u.Password), []byte(password))
	if err != nil {
		return nil, fmt.Errorf("failed authentication: %+v", err)
	}

	user := &entity.User{
		ID:       u.ID.String(),
		Username: u.Username,
		Password: u.Password,
		Email:    u.Email,
	}

	return user, nil
}

// Registration create a new user
func (uu *UserUsecase) Registration(ctx context.Context, input entity.UserInput) (*entity.User, error) {
	if len(input.Username) < 6 {
		return nil, fmt.Errorf("invalid username")
	}

	if len(input.Password) < 12 {
		return nil, fmt.Errorf("invalid password")
	}

	// cost for hash password
	cost := 14
	hashPassword, err := bcrypt.GenerateFromPassword([]byte(input.Password), cost)
	if err != nil {
		return nil, fmt.Errorf("failed hash password: %+v", err)
	}

	input.Password = string(hashPassword)

	u, err := uu.UserRepo.Create(ctx, input)
	if err != nil {
		return nil, err
	}

	// parse result user from *ent.User to *entity.User
	user := &entity.User{
		ID:       u.ID.String(),
		Username: u.Username,
		Password: u.Password,
		Email:    u.Email,
	}

	return user, nil
}
