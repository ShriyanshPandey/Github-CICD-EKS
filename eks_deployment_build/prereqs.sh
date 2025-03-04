#!/usr/bin/env bash

# This script installs EKS prerequisites on Ubuntu
# * kubectl
# * aws-iam-authenticator
# * AWS CLI
# * eksctl
# * kubectx/kubens

set -e

mkdir -p $HOME/bin
echo 'export PATH=$HOME/bin:$PATH' >>~/.bashrc

# Install required packages
sudo apt update && sudo apt install -y curl unzip git

# Install kubectl, if absent
if ! command -v kubectl &>/dev/null; then
	curl -o kubectl "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
	chmod +x kubectl
	mv kubectl $HOME/bin/
	echo 'kubectl installed'
else
	echo 'kubectl already installed'
fi

# Install aws-iam-authenticator, if absent
if ! command -v aws-iam-authenticator &>/dev/null; then
	curl -o aws-iam-authenticator "https://amazon-eks.s3.us-west-2.amazonaws.com/1.10.3/2018-07-26/bin/linux/amd64/aws-iam-authenticator"
	chmod +x aws-iam-authenticator
	mv aws-iam-authenticator $HOME/bin/
	echo 'aws-iam-authenticator installed'
else
	echo 'aws-iam-authenticator already installed'
fi

# Install AWS CLI, if absent
if ! command -v aws &>/dev/null; then
	curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
	unzip awscliv2.zip
	sudo ./aws/install
	rm -rf awscliv2.zip aws/
	echo 'AWS CLI installed'
else
	echo 'AWS CLI already installed'
fi

# Install eksctl, if absent
if ! command -v eksctl &>/dev/null; then
	curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_Linux_amd64.tar.gz" | tar xz -C /tmp
	sudo mv /tmp/eksctl /usr/local/bin/
	echo 'eksctl installed'
else
	echo 'eksctl already installed'
fi

# Install kubectx/kubens, if absent
if ! command -v kubectx &>/dev/null; then
	git clone https://github.com/ahmetb/kubectx /opt/kubectx
	sudo ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx
	sudo ln -s /opt/kubectx/kubens /usr/local/bin/kubens
	echo 'kubectx installed'
else
	echo 'kubectx already installed'
fi

# Test if AWS credentials exist
aws sts get-caller-identity
