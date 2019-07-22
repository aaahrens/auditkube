#!/usr/bin/env bash
# SOURCE FOR THE IS HERE https://github.com/cloudposse/terraform-aws-cloudwatch-agent/blob/master/templates/cloud_init.yaml
export NAME=$(cat /etc/os-release)
echo ${NAME}
case ${NAME} in
  *"Amazon Linux"*) echo "Installing the cloudwatch agent for Amazon Linux."
    curl -O https://s3.amazonaws.com/amazoncloudwatch-agent/amazon_linux/amd64/latest/amazon-cloudwatch-agent.rpm
    rpm -U ./amazon-cloudwatch-agent.rpm
    ;;
  *Centos*) echo "Installing the cloudwatch agent for Centos Linux."
    curl -O https://s3.amazonaws.com/amazoncloudwatch-agent/centos/amd64/latest/amazon-cloudwatch-agent.rpm
    rpm -U ./amazon-cloudwatch-agent.rpm
    ;;
  *Debian*) echo "Installing the cloudwatch agent for Debian Linux."
    curl -O https://s3.amazonaws.com/amazoncloudwatch-agent/debian/amd64/latest/amazon-cloudwatch-agent.deb
    dpkg -i -E ./amazon-cloudwatch-agent.deb
    ;;
  *Redhat*) echo "Installing the cloudwatch agent for Redhat Linux."
    curl -O https://s3.amazonaws.com/amazoncloudwatch-agent/redhat/amd64/latest/amazon-cloudwatch-agent.rpm
    rpm -U ./amazon-cloudwatch-agent.rpm
    ;;
  *Suse*) echo "Installing the cloudwatch agent for Suse Linux."
    curl -O https://s3.amazonaws.com/amazoncloudwatch-agent/suse/amd64/latest/amazon-cloudwatch-agent.rpm
    rpm -U ./amazon-cloudwatch-agent.rpm
    ;;
  *Ubuntu*) echo "Installing the cloudwatch agent for Ubuntu Linux."
    curl -O https://s3.amazonaws.com/amazoncloudwatch-agent/ubuntu/amd64/latest/amazon-cloudwatch-agent.deb
    dpkg -i -E ./amazon-cloudwatch-agent.deb
    ;;
  *)
    echo "Operating system not supported. Please refer to the official documents for more info https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/install-CloudWatch-Agent-on-first-instance.html"
esac