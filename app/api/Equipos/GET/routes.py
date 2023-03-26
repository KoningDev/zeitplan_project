from fastapi import APIRouter

router = APIRouter()

api_id = "zeitplanEquipoObtener"
api_route = "/v1/equipos/{equipo_id}"
metodo = "get"


@router.get("/v1/equipos/{equipo_id}")
async def api1_get():
    return {"message": "Hello from getting a equipo - GET"}