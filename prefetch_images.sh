echo '###############################################################################'
echo 'Prefetch images'
echo '###############################################################################'
# Create dummy project for prefetching images
oc new-project prefetch-images
# Create Pull Secret for Red Hat Container Catalog
kubectl create -f config/crc-secret.yaml --namespace=prefetch-images
# Create template for demo application and provision it
oc create -f ./config/company-website-template.yml -n prefetch-images
oc new-app --template=nodejs-mongo-persistent-custom -n prefetch-images
echo 'Waiting 2m for prefetch to complete...'
sleep 120

# Cleanup
oc delete project prefetch-images