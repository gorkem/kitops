ARG KIT_BASE_IMAGE=ghcr.io/jozu-ai/kit:next

# Define the kit-cli stage
FROM $KIT_BASE_IMAGE AS kit-cli

# Define the yq stage
FROM mikefarah/yq AS yq

# Define the final stage
FROM ghcr.io/ggerganov/llama.cpp:server AS final

# Set environment variables for model kit reference and unpack path
ARG MODELKIT_REF
ARG UNPACK_PATH=/home/user/modelkit/

ENV MODELKIT_REF=${MODELKIT_REF}
ENV UNPACK_PATH=${UNPACK_PATH}
# Copy necessary tools from other stages
COPY --from=yq /usr/bin/yq /yq

# Copy entrypoint script
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

# Create the unpack path directory
RUN mkdir -p $UNPACK_PATH

# Run the unpack command using kit from the kit-cli stage
RUN --mount=type=bind,from=kit-cli,source=/usr/local/bin/kit,target=/usr/local/bin/kit \
    /usr/local/bin/kit unpack "$MODELKIT_REF" --dir "$UNPACK_PATH" --filter=model,kitfile -vvv

# Set the entrypoint
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]