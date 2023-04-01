from fastapi import FastAPI
from mangum import Mangum

from app.api.Equipos.GET.routes import router as get_equipo
from app.api.Equipos.DELETE.routes import router as delete_equipo
from app.api.Equipos.POST.routes import router as post_equipo

app = FastAPI()

app.include_router(get_equipo, prefix="/equipo/{equipo_id}")
app.include_router(delete_equipo, prefix="/equipo/{equipo_id}")
app.inclute_router(post_equipo, prefix="/equipo")

handler = Mangum(app)
