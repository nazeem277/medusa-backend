# Use the official Node.js image as a base image
FROM node:16

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json (or yarn.lock)
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the application code
COPY . .

# Expose the port, app will run on it
EXPOSE 9000

# command to run the application
CMD ["npm", "run", "start"]
