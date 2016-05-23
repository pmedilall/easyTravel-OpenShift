# How to deploy RedHat OpenShift Origin with Ansible on AWS

The following findings are based on the [OpenShift and Atomic Enterprise Ansible](https://github.com/openshift/openshift-ansible) project.

## Prerequisites

1) [Ansible](https://www.ansible.com/) is required to deploy the RedHat OpenShift cluster. As of now, the latest supported version of Ansible is `1.9.4`. Support for [Ansible 2.0](https://www.ansible.com/blog/ansible-2.0-launch) is [under active development](https://github.com/openshift/openshift-ansible/issues/1339). On a personal note, I prefer to install Ansible via the Python package manager [pip](https://pypi.python.org/pypi/pip): `sudo pip install ansible==1.9.4`.

2) Ansible requires access to your AWS account when deploying the cluster. A fine place to provide your credentials is in `~/.aws/credentials`, as described in the project's [README_AWS.md](https://github.com/openshift/openshift-ansible/blob/prod/README_AWS.md#user-content-get-aws-api-credentials).

3) Accept the terms for using [CentOS 7 Linux AMIs](https://aws.amazon.com/marketplace/pp/B00O7WM7QW) on the AWS Marketplace: make sure that you are signed in, then click on the "Continue"-Button and await an email that confirms your subscription to the *CentOS 7 (x86_64) with Updates HVM  sold by Centos.org* product.

4) Create a dedicated Key Pair in the AWS Console, e.g., `openshift-origin-dev`. Make sure to safely stow it in `~/.ssh` with a mode of `400` and add it to the `ssh-agent` via `ssh-add ~/.ssh/openshift-origin-dev.pem`.

5) Create a Security Group in the AWS Console, e.g., `openshift-dev`, and give it access to the list of ports mentioned in the project's [README_AWS.md](https://github.com/openshift/openshift-ansible/blob/prod/README_AWS.md#user-content-set-up-security-group).

6) Pick a VPC Subnet ID in your favorite availability zone, e.g., `subnet-f1234abc`, and keep it as a reference for the next step.

7) `git clone` or download the [OpenShift and Atomic Enterprise Ansible](https://github.com/openshift/openshift-ansible) project into `~/openshift-ansible`.

## Deploy OpenShift Origin with Ansible

8) Adapt `./config/os-origin-config.sh` to suit your needs and source the file via `. ./config/os-origin-config.sh`.

9) Create the cluster using Ansible via `~/openshift-ansible/bin/cluster create -t origin aws dev`. If you keep having issues, make sure to refresh the Ansible cache via `~/openshift-ansible/inventory/aws/hosts/ec2.py --refresh-cache` and try again. Undo via `./bin/cluster terminate -t origin aws dev`.

## Deploy OpenShift Enterprise with Ansible

8) Adapt `./config/os-enterprise-config.sh` to suit your needs and source the file via `. ./config/os-enterprise-config.sh`.

9) Create the cluster using Ansible via `~/openshift-ansible/bin/cluster create -t openshift-enterprise aws dev`. If you keep having issues, make sure to refresh the Ansible cache via `~/openshift-ansible/inventory/aws/hosts/ec2.py --refresh-cache` and try again. Undo via `./bin/cluster terminate -t openshift-enterprise aws dev`.

10) Copy the Kubernetes master configuration to your localhost via `scp centos@${OS_MASTER_IP}:~/.kube/config ~/.kube/config`.

## Additional Resources

- [OpenShift and Atomic Enterprise Ansible: README_AWS.md](https://github.com/openshift/openshift-ansible/blob/prod/README_AWS.md)