FROM node:18-alpine

WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install


COPY . .

# Expose the port the app runs on
EXPOSE 3000


CMD ["npm", "start"]