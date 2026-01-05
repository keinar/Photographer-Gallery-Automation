# Use official Playwright image as base
FROM mcr.microsoft.com/playwright:v1.57.0-jammy

# Install Java for Allure report generation
RUN apt-get update && apt-get install -y default-jre && \
    npm install -g allure-commandline && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

ENV BASE_URL=http://localhost:4200
ENV ADMIN_USER=default@admin.com
ENV ADMIN_PASS=default_pass

COPY package.json package-lock.json ./
RUN npm install --legacy-peer-deps

# Copy all Playwright configuration files
COPY playwright.config.ts ./
COPY global.setup.ts ./

# Copy all source folders
COPY config ./config
COPY tests ./tests
COPY helpers ./helpers
COPY pages ./pages
COPY fixtures ./fixtures
COPY services ./services
COPY repositories ./repositories
COPY entrypoint.sh ./
RUN chmod +x entrypoint.sh

# Create a directory for results
RUN mkdir -p /app/results

CMD ["./entrypoint.sh", "all"]