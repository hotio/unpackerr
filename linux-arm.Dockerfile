FROM alpine:3.12 as builder
RUN apk add --no-cache gzip
ARG UNPACKERR_VERSION
RUN wget -O "/tmp/unpackerr.gz" "https://github.com/davidnewhall/unpackerr/releases/download/v${UNPACKERR_VERSION}/unpackerr.armhf.linux.gz" && gunzip -c "/tmp/unpackerr.gz" > "/tmp/unpackerr" && chmod 755 "/tmp/unpackerr"

FROM hotio/base@sha256:dba94df91a2c476ec1e3717a2f76fd01ef5b9fcf1a1baa0efbac5e3c5b5f77d4
COPY --from=builder /tmp/unpackerr /app/unpackerr
COPY root/ /
