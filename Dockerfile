FROM ruby:2.7.0

RUN gem install bundler
RUN mkdir /app
COPY Gemfile Gemfile.lock /app/
WORKDIR /app
RUN bundle install
COPY . /app
CMD ["bundle", "exec", "puma"]