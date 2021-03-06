# Start from golang:alpine with the latest version of Go installed
# and use it as a build environment
FROM golang:alpine3.8

WORKDIR /go/src/github.com/jblaskowich/hellogvisor/
# Copy the local code to the container
COPY hellogvisor.go .

# build du code source
RUN CGO_ENABLED=0 GOOS=linux go build -v -o hellogvisor

# Transfert the builded binary to scratch
# in order to have the smallest footprint
FROM scratch
COPY --from=0 /go/src/github.com/jblaskowich/hellogvisor/hellogvisor .

# Run the hellogvisor command when the container starts
ENTRYPOINT ["./hellogvisor"]

# Document that the service listens on port 8080
EXPOSE 8080
