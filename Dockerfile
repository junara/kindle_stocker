FROM ruby:3.0
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs fonts-ipafont chromium
RUN fc-cache -fv
RUN mkdir /myapp
WORKDIR /myapp
ADD . /myapp
RUN bundle install
