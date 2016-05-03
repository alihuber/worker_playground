FROM ruby:2.3.1
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /worker_playground
WORKDIR /worker_playground
ADD Gemfile /worker_playground/Gemfile
ADD Gemfile.lock /worker_playground/Gemfile.lock
RUN bundle install
ADD . /worker_playground
