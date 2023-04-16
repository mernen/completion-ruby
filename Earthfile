VERSION 0.7

bash-completion:
    FROM curlimages/curl:8.00.1
    WORKDIR /tmp
    RUN curl 'https://raw.githubusercontent.com/scop/bash-completion/2.x/bash_completion' -o ./bash_completion
    SAVE ARTIFACT ./bash_completion

ruby:
    ARG RUBY_VERSION=2.7
    FROM ruby:$RUBY_VERSION

    COPY +bash-completion/bash_completion /usr/src/bash_completion
    ENV BASH_COMPLETION_SCRIPT=/usr/src/bash_completion

rails-app:
    FROM +ruby

    ARG RAILS_VERSION="~>7.0"
    RUN gem install rails --version "$RAILS_VERSION"

    WORKDIR /usr/src
    RUN rails new testapp \
        --skip-git --skip-keeps \
        --skip-action-cable --skip-action-mailer --skip-action-mailbox --skip-active-job --skip-active-storage \
        --skip-action-text --skip-javascript --skip-sprockets --skip-turbolinks \
        --skip-bootsnap --skip-listen --skip-jbuilder --skip-puma
    ENV RAILS_TEST_APP_DIR=/usr/src/testapp


test:
    BUILD +test-bundle-all
    BUILD +test-gem-all
    BUILD +test-jruby-all
    BUILD +test-rails-all
    BUILD +test-rake-all
    BUILD +test-ruby-all

test-latest:
    BUILD +test-bundle --RUBY_VERSION=latest --RAILS_VERSION=">=7"
    BUILD +test-gem --RUBY_VERSION=latest
    BUILD +test-jruby --JRUBY_VERSION=latest
    BUILD +test-rails --RUBY_VERSION=latest --RAILS_VERSION=">=7"
    BUILD +test-rake --RUBY_VERSION=latest --RAILS_VERSION=">=7"
    BUILD +test-ruby --RUBY_VERSION=latest

test-bundle:
    FROM +rails-app

    WORKDIR /usr/src/completion-ruby
    COPY --dir ./completion-bundle ./completion-rails ./completion-rake ./tests ./
    RUN ./tests/completion-bundle/test.sh

test-bundle-all:
    BUILD +test-bundle --RUBY_VERSION=2.7 --RAILS_VERSION="~>6.0"
    BUILD +test-bundle --RUBY_VERSION=3.0 --RAILS_VERSION="~>6.0"
    BUILD +test-bundle --RUBY_VERSION=3.0 --RAILS_VERSION="~>7.0"
    BUILD +test-bundle --RUBY_VERSION=3.1 --RAILS_VERSION="~>7.0"


test-gem:
    FROM +ruby

    WORKDIR /usr/src/completion-ruby
    COPY --dir ./completion-gem ./tests ./
    RUN ./tests/completion-gem/test.sh

test-gem-all:
    BUILD +test-gem --RUBY_VERSION=1.9
    BUILD +test-gem --RUBY_VERSION=2.0
    BUILD +test-gem --RUBY_VERSION=2.1
    BUILD +test-gem --RUBY_VERSION=2.2
    BUILD +test-gem --RUBY_VERSION=2.3
    BUILD +test-gem --RUBY_VERSION=2.4
    BUILD +test-gem --RUBY_VERSION=2.5
    BUILD +test-gem --RUBY_VERSION=2.6
    BUILD +test-gem --RUBY_VERSION=2.7
    BUILD +test-gem --RUBY_VERSION=3.0
    BUILD +test-gem --RUBY_VERSION=3.1


test-jruby:
    ARG JRUBY_VERSION=9
    FROM jruby:$JRUBY_VERSION

    COPY +bash-completion/bash_completion /usr/src/bash_completion
    ENV BASH_COMPLETION_SCRIPT=/usr/src/bash_completion

    WORKDIR /usr/src/completion-ruby
    COPY --dir ./completion-jruby ./completion-ruby ./tests ./
    RUN ./tests/completion-jruby/test.sh

test-jruby-all:
    # jruby images are available for ARM64 only starting with 9.3, so let's force x86-64
    BUILD --platform=linux/amd64 +test-jruby --JRUBY_VERSION=9.2
    BUILD +test-jruby --JRUBY_VERSION=9.3
    BUILD +test-jruby --JRUBY_VERSION=9.4


test-rails:
    FROM +rails-app

    WORKDIR /usr/src/completion-ruby
    COPY --dir ./completion-rails ./tests ./
    RUN ./tests/completion-rails/test.sh

test-rails-all:
    BUILD +test-rails --RUBY_VERSION=2.7 --RAILS_VERSION="~>6.0"
    BUILD +test-rails --RUBY_VERSION=3.0 --RAILS_VERSION="~>6.0"
    BUILD +test-rails --RUBY_VERSION=3.0 --RAILS_VERSION="~>7.0"
    BUILD +test-rails --RUBY_VERSION=3.1 --RAILS_VERSION="~>7.0"


test-rake:
    FROM +rails-app

    WORKDIR /usr/src/completion-ruby
    COPY --dir ./completion-rake ./tests ./
    RUN ./tests/completion-rake/test.sh

test-rake-all:
    BUILD +test-rake --RUBY_VERSION=2.7 --RAILS_VERSION="~>6.0"
    BUILD +test-rake --RUBY_VERSION=3.0 --RAILS_VERSION="~>6.0"
    BUILD +test-rake --RUBY_VERSION=3.0 --RAILS_VERSION="~>7.0"
    BUILD +test-rake --RUBY_VERSION=3.1 --RAILS_VERSION="~>7.0"


test-ruby:
    FROM +ruby

    WORKDIR /usr/src/completion-ruby
    COPY --dir ./completion-ruby ./tests ./
    RUN ./tests/completion-ruby/test.sh

test-ruby-all:
    BUILD +test-ruby --RUBY_VERSION=1.9
    BUILD +test-ruby --RUBY_VERSION=2.0
    BUILD +test-ruby --RUBY_VERSION=2.1
    BUILD +test-ruby --RUBY_VERSION=2.2
    BUILD +test-ruby --RUBY_VERSION=2.3
    BUILD +test-ruby --RUBY_VERSION=2.4
    BUILD +test-ruby --RUBY_VERSION=2.5
    BUILD +test-ruby --RUBY_VERSION=2.6
    BUILD +test-ruby --RUBY_VERSION=2.7
    BUILD +test-ruby --RUBY_VERSION=3.0
    BUILD +test-ruby --RUBY_VERSION=3.1
