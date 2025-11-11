---
title: Docker Multi-Container Management
type: knowledge
tags: [docker, development, containers, networking]
---

# Docker Multi-Container Management

## Problem

Running multiple containers with the same service (e.g., PostgreSQL) on localhost requires different port mappings to avoid conflicts.

## Solutions

### 1. Different Host Ports (Simplest)

Map each container's internal port to a different host port:

```bash
# App 1: Postgres on 5432 (standard)
docker run -d --name app1-postgres \
  -p 5432:5432 \
  -e POSTGRES_PASSWORD=password \
  postgres:15

# App 2: Postgres on 5433
docker run -d --name app2-postgres \
  -p 5433:5432 \
  -e POSTGRES_PASSWORD=password \
  postgres:15
```

**Connect to:**

- App 1: `localhost:5432`
- App 2: `localhost:5433`

### 2. Docker Networks (Recommended for Isolation)

Create isolated networks so containers can use the same ports internally but are isolated:

```bash
# Create network for App 1
docker network create app1-network

# Create network for App 2
docker network create app2-network

# App 1 Postgres (uses port 5432 internally, accessible only on app1-network)
docker run -d --name app1-postgres \
  --network app1-network \
  -e POSTGRES_PASSWORD=password \
  postgres:15

# App 2 Postgres (uses port 5432 internally, accessible only on app2-network)
docker run -d --name app2-postgres \
  --network app2-network \
  -e POSTGRES_PASSWORD=password \
  postgres:15

# Your apps connect via service name
# App 1 connects to: app1-postgres:5432
# App 2 connects to: app2-postgres:5432
```

**Benefits:**

- Same internal ports, different networks
- Better isolation
- Containers reference each other by service name
- No port conflicts

### 3. Docker Compose (Best for Projects)

Use separate `docker-compose.yml` files with different projects:

**app1/docker-compose.yml:**

```yaml
version: "3.8"
services:
  postgres:
    image: postgres:15
    container_name: app1-postgres
    ports:
      - "5432:5432"
    environment:
      POSTGRES_PASSWORD: password
      POSTGRES_DB: app1_db
    volumes:
      - app1_postgres_data:/var/lib/postgresql/data

volumes:
  app1_postgres_data:
```

**app2/docker-compose.yml:**

```yaml
version: "3.8"
services:
  postgres:
    image: postgres:15
    container_name: app2-postgres
    ports:
      - "5433:5432" # Different host port
    environment:
      POSTGRES_PASSWORD: password
      POSTGRES_DB: app2_db
    volumes:
      - app2_postgres_data:/var/lib/postgresql/data

volumes:
  app2_postgres_data:
```

**Run with project names:**

```bash
# App 1
cd app1
docker compose -p app1 up -d

# App 2
cd app2
docker compose -p app2 up -d
```

### 4. Environment-Specific Configuration

Use different connection strings for each app:

```bash
# App 1 environment
export DATABASE_URL="postgresql://user:password@localhost:5432/app1_db"

# App 2 environment
export DATABASE_URL="postgresql://user:password@localhost:5433/app2_db"
```

Or in your `.env` files:

```bash
# app1/.env
DATABASE_URL=postgresql://user:password@localhost:5432/app1_db

# app2/.env
DATABASE_URL=postgresql://user:password@localhost:5433/app2_db
```

## Practical Examples

### Multiple Postgres Instances

```bash
# Project 1: Standard port
docker run -d \
  --name project1-postgres \
  -p 5432:5432 \
  -e POSTGRES_PASSWORD=pass1 \
  -e POSTGRES_DB=project1 \
  -v project1_data:/var/lib/postgresql/data \
  postgres:15

# Project 2: Different port
docker run -d \
  --name project2-postgres \
  -p 5433:5432 \
  -e POSTGRES_PASSWORD=pass2 \
  -e POSTGRES_DB=project2 \
  -v project2_data:/var/lib/postgresql/data \
  postgres:15

# Project 3: Another port
docker run -d \
  --name project3-postgres \
  -p 5434:5432 \
  -e POSTGRES_PASSWORD=pass3 \
  -e POSTGRES_DB=project3 \
  -v project3_data:/var/lib/postgresql/data \
  postgres:15
```

### Multiple Redis Instances

```bash
docker run -d --name redis1 -p 6379:6379 redis:7
docker run -d --name redis2 -p 6380:6379 redis:7
docker run -d --name redis3 -p 6381:6379 redis:7
```

## Best Practices

1. **Use Docker Compose** for project-specific containers
2. **Use named volumes** to persist data: `-v volume_name:/data`
3. **Use networks** for container-to-container communication
4. **Document port assignments** in your project README
5. **Use environment variables** for connection strings
6. **Stop/remove containers** when not in use to free ports

## Useful Commands

```bash
# List running containers and their ports
docker ps --format "table {{.Names}}\t{{.Ports}}"

# Check what's using a port
lsof -i :5432

# Stop a specific container
docker stop container-name

# Remove a container
docker rm container-name

# View all Docker networks
docker network ls

# Inspect a network
docker network inspect network-name

# List all volumes
docker volume ls

# Remove unused volumes
docker volume prune
```

## Managing Multiple Projects

### Quick Reference Table

| Project | Service  | Host Port | Internal Port | Container Name |
| ------- | -------- | --------- | ------------- | -------------- |
| App 1   | Postgres | 5432      | 5432          | app1-postgres  |
| App 2   | Postgres | 5433      | 5432          | app2-postgres  |
| App 3   | Postgres | 5434      | 5432          | app3-postgres  |
| App 1   | Redis    | 6379      | 6379          | app1-redis     |
| App 2   | Redis    | 6380      | 6379          | app2-redis     |

## Troubleshooting

### Port Already in Use

```bash
# Find what's using the port
lsof -i :5432

# Kill the process or stop the container
docker stop container-name
```

### Container Name Conflicts

```bash
# Remove existing container first
docker rm -f old-container-name

# Then create new one with same name
docker run -d --name container-name ...
```

### Network Issues

```bash
# List networks
docker network ls

# Remove unused networks
docker network prune

# Inspect network
docker network inspect network-name
```
