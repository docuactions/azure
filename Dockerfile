# Use Node.js base image
FROM node:16

# Install Azure CLI
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

# Set up work directory
WORKDIR /usr/src/app

# Copy only package.json and package-lock.json first to leverage Docker cache
COPY package*.json ./

# Install project dependencies
RUN npm install

# Copy the rest of the action code (the Docusaurus project)
COPY . .

# Build the Docusaurus site
RUN npm run build

# Set default entrypoint
ENTRYPOINT ["node", "/usr/src/app/entrypoint.js"]
