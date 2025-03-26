FROM nginx:alpine

COPY docker/nginx.conf /etc/nginx/conf.d/default.conf

COPY build/ /usr/share/nginx/html/

RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80