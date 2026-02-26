#!/bin/sh

FOLDER=$1

if [ -f .env ]; then
  echo "Removing local .env to enforce injected configuration..."
  rm .env
fi

echo "Running against BASE_URL: $BASE_URL"

if [ -z "$FOLDER" ] || [ "$FOLDER" = "all" ]; then
  echo "Running ALL tests..."
  npx playwright test
else
  echo "Running tests in folder: $FOLDER"
  npx playwright test "$FOLDER"
fi
