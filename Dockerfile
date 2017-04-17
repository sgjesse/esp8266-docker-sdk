# Dockerfile for building an image with a ESP8266 toolchain.
FROM debian:stretch

# Install required packages.
RUN apt-get update && apt-get install -y \
	autoconf \
	automake \
	bison \
	bzip2 \
	flex \
	g++ \
	gawk \
	gcc \
	git \
	gperf \
	libexpat-dev \
	libtool-bin \
	make \
	ncurses-dev \
	nano \
	python \
	python-dev \
	python-serial \
	sed \
	texinfo \
	unrar-free \
	unzip \
	wget \
	help2man \
        sudo

# Set the timezone.
TIMEZONE=Europe/Copenhagen
RUN sudo ln -sf /usr/share/zoneinfo/$TIMEZONE /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata

ENV USER esp8266

# Create user esp without password and sudo access.
RUN useradd -m -G dialout,sudo $USER && \
    echo "$USER ALL=(ALL:ALL) NOPASSWD:ALL" > /etc/sudoers.d/$USER && \
    chmod 440 /etc/sudoers.d/$USER

USER $USER

RUN (cd /home/$USER && git clone --recursive https://github.com/pfalcon/esp-open-sdk.git) && \
    (cd /home/$USER/esp-open-sdk && make STANDALONE=n) && \
    (cd /home/$USER && git clone --recursive https://github.com/Superhouse/esp-open-rtos.git)

#RUN (cd /home/$USER/ && git clone https://github.com/esp8266/source-code-examples.git)

ENV TOOLCHAIN_DIR /home/$USER/esp-open-sdk/xtensa-lx106-elf
ENV TOOLCHAIN_PREFIX $TOOLCHAIN_DIR/bin/xtensa-lx106-elf-
ENV PATH $TOOLCHAIN_DIR/bin:$PATH

# Add .bash_aliases. This is soucred by the default Debian .bashrc.
ADD .bash_aliases /home/$USER

CMD (cd /home/$USER && /bin/bash)
