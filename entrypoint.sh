#!/bin/sh
FOLDER_PATH=$1

echo "🚀 Starting tests in folder: ${FOLDER_PATH}"

if [ "$FOLDER_PATH" = "all" ] || [ -z "$FOLDER_PATH" ]; then
    npx playwright test
else
    npx playwright test "$FOLDER_PATH"
fi

# Generate Allure report
npx allure generate allure-results --clean -o allure-report