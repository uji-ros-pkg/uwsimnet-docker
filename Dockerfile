FROM ros:melodic-ros-base-bionic

WORKDIR /root
RUN mkdir -p catkin_ws/src
RUN cd catkin_ws/src

WORKDIR /root/catkin_ws/src
RUN git clone https://github.com/uji-ros-pkg/underwater_simulation.git
RUN git clone --recursive https://github.com/dcentelles/dccomms_ros_pkgs.git
RUN git clone --recursive https://github.com/uji-ros-pkg/netsim_tracing_examples.git

WORKDIR /root/catkin_ws/
RUN apt-get update
RUN /ros_entrypoint.sh rosdep install --from-paths src --ignore-src --rosdistro melodic -y
RUN /ros_entrypoint.sh catkin_make install -DCMAKE_BUILD_TYPE=Release

WORKDIR /root/catkin_ws/install/share/uwsim/data/scenes
RUN mkdir -p ~/.uwsim/data
RUN wget http://www.irs.uji.es/uwsim/files/data.tgz -O ~/.uwsim/UWSim-data.tgz && tar -zxvf ~/.uwsim/UWSim-data.tgz -C ~/.uwsim
RUN rm ~/.uwsim/UWSim-data.tgz
RUN chmod u+x installScene
RUN ./installScene -s netsim_scenes.uws

WORKDIR /root

RUN echo "source catkin_ws/install/setup.bash" >> .bashrc

RUN git clone --recursive https://github.com/dcentelles/dccomms_by_examples.git
RUN mkdir dccomms_by_examples/build

WORKDIR dccomms_by_examples/build

RUN cmake ..
RUN make

WORKDIR /root

COPY ./uwsimnet_entrypoint.sh /

ENTRYPOINT ["/uwsimnet_entrypoint.sh"]
CMD ["bash"]

# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES \
    ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
    ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics

