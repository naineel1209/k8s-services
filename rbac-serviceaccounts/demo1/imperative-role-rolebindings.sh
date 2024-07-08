kubectl create ns dev1
kubectl create serviceaccount demo2-sa -n dev1
kubectl create role demo2-deployment-creator --verb=create \
--resource=deployments.apps -n dev1
kubectl create rolebinding demo2-sa-deployment-binder \
--role=demo2-deployment-creator --serviceaccount=dev1:demo2-sa -n dev1
kubectl auth can-i create deployments --namespace dev1 \
--as=system:serviceaccount:dev1:demo2-sa
kubectl create token demo2-sa -n dev1
APISERVER=$(kubectl config view --minify -o \
jsonpath='{.clusters[0].cluster.server}')
curl -k -X POST $APISERVER/api/v1/namespaces/dev1/secrets \
    -H "Authorization: Bearer $TOKEN" \
    -H "Content-Type: application/json" \
    -d '{
        "apiVersion": "v1",
        "kind": "Secret",
        "metadata": {
            "name": "demo-secret"
        },
        "data": {
            "key": "'$SECRET_DATA'"
} }'
