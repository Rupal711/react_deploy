# Use a Node.js base image
FROM node:14

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the React app for production
RUN npm run build

# Install serve to serve the React build
RUN npm install -g serve

# Command to run the application
CMD ["serve", "-s", "build", "-l", "3000"]

# Expose port 3000
EXPOSE 3000
