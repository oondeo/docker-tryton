FROM debian:jessie
ENV DEBIAN_FRONTEND=noninteractive LANG=es_ES.UTF-8 LANGUAGE=es_ES.UTF-8 LC_ALL=es_ES.UTF-8 \
    XDG_DATA_HOME="/var/lib/tryton/.local/share" \
    TRYTON_HOME="/var/lib/tryton"


RUN sed -i 's/main$/main contrib non-free/g' /etc/apt/sources.list \
  && useradd -b $TRYTON_HOME tryton   && mkdir -p $XDG_DATA_HOME $HOME && chown -R tryton $TRYTON_HOME $XDG_DATA_HOME \
  && apt-get update  && apt-get install -y --no-install-recommends locales \
  && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
  && echo $LANG UTF-8 >> /etc/locale.gen \
  && locale-gen  \
  && apt-get install -y --no-install-recommends dash python-pip \
  python-pil python-dev python-stdnum python-virtualenv virtualenv libyaml-dev freetds-dev \
  libldap2-dev libsasl2-dev libpq-dev libmariadbd-dev libmysqlclient-dev sqlite sqlite3 \
  libsqlite3-dev libmagic-dev python-uno libreoffice-writer \
  npm libxml2-dev libxslt-dev libjpeg-dev mercurial git build-essential libreadline-dev \
  gcc libffi-dev libncurses5-dev ttf-mscorefonts-installer rabbitmq-server \
  && ln -s /usr/bin/nodejs /usr/bin/node \
  && npm install -g grunt bower \
  && rm -rf /var/cache/apt/* /var/lib/apt/* /var/tmp/* /tmp/* /var/log/* /usr/share/doc/* /usr/share/man/* || true 

WORKDIR /app
COPY bashrc /root/.bashrc
COPY unoconv /usr/local/bin


ENV TRYTON_VERSION=4.0 \
#dev/production
    ENVIRONMENT="dev" \
    PYTHON_BIN="/app/.env/bin/python" \    
    TRYTOND_BIN="trytond/bin/trytond" \
    TRYTOND_CONFIG="trytond.conf" \
    TRYTOND_LOGCONFIG="trytond-log.conf" \
    TRYTOND_ARGS="" \
    DB_NAME="" \
    TRYTOND_DATABASE_URI="postgresql://tryton:tryton@postgres:5432/" 
    
    
CMD ["su","tryton","-p","-c", "${PYTHON_BIN} ${TRYTOND_BIN} -c ${TRYTOND_CONFIG} --logconf ${TRYTOND_LOGCONFIG} -v"]

