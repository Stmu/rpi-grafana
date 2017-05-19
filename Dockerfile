FROM resin/raspberrypi3-golang
MAINTAINER Stefan Mueller <stmu@stmu.net>


# RUN apt-get update && apt-get install curl
RUN curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -

RUN apt-get install nodejs

RUN node --version
RUN go version
# Get source code
RUN go get github.com/grafana/grafana || true 

RUN cd $GOPATH/src/github.com/grafana/grafana && go run build.go setup && go run build.go build

RUN npm install -g yarn
RUN yarn install --pure-lockfile
RUN npm run build

EXPOSE 3000
CMD ["./bin/grafana-server"]
