# crc-v4-showcase

## Create Pull secret for Red Hat Container Catalog
1. Create a new Registry Service Accounts here: https://access.redhat.com/terms-based-registry/#/accounts
2. Download the OpenShift Secret and save it to `config/crc-secret.yaml`


## Setup Demo Application
Create template for demo application `oc create -f ./config/company-website-template.yml`

## TODO: Try to import images from Red Hat Registry beforehand

1. See https://docs.openshift.com/container-platform/4.2/openshift_images/image-streams-manage.html#images-imagestreams-import_image-streams-managing
oc tag registry.redhat.io/rhoar-nodejs/nodejs-10 nodejs:10 --scheduled=true -n openshift

2. Use import-image
oc import-image nodejs:latest -n openshift

https://github.com/RedHat-EMEA-SSA-Team/skopeo-ubi