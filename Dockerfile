FROM node:12-slim

RUN apt-get update && apt-get -y --no-install-recommends install \
    ca-certificates \
    curl \
    gnupg2 \
  && curl -s https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
  && apt-get update && apt-get install -y --no-install-recommends \
    firefox-esr \
    google-chrome-stable \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /src/*.deb

WORKDIR /home/node
COPY package.json .
RUN npm install
COPY . .

RUN mkdir --parents /home/node/report && \
    chown --recursive node:node /home/node
USER node

# Disable Lighthouse error reporting to prevent prompt.
ENV CI=true
CMD ["npm", "test"]
