# Use a modern and stable version of Node.js
FROM node:18

# Set the working directory inside the container
WORKDIR /app

# Copy all project files into the container
COPY . .

# Install dependencies
RUN npm install

# Expose default port (can be mapped to another one at runtime)
EXPOSE 3001

# Start the application
CMD ["npm", "start"]

