# easyTravel-OpenShift

![easyTravel Logo](https://github.com/dynatrace-innovationlab/easyTravel-Builder/blob/images/easyTravel-logo.png)

This project builds and deploys the [Dynatrace easyTravel](https://community.dynatrace.com/community/display/DL/Demo+Applications+-+easyTravel) demo application on [RedHat OpenShift](https://www.openshift.com).

## Application Components

| Component | Component
|:----------|:---------
| mongodb   | A pre-populated travel database (MongoDB).
| backend   | The easyTravel Business Backend (Java).
| frontend  | The easyTravel Customer Frontend (Java).
| loadgen   | A synthetic UEM load generator (Java).

## Prerequisites

The following automated build and deployment process is based on these prerequisites:

1) The *build process* depends on the [easyTravel-Builder](https://github.com/dynatrace-innovationlab/easyTravel-Builder) project as a *git submodule*. To obtain the entire codebase, either clone the project recursively via `git clone --recursive` or download a source distribution release from [here](https://github.com/dynatrace-innovationlab/easyTravel-Builder/releases). Configuration for building easyTravel is stored in [config/app-settings.sh](https://github.com/dynatrace-innovationlab/easyTravel-OpenShift/blob/master/config/app-settings.sh). Adapt to suit your needs.

Building runs entirely in Docker, which relieves you from setting up a build environment first. If you don't have done so yet, go install [Docker](https://docs.docker.com/linux/step_one/) or the [Docker Toolbox](https://www.docker.com/products/docker-toolbox) now.

2) The *deployment process* require access to an [OpenShift](https://www.openshift.com) environment. The [OpenShift CLI](https://docs.openshift.org/latest/cli_reference/get_started_cli.html) has to be installed. Configuration for deploying easyTravel on Cloud Foundry is stored in [config/oc-settings.sh](https://github.com/dynatrace-innovationlab/easyTravel-OpenShift/blob/master/config/oc-settings.sh). Adapt to suit your needs.

## Build and Deploy easyTravel on OpenShift

### 0. Bootstrap OpenShift

#### Login as *system:admin* and grant rights to user *admin*

```
oc login https://${OS_MASTER_IP}:8443 -u system:admin
oc policy add-role-to-user cluster-admin admin
```

### 1. Build

`./build.sh` creates the required deployment artefacts in `./build`.

```
.
├── build
    ├── backend/build
    │   └── backend.war
    ├── frontend/build
    │   └── frontend.war
    ├── loadgen/build
    │   └── loadgen.tar.gz
    └── mongodb/build
        └── easyTravel-mongodb-db-noauth.tar.gz
```

### 2. Deploy

`./deploy.sh` deploys easyTravel on OpenShift. Undo via `./clean.sh`.

We will be working on a better way to publicly expose easyTravel's Customer Frontend service. For now, please follow these steps to map the service's internal port `8080` to a port on your local host, e.g. `32123`, through which you can conveniently access easyTravel in your browser.

```
oc get pods (gives e.g. easytravel-frontend-1-a4tli)
oc port-forward easytravel-frontend-1-a4tli 32123:8080
```

## License

Licensed under the MIT License. See the [LICENSE](https://github.com/dynatrace-innovationlab/easyTravel-OpenShift/blob/master/LICENSE) file for details.