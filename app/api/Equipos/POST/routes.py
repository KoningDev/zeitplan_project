from fastapi import APIRouter

router = APIRouter()

api_id = "zeitplanEquipoAgregar"
api_route = "/v1/equipos"
metodo = "post"


@router.post("/v1/equipos/")
async def api1_post():
    return {"message": "Hello from adding equipo - POST"}
