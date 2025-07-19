#!/bin/bash

# Install AWS CLI (optional if already in AMI)
yum install -y awscli

# Get Instance ID and Name tag
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
REGION=$(curl -s http://169.254.169.254/latest/meta-data/placement/region)
INSTANCE_NAME=$(aws ec2 describe-tags \
  --filters "Name=resource-id,Values=$INSTANCE_ID" "Name=key,Values=Name" \
  --region "$REGION" \
  --output text | awk '{print $5}')

echo "Instance name is $INSTANCE_NAME"

cd /tmp
git clone https://github.com/Lingaiahthammisetti/3.7.shell-script-roboshop-app.git
cd 3.7.shell-script-roboshop-app

case "$INSTANCE_NAME" in
  "mongodb")
    bash mongodb.sh
    ;;
  "redis")
    bash redis.sh
    ;;
  "mysql")
    bash mysql.sh
    ;;
  "rabbitmq")
    bash rabbitmq.sh
    ;;
  "catalogue")
    bash catalogue.sh
    ;;
  "user")
    bash user.sh
    ;;
  "cart")
    bash cart.sh
    ;;
  "shipping")
    bash shipping.sh
    ;;
  "payment")
    bash payment.sh
    ;;
  "dispatch")
    bash dispatch.sh
    ;;
  "web")
    bash web.sh
    ;;
  *)
    echo "Unknown component: $INSTANCE_NAME"
    ;;
esac
