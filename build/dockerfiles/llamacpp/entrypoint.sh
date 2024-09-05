#!/bin/bash

set -e

# Kit configuration via env vars:
#   - UNPACK_PATH   : Where to unpack the modelkit (default: /home/user/modelkit)
#   - UNPACK_FILTER : What to unpack from the modelkit (default: model)
#   - MODELKIT_REF  : The modelkit to unpack -- required!
UNPACK_PATH=${UNPACK_PATH:-/home/user/modelkit/}
UNPACK_FILTER=${UNPACK_FILTER:-model}
if [ -z "$MODELKIT_REF" ]; then
  echo "Environment variable \$MODELKIT_REF is required"
  exit 1
fi

# Check if the kitfile already exists
if [ ! -f "$UNPACK_PATH/Kitfile" ]; then
  echo "Unpacking modelkit $MODELKIT_REF to $UNPACK_PATH with filter $UNPACK_FILTER"
  /kit unpack "$MODELKIT_REF" --dir "$UNPACK_PATH" --filter=model,kitfile
else
  # The model is inlined with image
  echo "Model already exists at $UNPACK_PATH, skipping unpack."
fi

MODELPATH=$( cat $UNPACK_PATH/Kitfile | /yq ".model.path")
echo "Loading model from path: $MODELPATH"  
/llama-server -m $UNPACK_PATH/$MODELPATH --port 8000 --host 0.0.0.0 -n 512 
