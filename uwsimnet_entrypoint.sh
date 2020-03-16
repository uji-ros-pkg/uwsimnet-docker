#!/bin/bash
set -e

# setup ros environment
source "/root/catkin_ws/install/setup.bash"
exec "$@"
