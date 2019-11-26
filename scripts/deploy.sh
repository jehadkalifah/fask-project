# pushing the images to Docker Hub
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
ls -l
docker build -t $DOCKER_WEB_IMAGE -f Dockerfile /web 
docker build -t $DOCKER_NGINX_IMAGE -f Dockerfile /nginx 
docker push $DOCKER_WEB_IMAGE
docker push $DOCKER_NGINX_IMAGE

# testing the environment
docker-compose up -d
docker ps
docker-compose down 

# deploy the environment to Azure Kubernetes Service
#sudo az login --service-principal -u $AZURE_SP_USERNAME -p $AZURE_SP_PASSWORD --tenant $AZURE_SP_TENANT
#sudo az aks get-credentials --resource-group $AZURE_AKS_RESOURCE_GROUP --name $AZURE_AKS_NAME
#sudo kubectl apply -f ./kube
#sudo kubectl get all -n fask-namespace
