package main

import (
	"net/http"

	"github.com/gin-gonic/gin"
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
	c.IndentedJSON(http.StatusOK, users)
}

func healthCheck(c *gin.Context){
	response := HealthCheckResponse{
		Status: "OK",
		InstanceId: "user-instance-1",
		ServiceName: "USER-SERVICE",
	}
	c.IndentedJSON(http.StatusOK, response)
}



func main() {
	router := gin.Default()
	router.GET("/users", getUsers)
	router.GET("/health", healthCheck)

	router.Run(":8081")
}