export PROJECT_ID=sre-bootcamp-328203
export PROD_ZONE=asia-south2-a
export DR_ZONE=us-central1-a

gcloud config set project $PROJECT_ID

# Enable the APIs
gcloud services enable anthos.googleapis.com multiclusteringress.googleapis.com gkehub.googleapis.com container.googleapis.com --project=$PROJECT_ID 

# Creating the Production Cluster in Asia Region

gcloud container clusters update prod-cluster --zone=$PROD_ZONE --workload-pool=$PROJECT_ID.svc.id.goog  --project=$PROJECT_ID 

gcloud beta container clusters update prod-cluster --zone=$PROD_ZONE --update-addons=Istio=ENABLED --istio-config=auth=MTLS_PERMISSIVE

# Creating the DR Cluster in Us Region

gcloud container clusters update dr-cluster --zone=$DR_ZONE --workload-pool=$PROJECT_ID.svc.id.goog  --project=$PROJECT_ID

gcloud beta container clusters update dr-cluster --zone=$DR_ZONE --update-addons=Istio=ENABLED --istio-config=auth=MTLS_PERMISSIVE


# Configure credentials for kubectl in PROD & DR clusters

gcloud container clusters get-credentials prod-cluster --zone=$PROD_ZONE --project=$PROJECT_ID

gcloud container clusters get-credentials dr-cluster --zone=$DR_ZONE --project=$PROJECT_ID


# Renaming the cluster context name

kubectl config rename-context gke_equifax-demo-326219_asia-south2-a_prod-cluster gke-asia
kubectl config rename-context gke_equifax-demo-326219_us-central1-a_dr-cluster gke-us


# Connecting the clusters into a single group

gcloud container hub memberships register prod-cluster --gke-cluster $PROD_ZONE/prod-cluster --enable-workload-identity --project=$PROJECT_ID

gcloud container hub memberships register dr-cluster --gke-cluster $DR_ZONE/dr-cluster  --enable-workload-identity --project=$PROJECT_ID

# To check the clusters connected or not

gcloud container hub memberships list --project=$PROJECT_ID


# Enable the ingress for US region

gcloud beta container hub ingress enable --config-membership=prod-cluster

# To check the status of the ingress

gcloud beta container hub ingress describe

# Configure the firewall for Multi Cluster ingress

gcloud compute firewall-rules create todoappfirewall --project $PROJECT_ID --network default  --direction INGRESS --allow tcp:0-65535 

# Deploying the application in PROD & DR clusters with ISTIO enabled

cd ../K8s_deployment_files

kubectl config use-context gke-asia

kubectl label namespace gke-connect istio-injection=enabled

kubectl apply -f api-deployment.yaml
kubectl apply -f asia-api-service.yaml
kubectl apply -f as-ui-deployment.yaml
kubectl apply -f autoscale-backend.yaml
kubectl apply -f autoscale-frontend.yaml

kubectl config use-context gke-us

kubectl label namespace gke-connect istio-injection=enabled

kubectl apply -f api-deployment.yaml
kubectl apply -f us-api-service.yaml
kubectl apply -f us-ui-deployment.yaml
kubectl apply -f autoscale-backend.yaml
kubectl apply -f autoscale-frontend.yaml

kubectl config use-context gke-asia

kubectl apply -f ui-mcs.yaml
kubectl apply -f ui-mci.yaml

kubectl describe mci zone-ingress -n gke-connect 
