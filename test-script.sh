#!/bin/bash
# Container testing script for the Todo List application

echo "Testing Docker containers..."

# Check if containers are running
echo "Checking container status..."
if [ $(docker-compose ps | grep "Up" | wc -l) -ne 3 ]; then
  echo "Error: Not all containers are running!"
  docker-compose ps
  exit 1
fi
echo "All containers are running."

# Test for frontend
echo "Testing frontend..."
if ! curl -s http://localhost:80 | grep -q "React"; then
  echo "Error: Frontend not responding correctly!"
  exit 1
fi
echo "Frontend is working."

# Test for backend
echo "Testing backend API..."
if ! curl -s http://localhost:3000 | grep -q "Todo"; then
  echo "Error: Backend not responding correctly!"
  exit 1
fi
echo "Backend is working."

# Test MongoDB connection to backend
echo "Testing MongoDB connection..."
MONGO_TEST=$(docker exec backend node -e "const mongoose = require('mongoose'); mongoose.connect(process.env.MONGO_URI).then(() => console.log('Connected')).catch(err => console.error(err))")
if ! echo $MONGO_TEST | grep -q "Connected"; then
  echo "Error: MongoDB connection failed!"
  exit 1
fi
echo "MongoDB connection is working."

# Test API endpoints
echo "Testing API endpoints..."

# Test GET /api/gettodos
echo "Testing GET /api/gettodos endpoint..."
if ! curl -s http://localhost:3000/api/gettodos | grep -q "todoList"; then
  echo "Error: GET /api/gettodos endpoint not working!"
  exit 1
fi
echo "GET /api/gettodos endpoint is working."

# Test GET /todos
echo "Testing GET /todos endpoint..."
if ! curl -s "http://localhost:3000/todos?page=1&limit=10" | grep -q "todos"; then
  echo "Error: GET /todos endpoint not working!"
  exit 1
fi
echo "GET /todos endpoint is working."

# Test POST /api/todos
echo "Testing POST /api/todos endpoint..."
CREATE_RESPONSE=$(curl -s -X POST -H "Content-Type: application/json" -d '{"title":"Test Todo","description":"Test Description","activity":"Test Activity","date":"2023-06-15","strStatus":"pending"}' http://localhost:3000/api/todos)
if ! echo $CREATE_RESPONSE | grep -q "todo"; then
  echo "Error: POST /api/todos endpoint not working!"
  exit 1
fi
echo "POST /api/todos endpoint is working."

echo "All tests passed! The containerized application is running correctly."