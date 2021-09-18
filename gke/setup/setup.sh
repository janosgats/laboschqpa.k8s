helm install main-release ingress-nginx/ingress-nginx

kubectl -n=qpa create secret generic protected-ingress-basic-auth-secret --from-file=auth=protected-ingress-basic-auth.htpasswd

kubectl -n=qpa create secret generic laboschqpa-server-secrets --from-file=secrets.properties=server-secrets.properties
kubectl -n=qpa create secret generic laboschqpa-filehost-secrets --from-file=secrets.properties=filehost-secrets.properties
kubectl -n=qpa create secret generic laboschqpa-imageconverter-secrets --from-file=secrets.properties=imageconverter-secrets.properties


gcloud iam service-accounts add-iam-policy-binding --role roles/iam.workloadIdentityUser --member "serviceAccount:qpa-web-2.svc.id.goog[qpa/cloud-sql-auth-proxy]" cloud-sql-auth-proxy@qpa-web-2.iam.gserviceaccount.com


helm repo add jetstack https://charts.jetstack.io
helm repo update
helm install cert-manager jetstack/cert-manager --namespace cert-manager --version v1.2.0
kubectl apply -f https://github.com/jetstack/cert-manager/releases/download/v1.2.0/cert-manager.crds.yaml