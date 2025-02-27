#! /bin/bash
source "$(dirname "$0")/../test-utils"
source "$(dirname "$0")/../../completion-bundle"
source "$(dirname "$0")/../../completion-rake"
source "$(dirname "$0")/../../completion-rails"

_TEST_FN=__bundle
_TEST_BINARIES=(ruby bundle rails)

cd "$RAILS_TEST_APP_DIR"

print-binary-versions

begin-test 'should offer basic commands'
(
    test-completion bundle ''
    expect help install update
)
end-test

begin-test 'should offer global options'
(
    test-completion bundle --
    expect --version --verbose --no-verbose
    reject --force
)
end-test

begin-test 'should trigger completion for subcommands: rake'
(
    test-completion bundle exec rake ''
    expect db:migrate
    reject install
)
end-test

begin-test 'should trigger completion for subcommands: rails'
(
    test-completion bundle exec rails ''
    expect generate
    reject install
)
end-test

end-test-suite
