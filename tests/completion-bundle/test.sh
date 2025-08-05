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

begin-test 'should offer configurations with trailing spaces for: bundle config'
(
    test-completion bundle config ''
    expect 'path ' 'frozen ' 'without ' local.
    reject install rake 'local. '
)
end-test

begin-test 'should offer configurations with trailing spaces for: bundle config get'
(
    test-completion bundle config get c
    expect 'cache_all_platforms ' 'cache_all ' 'clean ' 'console '
)
end-test

begin-test 'should offer local gems for: bundle config get local.*'
(
    test-completion bundle config get local.
    expect local.rake
    reject local.cache_all_platforms
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
