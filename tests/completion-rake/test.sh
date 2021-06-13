#! /bin/bash

source "$(dirname "$0")/../test-setup"
source "$(dirname "$0")/../../completion-rake"

_TEST_FN=__rake

set -x
ruby --version
rails --version
rake --version
set +x

cd "$RAILS_TEST_APP_DIR"

(
    test-completion rake ''
    expect db:migrate db:seed test
) || exit $?

(
    test-completion rake db
    expect db:migrate db:seed db:rollback
) || exit $?

(
    test-completion rake db:s
    expect seed setup
) || exit $?

(
    test-completion rake --
    expect --backtrace= '--help ' '--version '
) || exit $?
