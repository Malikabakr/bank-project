# Makefile for Card Delivery Processing System

.PHONY: help build up down restart logs status shell clean test

# Default target
help:
	@echo "Card Delivery Processing System - Docker Commands"
	@echo "=================================================="
	@echo ""
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@echo "  help       - Show this help message"
	@echo "  build      - Build Docker images"
	@echo "  up         - Start containers in background"
	@echo "  down       - Stop and remove containers"
	@echo "  restart    - Restart containers"
	@echo "  logs       - View container logs (follow mode)"
	@echo "  status     - Show container status and health"
	@echo "  shell      - Access container shell"
	@echo "  clean      - Remove containers, volumes, and images"
	@echo "  rebuild    - Clean build and start"
	@echo ""

# Build Docker images
build:
	@echo "🔨 Building Docker images..."
	docker-compose build

# Start containers
up:
	@echo "🚀 Starting containers..."
	docker-compose up -d
	@echo "✅ Application running at http://localhost:5048"

# Stop containers
down:
	@echo "🛑 Stopping containers..."
	docker-compose down

# Restart containers
restart:
	@echo "🔄 Restarting containers..."
	docker-compose restart

# View logs
logs:
	@echo "📋 Viewing logs (Ctrl+C to exit)..."
	docker-compose logs -f

# Check status
status:
	@echo "📊 Container Status:"
	@docker-compose ps
	@echo ""
	@echo "🔍 Health Check:"
	@docker inspect --format='{{.State.Health.Status}}' card-processing-system 2>/dev/null || echo "Container not running"

# Access shell
shell:
	@echo "🐚 Accessing container shell..."
	docker-compose exec card-processing-app bash

# Clean up everything
clean:
	@echo "🧹 Cleaning up..."
	docker-compose down -v
	docker image prune -f
	@echo "✅ Cleanup complete!"

# Rebuild everything
rebuild: clean build up
	@echo "✅ Rebuild complete!"

# Development mode (with auto-reload)
dev:
	@echo "🔧 Starting in development mode..."
	docker-compose up

# Production build
prod: build up
	@echo "✅ Production deployment complete!"
