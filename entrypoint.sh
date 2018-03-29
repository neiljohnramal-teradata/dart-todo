#!/bin/sh

echo "Waiting for postgres..."

while ! nc -z todos-db 5432; do
  sleep 0.1
done

echo "PostgreSQL has been started."

pub run aqueduct:aqueduct serve --port 8000
