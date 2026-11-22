set -e

echo "Building images..."
docker compose build

echo "Starting containers..."
docker compose up -d

echo "Waiting for the services to start..."
sleep 15

echo "Stopping containers..."
docker compose down

echo "Pushing images..."
docker compose push
