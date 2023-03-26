from fastapi import APIRouter

router = APIRouter()

api_id = "zeitplanUsuarioAgregar"
api_route = "/v1/usuario/"
metodo = "post"


@router.post("/v1/usuarios/")
async def api2_post():
    return {"message": "Hello from adding usuario - POST"}