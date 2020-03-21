## Build the image
Go into this repository and build the UWSim-NET docker image:
```bash
docker build -t uwsimnet-image .
```
In order to allow GUI visualization configure permissions for the X server in the host and run the image as explained in [this guide](http://wiki.ros.org/docker/Tutorials/GUI). 

## How to run the image if using Nvidia graphics on Ubuntu.
In order to avoid a LibGL error when launching a GUI ([https://github.com/jessfraz/dockerfiles/issues/253](https://github.com/jessfraz/dockerfiles/issues/253)), you have to enable graphics acceleration for Nvidia.

For this, you need to install the `nvidia-docker2` package. The first step is to install the repository for your distribution by following the instructions [here](http://nvidia.github.io/nvidia-docker/). E.g. in the case of a debian based distribution:
```
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | \
  sudo apt-key add -
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | \
  sudo tee /etc/apt/sources.list.d/nvidia-docker.list
sudo apt-get update
```
Now you can install the `nvidia-docker2` package and reload the Docker daemon configuration:
```
sudo apt-get install nvidia-docker2
sudo pkill -SIGHUP dockerd
```
Finally use the `run_image.bash` script to create and start the first docker container.
```bash
chmod u+x run_image.bash
./run_image.bash uwsimnet-image
```
This steps have been based on the documentation available in [ros-docker-with-hardware-acceleration](http://wiki.ros.org/docker/Tutorials/Hardware%20Acceleration)
