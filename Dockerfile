# Build stage
FROM php:8.3-fpm-alpine AS builder

RUN apk add --no-cache --virtual .build-deps \
    $PHPIZE_DEPS \
    postgresql-dev \
    libzip-dev \
    oniguruma-dev \
    icu-dev

RUN docker-php-ext-install -j$(nproc) \
    pdo_mysql \
    mysqli \
    pdo_pgsql \
    pgsql \
    mbstring \
    intl \
    zip

# Runtime stage
FROM php:8.3-fpm-alpine

RUN apk add --no-cache \
    postgresql-libs \
    libzip \
    icu-libs

COPY --from=builder /usr/local/lib/php/extensions/ /usr/local/lib/php/extensions/
COPY --from=builder /usr/local/etc/php/conf.d/ /usr/local/etc/php/conf.d/

WORKDIR /var/www/html

CMD ["php-fpm"]