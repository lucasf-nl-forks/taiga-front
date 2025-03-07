# This source code is licensed under the terms of the
# GNU Affero General Public License found in the LICENSE file in
# the root directory of this source tree.
#
# Copyright (c) 2021-present Kaleidos INC

FROM nginx:1.23-alpine
LABEL maintainer="support@taiga.io"

COPY docker/default.conf /etc/nginx/conf.d/default.conf
COPY docker/conf.json.template /
COPY docker/config_env_subst.sh /docker-entrypoint.d/30_config_env_subst.sh

# subversion???
RUN set -eux; \
    apk update; \
    apk add --no-cache --virtual /.build-deps \
       subversion nodejs npm; \
    apk add bash;

COPY . /taiga
WORKDIR /taiga

RUN npm ci && npx gulp deploy

RUN mkdir /taiga/dist/plugins; \
    apk del --no-cache /.build-deps; \
    mv /taiga/dist/* /usr/share/nginx/html;
