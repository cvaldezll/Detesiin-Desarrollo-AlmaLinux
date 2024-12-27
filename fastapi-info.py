from fastapi import FastAPI
import platform
import psutil

app = FastAPI()

@app.get("/info")
def get_system_info():
    return {
        "sistema_operativo": platform.system(),
        "version_python": platform.python_version(),
        "procesador": platform.processor(),
        "memoria_total": psutil.virtual_memory().total >> 30,  # En GB
        "memoria_disponible": psutil.virtual_memory().available >> 30  # En GB
    }