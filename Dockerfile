FROM golang:1.23-alpine as builder

WORKDIR /usr/src/app

COPY . .

RUN go mod download && go mod verify

RUN go build -v -o /usr/local/bin/app ./...

FROM scratch

COPY --from=builder /usr/local/bin/app /usr/local/bin/app

CMD ["/usr/local/bin/app"]