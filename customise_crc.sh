# Extract credentials for kubeadmin (see https://www-user.tu-chemnitz.de/~hot/unix_linux_werkzeugkasten/awk.html)
KUBEADMIN_PWD=`crc console --credentials | awk '/kubeadmin/' | awk '{print $(NF-1)}'`
CRC_ADMIN_URL='https://api.crc.testing:6443'

# Login with kubeadmin
oc login -u kubeadmin -p $KUBEADMIN_PWD $CRC_ADMIN_URL

# Create admin user for htpasswd Provider (see https://docs.openshift.com/container-platform/4.2/authentication/identity_providers/configuring-htpasswd-identity-provider.html)
htpasswd -c -B -b users.htpasswd developer developer && htpasswd -b users.htpasswd admin admin
oc delete secret htpass-secret -n openshift-config
oc create secret generic htpass-secret --from-file=htpasswd=./users.htpasswd -n openshift-config
sleep 10
oc adm policy add-cluster-role-to-user cluster-admin admin
rm ./users.htpasswd

# Login with admin and remove kubeadmin user
sleep 2
oc login -u admin -p admin $CRC_ADMIN_URL
oc delete secrets kubeadmin -n kube-system

# Create demo project
oc new-project company-website --display-name='Company Website' --description='My new company website based on a modern cloud native development stack.' --as=developer --as-group=system:authenticated --as-group=system:authenticated:oauth
# Create Pull Secret for Red Hat Container Catalog
kubectl create -f config/crc-secret.yaml --namespace=company-website