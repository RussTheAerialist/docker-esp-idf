# TODO: Build ncurses5 from AUR in a separate container and then install it into the main dockerfile
FROM archlinux/base:latest
ARG TOOLCHAIN_URL=https://dl.espressif.com/dl/xtensa-esp32-elf-linux64-1.22.0-80-g6c4433a-5.2.0.tar.gz
ARG FRAMEWORK_REPO=https://github.com/espressif/esp-idf.git
ARG FRAMEWORK_VERSION=v3.2
RUN pacman -Sy --noconfirm --needed gcc git make ncurses flex bison gperf python2-pip python2-pyserial python2-cryptography python2-future python2-pyparsing python2-pyelftools && pacman -Scc
WORKDIR /root
RUN echo ${TOOLCHAIN_URL} && curl -o /tmp/esp32.tgz ${TOOLCHAIN_URL} && tar xvfz /tmp/esp32.tgz
RUN git clone -b ${FRAMEWORK_VERSION} --depth=1 --recursive ${FRAMEWORK_REPO}
ENV IDF_PATH=/root/esp-idf
RUN python2 -m pip install --user -r $IDF_PATH/requirements.txt