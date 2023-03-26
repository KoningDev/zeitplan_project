from fastapi import FastAPI
from mangum import Mangum
from app.api.api_uno.routes import router as api1_router
from app.api.api_dos.routes import router as api2_router

app = FastAPI()

app.include_router(api1_router, prefix="/api1")
app.include_router(api2_router, prefix="/api2")

handler = Mangum(app)
