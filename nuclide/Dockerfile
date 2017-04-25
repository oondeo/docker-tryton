FROM oondeo/tryton-base


RUN apt-get update && apt-get install -y --no-install-recommends lldb liblldb-3.5-dev openssh-server \
    && rm -rf /var/cache/apt/* /var/lib/apt/* /var/tmp/* /tmp/* /var/log/* /usr/share/doc/* /usr/share/man/* /root/.npm || true

ENV WATCHMAN_VERSION=4.7.0
RUN wget -O - https://github.com/facebook/watchman/archive/v$WATCHMAN_VERSION.tar.gz | tar -zxvf- -C /tmp \
    && ln -s /var /usr/local/var && cd /tmp/watchman-$WATCHMAN_VERSION \
    && ./autogen.sh && ./configure && make && make install && npm install -g nuclide \
    && rm -rf /var/cache/apt/* /var/lib/apt/* /var/tmp/* /tmp/* /var/log/* /usr/share/doc/* /usr/share/man/* /root/.npm || true

COPY sshconfig /usr/local/sbin/sshconfig
COPY start.sh /start.sh

CMD ["/start.sh"]
