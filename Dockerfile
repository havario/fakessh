FROM golang:1-alpine AS builder
WORKDIR /go/src
COPY . .
RUN CGO_ENABLED=0 go build -trimpath -ldflags="-w -s" -o /go/bin/fakessh fakessh.go

FROM scratch
COPY --from=builder /go/bin/fakessh /usr/bin/fakessh
EXPOSE 22
ENTRYPOINT ["fakessh"]