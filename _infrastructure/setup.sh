###  Designed for ubuntu 24.04 WSL2
###  Install Kind
# For AMD64 / x86_64
[ $(uname -m) = x86_64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.27.0/kind-linux-amd64
# # Using WSL so not needed
# # For ARM64
# # [ $(uname -m) = aarch64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.27.0/kind-linux-arm64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind

# ### Start Kind Cluster named sandbox
kind create cluster --name sandbox

# Get ArgoCD Helm Chart
helm repo add argo https://argoproj.github.io/argo-helm
helm repo update

# Install ArgoCD v6.10.2 as LC
kubectl config use-context kind-sandbox
helm install argocd argo/argo-cd --version 6.10.2 \
  --namespace argocd \
  --create-namespace \
  --set server.service.type=NodePort

echo "Waiting for ArgoCD server pod to be ready..."

# Wait until the argocd-server pod is in 'Running' and 'Ready' state
kubectl wait --for=condition=ready pod -l app.kubernetes.io/name=argocd-server -n argocd --timeout=180s

# Get the ArgoCD admin password

echo "Fetching initial ArgoCD server credentials..."
echo "Username: admin"
echo "Password: $(kubectl get secret argocd-initial-admin-secret -n argocd \
  -o jsonpath="{.data.password}" | base64 --decode)" && echo


# Port forward the ArgoCD server
kubectl port-forward svc/argocd-server -n argocd 8080:80