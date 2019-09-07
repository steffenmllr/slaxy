# Stage 1: Build executable
FROM golang:1.12 as buildImage

WORKDIR $GOPATH/src/github.com/github.com/innogames/slaxy
COPY . .

RUN go get
RUN GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -o /slaxy

# Stage 2: Create release image
FROM alpine:3
RUN apk --no-cache add ca-certificates
COPY --from=buildImage /slaxy /usr/bin/slaxy
RUN chmod +x /usr/bin/slaxy
ENTRYPOINT ["slaxy"]
