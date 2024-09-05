ARG KIT_BASE_IMAGE=ghcr.io/jozu-ai/kit:next

FROM $KIT_BASE_IMAGE AS kit-cli
FROM mikefarah/yq AS yq
FROM ghcr.io/ggerganov/llama.cpp:server

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
COPY --from=kit-cli /usr/local/bin/kit /kit
COPY --from=yq  /usr/bin/yq /yq


ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
