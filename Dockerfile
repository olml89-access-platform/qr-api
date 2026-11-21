FROM dunglas/frankenphp:php8.5-alpine AS base

WORKDIR /app

RUN apk add --no-cache libzip && \
    apk add --no-cache --virtual .zip-build-deps \
        libzip-dev && \
    docker-php-ext-install zip && \
    apk del .zip-build-deps

FROM base AS prod

COPY . /app
COPY Caddyfile /etc/frankenphp/Caddyfile

FROM base AS dev

RUN --mount=type=bind,from=ghcr.io/php/pie:bin,source=/pie,target=/usr/local/bin/pie \
    apk add --no-cache --virtual .xdebug-build-deps \
        $PHPIZE_DEPS \
        linux-headers && \
    pie install xdebug/xdebug && \
    apk del .xdebug-build-deps

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

ARG XDEBUG_PORT
COPY docker/php/conf.d/xdebug.ini /usr/local/etc/php/conf.d/xdebug-settings.ini
RUN sed -i "s|\${XDEBUG_PORT}|$XDEBUG_PORT|g" /usr/local/etc/php/conf.d/xdebug-settings.ini
