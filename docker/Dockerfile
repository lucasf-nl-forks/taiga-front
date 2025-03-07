# This source code is licensed under the terms of the
# GNU Affero General Public License found in the LICENSE file in
# the root directory of this source tree.
#
# Copyright (c) 2021-present Kaleidos INC

# SASS NodeJS version requirements
FROM node:18.0.0-alpine AS node

FROM nginx:1.27-alpine
LABEL maintainer="support@taiga.io"

COPY --from=node /usr/lib /usr/lib
COPY --from=node /usr/local/lib /usr/local/lib
COPY --from=node /usr/local/include /usr/local/include
COPY --from=node /usr/local/bin /usr/local/bin

COPY docker/default.conf /etc/nginx/conf.d/default.conf
COPY docker/conf.json.template /
COPY docker/config_env_subst.sh /docker-entrypoint.d/30_config_env_subst.sh

# subversion???
RUN set -eux; \
    apk update; \
    apk add --no-cache --virtual /.build-deps \
       subversion python3 optipng zlib zlib-dev libc6-compat git; \
    apk add bash;

COPY . /taiga
WORKDIR /taiga

RUN npm i && npm i optipng-bin && npm rebuild node-sass && npx gulp deploy

RUN mkdir /taiga/dist/plugins; \
    apk del --no-cache /.build-deps; \
    mv /taiga/dist/* /usr/share/nginx/html;
