FROM opensuse:13.2
RUN zypper rr repo-oss
RUN zypper ar http://download.opensuse.org/distribution/13.2/repo/oss/ repo-oss
RUN zypper -n ref && zypper -n up && zypper -n in ruby rubygem-yast-rake yast2  && zypper -n in -t pattern devel_ruby devel_C_C++ devel_basis
ADD [".","/password-policy"]
CMD ["/password-policy/run-yast.sh"]
