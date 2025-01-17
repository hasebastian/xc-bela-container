FROM debian:bullseye
ENV DEBIAN_FRONTEND noninteractive

COPY scripts/build_bela.sh \
	scripts/build_packages.sh \
	scripts/build_env.sh \
	scripts/build_settings \
	./

RUN ./build_packages.sh && rm build_packages.sh
RUN ./build_bela.sh && rm build_bela.sh && rm build_settings
RUN ./build_env.sh && rm build_env.sh

RUN apt-get update && \
      apt-get install -y \
				python3 \
				pipenv

RUN pip3 install tensorflow torch

CMD /bin/bash