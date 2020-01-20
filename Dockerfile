FROM node:12-slim

# Install utilities
RUN apt-get update --fix-missing && apt-get -y upgrade && \
    apt-get -y --no-install-recommends install firefox-esr wget gnupg2 
# Don't combine this, we need gnupg2 for apt-key
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
    && apt-get update \
    && apt-get install -y google-chrome-stable --no-install-recommends \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /src/*.deb && \
    mkdir --parents /home/node/report && \
    chown --recursive node:node /home/node

WORKDIR /home/node
COPY package.json .
RUN npm install
COPY . .

RUN chown --recursive node:node /home/node
USER node

VOLUME /home/node/report

# Disable Lighthouse error reporting to prevent prompt.
ENV CI=true

EXPOSE 8080

CMD ["npm", "test"]
