# DevOps Intern Final Assessment – Springer Capital
Name: Jerry Sarpey
Date: August 7, 2026

This repository implements a realistic DevOps workflow using Linux, GitHub, Docker, CI/CD, Nomad, and Grafana Loki.

Repository Structure

devops-intern-final/
├── Dockerfile
├── hello.py
├── scripts/
│   └── sysinfo.sh
├── nomad/
│   └── hello.nomad
├── monitoring/
│   └── loki_setup.txt
├── images/
│   ├── nomad.png
│   ├── loki.png
│   └── cicd.png
└── .github/
    └── workflows/
        └── ci.yml

Linux System Info Script

The sysinfo.sh script prints:

Current user

Date

Filesystem usage

Mounted volumes

Run it:
chmod +x scripts/sysinfo.sh
./scripts/sysinfo.sh

=== System Info ===
User: amrad
Date: Sun Aug 9 20:45:47 EDT 2026
Filesystem      Size    Used    Avail   Capacity iused   ifree   %iused  Mounted on
...
![alt text](<Image 8-9-26 at 10.23 PM.png>)


Python Application

A simple Python script (hello.py) used as the workload for CI/CD and container deployment.

🐳 Docker Containerization

The project includes a minimal Dockerfile:

FROM python:3.11-slim

WORKDIR /app

COPY . /app

CMD ["python3", "hello.py"]

Build the image:

docker build -t devops-hello .

Run the container:

docker run --rm devops-hello

Expected output:

![alt text](<Dooker run output.png>)

Hello, DevOps!

⚙️ GitHub Actions CI/CD Pipeline

Located at .github/workflows/ci.yml, this workflow:

Checks out the repository

Sets up Python

Runs the application

Triggering CI/CD
Make a change:

print("Hello, DevOps Intern!")

Commit and push:

git add .
git commit -m "Trigger CI pipeline"
git push

CI/CD Result
Workflow: Trigger CI pipeline #3

Status: Success

Duration: 15s



📦 Nomad Deployment

The Nomad job (nomad/hello.nomad) defines how the Python service is scheduled and deployed.

Key Features
Runs Docker image devops-hello:v1

Allocates CPU & memory

Exposes port 8080

Captures logs

Uses local Docker image (force_pull = false)

Run the job:

nomad job run nomad/hello.nomad

✓ Deployment successful
Healthy = 1
Unhealthy = 0

View logs:

nomad alloc logs -f a6ddebb2

Hello, DevOps!
Hello, DevOps!
Hello, DevOps!

📊 Monitoring with Grafana Loki
Loki is used for log aggregation and querying.

Steps Performed
Started Loki using Docker

Installed Loki Docker logging plugin

Forwarded container logs

Queried logs using LogQL

Documented everything in monitoring/loki_setup.txt

Verify logs:

curl -G -s "http://localhost:3100/loki/api/v1/query" \
--data-urlencode 'query={container_name="devops-hello-loki"}'

Expected output:

Hello, DevOps!
Hello, DevOps!
Hello, DevOps!

How to Run Everything (Quick Start)

1. Linux Script
chmod +x scripts/sysinfo.sh
./scripts/sysinfo.sh

2. Docker

docker build -t devops-hello .
docker run --rm devops-hello

3. CI/CD

git add .
git commit -m "Trigger CI pipeline"
git push

4. Nomad
nomad agent -dev
nomad job run nomad/hello.nomad
nomad alloc logs -f <alloc-id>

5. Loki

docker run -d --name loki -p 3100:3100 grafana/loki:2.9.2 -config.file=/etc/loki/local-config.yaml
docker plugin install grafana/loki-docker-driver:latest --alias loki --grant-all-permissions
docker run -d --log-driver=loki --log-opt loki-url="http://localhost:3100/loki/api/v1/push" --name devops-hello-loki devops-hello:v1


Final Deliverable Summary

Final Deliverable Summary
This repository contains all required components for the DevOps Intern Final Assessment:

Linux scripting

Docker containerization

CI/CD pipeline

Nomad deployment

Monitoring with Grafana Loki

Full documentation

Screenshots for verification

Everything has been tested end‑to‑end and validated successfully.

Project Checklist (Completed)
[x] README.md with full documentation

[x] scripts/sysinfo.sh

[x] Dockerfile

[x] .github/workflows/ci.yml

[x] nomad/hello.nomad

[x] monitoring/loki_setup.txt

[x] Nomad job running and healthy

[x] Loki logs verified

[x] CI/CD pipeline triggered and passed

[x] Docker image built and running

[x] Screenshots added

[x] Final deliverable complete