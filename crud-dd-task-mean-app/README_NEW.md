# MEAN Stack CRUD Application with DevOps Pipeline

A full-stack CRUD application built with MongoDB, Express.js, Angular 15, and Node.js, featuring complete Dockerization and CI/CD pipeline deployment.

![MEAN Stack](https://img.shields.io/badge/Stack-MEAN-green)
![Docker](https://img.shields.io/badge/Docker-Containerized-blue)
![CI/CD](https://img.shields.io/badge/CI/CD-GitHub%20Actions-orange)
![Nginx](https://img.shields.io/badge/Proxy-Nginx-brightgreen)

---

## 📋 Table of Contents
- [Project Overview](#project-overview)
- [Features](#features)
- [Technology Stack](#technology-stack)
- [Architecture](#architecture)
- [Quick Start](#quick-start)
- [Deployment](#deployment)
- [Screenshots](#screenshots)
- [Documentation](#documentation)

---

## 🎯 Project Overview

This application manages a collection of tutorials with full CRUD (Create, Read, Update, Delete) operations. Each tutorial includes:
- **ID**: Unique identifier
- **Title**: Tutorial name
- **Description**: Detailed content
- **Published Status**: Boolean flag

### Key Capabilities:
 Create new tutorials  
 View all tutorials  
 Update existing tutorials  
 Delete tutorials  
 Search tutorials by title  
 Filter by published status  

---

##  Features

### Application Features:
- RESTful API backend with Express.js
- Reactive Angular frontend
- MongoDB database with Mongoose ODM
- Real-time search functionality
- Responsive UI design

### DevOps Features:
- **Dockerized** - Both frontend and backend containerized
- **CI/CD Pipeline** - Automated deployment with GitHub Actions
- **Cloud Deployed** - Running on Ubuntu VM
- **Nginx Reverse Proxy** - Secure access on port 80
- **Docker Hub** - Automated image builds and storage
- **Auto Deployment** - Push to GitHub triggers auto-deploy

---

## 🛠 Technology Stack

### Frontend:
- **Angular 15** - Modern web framework
- **Bootstrap 4** - UI styling
- **RxJS** - Reactive programming
- **TypeScript** - Type-safe JavaScript

### Backend:
- **Node.js** - JavaScript runtime
- **Express.js** - Web framework
- **Mongoose** - MongoDB ODM
- **CORS** - Cross-origin resource sharing

### Database:
- **MongoDB 6.0** - NoSQL database

### DevOps:
- **Docker** - Containerization
- **Docker Compose** - Multi-container orchestration
- **GitHub Actions** - CI/CD pipeline
- **Nginx** - Reverse proxy server
- **Ubuntu Server** - Cloud VM deployment

---

## 🏗 Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                         User Browser                         │
└───────────────────────────┬─────────────────────────────────┘
                            │ HTTP (Port 80)
                            ▼
┌─────────────────────────────────────────────────────────────┐
│                    Nginx Reverse Proxy                       │
│                     (Ubuntu VM - Port 80)                    │
└────────────┬─────────────────────────────────┬──────────────┘
             │                                 │
             │ Proxy to :4200                  │ Proxy to :8080/api
             ▼                                 ▼
┌──────────────────────────┐      ┌──────────────────────────┐
│   Frontend Container     │      │   Backend Container      │
│   (Angular + Nginx)      │─────▶│   (Node.js + Express)    │
│      Port: 4200          │      │      Port: 8080          │
└──────────────────────────┘      └───────────┬──────────────┘
                                              │
                                              │ Port 27017
                                              ▼
                                  ┌──────────────────────────┐
                                  │   MongoDB Container      │
                                  │      Port: 27017         │
                                  │   Volume: mongodb_data   │
                                  └──────────────────────────┘
```

### CI/CD Pipeline Flow:

```
Developer → Git Push → GitHub → GitHub Actions
                                      │
                    ┌─────────────────┴──────────────────┐
                    ▼                                    ▼
            Build Docker Images                  Deploy to VM
                    │                                    │
                    ├─ Backend Image                     ├─ SSH to VM
                    ├─ Frontend Image                    ├─ Pull latest images
                    │                                    ├─ Stop old containers
                    ▼                                    ├─ Start new containers
            Push to Docker Hub                           └─ Health checks
                    │
                    └────────────────▶ VM pulls images
```

---

## Quick Start

### Prerequisites:
- Docker & Docker Compose installed
- Node.js 18+ (for local development)
- Git

### Local Development (Without Docker):

#### 1. Backend Setup:
```bash
cd backend
npm install
node server.js
# Backend runs on http://localhost:8080
```

#### 2. Frontend Setup:
```bash
cd frontend
npm install
ng serve --port 8081
# Frontend runs on http://localhost:8081
```

#### 3. Database Configuration:
Update `backend/app/config/db.config.js` with your MongoDB connection string.

### Local Development (With Docker):

```bash
# Clone repository
git clone <your-repo-url>
cd crud-dd-task-mean-app

# Start all services
docker-compose up --build

# Access application
# Frontend: http://localhost:4200
# Backend API: http://localhost:8080
# MongoDB: localhost:27017
```

---

## Deployment

### Build and Push Docker Images:

```powershell
# On Windows
.\build-and-push.ps1

# On Linux/Mac
./build-and-push.sh
```

### Manual Deployment to VM:

```bash
# SSH into your VM
ssh ubuntu@YOUR_VM_IP

# Clone repository
git clone <your-repo-url> /home/ubuntu/crud-dd-task-mean-app
cd /home/ubuntu/crud-dd-task-mean-app

# Run deployment script
chmod +x deploy.sh
./deploy.sh
```

### Automated Deployment:

1. **Push to GitHub** - Any push to `main` branch
2. **GitHub Actions Triggers** - Builds images automatically
3. **Images Push to Docker Hub** - Tagged with latest and commit SHA
4. **Auto Deploy to VM** - SSH deployment via GitHub Actions
5. **Health Checks** - Automatic verification

---

## 📸 Screenshots

### 1. Application Interface
<!-- Add screenshot of your Angular app -->
![App Interface](screenshots/app-interface.png)

### 2. GitHub Actions Pipeline
<!-- Add screenshot of successful GitHub Actions run -->
![CI/CD Pipeline](screenshots/github-actions.png)

### 3. Docker Hub Repository
<!-- Add screenshot of Docker Hub with your images -->
![Docker Hub](screenshots/docker-hub.png)

### 4. Running Containers
<!-- Add screenshot of docker ps output -->
![Containers](screenshots/containers.png)

### 5. Nginx Configuration
<!-- Add screenshot of Nginx setup -->
![Nginx Setup](screenshots/nginx-config.png)

### 6. Application Demo
<!-- Add screenshots of CRUD operations -->
![CRUD Operations](screenshots/crud-demo.png)

---

## 📚 Documentation

### Setup Guides:
- **[SETUP_CHECKLIST.md](SETUP_CHECKLIST.md)** - Complete setup checklist
- **[VM_SETUP.md](VM_SETUP.md)** - Ubuntu VM configuration guide
- **[CI_CD_SETUP.md](CI_CD_SETUP.md)** - GitHub Actions setup
- **[NGINX_SETUP.md](NGINX_SETUP.md)** - Nginx configuration guide

### Configuration Files:
- `docker-compose.yml` - Local development setup
- `docker-compose.prod.yml` - Production deployment
- `.github/workflows/deploy.yml` - CI/CD pipeline
- `nginx-vm.conf` - Nginx reverse proxy config

---

## 🔧 Configuration

### Environment Variables:

#### Backend (.env):
```env
DB_HOST=mongodb
DB_PORT=27017
DB_NAME=dd_db
PORT=8080
```

#### Frontend:
Update `src/app/services/tutorial.service.ts` for API endpoint:
```typescript
private baseUrl = 'http://YOUR_VM_IP/api/tutorials';
```

### GitHub Secrets Required:
- `DOCKER_USERNAME` - Docker Hub username
- `DOCKER_PASSWORD` - Docker Hub access token
- `VM_HOST` - VM public IP address
- `VM_USER` - SSH username (ubuntu)
- `VM_SSH_KEY` - Private SSH key for VM access

---

## 🧪 Testing

### Local Testing:
```bash
# Test backend
curl http://localhost:8080/api/tutorials

# Test frontend
curl http://localhost:4200
```

### Production Testing:
```bash
# Test via Nginx (port 80)
curl http://YOUR_VM_IP/api/tutorials
```

---

## 📊 API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/tutorials` | Get all tutorials |
| GET | `/api/tutorials/:id` | Get tutorial by ID |
| POST | `/api/tutorials` | Create new tutorial |
| PUT | `/api/tutorials/:id` | Update tutorial |
| DELETE | `/api/tutorials/:id` | Delete tutorial |
| DELETE | `/api/tutorials` | Delete all tutorials |
| GET | `/api/tutorials?title=keyword` | Search by title |

---

## 🐛 Troubleshooting

### Container Issues:
```bash
# View logs
docker-compose logs -f

# Restart services
docker-compose restart

# Rebuild images
docker-compose up --build
```

### Nginx Issues:
```bash
# Check status
sudo systemctl status nginx

# View logs
sudo tail -f /var/log/nginx/error.log

# Test configuration
sudo nginx -t
```

### CI/CD Issues:
- Check GitHub Actions logs
- Verify GitHub Secrets are correct
- Test SSH connection manually
- Check Docker Hub for image uploads

---



## 📝 Project Structure

```
crud-dd-task-mean-app/
├── backend/
│   ├── app/
│   │   ├── config/
│   │   │   └── db.config.js
│   │   ├── controllers/
│   │   │   └── tutorial.controller.js
│   │   ├── models/
│   │   │   ├── index.js
│   │   │   └── tutorial.model.js
│   │   └── routes/
│   │       └── tutorial.routes.js
│   ├── Dockerfile
│   ├── .dockerignore
│   ├── package.json
│   └── server.js
├── frontend/
│   ├── src/
│   │   ├── app/
│   │   │   ├── components/
│   │   │   ├── models/
│   │   │   └── services/
│   │   ├── assets/
│   │   └── index.html
│   ├── Dockerfile
│   ├── nginx.conf
│   ├── .dockerignore
│   └── package.json
├── .github/
│   └── workflows/
│       └── deploy.yml
├── docker-compose.yml
├── docker-compose.prod.yml
├── deploy.sh
├── build-and-push.ps1
├── nginx-vm.conf
└── README.md
```

---


