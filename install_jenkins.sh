#!/bin/bash

set -e

echo "Updating system..."
sudo dnf update -y

echo "Installing Git..."
sudo yum install git -y

echo "Installing Java 17..."
sudo dnf install -y java-17-amazon-corretto

echo "Installing Docker..."
sudo dnf install -y docker

echo "Starting and enabling Docker..."
sudo systemctl enable --now docker

echo "Adding users to the docker group..."
sudo usermod -aG docker ec2-user
sudo usermod -aG docker jenkins 2>/dev/null || echo "Jenkins user not yet created — will add later."

echo "Installing Helm..."
sudo curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | sudo bash

echo "Installing Kubectl..."
curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.31.2/2024-11-15/bin/linux/amd64/kubectl
chmod +x ./kubectl
mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$HOME/bin:$PATH

export ARCH=amd64
export PLATFORM=$(uname -s)_$ARCH

echo "Installing Eksctl..."
curl -sLO "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_$PLATFORM.tar.gz"
tar -xzf eksctl_$PLATFORM.tar.gz -C /tmp && rm eksctl_$PLATFORM.tar.gz
sudo mv /tmp/eksctl /usr/local/bin

echo "Adding Jenkins repo and key..."
sudo curl -o /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

echo "Installing Jenkins..."
sudo dnf install -y jenkins

echo "Adding jenkins to docker group now..."
sudo usermod -aG docker jenkins

echo "Enabling and starting Jenkins..."
sudo systemctl enable --now jenkins

echo "Jenkins is installed and running!"
echo "Initial Jenkins Admin Password:"
sudo cat /var/lib/jenkins/secrets/initialAdminPassword

echo "NOTE: You should reboot the instance for group changes to take full effect!"
