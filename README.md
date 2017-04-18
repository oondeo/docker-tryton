This is a base tryton Dockerfile to use with other deployments, example: 




```
FROM oondeo/tryton-base

#cleanup:
# find -name "*.pyc" -exec rm -f {} \;
# find .env -name "*.pyc" -exec rm -f {} \;
# find -type d -exec chmod 777 {} \;
COPY . /app 

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

```

Usage: docker run -v /home:/home -v /home/tryton:/var/lib/trytond -v /tmp:/tmp -v /home/app:/app oondeo/tryton
