# llamacpp Inference Containers for ModelKits

The Dockerfiles in this folder can be used to build container images for inference microservice with a ModelKit using llamacpp-server.

There are 2 kinds of container images

1. **Dynamic Inference Container:** Model weights are downloaded by the entrypoint at runtime.
2. **Embedded Inference Container:** Model weights are inlined into the container at build time.


## Usage



## Building

### Dynamic Inference Container

This is a generic container that downloads the Model weights from any ModelKit and runs them

```shell
docker build -t llamacpp-kit:latest --build-arg KIT_BASE_IMAGE=kit-cli:latest .
```

To run pass the ModelKit reference as an environment variable

```shell
docker run -e MODELKIT_REF=jozu.ml/jozu/phi3:3.8b-mini-instruct-4k-q4_K_M llamacpp-kit
```

### Embedded Inference Container

This builds a container where the model weights and kitfile is built into the container. 

```shell
docker build -t llamacpp-kit-phi3:latest --build-arg MODELKIT_REF=jozu.ml/jozu/phi3:3.8b-mini-instruct-4k-q4_K_M  .
```
