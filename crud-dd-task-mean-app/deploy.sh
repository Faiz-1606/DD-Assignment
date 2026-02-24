

set -e  

echo "=========================================="
echo "Starting MEAN App Deployment"
echo "=========================================="


APP_DIR="/home/ubuntu/crud-dd-task-mean-app"
DOCKER_COMPOSE_FILE="$APP_DIR/docker-compose.yml"


cd $APP_DIR

echo "Pulling latest code from GitHub..."
git pull origin main 2>/dev/null || git pull origin master 2>/dev/null || echo "Already up to date"


if [ -f .env ]; then
    export $(grep -v '^#' .env | xargs)
fi

echo "Docker Username: ${DOCKER_USERNAME:-not set}"

echo "Pulling latest Docker images from Docker Hub..."
docker-compose pull

echo "Stopping existing containers..."
docker-compose down

echo "Starting containers with updated images..."
docker-compose up -d

echo "Waiting for services to start..."
sleep 15

echo "Checking container status..."
docker-compose ps

echo "Cleaning up old Docker images..."
docker image prune -f

echo "=========================================="
echo "Deployment completed successfully!"
echo "=========================================="


echo ""
echo "Running health checks..."
echo "----------------------------------------"


if curl -f -s http://localhost:8080/ >/dev/null 2>&1; then
    echo "✓ Backend is running on port 8080"
else
    echo "✗ Backend is not responding on port 8080"
fi


if curl -f -s http://localhost:4200/ >/dev/null 2>&1; then
    echo "✓ Frontend is running on port 4200"
else
    echo "✗ Frontend is not responding on port 4200"
fi


if docker exec mongodb mongosh --eval "db.adminCommand('ping')" >/dev/null 2>&1; then
    echo "✓ MongoDB is running"
else
    echo "✗ MongoDB connection failed"
fi


if systemctl is-active --quiet nginx; then
    echo "✓ Nginx is running"
else
    echo "✗ Nginx is not running"
fi

echo "----------------------------------------"
echo ""
echo "View logs with: docker-compose logs -f"
echo "Application accessible at: http://$(curl -s ifconfig.me)"
