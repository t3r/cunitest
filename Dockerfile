FROM node:12-slim

ARG BUILD_NUMBER=0
ARG BUILD_ID=0
ARG BUILD_TAG="none"
ARG GIT_COMMIT="none"

# Install utilities
RUN apt-get update --fix-missing && apt-get -y upgrade
RUN apt-get update && apt-get -y install firefox-esr wget gnupg2

# Install latest chrome dev package.
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
    && apt-get update \
    && apt-get install -y google-chrome-stable --no-install-recommends \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /src/*.deb

# Add a tester user and setup home dir.
RUN groupadd --system tester && \
    useradd --system --create-home --gid tester --groups audio,video tester --shell /bin/bash && \
    mkdir --parents /home/tester/report && \
    chown --recursive tester:tester /home/tester

WORKDIR /home/tester
COPY package.json .
RUN npm install
COPY . .

RUN chown --recursive tester:tester /home/tester
USER tester

VOLUME /home/tester/report

# Disable Lighthouse error reporting to prevent prompt.
ENV CI=true

EXPOSE 8080

CMD ["npm", "test"]
