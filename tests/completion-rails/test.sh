#! /bin/bash
source "$(dirname "$0")/../test-setup"
source "$(dirname "$0")/../../completion-rails"

_TEST_FN=__rails

(
    test-completion rails ''
    expect new
) || exit $?

cd "$RAILS_TEST_APP_DIR"

(
    test-completion rails ''
    expect generate g console c server s dbconsole db
) || exit $?

(
    test-completion rails g ''
    expect controller generator helper model
) || exit $?
