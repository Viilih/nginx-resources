#!/bin/bash

# Script para testar o Load Balancing com Round Robin

echo "========================================="
echo "🔄 Testando Load Balancing - Users Service (3 instâncias)"
echo "========================================="
echo ""
echo "Enviando 9 requisições para observar o Round Robin..."
echo ""

for i in {1..9}; do
  curl -s -D - http://localhost:8080/users -o /dev/null | grep -i "x-instance-id"
done

echo ""
echo "========================================="
echo "🔄 Testando Load Balancing - Products Service (2 instâncias)"
echo "========================================="
echo ""
echo "Enviando 6 requisições para observar o Round Robin..."
echo ""

for i in {1..6}; do
  curl -s -D - http://localhost:8080/products -o /dev/null | grep -i "x-instance-id"
done

echo ""
echo "========================================="
echo "🔄 Testando Load Balancing - Orders Service (3 instâncias)"
echo "========================================="
echo ""
echo "Enviando 9 requisições para observar o Round Robin..."
echo ""

for i in {1..9}; do
  curl -s -D - http://localhost:8080/orders -o /dev/null | grep -i "x-instance-id"
done

echo ""
echo "✅ Teste concluído!"
echo ""
echo "📝 Observe que as requisições são distribuídas sequencialmente entre as instâncias."
echo ""
