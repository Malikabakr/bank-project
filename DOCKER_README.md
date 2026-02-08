
Health check endpoint:
-- URL: `http://localhost:5048/`
+- URL: `http://localhost:5656/`
- Interval: 30 seconds
- Timeout: 10 seconds
- Retries: 3
@@ -182,7 +182,7 @@
1. ✅ Build and run: `docker-compose up --build -d`
2. ✅ Check logs: `docker-compose logs -f`
-3. ✅ Access app: `http://localhost:5048`
+3. ✅ Access app: `http://localhost:5656`
4. ✅ Monitor: `docker stats card-processing-system`
5. ✅ Stop: `docker-compose down`
# 🐳 Docker Deployment Guide

Complete guide for running the Card Delivery Processing System using Docker.

## 📋 Prerequisites

- Docker Desktop installed (Mac, Windows, or Linux)
- Docker Compose v1.27.0 or higher
- At least 2GB of available RAM
- Port 5656 available (or configure a different port in `.env`)

## 🚀 Quick Start

### 1. Build and Run with Docker Compose

```bash
# Build and start the application
docker-compose up --build -d

# View logs
docker-compose logs -f

# Check status
docker-compose ps
```

### 2. Access the Application

Open your browser and navigate to:
```
http://localhost:5048
```

### 3. Stop the Application

```bash
# Stop containers
docker-compose down

# Stop and remove volumes
docker-compose down -v
```

## 🔧 Configuration

### Environment Variables

Configure the application by editing the `.env` file:

```bash
# Copy the example file
cp .env.example .env

# Edit configuration
nano .env
```

Key settings:
- `SESSION_SECRET`: Secure session key (auto-generated)
- `HOST_PORT`: External port (default: 5048)
- `FILE_AGE_LIMIT`: Minutes before auto-deletion (default: 2)
- `LOG_LEVEL`: Logging verbosity (INFO, DEBUG, WARNING, ERROR)

### Port Configuration

To change the external port, edit `.env`:
```bash
HOST_PORT=8080        # Change to your desired port
CONTAINER_PORT=5048   # Keep internal port as 5048
```

Then restart:
```bash
docker-compose down
docker-compose up -d
```

## 🛠️ Docker Commands

### Build and Run

```bash
# Build the image
docker-compose build

# Start in detached mode
docker-compose up -d

# Start in foreground (see logs)
docker-compose up

# Rebuild and start
docker-compose up --build
```

### Monitoring

```bash
# View logs
docker-compose logs

# Follow logs (real-time)
docker-compose logs -f

# View logs for specific time
docker-compose logs --since 10m

# Check container status
docker-compose ps

# Check resource usage
docker stats card-processing-system
```

### Container Management

```bash
# Stop containers
docker-compose stop

# Start stopped containers
docker-compose start

# Restart containers
docker-compose restart

# Remove containers
docker-compose down

# Remove containers and volumes
docker-compose down -v
```

### Shell Access

```bash
# Access container shell
docker-compose exec card-processing-app bash

# Run commands in container
docker-compose exec card-processing-app python --version

# View container files
docker-compose exec card-processing-app ls -la
```

## 📁 Volume Management

### Persistent Data

The application uses volumes for:
- `./static/uploads` - Temporary file uploads (auto-cleaned)
- `./logs` - Application logs

### Backup Volumes

```bash
# Backup uploads
docker cp card-processing-system:/app/static/uploads ./backup-uploads

# Backup logs
docker cp card-processing-system:/app/logs ./backup-logs
```

## 🔍 Troubleshooting

### Container Won't Start

```bash
# Check logs
docker-compose logs card-processing-app

# Check if port is in use
lsof -i :5048

# Remove old containers and rebuild
docker-compose down
docker-compose up --build
```

### Permission Issues

```bash
# Fix upload directory permissions
chmod -R 755 static/uploads

# Rebuild with correct permissions
docker-compose down
docker-compose up --build
```

### Memory Issues

Edit `docker-compose.yml` to adjust memory limits:
```yaml
deploy:
  resources:
    limits:
      memory: 2G  # Increase from 1G
```

### Can't Connect to Application

1. Check if container is running:
   ```bash
   docker-compose ps
   ```

2. Check container logs:
   ```bash
   docker-compose logs card-processing-app
   ```

3. Verify port mapping:
   ```bash
   docker-compose port card-processing-app 5048
   ```

4. Test from inside container:
   ```bash
   docker-compose exec card-processing-app curl http://localhost:5048
   ```

## 🏗️ Advanced Configuration

### Production Deployment

For production, consider:

1. **Use a reverse proxy (nginx)**:
```yaml
services:
  nginx:
    image: nginx:alpine
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf
    depends_on:
      - card-processing-app
```

2. **Add SSL/TLS certificates**
3. **Configure proper logging**
4. **Set up monitoring**
5. **Implement backup strategy**

### Multi-Stage Build (Smaller Image)

Edit `Dockerfile` for production:
```dockerfile
# Build stage
FROM python:3.11-slim as builder
WORKDIR /app
COPY requirements.txt .
RUN pip install --user --no-cache-dir -r requirements.txt

# Runtime stage
FROM python:3.11-slim
WORKDIR /app
COPY --from=builder /root/.local /root/.local
COPY . .
ENV PATH=/root/.local/bin:$PATH
CMD ["python", "app.py"]
```

### Scaling

Run multiple instances:
```bash
docker-compose up --scale card-processing-app=3
```

## 🔒 Security Best Practices

1. **Never commit `.env` file**
   ```bash
   # Already in .gitignore
   git status
   ```

2. **Use secrets for sensitive data**:
   ```yaml
   secrets:
     session_secret:
       file: ./secrets/session_secret.txt
   ```

3. **Run as non-root user** (already configured in Dockerfile)

4. **Keep images updated**:
   ```bash
   docker-compose pull
   docker-compose up -d
   ```

5. **Scan for vulnerabilities**:
   ```bash
   docker scan card-processing-system:latest
   ```

## 📊 Health Checks

The container includes automatic health checks:

```bash
# View health status
docker inspect --format='{{.State.Health.Status}}' card-processing-system

# View health check logs
docker inspect --format='{{range .State.Health.Log}}{{.Output}}{{end}}' card-processing-system
```

Health check endpoint:
- URL: `http://localhost:5656/`

## 🧹 Cleanup

### Remove Everything

```bash
# Stop and remove containers, networks, volumes
docker-compose down -v

# Remove images
docker rmi $(docker images -q card-processing-system)

# Clean up Docker system
docker system prune -af
```

### Remove Old Images

```bash
# Remove dangling images
docker image prune

# Remove all unused images
docker image prune -a
```

## 📝 Useful Commands Reference

| Task | Command |
|------|---------|
| Build | `docker-compose build` |
| Start | `docker-compose up -d` |
| Stop | `docker-compose down` |
| Logs | `docker-compose logs -f` |
| Shell | `docker-compose exec card-processing-app bash` |
| Rebuild | `docker-compose up --build` |
| Status | `docker-compose ps` |
| Stats | `docker stats card-processing-system` |

## 🆘 Support

For issues related to:
- **Application**: See main `README.md`
- **Security**: See `PCI_DSS_Compliance_Report.md`
- **Docker**: Check logs with `docker-compose logs -f`

## 📚 Additional Resources

- [Docker Documentation](https://docs.docker.com/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)
- [Flask on Docker](https://flask.palletsprojects.com/en/latest/deploying/)
- [Docker Security Best Practices](https://docs.docker.com/develop/security-best-practices/)

## 🎯 Next Steps

1. ✅ Build and run: `docker-compose up --build -d`
2. ✅ Check logs: `docker-compose logs -f`
3. ✅ Access app: `http://localhost:5656`
4. ✅ Monitor: `docker stats card-processing-system`
5. ✅ Stop: `docker-compose down`
