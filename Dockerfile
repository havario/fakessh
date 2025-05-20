FROM golang:1-alpine AS builder
WORKDIR /go/src
COPY . .
ENV CGO_ENABLED=0
RUN go build -v -trimpath -ldflags="-s -w -buildid=" \
    -o /go/bin/fakessh fakessh.go

FROM scratch
COPY --from=builder /go/bin/fakessh /usr/bin/fakessh
EXPOSE 22
ENTRYPOINT ["fakessh"]