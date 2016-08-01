FROM gentoo/stage3-amd64:latest
RUN emerge --sync
RUN emerge =sys-devel/gcc-4.5.4 && rm -rf /var/tmp/protage/*
RUN gcc-config x86_64-pc-linux-gnu-4.5.4 && env-update && source /etc/profile
RUN emerge eix vim net-misc/curl dev-vcs/git && rm -rf /var/tmp/portage/*

## Ruby
ADD keyword /etc/portage/package.accept_keywords/ruby
ADD use /etc/portage/package.use/ruby
RUN yes | emerge =dev-lang/ruby-2.3.1 && rm -rf /var/tmp/protage/*


## Rails
ADD keyword_rails /etc/portage/package.accept_keywords/rails
RUN emerge dev-ruby/mysql2 dev-db/postgresql dev-db/sqlite &&  rm -rf /var/tmp/protage/*
RUN gem install bundler -v 1.7.9
RUN bundle config --global frozen 1

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

ONBUILD COPY Gemfile /usr/src/app/
ONBUILD COPY Gemfile.lock /usr/src/app/
ONBUILD RUN bundle install

ONBUILD COPY . /usr/src/app
