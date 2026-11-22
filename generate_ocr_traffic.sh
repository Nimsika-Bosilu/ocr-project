#!/bin/bash

# OCR API Traffic Generator

MINIKUBE_IP=$(minikube ip -p ocr-devops)
NODE_PORT=$(kubectl get svc api-gateway -n ocr-system -o jsonpath='{.spec.ports[0].nodePort}')

URL="http://${MINIKUBE_IP}:${NODE_PORT}/gateway/ocr"

echo "===================================="
echo "       OCR Traffic Generator"
echo "===================================="
echo "Target URL: $URL"
echo ""

# Generate 50 successful inference requests
echo "[INFO] Sending 50 valid image requests..."

for i in $(seq 1 50); do
    curl -s -o /dev/null -X POST "$URL" \
        -F "image_file=@tests/test.png"
done

echo "[SUCCESS] 50 valid requests sent."

# Generate 5 invalid image requests
echo "not an image" > /tmp/bad.png

echo "[INFO] Sending 5 invalid image requests..."

for i in $(seq 1 5); do
    curl -s -o /dev/null -X POST "$URL" \
        -F "image_file=@/tmp/bad.png"
done

echo "[SUCCESS] 5 invalid requests sent."

echo ""
echo "===================================="
echo "       Traffic Generation Done"
echo "===================================="
echo "Valid Requests   : 50"
echo "Invalid Requests : 5"
echo "Total Requests   : 55"