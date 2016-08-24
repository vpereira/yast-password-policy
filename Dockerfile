FROM opensuse:42.1
RUN zypper -n ref && zypper -n up && zypper -n in ruby \
    ruby2.1-rubygem-yast-rake yast2 libpwquality1 && \
    zypper -n in -t pattern devel_ruby devel_C_C++ devel_basis

VOLUME /password-policy
WORKDIR /password-policy

ADD run-yast.sh /
RUN chmod u+x /run-yast.sh

CMD ["/run-yast.sh"]
