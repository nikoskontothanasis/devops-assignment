init:
	cd kafka-service/terraform; terraform init
	cd mesh-service/terraform; terraform init

destroy:
	cd kafka-service/terraform; terraform destroy
	cd mesh-service/terraform; terraform destroy 

kafka-plan:
	cd kafka-service/terraform; terraform plan

mesh-plan:
	cd mesh-service/terraform; terraform plan

kafka-deploy:
	cd kafka-service/terraform; terraform apply

mesh-deploy:
	cd mesh-service/terraform; terraform apply
	kubectl apply -f mesh-service/gRPC/grpc-service-deployment.yaml
	kubectl apply -f mesh-service/gRPC/virtualservice.yaml -f mesh-service/gRPC/destinationrule.yaml

build-gRPC:
	docker build -t grpcservice:v1 -f mesh-service/gRPC/Dockerfile .

push-gRPC:
	docker build -t grpcservice:v1 -f mesh-service/gRPC/Dockerfile .
	docker push grpcservice:v1
	
mesh-verify:
	kubectl get pods
	kubectl get svc grpc-service
