## Running Locally
If you want to run this setup locally using Docker, you can follow these steps:
docker-compose up -d

This will start both services and make the app available at `http://localhost:3000` with the PostgreSQL 
## Helpful Commands for Docker

- `docker-compose ps` – check status of Docker containers
- `docker-compose logs web` – view Next.js output logs
- `docker-compose logs cron` – view cron logs
- `docker-compose down` - shut down the Docker containers
- `docker-compose up -d` - start containers in the background
- `sudo systemctl restart nginx` - restart nginx
- `docker exec -it myapp-web-1 sh` - enter Next.js Docker container
- `docker exec -it myapp-db-1 psql -U myuser -d mydatabase` - enter Postgres db


## Helpful Commands for Kubernetes

- `kubectl apply -f k8s/` – apply kubernetes manifests
- `kubectl get pods` – verify pod deployment
- `kubectl get services` – verify services deployment
- `kubectl create secret generic app-secrets \`
   `--from-literal=DB_USER=myuser \`
   `--from-literal=DB_PASSWORD=mypassword`- managing kubernetes secrets.

## Kubernetes Deployment Commands
- `kubectl apply -f configuration.yaml` - aaply the main configuration file
- `kubectl apply -f secret.yaml` `kubectl apply -f redis-secret.yaml ` - apply secret configurations
- `kubectl apply -f postgres-service.yaml` `kubectl apply -f postgres-deployment.yaml` - apply postgreSQL service and deployment
- `kubectl apply -f redis-deployment.yaml` - apply redis and deplyment
- `kubectl apply -f nextjs-app-service.yaml` `kubectl apply -f nextjs-app-deployment.yaml` - apply Next.js app service and deployment

## Terraform Deployment Commands
- `terraform init` - initialize terraform
- `terraform validate` validating terraform config files
- `terraform plan` - checking for the changes that will happen
- `terraform apply` - apply the changes

## Infrastructure Setup Includes
- Ubuntu Linux Server
- Docker & Docker Compose
- Nginx
- SSL/TLS certificates
- PostgreSQL database
Setup automated using deploy.sh script which handles installation, configuration and orchestration.

## Infrastructure Teardown
- `docker-compose down` - to stop and remove containers
- `sudo systemctl stop nginx` 
   `sudo apt remove docker docker-compose nginx -y` - to completely remove infrastructure.




