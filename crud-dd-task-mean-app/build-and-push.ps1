
$DOCKER_USERNAME = "faiz72043"
$BACKEND_IMAGE = "${DOCKER_USERNAME}/mean-app-backend"
$FRONTEND_IMAGE = "${DOCKER_USERNAME}/mean-app-frontend"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Building and Pushing Docker Images" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""


try {
    docker ps | Out-Null
} catch {
    Write-Host " Error: Docker is not running!" -ForegroundColor Red
    Write-Host "Please start Docker Desktop and try again." -ForegroundColor Yellow
    exit 1
}


Write-Host "Logging into Docker Hub..." -ForegroundColor Yellow
docker login
if ($LASTEXITCODE -ne 0) {
    Write-Host " Docker login failed!" -ForegroundColor Red
    exit 1
}


Write-Host ""
Write-Host "Building Backend Image..." -ForegroundColor Yellow
docker build -t "${BACKEND_IMAGE}:latest" ./backend
if ($LASTEXITCODE -ne 0) {
    Write-Host " Backend build failed!" -ForegroundColor Red
    exit 1
}
Write-Host " Backend image built successfully" -ForegroundColor Green


Write-Host ""
Write-Host "Building Frontend Image..." -ForegroundColor Yellow
docker build -t "${FRONTEND_IMAGE}:latest" ./frontend
if ($LASTEXITCODE -ne 0) {
    Write-Host " Frontend build failed!" -ForegroundColor Red
    exit 1
}
Write-Host " Frontend image built successfully" -ForegroundColor Green


Write-Host ""
Write-Host "Pushing Backend Image to Docker Hub..." -ForegroundColor Yellow
docker push "${BACKEND_IMAGE}:latest"
if ($LASTEXITCODE -ne 0) {
    Write-Host " Backend push failed!" -ForegroundColor Red
    exit 1
}
Write-Host " Backend image pushed successfully" -ForegroundColor Green


Write-Host ""
Write-Host "Pushing Frontend Image to Docker Hub..." -ForegroundColor Yellow
docker push "${FRONTEND_IMAGE}:latest"
if ($LASTEXITCODE -ne 0) {
    Write-Host " Frontend push failed!" -ForegroundColor Red
    exit 1
}
Write-Host " Frontend image pushed successfully" -ForegroundColor Green


Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host " All images built and pushed!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Your images are now available at:" -ForegroundColor White
Write-Host "  • https://hub.docker.com/r/${DOCKER_USERNAME}/mean-app-backend" -ForegroundColor Cyan
Write-Host "  • https://hub.docker.com/r/${DOCKER_USERNAME}/mean-app-frontend" -ForegroundColor Cyan
Write-Host ""

