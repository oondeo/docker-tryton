FROM oondeo/tryton-base

RUN echo "deb http://ftp.debian.org/debian jessie-backports main" > /etc/apt/sources.list.d/backports.list \
    && apt-get update && apt-get install -y --no-install-recommends python-lldb-3.8 lldb-3.8 openssh-server \
    && rm -rf /var/cache/apt/* /var/lib/apt/* /var/tmp/* /tmp/* /var/log/* /usr/share/doc/* /usr/share/man/* /root/.npm || true

RUN ln -s /usr/bin/lldb-3.8 /usr/bin/lldb || true
RUN ln -s /usr/bin/lldb-mi-3.8 /usr/bin/lldb-mi || true
RUN ln -s /usr/bin/lldb-server-3.8 /usr/bin/lldb-server || true

ENV WATCHMAN_VERSION=4.7.0
RUN wget -O - https://github.com/facebook/watchman/archive/v$WATCHMAN_VERSION.tar.gz | tar -zxvf- -C /tmp \
    && ln -s /var /usr/local/var && cd /tmp/watchman-$WATCHMAN_VERSION \
    && ./autogen.sh && ./configure && make && make install && npm install -g nuclide \
    && rm -rf /var/cache/apt/* /var/lib/apt/* /var/tmp/* /tmp/* /var/log/* /usr/share/doc/* /usr/share/man/* /root/.npm || true

RUN bash -c 'echo -e "sshconfig\nsshconfig" | passwd tryton'
COPY sshconfig /usr/local/sbin/sshconfig
COPY start.sh /start.sh

CMD ["/start.sh"]
