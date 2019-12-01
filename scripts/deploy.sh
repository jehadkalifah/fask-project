# Building and pushing the images to Docker Hub
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
docker build -t $DOCKER_WEB_IMAGE ./web 
docker build -t $DOCKER_NGINX_IMAGE ./nginx
docker push $DOCKER_WEB_IMAGE
docker push $DOCKER_NGINX_IMAGE

# testing the environment
docker-compose up -d
docker ps
docker-compose down 

# deploy the environment to Azure Kubernetes Service
sudo az login --service-principal -u $AZURE_SP_USERNAME -p $AZURE_SP_PASSWORD --tenant $AZURE_SP_TENANT
sudo az aks get-credentials --resource-group $AZURE_AKS_RESOURCE_GROUP --name $AZURE_AKS_NAME
sudo kubectl apply -f ./kube

# force to use the latest pushed images
sudo kubectl set image deployments/fask-web-deployment fask-web-container=$DOCKER_WEB_IMAGE -n fask-namespace
sudo kubectl set image deployments/fask-nginx-deployment fask-nginx-container=$DOCKER_NGINX_IMAGE -n fask-namespace

# check the deployment status
sudo kubectl get all -n fask-namespace -o wide
