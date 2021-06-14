bash-completion:
    FROM curlimages/curl:7.77.0
    WORKDIR /tmp
    RUN curl 'https://raw.githubusercontent.com/scop/bash-completion/2.x/bash_completion' -o ./bash_completion
    SAVE ARTIFACT ./bash_completion

baseline:
    ARG RUBY_VERSION=2.7
    FROM ruby:$RUBY_VERSION

    COPY +bash-completion/bash_completion /usr/src/bash_completion
    ENV BASH_COMPLETION_SCRIPT=/usr/src/bash_completion

setup-rails-app:
    FROM +baseline
    ARG RAILS_VERSION="~>6.0"

    RUN gem install rails --version "$RAILS_VERSION"

    WORKDIR /usr/src
    RUN rails new testapp \
        --skip-git --skip-keeps \
        --skip-action-cable --skip-action-mailer --skip-active-storage \
        --skip-action-text --skip-javascript --skip-sprockets --skip-turbolinks \
        --skip-puma
    ENV RAILS_TEST_APP_DIR=/usr/src/testapp

    # In Ruby 3 we need to explicitly declare REXML as a dependency
    RUN if [ ${RUBY_VERSION%%.*} -ge 3 ]; then \
            cd "$RAILS_TEST_APP_DIR" && \
            echo 'gem "rexml"' >>Gemfile && \
            bundle; \
        fi

test-bundle:
    FROM +setup-rails-app

    WORKDIR /usr/src/completion-ruby
    COPY --dir ./completion-bundle ./completion-rails ./completion-rake ./tests ./
    RUN ./tests/completion-bundle/test.sh

test-bundle-all:
    BUILD --build-arg RUBY_VERSION=2.5 --build-arg RAILS_VERSION="~>5.0" +test-bundle
    BUILD --build-arg RUBY_VERSION=2.5 --build-arg RAILS_VERSION="~>6.0" +test-bundle
    BUILD --build-arg RUBY_VERSION=2.7 --build-arg RAILS_VERSION="~>6.0" +test-bundle
    BUILD --build-arg RUBY_VERSION=3.0 --build-arg RAILS_VERSION="~>6.0" +test-bundle

test-rails:
    FROM +setup-rails-app

    WORKDIR /usr/src/completion-ruby
    COPY --dir ./completion-rails ./tests ./
    RUN ./tests/completion-rails/test.sh

test-rails-all:
    BUILD --build-arg RUBY_VERSION=2.5 --build-arg RAILS_VERSION="~>5.0" +test-rails
    BUILD --build-arg RUBY_VERSION=2.5 --build-arg RAILS_VERSION="~>6.0" +test-rails
    BUILD --build-arg RUBY_VERSION=2.7 --build-arg RAILS_VERSION="~>6.0" +test-rails
    BUILD --build-arg RUBY_VERSION=3.0 --build-arg RAILS_VERSION="~>6.0" +test-rails

test-rake:
    FROM +setup-rails-app

    WORKDIR /usr/src/completion-ruby
    COPY --dir ./completion-rake ./tests ./
    RUN ./tests/completion-rake/test.sh

test-rake-all:
    BUILD --build-arg RUBY_VERSION=2.5 --build-arg RAILS_VERSION="~>5.0" +test-rake
    BUILD --build-arg RUBY_VERSION=2.5 --build-arg RAILS_VERSION="~>6.0" +test-rake
    BUILD --build-arg RUBY_VERSION=2.7 --build-arg RAILS_VERSION="~>6.0" +test-rake
    BUILD --build-arg RUBY_VERSION=3.0 --build-arg RAILS_VERSION="~>6.0" +test-rake

test-ruby:
    FROM +baseline

    WORKDIR /usr/src/completion-ruby
    COPY --dir ./completion-ruby ./tests ./
    RUN ./tests/completion-ruby/test.sh

test-ruby-all:
    BUILD --build-arg RUBY_VERSION=1.9 +test-ruby
    BUILD --build-arg RUBY_VERSION=2.0 +test-ruby
    BUILD --build-arg RUBY_VERSION=2.1 +test-ruby
    BUILD --build-arg RUBY_VERSION=2.2 +test-ruby
    BUILD --build-arg RUBY_VERSION=2.3 +test-ruby
    BUILD --build-arg RUBY_VERSION=2.4 +test-ruby
    BUILD --build-arg RUBY_VERSION=2.5 +test-ruby
    BUILD --build-arg RUBY_VERSION=2.6 +test-ruby
    BUILD --build-arg RUBY_VERSION=2.7 +test-ruby
    BUILD --build-arg RUBY_VERSION=3.0 +test-ruby

test:
    BUILD +test-rails-all
    BUILD +test-rake-all
    BUILD +test-ruby-all
