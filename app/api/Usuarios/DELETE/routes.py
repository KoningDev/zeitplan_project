from fastapi import APIRouter

router = APIRouter()

api_id = "zeitplanUsuarioEliminar"
api_route = "/v1/usuario/{usuario_id}"
metodo = "delete"


@router.delete("/v1/usuarios/{usuario_id}")
async def api2_delete():
    return {"message": "Hello from deleting usuario - DELETE"}