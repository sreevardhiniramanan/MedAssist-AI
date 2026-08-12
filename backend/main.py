from fastapi import FastAPI
from sqlalchemy import text

from database import engine
from routers.auth import router as auth_router

app = FastAPI(
    title="MedAssist AI",
    description="Intelligent Hospital Assistant API",
    version="1.0.0"
)

app.include_router(auth_router)


@app.get("/")
def root():
    return {
        "message": "Welcome to MedAssist AI API",
        "status": "Running Successfully"
    }


@app.get("/database-test")
def database_test():
    with engine.connect() as connection:
        connection.execute(text("SELECT 1"))

    return {
        "database": "PostgreSQL",
        "status": "Connected Successfully"
    }