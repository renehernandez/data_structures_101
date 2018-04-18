FROM ruby:2.5

RUN mkdir /datastructures

WORKDIR /datastructures

COPY . .

RUN bundle install

CMD ["rspec"]