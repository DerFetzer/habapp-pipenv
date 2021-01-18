FROM python:3.8-alpine

# Install required dependencies
RUN apk add --no-cache \
# Support for Timezones
    tzdata \
# ujson won't compile without these libs
    g++

RUN pip3 install pipenv

RUN mkdir /opt/config && mkdir /opt/venvs
RUN chown -R 9001:9001 /opt/config && chown -R 9001:9001 /opt/venvs

COPY ./entrypoint.sh /opt/app/entrypoint.sh

USER 9001:9001

ENV WORKON_HOME="/opt/venvs"
ENV PIPENV_CACHE_DIR="/opt/venvs/.cache"

WORKDIR /opt/config

RUN pipenv install "HABApp===0.19.1"
RUN pipenv sync

VOLUME ["/opt/config"]
VOLUME ["/opt/venvs"]

ENTRYPOINT ["/opt/app/entrypoint.sh"]
CMD ["--config", "/opt/config"]

