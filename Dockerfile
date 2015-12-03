FROM gentoo/stage3-amd64:latest
RUN emerge --sync
RUN emerge =sys-devel/gcc-4.5.4 && rm -rf /var/tmp/protage/*
RUN gcc-config x86_64-pc-linux-gnu-4.5.4 && env-update && source /etc/profile
ADD keyword /etc/portage/package.accept_keywords/ruby
ADD use /etc/portage/package.use/ruby
RUN yes | emerge =dev-lang/ruby-2.2.3-r2 && rm -rf /var/tmp/protage/*

RUN gem install bundler -v 1.7.9
