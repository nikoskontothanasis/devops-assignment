# Dockerfile
FROM golang:1.16

WORKDIR /app

COPY . .

RUN go get -u google.golang.org/grpc
RUN go get -u path/to/your/protobuf

RUN go build -o main .

EXPOSE 50051

CMD ["./main"]
