# How to build and use the docker image
Go into this repository and build the UWSim-NET docker image:
```bash
docker build -t uwsimnet-image .
```
Use the *run_melodic_image.bash* script to create and start the first docker container. 
```bash
chmod u+x run_melodic_image.bash
./run_melodic_image.bash uwsimnet-image
```
In order to allow GUI visualization configure permissions for the X server in the host following [this guide](http://wiki.ros.org/docker/Tutorials/GUI). The fastest way (but not recomended due to security issues): 
```bash
xhost +local:root
```
In the container terminal, run UWSim-NET for the first time
```bash
rosrun uwsim uwsim
```
### Notes
If you are getting a LibGL error ([https://github.com/jessfraz/dockerfiles/issues/253](https://github.com/jessfraz/dockerfiles/issues/253)) when launching a GUI, try to enable graphics acceleration for Nvidia ([ros-docker-with-hardware-acceleration](http://wiki.ros.org/docker/Tutorials/Hardware%20Acceleration))
