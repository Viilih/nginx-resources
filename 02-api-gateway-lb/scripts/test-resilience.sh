#!/bin/bash

# Script para testar a resiliência do sistema

echo "========================================="
echo "🛡️  Teste de Resiliência"
echo "========================================="
echo ""

echo "1️⃣  Testando com todas as instâncias ativas..."
echo ""

for i in {1..6}; do
  curl -s -D - http://localhost:8080/users -o /dev/null | grep -i "x-instance-id"
done

echo ""
echo "2️⃣  Derrubando users-instance-2..."
docker stop users-instance-2 > /dev/null 2>&1

echo "✓ Instância derrubada"
echo ""
echo "Aguardando 3 segundos..."
sleep 3

echo ""
echo "3️⃣  Testando com uma instância fora do ar..."
echo ""

for i in {1..9}; do
  curl -s -D - http://localhost:8080/users -o /dev/null | grep -i "x-instance-id"
done

echo ""
echo "📝 Observe que a instância 2 não aparece mais na rotação!"
echo ""

read -p "Pressione ENTER para restaurar a instância..."

echo ""
echo "4️⃣  Restaurando users-instance-2..."
docker start users-instance-2 > /dev/null 2>&1

echo "✓ Instância restaurada"
echo ""
echo "Aguardando 3 segundos para a instância ficar pronta..."
sleep 3

echo ""
echo "5️⃣  Testando após restauração..."
echo ""

for i in {1..9}; do
  curl -s -D - http://localhost:8080/users -o /dev/null | grep -i "x-instance-id"
done

echo ""
echo "✅ Teste de resiliência concluído!"
echo ""
echo "📝 A instância 2 voltou automaticamente para a rotação!"
echo ""
