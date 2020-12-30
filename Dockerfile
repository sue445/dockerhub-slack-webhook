FROM ruby:3.0.0

# Create app directory
WORKDIR /app

# Bundle app source
COPY . .

RUN bundle install

EXPOSE 3000

CMD ["bundle","exec","puma","-p","3000"]
