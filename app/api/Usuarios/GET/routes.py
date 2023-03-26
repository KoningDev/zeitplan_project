from fastapi import APIRouter

router = APIRouter()

api_id = "zeitplanUsuarioObtener"
api_route = "/v1/usuario/{usuario_id}"
metodo = "get"


@router.get("/v1/usuarios/{usuario_id}")
async def api2_get():
    return {"message": "Hello from getting usuario - GET"}