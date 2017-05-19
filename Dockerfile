FROM resin/raspberrypi3-golang
MAINTAINER Stefan Mueller <stmu@stmu.net>

RUN apt-get update && apt-get install nodejs

# Get source code
RUN go get github.com/grafana/grafana

# Building the backend
cd $GOPATH/src/github.com/grafana/grafana
RUN go run build.go setup
RUN $GOPATH/bin/godep restore
RUN go run build.go build

RUN npm install
RUN npm install -g grunt-cli
RUN grunt

RUN  apt-get install ruby-dev build-essential
RUN gem install fpm
RUN go run build.go build package


RUN dpkg -i $GOPATH/src/github.com/grafana/grafana/dist/grafana_x.x.x-prex_armhf 