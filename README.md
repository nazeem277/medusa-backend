# medusa-backend

Create hcl file and dockerfile
build docker image : docker build -t medusa-image .

Push Docker Image to ECR:
  Create a repository in AWS ECR
  Authenticate Docker with ECR : aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin YOUR_ACCOUNT_ID.dkr.ecr.us-east- 
  1.amazonaws.com

  Tag and push the Docker image : docker tag YOUR_DOCKER_IMAGE_URI YOUR_ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com/medusa
  docker push YOUR_ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com/medusa
  
To run the docker container : docker run -p 9000:9000 medusa-backend (Checking on localhost with port 9000)
  

Configure GitHub Secrets with AWS_ACCESS_KEY_ID & AWS_SECRET_ACCESS_KEY




