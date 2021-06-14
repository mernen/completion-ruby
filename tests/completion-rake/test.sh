#! /bin/bash

source "$(dirname "$0")/../test-setup"
source "$(dirname "$0")/../../completion-rake"

_TEST_FN=__rake
_TEST_BINARIES=(ruby rake rails)

cd "$RAILS_TEST_APP_DIR"

begin-test 'should offer commands from the Rakefile'
(
    test-completion rake ''
    expect db:migrate db:seed test
)
end-test

begin-test 'when the word contains a ":", should only suggest the part after that'
(
    test-completion rake db:migrat
    expect migrate:down migrate:up

    test-completion rake db:migrate:
    expect down up
    reject db:migrate:down migrate:down
)
end-test

begin-test 'should suggest options'
(
    test-completion rake --
    expect --backtrace= '--help ' '--version '
)
end-test
