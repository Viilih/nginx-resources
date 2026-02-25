#!/bin/bash

# Script para testar todos os endpoints dos serviços

BASE_URL="http://localhost:8080"

echo "========================================="
echo "🧪 Testando todos os endpoints"
echo "========================================="
echo ""

# Função para fazer requisição e mostrar resultado
test_endpoint() {
  local method=$1
  local endpoint=$2
  local description=$3

  echo "🔹 $description"
  echo "   $method $endpoint"
  echo ""

  response=$(curl -s -w "\nHTTP Status: %{http_code}\n" "$BASE_URL$endpoint")
  echo "$response"
  echo ""
  echo "---"
  echo ""
}

# API Gateway Health
test_endpoint "GET" "/health" "Health check do API Gateway"

# Users Service
test_endpoint "GET" "/users/health" "Health check - Users Service"
test_endpoint "GET" "/users" "Listar usuários"

# Products Service
test_endpoint "GET" "/products/health" "Health check - Products Service"
test_endpoint "GET" "/products" "Listar produtos"
test_endpoint "GET" "/products/1" "Buscar produto por ID"

# Orders Service
test_endpoint "GET" "/orders/health" "Health check - Orders Service"
test_endpoint "GET" "/orders" "Listar pedidos"
test_endpoint "GET" "/orders/1" "Buscar pedido por ID"

# Rota inexistente (404)
test_endpoint "GET" "/rota-inexistente" "Rota inexistente (deve retornar 404)"

echo "✅ Testes concluídos!"
echo ""
