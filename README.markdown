# completion-ruby: bash completion for Ruby-related commands

**completion-ruby** is a set of [bash](http://www.gnu.org/software/bash/)
scripts offering command-line completion for various
[Ruby](http://www.ruby-lang.org/)-related commands and tools.

Currently, only [rake](http://rubyforge.org/projects/rake) is supported,
though. :(

## Usage

Save the `completion-rake` file somewhere and add the following line
to your `~/.bashrc`:

    . /path/to/completion-rake

## Why yet another completion script?

Before writing my own, I'd seen about five different scripts for `rake`
completion. None of them, though, at the same time:

* cached the task list for fast results;
* invalidated said cache when the rakefile was modified;
* worked properly with namespaces; and
* worked on subdirectories of the project

...among other minor quirks. While providing all of the above, a few other
niceties were added, like command-line options completion.

This script is not perfect (for instance, it won't update the cache if
a dependency of the rakefile is updated), but it tries to cover all the
most common cases without overcomplicating or overthinking the code.

## License and website

Copyright (C) 2008 [Daniel Luz](http://mernen.com/).

**completion-ruby** is distributed under the
[MIT license](http://www.opensource.org/licenses/mit-license.php).

The source is available in a [Git](http://git.or.cz/) repository,
which can be viewed at: <http://github.com/mernen/completion-ruby/>.

For up-to-date information, the permalink for this project is:
<http://mernen.com/projects/completion-ruby>.
