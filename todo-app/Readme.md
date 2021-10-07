# **_To-Do App_**
      Simple Web Application for adding daily task for tracking purpose. Application UI developed using HTML & backend web api develpoed using Python flask and using Firestore DB for Storage.
      Application build as a image using Docker , pushed into GCR & deployed into GKE. 
      Istio is configured in PROD & DR cluster for service management.
      Grafana is added to Istio for monitoring.
      
## Setup
    1. Build the application UI & Web Api as a image using Docker files available in Application folder
    2. Push the images to GCR
    3. Create Prod & DR clusters in GKE using terraform file available in Production_Cluster & DR_Cluster folders
    4. Configure Prod & DR Cluster, Install Istio as a addon & Deploy the application images in GKE using this automation script "GKE_Configuration_And_Deployment.sh" available in 
       Scripts folder (Deployment YAML file available in K8s_deployment_files folder)
    5. Add the granfana to using the script avalaible in Scripts folder
    6. Provide the load using Apache beam by applying the script avalaible in Scripts folder
    7. Deleting the "as-ui-deployment.yaml" file to check the DR cluster is working
    8. Destry the clusters using terraform
