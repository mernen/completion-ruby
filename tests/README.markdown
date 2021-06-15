# completion-ruby tests

Tests are executed using [Earthly]. Environment setup can be found in the
[`Earthfile`](../Earthfile) at the root of the project.

An ad-hoc testing utility is written in the [`test-utils`](./test-utils) file.

## Running tests

To run these tests, [Earthly] is needed (which, by extension, also needs [Docker]).
Check [Earthly's install instructions][earhtly-install].

To test a single completion script:

    $ earthly +test-rake

This will instantiate a basic Rails project in a container to perform the tests.
A default version of Ruby and Rails will be picked, but you can specify it using:

    $ earthly --build-arg RUBY_VERSION=3.0 +test-rake

To test a certain script against all supported versions of Ruby/Rails/etc.,
use the `+test-*-all` target:

    $ earthly +test-rake-all

To run the full test suite against all supported versions, use the `+test` target:

    $ earthly +test


[Docker]: https://docs.docker.com/install/
[Earthly]: https://earthly.dev
[earthly-install]: https://earthly.dev/get-earthly
