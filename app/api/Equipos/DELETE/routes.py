from fastapi import APIRouter

router = APIRouter()

api_id = "zeitplanEquipoEliminar"
api_route = "/v1/equipos/{equipo_id}"
metodo = "delete"


@router.delete("/v1/equipos/{equipo_id}")
async def api1_deleting():
    return {"message": "Hello from deleting equipo - DELETE"}
