#! /bin/bash
source "$(dirname "$0")/../test-setup"
source "$(dirname "$0")/../../completion-ruby"

_TEST_FN=__ruby

touch foo.rb
touch bar.rb
touch baz.rb

(
    test-completion ruby -
    expect -0 -e -n -x --help
) || exit $?

(
    test-completion ruby -S ''
    expect bundle rake
) || exit $?
