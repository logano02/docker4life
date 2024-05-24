# # Multi stage
# # Stage 1: Install dependencies
# FROM --platform=linux/amd64/v4 node:18.18.2-alpine AS deps
# WORKDIR /usr/src/app
# COPY package*.json ./
# # COPY yarn.lock ./
# RUN npm install --frozen-lockfile --network-timeout 100000

# # Stage 2: Build the application
# FROM --platform=linux/amd64/v4 node:18.18.2-alpine AS builder
# WORKDIR /usr/src/app
# COPY --from=deps /usr/src/app/node_modules ./node_modules
# COPY . .
# RUN npm run build

# # Stage 3: Run the application
# FROM --platform=linux/amd64/v4 node:18.18.2-alpine
# WORKDIR /usr/src/app
# COPY --from=builder /usr/src/app/dist ./dist
# EXPOSE 3000
# CMD ["npx", "serve", "-l", "3000", "-s", "dist"]

# Single stage
# Use the base image
FROM --platform=linux/amd64/v4 node:18.18.2-alpine

# Set the working directory
WORKDIR /usr/src/app

# Copy package.json, yarn.lock, and install dependencies
COPY package*.json ./
# COPY yarn.lock ./
RUN npm install --frozen-lockfile --network-timeout 100000

# Copy the rest of the application code
COPY . .

# Build the application
RUN npm run build

# Expose the application port
EXPOSE 3000

# Run the application
CMD ["npx", "serve", "-l", "3000", "-s", "dist"]
