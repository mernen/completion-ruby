#! /bin/bash
source "$(dirname "$0")/../test-setup"
source "$(dirname "$0")/../../completion-jruby"

_TEST_FN=__jruby
_TEST_BINARIES=(jruby)

begin-test 'should provide (limited) funcitonality when completion-ruby is not present'
(
    test-completion jruby -
    expect -J --server
)
end-test

source "$(dirname "$0")/../../completion-ruby"

begin-test 'should suggest options'
(
    test-completion jruby -
    expect -0 -e -n -x --help -J
)
end-test

begin-test "after -S should suggest commands from JRuby's path"
(
    test-completion jruby -S ''
    expect bundle rake
)
end-test

begin-test "after --disable should suggest features"
(
    test-completion jruby --disable ''
    expect did_you_mean gems rubyopt
)
end-test
