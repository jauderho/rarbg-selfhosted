FROM golang:1.22.6-alpine3.20@sha256:1a478681b671001b7f029f94b5016aed984a23ad99c707f6a0ab6563860ae2f3 AS build

RUN mkdir /app
COPY . /app

RUN apk add gcc musl-dev && cd /app && GOAMD64=v3 go build -trimpath -ldflags="-s -w" -o rbg .


###


FROM alpine:3.20.0@sha256:77726ef6b57ddf65bb551896826ec38bc3e53f75cdde31354fbffb4f25238ebd

COPY --from=build /app/rbg /rbg
COPY ./trackers.txt /trackers.txt

ENTRYPOINT ["/rbg"]

