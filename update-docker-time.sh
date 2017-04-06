#!/bin/bash

docker run -it --rm --privileged --pid=host sgjesse/esp-open-sdk sudo nsenter -t 1 -m -u -n -i date -u $(date -u +%m%d%H%M%Y)
