FROM ubuntu:18.04

# Setup the base OS image for installing things
ENV    DEBIAN_FRONTEND noninteractive
RUN    echo "deb-src http://archive.ubuntu.com/ubuntu xenial main" >> /etc/apt/sources.list
RUN    sed 's/main$/main universe/' -i /etc/apt/sources.list
RUN    apt-get update
RUN    apt-get upgrade -y
RUN    apt-get -y install wget \
                          vim \
                          git \
                          libpq-dev

# Install dependencies for nginx
RUN    apt-get -y build-dep nginx && \
       apt-get -q -y clean && \
       rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

# Install openresty version 1.15.8.2
RUN    wget https://openresty.org/download/openresty-1.15.8.2.tar.gz \
  && tar xvfz openresty-1.15.8.2.tar.gz \
  && cd openresty-1.15.8.2 \
  && ./configure --with-luajit  \
                 --with-http_addition_module \
                 --with-http_dav_module \
                 --with-http_geoip_module \
                 --with-http_gzip_static_module \
                 --with-http_image_filter_module \
                 --with-http_realip_module \
                 --with-http_stub_status_module \
                 --with-http_ssl_module \
                 --with-http_sub_module \
                 --with-http_xslt_module \
                 --with-ipv6 \
                 --with-http_postgres_module \
                 --with-pcre-jit \
  && make \
  && make install \
  && rm -rf /openresty*
