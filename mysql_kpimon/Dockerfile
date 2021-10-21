FROM nexus3.o-ran-sc.org:10001/o-ran-sc/bldr-ubuntu18-c-go:1.9.0 as kpimonbuild

ENV PATH $PATH:/usr/local/bin
ENV GOPATH /go
ENV GOBIN /go/bin


ENV RMR_SEED_RT /opt/routes.txt

COPY routes.txt /opt/routes.txt

ARG RMRVERSION=4.0.2
ARG RMRLIBURL=https://packagecloud.io/o-ran-sc/release/packages/debian/stretch/rmr_${RMRVERSION}_amd64.deb/download.deb
ARG RMRDEVURL=https://packagecloud.io/o-ran-sc/release/packages/debian/stretch/rmr-dev_${RMRVERSION}_amd64.deb/download.deb
RUN wget --content-disposition ${RMRLIBURL} && dpkg -i rmr_${RMRVERSION}_amd64.deb
RUN wget --content-disposition ${RMRDEVURL} && dpkg -i rmr-dev_${RMRVERSION}_amd64.deb
RUN rm -f rmr_${RMRVERSION}_amd64.deb rmr-dev_${RMRVERSION}_amd64.deb
# RMR setup
#RUN mkdir -p /opt/route/
# copy rmr files from builder image in lieu of an Alpine package
#COPY --from=nexus3.o-ran-sc.org:10002/o-ran-sc/bldr-alpine3-rmr:4.0.5 /usr/local/lib64/librmr* /usr/local/lib64/
# rmr_probe replaced health_ck
#COPY --from=nexus3.o-ran-sc.org:10002/o-ran-sc/bldr-alpine3-rmr:4.0.5 /usr/local/bin/rmr* /usr/local/bin/
#ENV LD_LIBRARY_PATH /usr/local/lib/:/usr/local/lib64
#COPY tests/fixtures/local.rt /opt/route/local.rt
#ENV RMR_SEED_RT /opt/route/local.rt

#RUN go get -u github.com/go-sql-driver/mysql@v1.4

RUN export GIT_SSL_NO_VERIFY=1
RUN git config --global http.sslverify false
ARG XAPPFRAMEVERSION=v0.4.11
WORKDIR /go/src
RUN mkdir github.com
WORKDIR /go/src/github.com
RUN mkdir go-sql-driver
WORKDIR /go/src/github.com/go-sql-driver
RUN git clone https://github.com/go-sql-driver/mysql -b v1.4

WORKDIR /go/src/gerrit.o-ran-sc.org/r/ric-plt
#RUN apt-get remove golang-go
#RUN rm -rvf /usr/local/go
#RUN wget https://golang.org/dl/go1.13.1.linux-amd64.tar.gz
#RUN sha256sum go1.13.1.linux-amd64.tar.gz
#RUN tar -xzf go1.13.1.linux-amd64.tar.gz -C /usr/local
#RUN mv go /usr/local
#RUN export GOROOT=/usr/local/go 
#RUN export PATH=$PATH:/usr/local/go/bin
#RUN export GO111MODULE=on
#RUN go mod init
#RUN go mod edit -replace=github.com/go-sql-driver/mysql=github.com/go-sql-driver/mysql@v1.4.1
RUN git clone -b cherry "https://gerrit.o-ran-sc.org/r/ric-plt/sdlgo"
RUN git clone -b ${XAPPFRAMEVERSION} "https://gerrit.o-ran-sc.org/r/ric-plt/xapp-frame"
RUN cd xapp-frame && \
    GO111MODULE=on go mod vendor -v && \
    cp -r vendor/* /go/src/ && \
    rm -rf vendor
#RUN GO111MODULE=on go get -u github.com/go-sql-driver/mysql@v1.4.1
WORKDIR /go/src/gerrit.o-ran-sc.org/r/scp/ric-app/kpimon
COPY control/ control/
COPY cmd/ cmd/
COPY e2ap/ e2ap/
COPY e2sm/ e2sm/

# "COMPILING E2AP Wrapper"
RUN cd e2ap && \
    gcc -c -fPIC -Iheaders/ lib/*.c wrapper.c && \
    gcc *.o -shared -o libe2apwrapper.so && \
    cp libe2apwrapper.so /usr/local/lib/ && \
    mkdir /usr/local/include/e2ap && \
    cp wrapper.h headers/*.h /usr/local/include/e2ap && \
    ldconfig

# "COMPILING E2SM Wrapper"
RUN cd e2sm && \
    gcc -c -fPIC -Iheaders/ lib/*.c wrapper.c && \
    gcc *.o -shared -o libe2smwrapper.so && \
    cp libe2smwrapper.so /usr/local/lib/ && \
    mkdir /usr/local/include/e2sm && \
    cp wrapper.h headers/*.h /usr/local/include/e2sm && \
    ldconfig

WORKDIR /go/src/gerrit.o-ran-sc.org/r/scp/ric-app/kpimon

RUN mkdir pkg

RUN go build ./cmd/kpimon.go && pwd && ls -lat


FROM ubuntu:18.04

#ENV PATH $PATH:/usr/local/bin
#ENV GOPATH /go
#ENV GOBIN /go/bin


#ENV RMR_SEED_RT /opt/routes.txt

#COPY routes.txt /opt/routes.txt


COPY --from=kpimonbuild /usr/local/lib /usr/local/lib
COPY --from=kpimonbuild /usr/local/include/e2ap/*.h /usr/local/include/e2ap/
COPY --from=kpimonbuild /usr/local/include/e2sm/*.h /usr/local/include/e2sm/
RUN ldconfig
WORKDIR /go/src/gerrit.o-ran-sc.org/r/ric-plt/xapp-frame/config/
COPY --from=kpimonbuild /go/src/gerrit.o-ran-sc.org/r/ric-plt/xapp-frame/config/config-file.yaml .
WORKDIR /go/src/gerrit.o-ran-sc.org/r/scp/ric-app/kpimon
COPY --from=kpimonbuild /go/src/gerrit.o-ran-sc.org/r/scp/ric-app/kpimon/kpimon .
#CMD exec /bin/bash -c "trap : TERM INT; sleep infinity & wait"
