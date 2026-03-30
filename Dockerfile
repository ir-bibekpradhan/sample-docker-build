# Use official Node.js LTS image
FROM node:20-alpine

# # Set working directory
# WORKDIR /app

# Copy package files and install dependencies
COPY app/package*.json ./app/
# RUN HTTP_PROXY=http://10.1.0.15:3128 HTTPS_PROXY=http://10.1.0.15:3128 http_proxy=http://10.1.0.15:3128 https_proxy=http://10.1.0.15:3128 NO_PROXY=pse.invisirisk.com,localhost,127.0.0.1 no_proxy=pse.invisirisk.com,localhost,127.0.0.1 NODE_EXTRA_CA_CERTS=/pse-ca/pse.crt SSL_CERT_FILE=/pse-ca/pse.crt REQUESTS_CA_BUNDLE=/pse-ca/pse.crt PIP_CERT=/pse-ca/pse.crt BUNDLE_SSL_CA_CERT=/pse-ca/pse.crt CURL_CA_BUNDLE=/pse-ca/pse.crt GIT_SSL_CAINFO=/pse-ca/pse.crt cd app

RUN MY_DEVELOP_ENV=development printenv
RUN cd app
RUN npm install --production

# Copy application source
COPY app/index.js ./app/

# Expose port
EXPOSE 3000

# Run the app
CMD ["node", "index.js"]
