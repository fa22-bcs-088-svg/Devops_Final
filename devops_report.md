## Technologies Used
    The following technologies used in this DevOps project:
- Next.js -Frontend web application framework
- Node.js - Server-side runtime environment
- PostgreSQL - Relational database for persistent storage
- Redis - In-memory cache for performance optimization
- Docker - Containerization of application and services
- Docker Compose - Local and production container orchestration
- Kubernetes - Container orchestration and deployment
- Nginx - Reverse proxy and HTTPS handling
- Git & Github - Version control and source code management
- Linux (Ubuntu) - Server operating system
- kubectl - Kubernetes command-line tool
- Prometheus - Monitoring and metrics collection for containers, services, and Kubernetes
- Grafana - Visualization of metrics collected by Prometheus, dashboards for performance and alerts


## Pipeline & Infrastructure Diagram

```
┌─────────────────┐
│  Code Push/PR   │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ Build & Test    │ ──┐
└────────┬────────┘   │
         │            │
         ▼            │
┌─────────────────┐   │
│ Security & Lint │ ──┤ (Parallel)
└────────┬────────┘   │
         │            │
         ▼            │
┌─────────────────┐   │
│ Docker Build    │ ──┘
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ Terraform Apply │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ Ansible Deploy  │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ Smoke Tests     │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ Pipeline Summary│
└─────────────────┘
```

**Infrastructure Diagram**
```
User
 ↓
Nginx (Reverse Proxy / HTTPS)
 ↓
Kubernetes Cluster
 ├── Next.js Application Pod
 ├── PostgreSQL Database Pod
 └── Redis Cache Pod

```

## Seceret Management Strategy
- Environment Variables for local development
- Docker .env file
- Kubernetes Secrets for production deployment

## Monitoring Strategy
- Kubernetes - `kubectl get pods` for pod health check status
- Container Logs - `kubectl logs` for application logs
- Docker Monitoring - `docker-compose ps` for container status
- Nginx Logs - Access and error logs for traffic monitoring

    **Prometheus**
    - Collects metrics from Next.js application, PostgreSQL, Redis, and Kubernetes pods
    - Tracks CPU, memory, and pod/container health
    - Enables alerting on threshold breaches

    **Grafana**
    - Visualizes metrics collected by Prometheus
    - Provides dashboards for application performance, database load, and cache usage
    - Supports real-time monitoring and historical analysis


## Lessons Learned
- Containerization simplifies deployment and environment consistency
- Kubernetes provides scalability and better service management
- Proper secret management is critical for application security
- Monitoring and logging help in early detection of failures
- Automating infrastructure setup reduces manual errors