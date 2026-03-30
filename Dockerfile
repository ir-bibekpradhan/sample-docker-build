# Use official Node.js LTS image
FROM node:20-alpine

# # Set working directory
# WORKDIR /app

# Copy package files and install dependencies
COPY app/package*.json ./app/
RUN MY_END=dev cd app && npm install --production

# Copy application source
COPY app/index.js ./app/

# Expose port
EXPOSE 3000

# Run the app
CMD ["node", "index.js"]
