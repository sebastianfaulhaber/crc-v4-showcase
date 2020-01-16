# crc-v4-showcase

## Initial setup of demo environment

### Install CodeReady Containers (MacOS)
1. Go to https://cloud.redhat.com/openshift/install/crc/installer-provisioned and download “macOS: Download (HyperKit)”
2. Download your personal “Pull Secret” to `~/.crc-pull-secret`
3. Extract and install the crc binary
```
    tar -vxf crc-macos-amd64.tar.xz && cd crc-macos-*
    mv crc /usr/local/bin/
    crc setup
```
4. Configure Pull Secret
```
crc config set pull-secret-file ~/.crc-pull-secret 
```

### Create Pull secret for Red Hat Container Catalog
1. Create a new Registry Service Accounts here: https://access.redhat.com/terms-based-registry/#/accounts
2. Download the OpenShift Secret and save it to `config/crc-secret.yaml`

## Start demo environment

### Start CodeReady Containers (MacOS)
```
crc start && eval $(crc oc-env)
```

### Customize CodeReady Containers installation
```
./customise_crc.sh
```

### Activate Command completion for bash [OPTIONAL]
source $(brew --prefix)/etc/bash_completion && oc completion bash > ~/.oc_bash_completion.sh && source ~/.oc_bash_completion.sh

### Credentials

| Username      | Password      | Login command |
| ------------- | ------------- | ------------- |
| developer     | developer     | `oc login -u developer -p developer https://api.crc.testing:6443` 
| admin         | admin         | `oc login -u admin -p admin https://api.crc.testing:6443` |



# TODO

## TODO: Add build pipelines
