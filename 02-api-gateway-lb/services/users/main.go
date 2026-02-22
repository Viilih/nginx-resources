package main

import (
	"net/http"

	"github.com/gin-gonic/gin"

	"log/slog"

	"os"
)

type User struct {
	ID   string `json:"id"`
	Name string `json:"name"`
	Email string `json:"email"`
}

type HealthCheckResponse struct {
	Status string `json:"status"`
	InstanceId	string `json:"instanceId"`
	ServiceName string `json:"serviceName"`
}


var users = []User{
	{ID: "1", Name: "Alice", Email: "teste1@gmail.com"},
	{ID: "2", Name: "Bob", Email: "teste2@gmail.com"},
	{ID: "3", Name: "Charlie", Email: "teste3@gmail.com"},
}


func getUsers(c *gin.Context){
	slog.Info("Get users endpoint called")
	slog.Info("Returning users", "users", users)
	c.Header("X-Instance-ID", os.Getenv("INSTANCE_ID"))
	c.IndentedJSON(http.StatusOK, users)
}

func healthCheck(c *gin.Context){
	slog.Info("Health check endpoint called")
	response := HealthCheckResponse{
		Status: "OK",
		InstanceId: os.Getenv("INSTANCE_ID"),
		ServiceName: "USER-SERVICE",
	}
	slog.Info("Health check response", "response", response)
	c.Header("X-Instance-ID", os.Getenv("INSTANCE_ID"))
	c.IndentedJSON(http.StatusOK, response)
}



func main() {
	router := gin.Default()
	router.GET("/users", getUsers)
	router.GET("/health", healthCheck)

	router.Run(":8081")
}