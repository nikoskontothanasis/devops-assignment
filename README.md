# devops-assignment
For Terraform installation i use tfenv, you can find the repo [here](https://github.com/tfutils/tfenv#terraform-version-file)

Quick steps:   
`$ brew install tfenv`   
`$ tfenv install latest`  
`$ tfenv use latest`  
Terraform version : v1.6.4

## Infrastructure Documentation
## Kafka-service

For Kafka service uses AWS MSK - [Managed Streaming for Apache Kafka](https://aws.amazon.com/msk/).   
Assuming that will be on Amazon AWS Cloud.   
Install aws-cli from [here](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html).   
Execute aws configure and provide all the necessary info.   

Kafka version: 3.3.2 [recommended](https://docs.aws.amazon.com/msk/latest/developerguide/supported-kafka-versions.html#3.3.2)

Using the global_prefix to prefix all the resources that will be created. This can be changed in the variables.tf file.     
Using customising in Kafka Cluster options, into the server.properties file of each broker of the cluster. Can be found under the resource "aws_msk_configuration" "kafka_config" in the serfver_properties field. With this configuration we want to enable automatic topic creation in the Kafka cluster.     
Using in total 3 nodes, each one using the kafka.m5.large instance type. Each broker to use an AWS EBS volume, with 1TB of capacity. Can be found under the resource "aws_msk_cluster" "kafka" on main.tf.      
Using 3 private subnets,associate a valid CIDR block for each, and map them to availability zones. Also a custom security group  to allow ingress traffic to the cluster over the exposed port 9092.    

## Mesh-service
For mesh-service uses Amazon AWS and assuming that already have a EKS K8 cluster up and running.    
As mesh services using Istio     
Terrafom code is in main.tf file under mesh-service/terraform    
Create the gRPC Service code, can be found under mesh-service/gRPC in main.go    
Create a Dockerfile to containerize your gRPC service under mesh-service/gRPC in Dockerfile.   
Create a Kubernetes Deployment YAML file under mesh-service/gRPC in grpc-service-deployment.yaml    
Create a VirtualService and a DestinationRule for gRPC service ,so Istio to handle traffic routing, timeouts etc can be found under mesh-service/gRPC in virtualservice.yaml & destinationrule.yaml    


## Instructions 

Run `make init` to init both tasks    
Run `make destroy` to destroy both tasks   

On folder kafka-service you will find task 1
### Plan: 
    make kafka-plan
### Apply:
    make kafka-deploy

On folder mesh-service you will find task 2
### Plan: 
    make istio-plan
## Build 
    make build-gRPC
## Push
    make push-gRPC:
### Apply:
    make istio-deploy
### Verify
    make istio-verify
    