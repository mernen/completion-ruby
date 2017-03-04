# completion-ruby: bash completion for Ruby-related commands

**completion-ruby** is a set of [bash][] scripts offering command-line
completion for various [Ruby][]-related commands and tools.

## Installation

These scripts depend on some utility functions from [bash-completion]. It
should be part of pretty much any modern Linux distribution, and you can
install it on macOS using [Homebrew]:

    brew install bash-completion

Save the completion files somewhere (in the same directory) and add the
following line to your `~/.bashrc` or `~/.profile`:

    . /path/to/completion-ruby-all

The `completion-ruby-all` script loads all the completions it finds,
but only for the commands you appear to have installed.
Alternatively, you can just save the specific scripts you wish, and
source them individually.

## Why yet another completion script?

Before writing my own, I'd seen about five different scripts for `rake`
completion. None of them, though, at the same time:

* cached the task list for fast results;
* invalidated said cache when the rakefile was modified;
* worked properly with namespaces; and
* worked on subdirectories of the project

...among other minor quirks. While providing all of the above, a few other
niceties were added, like command-line options completion and awareness of
task arguments.

This script is not perfect (for instance, it won't update the cache if
a dependency of the rakefile is updated; as a workaround, simply
`touch Rakefile`), but it tries to cover all the most common cases without
overcomplicating or overthinking the code.

## License and website

Copyright © 2008-2017 [Daniel Luz].

**completion-ruby** is distributed under the [MIT license][].

The source is available in a [Git][] repository [at GitHub][repo].

For up-to-date information, visit [this project's permalink][permalink].

[bash]: https://www.gnu.org/software/bash/ (Bourne-Again Shell)
[bash-completion]: https://github.com/scop/bash-completion
[Ruby]: https://www.ruby-lang.org/         (Ruby Programming Language)
[rake]: https://github.com/ruby/rake       (Rake — Ruby Make)
[Daniel Luz]:  http://mernen.com/
[MIT license]: https://opensource.org/licenses/MIT
[Git]:  https://git-scm.com/               (Git — Fast Version Control System)
[Homebrew]: http://brew.sh (Homebrew – The missing package manager for macOS)
[repo]: https://github.com/mernen/completion-ruby
[permalink]: http://mernen.com/projects/completion-ruby
