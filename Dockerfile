FROM resin/raspberrypi3-golang
MAINTAINER Stefan Mueller <stmu@stmu.net>


RUN wget https://nodejs.org/dist/v6.10.3/node-v6.10.3-linux-armv7l.tar.xz
RUN tar -xvf node-v6.10.3-linux-armv7l.tar.xz
RUN cd node-v6.10.3-linux-armv7l/bin

RUN cp -R * /usr/local/

RUN node --version
RUN go version
# Get source code
RUN go get github.com/grafana/grafana

RUN cd $GOPATH/src/github.com/grafana/grafana
RUN go run build.go setup
RUN go run build.go build

RUN npm install -g yarn
RUN yarn install --pure-lockfile
RUN npm run build

EXPOSE 3000
CMD ["./bin/grafana-server"]
