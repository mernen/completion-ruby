#! /bin/bash
source "$(dirname "$0")/../test-setup"
source "$(dirname "$0")/../../completion-rails"

_TEST_FN=__rails
_TEST_BINARIES=(ruby rails)

begin-test 'when outside of a Rails project, should offer the command `new`'
(
    test-completion rails ''
    expect new
    reject generate console
)
end-test

cd "$RAILS_TEST_APP_DIR"

begin-test 'when in a Rails project, should offer basic commands'
(
    test-completion rails ''
    expect generate g console c server s dbconsole db
)
end-test

begin-test '`rails g` should offer generators'
(
    test-completion rails g ''
    expect controller generator helper model
)
end-test

begin-test 'completion should work in subdirectories'
(
    cd app/ || exit $?
    test-completion rails g ''
    expect controller generator helper model
)
end-test
