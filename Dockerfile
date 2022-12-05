FROM debian:bullseye

USER root

WORKDIR /app

COPY . .

#installing system dependencies
RUN apt-get -y update
RUN apt-get install -y r-base r-base-dev
RUN apt-get install -y libcurl4-openssl-dev
RUN apt-get install -y libxml2-dev
RUN apt-get install libssl-dev

#install R dependencies
RUN chmod -R 777 /app

ENV TZ=Etc/UTC

# RUN Rscript ./install.R

ENTRYPOINT sh ./entrypoint.sh

