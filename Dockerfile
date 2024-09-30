# Use Node.js base image
FROM node:16

# Install Azure CLI
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

# Set up work directory
WORKDIR /usr/src/app

# Copy action code
COPY . .

# Install project dependencies
RUN npm install

# Set default entrypoint
ENTRYPOINT ["node", "/usr/src/app/entrypoint.js"]
