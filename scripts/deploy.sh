# pushing the images to Docker Hub
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
docker push $DOCKER_WEB_IMAGE
docker push $DOCKER_NGINX_IMAGE

# testing the environment
echo $PWD
ls -l
docker-compose -f docker-compose.yml up -d
docker ps
docker-compose down 


#sudo az login --service-principal -u $AZURE_SP_USERNAME -p $AZURE_SP_PASSWORD --tenant $AZURE_SP_TENANT
#sudo az aks get-credentials --resource-group $AZURE_AKS_RESOURCE_GROUP --name $AZURE_AKS_NAME
#sudo kubectl apply -f ./kube
#sudo kubectl get all -n fask-namespace
