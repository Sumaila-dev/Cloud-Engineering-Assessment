FROM node:18-alpine

WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install


COPY . .

# Build the application
RUN npm run build

# Expose the port the app runs on
EXPOSE 80


CMD ["npm", "run", "preview"]