FROM ruby:2.3
RUN mkdir -p /usr/src/app/vendor/cache
WORKDIR /usr/src/app
ENV PATH /usr/src/app/bin::$PATH

ADD /vendor/cache /usr/src/app/vendor/cache
ADD Gemfile Gemfile.lock /usr/src/app/
RUN bundle install --local

ADD . /usr/scr/app
