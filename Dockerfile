FROM golang:1.22.5-alpine3.20@sha256:8c9183f715b0b4eca05b8b3dbf59766aaedb41ec07477b132ee2891ac0110a07 AS build

RUN mkdir /app
COPY . /app

RUN apk add gcc musl-dev && cd /app && GOAMD64=v3 go build -trimpath -ldflags="-s -w" -o rbg .


###


FROM alpine:3.20.0@sha256:77726ef6b57ddf65bb551896826ec38bc3e53f75cdde31354fbffb4f25238ebd

COPY --from=build /app/rbg /rbg
COPY ./trackers.txt /trackers.txt

ENTRYPOINT ["/rbg"]

