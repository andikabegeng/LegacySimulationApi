# LegacySimulationApi

A .NET 8 Web API that simulates a legacy business process. This solution is cloud-ready (Docker) and includes basic logging, configuration, and two REST endpoints.

## Endpoints

- `GET /api/process/status` — returns API status
- `POST /api/process/run` — runs the legacy simulation

## Run locally

Prerequisites:
- .NET 8 SDK (or change TargetFramework in the csproj to your installed SDK)
- Docker (optional)

Run with dotnet:
```bash
dotnet run
```

Run with Podman:
```bash
./scripts/podman/build_podman.sh
./scripts/podman/run_podman.sh
```


## Deploy to AWS (short guide)
1. Build and tag Docker image.
2. Push to AWS ECR.
3. Create ECS Fargate task and service using the ECR image.
4. Attach an Application Load Balancer to expose the service.

## Sample Input
POST /api/process/run
```json
{
  "customerId": "CUST001",
  "amount": 1000
}
```

## Notes
- Replace configuration values in `appsettings.json` as needed.
- This repository is intentionally minimal to satisfy the technical assessment requirements.
