# Extract credentials for kubeadmin
KUBEADMIN_PWD=`crc console --credentials |sed '$!d' | sed -e "s/'//g" | sed -e "s/\.//g" | awk 'NF>1{print $NF}'`

# Login with kubeadmin
oc login -u kubeadmin -p $KUBEADMIN_PWD https://api.crc.testing:6443

# Create admin user for htpasswd Provider (see https://docs.openshift.com/container-platform/4.2/authentication/identity_providers/configuring-htpasswd-identity-provider.html)
htpasswd -c -B -b users.htpasswd developer developer && htpasswd -b users.htpasswd admin admin
oc delete secret htpass-secret -n openshift-config
oc create secret generic htpass-secret --from-file=htpasswd=./users.htpasswd -n openshift-config
sleep 5
oc adm policy add-cluster-role-to-user cluster-admin admin
rm ./users.htpasswd

#Login with admin and remove kubeadmin user
sleep 2
oc login -u admin -p admin https://api.crc.testing:6443
oc delete secrets kubeadmin -n kube-system