<p align="center">
    <img src="https://user-images.githubusercontent.com/62269745/174906065-7bb63e14-879a-4740-849c-0821697aeec2.png#gh-light-mode-only" width="40%">
    <img src="https://user-images.githubusercontent.com/62269745/174906068-aad23112-20fe-4ec8-877f-3ee1d9ec0a69.png#gh-dark-mode-only" width="40%">
</p>

# Full-Stack Todo List Application

This repository hosts a full-stack Todo List application designed to allow users to create, manage, and organize their tasks efficiently. The application features a React-based frontend and a Node.js backend, utilizing MongoDB for data persistence.

## Technologies Used

- **Frontend**: React, Material-UI
- **Backend**: Node.js, Express
- **Database**: MongoDB
- **Other Tools**: Vite, React Toastify, Lucide Icons

## Project Structure

The project is divided into two main parts:
- **Frontend**: Located in the `frontend/` directory with its own [README](frontend/README.md).
- **Backend**: Located in the `backend/` directory with its own [README](backend/README.md).

## Features

- Create, view, update, and delete todo items.
- Organize tasks with tags/categories.
- Responsive user interface adaptable to different screen sizes.
- Real-time updates without page reloads.

## Contributing

Contributions are welcome! See the specific README files in the `frontend/` and `backend/` directories for more details on contributing.

## Live Demo

<h4 align="left">Live Preview is available at https://fullstack-todolist-1.onrender.com/</h4>

## Snapshots

<img src="./Frontend/src/assets/home-snapshot.png" alt="home page"/>



## Prerequisites

Before you begin, ensure you have the following installed on your system:

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)

## Setup Instructions

### 1. Clone the Repository

```bash
git clone <https://github.com/Sumaila-dev/Cloud-Engineering-Assessment>
cd Cloud-Engineering-Assessment
```

### 2. Configure Environment Variables (Optional)

The application comes with default environment variables configured in the Docker Compose file. If you need to customize these:

1. Copy the example environment files:

```bash
cp Backend/.env.example Backend/.env
cp Frontend/.env.example Frontend/.env
```

2. Edit the `.env` files as needed.

### 3. Build and Start the Containers

```bash
docker-compose up -d
```

This command will:
- Build the Docker images for the frontend and backend
- Pull the MongoDB image
- Start all three containers
- Set up the network between them

### 4. Access the Application

- Frontend: http://localhost:80
- Backend API: http://localhost:3000
- MongoDB: mongodb://localhost:27017

### 5. Stop the Containers

```bash
docker-compose down
```

To remove all data (including the MongoDB volume):

```bash
docker-compose down -v
```

## Network and Security Configurations

### Network Architecture

The application uses Docker Compose's networking features to create a bridge network (`app-network`) that connects all three containers:

- **Frontend Container**: Nginx server on port 80
- **Backend Container**: Node.js server on port 3000
- **MongoDB Container**: MongoDB server on port 27017

### Port Exposure

- **Port 80**: Exposed to the host for accessing the frontend
- **Port 3000**: Exposed to the host for direct API access
- **Port 27017**: Exposed to the host for direct MongoDB access (can be removed in production)

### Security Considerations

1. **Database Credentials**: 
   - In a production environment, you should set a username and password for MongoDB
   - Update the `MONGO_URI` environment variable in the backend service

2. **Environment Variables**:
   - Sensitive information is stored in environment variables
   - For production, consider using Docker secrets or a secure environment variable management solution

3. **Network Isolation**:
   - In production, consider using Docker's network isolation features to restrict access between containers
   - Only expose the frontend port (80) to the public internet

## Troubleshooting Guide

### Common Issues

#### 1. Container Fails to Start

**Symptoms**: One or more containers fail to start or exit immediately after starting.

**Solutions**:
- Check container logs: `docker-compose logs <service-name>`
- Verify port availability: Ensure ports 80, 3000, and 27017 are not in use by other applications
- Check disk space: Ensure you have enough disk space for the containers

#### 2. Frontend Cannot Connect to Backend

**Symptoms**: Frontend loads but todos don't appear or cannot be created.

**Solutions**:
- Check backend logs: `docker-compose logs backend`
- Verify backend is running: `docker-compose ps`
- Check network connectivity: `docker exec frontend ping backend`

#### 3. Backend Cannot Connect to MongoDB

**Symptoms**: Backend logs show MongoDB connection errors.

**Solutions**:
- Check MongoDB logs: `docker-compose logs mongodb`
- Verify MongoDB is running: `docker-compose ps`
- Check network connectivity: `docker exec backend ping mongodb`
- Verify connection string: Check the `MONGO_URI` environment variable in the backend service



