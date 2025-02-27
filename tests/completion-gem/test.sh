#! /bin/bash
source "$(dirname "$0")/../test-utils"
source "$(dirname "$0")/../../completion-gem"

_TEST_FN=__gem
_TEST_BINARIES=(ruby gem)

begin-test-suite

begin-test 'should suggest options'
(
    test-completion gem -
    expect --help --version
    reject --local
)
end-test

begin-test 'after build should suggest local .gemspec files'
(
    touch foo.rb foo.gem foo.gemspec

    test-completion gem build f
    expect foo.gemspec
    reject foo.rb foo.gem

    rm -f foo.rb foo.gem foo.gemspec
)
end-test

begin-test 'after help should suggest available commands and special topics'
(
    test-completion gem help ''
    expect commands examples platforms install uninstall
)
end-test

begin-test 'after install should suggest local .gem files'
(
    touch foo.rb foo.gem foo.gemspec

    test-completion gem install f
    expect foo.gem
    reject foo.rb foo.gemspec

    rm -f foo.rb foo.gem foo.gemspec
)
end-test

begin-test 'after push should suggest local .gem files'
(
    touch foo.rb foo.gem foo.gemspec

    test-completion gem push f
    expect foo.gem
    reject foo.rb foo.gemspec

    rm -f foo.rb foo.gem foo.gemspec
)
end-test

begin-test 'after uninstall should suggest installed gems'
(
    test-completion gem uninstall ''
    expect json minitest
)
end-test

begin-test 'should offer command-specific options'
(
    test-completion gem install -
    expect --local -i
    reject --strict
)
end-test

begin-test 'after unpack should suggest local .gem files'
(
    touch foo.rb foo.gem foo.gemspec

    test-completion gem unpack f
    expect foo.gem
    reject foo.rb foo.gemspec

    rm -f foo.rb foo.gem foo.gemspec
)
end-test

end-test-suite
