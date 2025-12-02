📘 README.md – Legacy Simulation API (.NET + Podman)
Legacy Simulation API

A simple .NET Web API that simulates a basic legacy scoring process.
This project is containerized using Podman and includes scripts to build and run the API locally.

🚀 Features

.NET 8 Web API

Endpoint untuk simulasi legacy scoring

Endpoint untuk status API

Podman support (build + run)

Lightweight container image

Postman-ready endpoints

📦 Requirement

Pastikan sudah terinstall:

-- .NET 8 SDK (optional untuk development)

-- Podman (bukan Docker)

-- Git

-- Postman (untuk testing)

🛠 Build & Run Menggunakan Podman
1. Build Image

Jalankan perintah berikut di root project:

podman build -t legacy-sim-api .

atau bisa menggunakan :

./scripts/podman/build_podman.sh


2. Menjalankan Container

API ini listen di port 8080 dalam container, sehingga port mapping harus:

HOST:8080 → CONTAINER:8080


Jalankan:

podman run -d \
  -p 8080:8080 \
  --name legacyapi \
  legacy-sim-api


atau bisa menggunakan :

./scripts/podman/run_podman.sh


3. Cek Container
podman ps


Harus muncul:

0.0.0.0:8080->8080/tcp

4. Lihat Log
podman logs legacyapi

🧪 Testing API

Gunakan Postman atau browser.

1. Cek status API

GET

http://localhost:8080/api/process/status


Response example:

{
  "status": "Running",
  "serverTime": "2025-02-12T12:00:00Z"
}

2. Run Legacy Simulation

POST

http://localhost:8080/api/process/run


Headers

Content-Type: application/json


Body

{
  "customerId": "CUST001",
  "amount": 1000
}


Response example:

{
  "message": "Process completed",
  "score": 1851,
  "processedAt": "2025-02-12T12:01:22Z"
}

🧹 Stop & Remove Container

Untuk menghentikan API:

podman stop legacyapi


Menghapus container:

podman rm legacyapi

🏗 CI/CD (GitHub Actions – Optional)

Project ini dapat menggunakan pipeline sederhana:

build .NET

run unit test

build Podman image (rootless)

optional: push ke registry (GitHub Container Registry)

Pipeline file berada di:

.github/workflows/ci.yml