FROM node:20 AS builder

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm install

COPY . .
RUN npm run build

# Step 2: Serve the built files using a lightweight web server
FROM node:20-alpine

WORKDIR /app

# Copy the built files from the previous stage
COPY --from=builder /app/dist ./dist

# Install serve to serve the built files
RUN npm install -g serve

# Expose the port on which the server will run
EXPOSE 5173

# Command to run the web server and serve the built files
CMD ["serve", "-s", "dist", "-l", "5173"]
