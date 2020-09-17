FROM bcit/openshift-openresty:latest

ENV KEYCLOAK_ENDPOINT      "https://keycloak.example.com"
ENV KEYCLOAK_REALM         "master"
ENV KEYCLOAK_CLIENT_ID     "nginx"
ENV KEYCLOAK_CLIENT_SECRET "00000000-0000-0000-0000-000000000000"

LABEL maintainer="jesse@weisner.ca, chriswood.ca@gmail.com"
LABEL build_id="1600379444"

RUN opm install \
        bungle/lua-resty-session \
        zmartzone/lua-resty-openidc

COPY openid-callback.conf /usr/local/openresty/nginx/conf
COPY openid-auth.conf     /usr/local/openresty/nginx/conf
COPY default.conf         /usr/local/openresty/nginx/conf.d

RUN chown -R :root /usr/local/openresty \
 && chmod -R g+w  /usr/local/openresty

COPY 50-copy-config.sh /docker-entrypoint.d/
