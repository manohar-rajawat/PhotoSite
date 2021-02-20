FROM ruby:2.6.3-alpine3.10
# This installs
# * nodejs
# * sqlite
# * yarn
# * Rails
# * Gems in the Gemfile

RUN apk add --update --no-cache bash build-base nodejs sqlite-dev tzdata postgresql-dev yarn

RUN gem install bundler

WORKDIR /usr/src/app
COPY package.json yarn.lock ./

RUN yarn install --check-files

COPY Gemfile* ./
RUN bundle install

COPY .. .

ENV PATH=./bin:$PATH
EXPOSE 3000

CMD rails server -b 0.0.0.0 --port 3000