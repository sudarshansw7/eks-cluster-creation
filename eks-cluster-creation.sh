#!/bin/bash

echo "awscli is installing....."
sleep 4
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
apt install unzip
unzip awscliv2.zip
sudo ./aws/install
echo "awscli installation is completed...."
sleep 2

echo "kubectl installation is in progress...."
sleep 2
curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.31.2/2024-11-15/bin/linux/amd64/kubectl
sleep 4
chmod +x ./kubectl
mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$HOME/bin:$PATH
kubectl version --client
sleep 5
echo " kubectl installtion has successfull....."
sleep 2

echo "eksctl installtion has started...."
sleep 2
# for ARM systems, set ARCH to: `arm64`, `armv6` or `armv7`
ARCH=amd64
PLATFORM=$(uname -s)_$ARCH

curl -sLO "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_$PLATFORM.tar.gz"

# (Optional) Verify checksum
curl -sL "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_checksums.txt" | grep $PLATFORM | sha256sum --check

tar -xzf eksctl_$PLATFORM.tar.gz -C /tmp && rm eksctl_$PLATFORM.tar.gz

sudo mv /tmp/eksctl /usr/local/bin
echo "eksctl installtion is sucessfull...."
sleep 2

echo " cluster creation is in progress...."
sleep 2
eksctl create cluster --name my-cluster --region us-east-1 --node-type t2.micro --nodes 3
echo "cluster creation is sucessfull...."
sleep 2
