FROM ubuntu:19.04
MAINTAINER finlay@dragonfly.co.nz

RUN sed -i 's/deb\./ftp.nz./' /etc/apt/sources.list

RUN apt-get update
RUN apt-get install -y locales tzdata
RUN echo "en_NZ.UTF-8 UTF-8" >> /etc/locale.gen \
	&& locale-gen en_NZ.utf8 \
	&& /usr/sbin/update-locale LANG=en_NZ.UTF-8

ENV LC_ALL en_NZ.UTF-8
ENV LANG en_NZ.UTF-8


RUN apt-get install -y r-base r-base-dev

RUN Rscript -e "install.packages('ggplot2')"
RUN Rscript -e "install.packages('data.table')"

RUN apt-get install -y --no-install-recommends  cargo libudunits2-dev libgdal-dev

RUN Rscript -e "install.packages('png')"
RUN Rscript -e "install.packages('gifski')"
RUN Rscript -e "install.packages('gganimate')"
RUN Rscript -e "install.packages('transformr')"

RUN rm -rf /var/lib/apt/lists/*
