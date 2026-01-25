#!/bin/sh

FOLDER_PATH=$1

echo "🚀 Starting Agnostic Entrypoint..."
echo "📂 Target Folder: ${FOLDER_PATH:-all}"

if [ -f .env ]; then
    echo "🧹 Removing local .env file to enforce Worker configuration..."
    rm .env
fi

echo "🔍 Environment Check:"
echo "   Running against BASE_URL: $BASE_URL"


if [ -z "$FOLDER_PATH" ] || [ "$FOLDER_PATH" = "all" ]; then
    echo "▶️ Running ALL tests..."
    npx playwright test
else
    echo "▶️ Running tests in specific folder: $FOLDER_PATH"
    npx playwright test "$FOLDER_PATH"
fi

echo "📊 Generating Allure Report..."
npx allure generate allure-results --clean -o allure-report