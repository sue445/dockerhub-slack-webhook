FROM ruby:3.4-slim

ENV RACK_ENV=production

WORKDIR /app

COPY Gemfile Gemfile.lock /app/

RUN bundle config set --local jobs 2 && \
    bundle config set --local deployment 'true' && \
    bundle config set --local without 'development test' && \
    bundle install

COPY . .

EXPOSE 8080

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
