FROM opensuse:13.2
# the next two commands are just necessary, because of a bug in the opensuse 13:2 image (3/07/2015)
RUN zypper rr repo-oss
RUN zypper ar http://download.opensuse.org/distribution/13.2/repo/oss/ repo-oss
RUN zypper -n ref && zypper -n up && zypper -n in ruby rubygem-yast-rake yast2 libpwquality1 && zypper -n in -t pattern devel_ruby devel_C_C++ devel_basis

VOLUME /password-policy
WORKDIR /password-policy

ADD run-yast.sh /
RUN chmod u+x /run-yast.sh

CMD ["/run-yast.sh"]
