# Use the official Node.js image from the Docker Hub
FROM node:14

# Create and set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Expose port (adjust if necessary)
EXPOSE 3000

# Start the application
CMD ["npm", "start"]
