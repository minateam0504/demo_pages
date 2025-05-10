.PHONY: build start stop restart logs clean help

# Default target
.DEFAULT_GOAL := help

# Docker Compose commands
build: ## Build the Docker image
	docker-compose build

start: ## Start the Docker container
	docker-compose up -d

stop: ## Stop the Docker container
	docker-compose down

restart: ## Restart the Docker container
	docker-compose restart

logs: ## View container logs
	docker-compose logs -f

clean: ## Remove containers and images
	docker-compose down --rmi all

# Development commands
dev: ## Run the application in development mode
	cd app && uvicorn main:app --reload --host 0.0.0.0 --port 8000

# Help command
help: ## Display this help message
	@echo "Mina Backend Service"
	@echo ""
	@echo "Usage:"
	@echo "  make [target]"
	@echo ""
	@echo "Targets:"
	@awk -F ':|##' '/^[^\t].+?:.*?##/ { printf "  %-15s %s\n", $$1, $$NF }' $(MAKEFILE_LIST)
