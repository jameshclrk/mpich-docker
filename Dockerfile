FROM gcc:6

MAINTAINER James Clark <james.clark@stfc.ac.uk>

ENV MPICH_VERSION 3.2

RUN set -x \
	&& curl -fSL "http://www.mpich.org/static/downloads/$MPICH_VERSION/mpich-$MPICH_VERSION.tar.gz" -o mpich.tar.gz \
	&& mkdir -p /usr/src/mpich \
	&& tar -xf mpich.tar.gz -C /usr/src/mpich --strip-components=1 \
	&& rm mpich.tar.gz* \
	&& cd /usr/src/mpich \
	&& { rm *.tar.* || true; } \
	&& dir="$(mktemp -d)" \
	&& cd "$dir" \
	&& /usr/src/mpich/configure \
	&& make -j"$(nproc)" \
	&& make install \
	&& cd .. \
	&& rm -rf "$dir" \
