// main.go
package main

import (
	"log"
	"net"

	"google.golang.org/grpc"
	pb "path/to/your/protobuf" // Import your protobuf definition

	// Add other necessary imports
)

type server struct{}

func main() {
	lis, err := net.Listen("tcp", ":50051")
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}
	s := grpc.NewServer()
	pb.RegisterYourServiceServer(s, &server{})
	if err := s.Serve(lis); err != nil {
		log.Fatalf("failed to serve: %v", err)
	}
}
