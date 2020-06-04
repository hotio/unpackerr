FROM alpine:3.12 as builder
RUN apk add --no-cache gzip
ARG UNPACKERR_VERSION
RUN gzfile="/tmp/unpackerr.gz" && wget -O "${gzfile}" "https://github.com/davidnewhall/unpackerr/releases/download/v${UNPACKERR_VERSION}/unpackerr.arm64.linux.gz" && gunzip -c "${gzfile}" | dd of="/tmp/unpackerr" && chmod 755 "/tmp/unpackerr"

FROM hotio/base@sha256:5c748f472fd4dda9c2332dbce09046f9b419d6776083ec17df1d4d8370eb5a0b
COPY --from=builder /tmp/unpackerr /app/unpackerr
COPY root/ /
