ARG UPSTREAM_IMAGE
ARG UPSTREAM_DIGEST_AMD64

FROM golang:alpine as builder

ARG VERSION
RUN apk add --no-cache git build-base bash && \
    git clone -n https://github.com/unpackerr/unpackerr.git /unpackerr && cd /unpackerr && \
    git checkout ${VERSION} -b hotio && \
    CGO_ENABLED=0 make unpackerr.amd64.linux


FROM ${UPSTREAM_IMAGE}@${UPSTREAM_DIGEST_AMD64}

VOLUME ["${CONFIG_DIR}"]

COPY --from=builder /unpackerr/unpackerr.amd64.linux ${APP_DIR}/unpackerr
COPY --from=builder /unpackerr/examples/unpackerr.conf.example ${APP_DIR}/unpackerr.conf.example
RUN chmod 755 "${APP_DIR}/unpackerr"
COPY root/ /
RUN chmod -R +x /etc/cont-init.d/ /etc/services.d/
