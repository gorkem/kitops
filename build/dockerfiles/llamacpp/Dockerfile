ARG KIT_BASE_IMAGE=ghcr.io/jozu-ai/kit:next

FROM ghcr.io/ggerganov/llama.cpp:server
FROM $KIT_BASE_IMAGE

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
