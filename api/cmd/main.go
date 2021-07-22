package main

import (
	"context"
	"log"
	"net/http"
	"os"

	"github.com/99designs/gqlgen/graphql/handler"
	"github.com/99designs/gqlgen/graphql/playground"
	"github.com/mqnoy/cookingman/config"
	"github.com/mqnoy/cookingman/ent/migrate"
	"github.com/mqnoy/cookingman/internal/graphql"
	"github.com/mqnoy/cookingman/internal/resolver"
	userRepo "github.com/mqnoy/cookingman/internal/service/user/repository"
	userUsecase "github.com/mqnoy/cookingman/internal/service/user/usecase"

	_ "github.com/joho/godotenv/autoload"
)

const defaultPort = "8080"

func main() {
	port := os.Getenv("PORT")
	if port == "" {
		port = defaultPort
	}

	ctx := context.Background()

	cfg := config.NewMapConfig()
	client, err := cfg.ConnectDB()
	if err != nil {
		log.Printf("not connected postgresql %+v \n", err)
	}
	err = client.Schema.Create(ctx, migrate.WithDropIndex(true), migrate.WithDropColumn(true))
	if err != nil {
		log.Printf("failed migration: %+v \n", err)
	}

	uRepo := userRepo.NewUserRepository(client)
	uUC := userUsecase.NewUserUsecase(uRepo)

	srv := handler.NewDefaultServer(graphql.NewExecutableSchema(graphql.Config{Resolvers: &resolver.Resolver{
		UserUc: uUC,
	}}))

	http.Handle("/", playground.Handler("GraphQL playground", "/query"))
	http.Handle("/query", srv)

	log.Printf("connect to http://localhost:%s/ for GraphQL playground", port)
	log.Fatal(http.ListenAndServe(":"+port, nil))
}
