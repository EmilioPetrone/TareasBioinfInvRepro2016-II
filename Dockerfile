#################################################################
# Dockerfile Fastxtools
# This dockerfile pulls the last image of biodocker and installs the
# fastxtools  for pre-processing FASTQ/A files.

## To build the image you need to write in the terminal at the WD
## where de dockerfile is located the following command:
## docker build -t biodckr/fastxtools:0.0.014 .  (the dot is very important)
# "biodockr" is the name of the repository and 
# "fastxtool:0.0.014" is the name of the iamge and version

#####################################################

#These are some details of the dockerfile:
# Version:          1 
# Software:         Fastxtools
# Software Version: 0.0.14
# Description:      FASTQ/A short-reads pre-processing tools
# Website:          http://hannonlab.cshl.edu/fastx_toolkit/index.html
# Tags:             Genomics
# Provides:         fastxtools 0.0.14

# Set the base image 
FROM biodckr/biodocker:latest

################## BEGIN INSTALLATION ###########################
#Change user to root
USER root

ENV ZIP=libgtextutils-0.7.tar.gz
ENV URL=https://github.com/agordon/libgtextutils/releases/download/0.7/
ENV FOLDER=libgtextutils-0.7

ENV DST=/tmp
ENV ZIP1=fastx_toolkit-0.0.14.tar.bz2
ENV URL1=https://github.com/agordon/fastx_toolkit/releases/download/0.0.14/
ENV FOLDER1=fastx_toolkit-0.0.14
    
RUN wget $URL/$ZIP -O $DST/$ZIP && \
    tar xvf $DST/$ZIP -C $DST && \
    rm $DST/$ZIP && \
    cd $DST/$FOLDER && \ 
    ./configure && \
    make && \
    make install && \
    cd / && \
    rm -rf $DST/$ZIP && \
    wget $URL1/$ZIP1 -O $DST/$ZIP1 && \
    tar xvf $DST/$ZIP1 -C $DST && \
    rm $DST/$ZIP1 && \
    cd $DST/$FOLDER1 && \ 
    ./configure && \
    make && \
    make install && \
    cd / && \
    rm -rf $DST/$ZIP1

#Change user to biodocker
USER biodocker

#Change workdir to /data
WORKDIR /data/

#Autor
MAINTAINER Emilio Petrone <emiliopetronem@gmail.com
