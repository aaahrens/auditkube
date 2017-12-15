build:
	AWS_REGION=$(shell aws configure get bonafide.region) \
	AWS_ACCESS_KEY_ID=$(shell aws configure get bonafide.aws_access_key_id) \
	AWS_SECRET_ACCESS_KEY=$(shell aws configure get bonafide.aws_secret_access_key) \
	CLOUDWATCH_AWS_ACCESS_KEY_ID=$(shell aws configure get bonafide.aws_access_key_id) \
	CLOUDWATCH_AWS_SECRET_ACCESS_KEY=$(shell aws configure get bonafide.aws_secret_access_key) \
	packer build image.json

release: aws-marketplace

aws-marketplace:
	# Need to remove encryption to put on AWS Marketplace
	cat image.json | jq '.builders[].encrypt_boot=false' > aws-marketplace.json
	# Build Image with Packer for AWS Marketplace
	AWS_REGION=us-east-1 \
	AWS_ACCESS_KEY_ID=$(shell aws configure get opszero.aws_access_key_id) \
	AWS_SECRET_ACCESS_KEY=$(shell aws configure get opszero.aws_secret_access_key) \
	packer build aws-marketplace.json
