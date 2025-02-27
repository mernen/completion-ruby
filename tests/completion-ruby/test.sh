#! /bin/bash
source "$(dirname "$0")/../test-utils"
source "$(dirname "$0")/../../completion-ruby"

_TEST_FN=__ruby
_TEST_BINARIES=(ruby)

begin-test-suite

begin-test 'should suggest options'
(
    test-completion ruby -
    expect -0 -e -n -x --help
)
end-test

begin-test 'after -S should suggest commands from PATH'
(
    test-completion ruby -S ''
    expect bundle rake
)
end-test

end-test-suite
