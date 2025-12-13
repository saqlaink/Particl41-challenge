from fastapi import FastAPI, Request
from datetime import datetime

app = FastAPI()

@app.get("/")
async def get_time(request: Request):
    client_ip = request.client.host
    return {
        "timestamp": datetime.utcnow().isoformat() + "Z",
        "ip": client_ip
    }
