FROM ruby:2.7.5 as rails-base
RUN apt-get update -qq && apt-get install -y postgresql-client
WORKDIR /bookers2
# install nodejs(LTS)
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - && apt-get install -y nodejs
# install yarn
RUN npm install --global yarn
# gem
COPY Gemfile* /bookers2/
RUN bundle install

FROM rails-base as development
# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

FROM rails-base as production
COPY . /bookers2
RUN rails webpacker:install
# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]