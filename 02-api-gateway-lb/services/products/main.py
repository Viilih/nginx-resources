import os
from fastapi import FastAPI, Response
from typing import List, Dict

app = FastAPI()

# Dados mockados de produtos
products = [
    {"id": "1", "name": "Laptop", "price": 2500.00, "category": "Electronics"},
    {"id": "2", "name": "Mouse", "price": 50.00, "category": "Electronics"},
    {"id": "3", "name": "Keyboard", "price": 150.00, "category": "Electronics"},
    {"id": "4", "name": "Monitor", "price": 800.00, "category": "Electronics"},
]

@app.get("/")
def read_root():
    return {
        "message": "Products Service",
        "instanceId": os.getenv("INSTANCE_ID", "unknown"),
        "serviceName": "PRODUCTS-SERVICE"
    }

@app.get("/products")
def get_products(response: Response) -> List[Dict]:
    instance_id = os.getenv("INSTANCE_ID", "unknown")
    response.headers["X-Instance-ID"] = instance_id
    return products

@app.get("/products/{product_id}")
def get_product(product_id: str, response: Response) -> Dict:
    instance_id = os.getenv("INSTANCE_ID", "unknown")
    response.headers["X-Instance-ID"] = instance_id

    product = next((p for p in products if p["id"] == product_id), None)
    if product:
        return product
    return {"error": "Product not found"}

@app.get("/health")
def health_check(response: Response):
    instance_id = os.getenv("INSTANCE_ID", "unknown")
    response.headers["X-Instance-ID"] = instance_id

    return {
        "status": "OK",
        "instanceId": instance_id,
        "serviceName": "PRODUCTS-SERVICE"
    }
