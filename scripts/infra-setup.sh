set -e

minikube start -p ocr-devops --driver=docker --cpus=4 --memory=8192

helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add argo https://argoproj.github.io/argo-helm
helm repo update

helm upgrade --install kube-prometheus-stack prometheus-community/kube-prometheus-stack \
  -n monitoring --create-namespace \
  -f infra/helm-values/kube-prometheus-stack-values.yaml

helm upgrade --install argocd argo/argo-cd \
  -n argocd --create-namespace \
  -f infra/helm-values/argocd-values.yaml

kubectl create namespace ocr-system --dry-run=client -o yaml | kubectl apply -f -
