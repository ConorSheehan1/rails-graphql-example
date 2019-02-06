FROM ubuntu:16.04

RUN apt-get update && apt-get install -y ruby ruby-dev libsqlite3-dev curl bzip2 build-essential libssl-dev libreadline-dev zlib1g-dev apt-utils && \
  gem install sqlite3 -v 1.4.0
  # gem install rails -v 5.1.4 && \
  # rails new sqlite_test #&& \
  # cd sqlite_test && bundle #&& \
  # rails db:create # (failing)
  # Gem::LoadError: can't activate sqlite3 (~> 1.3.6), already activated sqlite3-1.4.0
  
  # solution: 
  # Gemfile: use sqlite ~> 1.3.6
  # bundle && rails db:create
