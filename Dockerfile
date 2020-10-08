FROM ros:noetic-ros-base

HEALTHCHECK CMD /ros_entrypoint.sh rostopic list || exit 1

CMD ["roscore"]