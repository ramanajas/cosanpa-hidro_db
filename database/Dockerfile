FROM postgis/postgis:11-3.3
# LABEL maintainer='COSANPA/PRODIGA'
# LABEL maintainer=ramanajas@prodigasistemas.com.br
# LABEL maintainer=rafaelneto.g@gmail.com

# USER root

RUN    apt update \
    && apt -y upgrade \
    && localedef -i pt_BR -c -f UTF-8 -A /usr/share/locale/locale.alias pt_BR.UTF-8 \
    && apt install -y postgresql-13-pgrouting

COPY ./10_postgis.sh /docker-entrypoint-initdb.d/10_postgis.sh

ENV LANG pt_BR.utf8

WORKDIR /var/lib/postgresql

USER postgres

# EXPOSE 5432

# CMD ["postgres"]