FROM rocker/hadleyverse

MAINTAINER "kenjimyzk" 

WORKDIR /home

# Install and update software
RUN apt-get update \
  && apt-get install -y gnupg wget curl libgetopt-long-descriptive-perl \
  libdigest-perl-md5-perl python-pygments fontconfig && rm -rf /var/lib/apt/lists/*
  
WORKDIR /
RUN curl -sL http://mirror.utexas.edu/ctan/systems/texlive/tlnet/install-tl-unx.tar.gz | tar zxf - \
  && mv install-tl-20* install-tl \
  && cd install-tl \
  && echo "selected_scheme scheme-full" > profile \
  && ./install-tl -repository http://mirror.utexas.edu/ctan/systems/texlive/tlnet -profile profile \
  && cd .. \
  && rm -rf install-tl

RUN apt-get update && apt-get install -y freeglut3 fonts-ipaexfont fonts-ipafont

# Change environment to Japanese(Character and DateTime)
ENV PATH /usr/local/texlive/2017/bin/x86_64-linux:$PATH
WORKDIR /home
ENV LANG ja_JP.UTF-8
ENV LC_ALL ja_JP.UTF-8
RUN sed -i '$d' /etc/locale.gen \
  && echo "ja_JP.UTF-8 UTF-8" >> /etc/locale.gen \
	&& locale-gen ja_JP.UTF-8 \
	&& /usr/sbin/update-locale LANG=ja_JP.UTF-8 LANGUAGE="ja_JP:ja"
RUN /bin/bash -c "source /etc/default/locale"
RUN ln -sf  /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

USER root
CMD ["/init"]  
