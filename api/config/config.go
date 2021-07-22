package config

import (
	"fmt"
	"os"
	"time"

	"github.com/mqnoy/cookingman/ent"

	"entgo.io/ent/dialect/sql"
	_ "github.com/lib/pq" // postgres driver
)

// MapConfig ...
type MapConfig struct {
	Database *Database
}

// Database ...
type Database struct {
	Host    string
	User    string
	Pass    string
	SSLMode string
	DBName  string
}

// NewMapConfig ...
func NewMapConfig() *MapConfig {
	host := os.Getenv("DB_HOST")
	user := os.Getenv("DB_USER")
	pass := os.Getenv("DB_PASS")
	dbName := os.Getenv("DB_NAME")
	sslMode := os.Getenv("DB_SSLMODE")

	db := &Database{
		Host:    host,
		User:    user,
		Pass:    pass,
		SSLMode: sslMode,
		DBName:  dbName,
	}

	return &MapConfig{
		Database: db,
	}
}

// ConnectDB ...
func (mc *MapConfig) ConnectDB() (*ent.Client, error) {
	dbURL := fmt.Sprintf("postgres://%s:%s@%s:5432/%s?sslmode=%s", mc.Database.User, mc.Database.Pass, mc.Database.Host, mc.Database.DBName, mc.Database.SSLMode)

	drv, err := sql.Open("postgres", dbURL)
	if err != nil {
		return nil, err
	}

	db := drv.DB()
	err = db.Ping()
	if err != nil {
		return nil, err
	}
	db.SetMaxIdleConns(10)
	db.SetMaxOpenConns(100)
	db.SetConnMaxLifetime(time.Hour)
	return ent.NewClient(ent.Driver(drv)), nil
}
