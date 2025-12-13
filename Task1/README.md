## Docker Image

**Public image:**

```
saqlainkhan/simple-time-service
```

---

## Build the Image

Only one command is required to build the container:

```bash
docker build -t simple-time-service .
```

---

## Run the Service

Only one command is required to run the container:

```bash
docker run -p 8000:8000 saqlainkhan/simple-time-service
```

The container will start and remain running.

---

## Test the Service

```bash
curl http://localhost:8000/
```

Example response:

```json
{
  "timestamp": "2025-01-13T10:42:31.481Z",
  "ip": "172.17.0.1"
}
```

---

## Implementation Notes

* Runs as a **non-root user** inside the container
* Uses a **minimal base image** to keep the container lightweight
* No secrets or external configuration required
* Follows container best practices

