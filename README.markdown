# completion-ruby: bash completion for Ruby-related commands

**completion-ruby** is a set of [bash][] scripts offering command-line
completion for various [Ruby][]-related commands and tools.

## Usage

Save the completion files somewhere and add the following line to your
`~/.bashrc`:

    . /path/to/completion-ruby-all

Additionally, you can just save the specific scripts you desire, and
source them individually.

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

Copyright (C) 2008 [Daniel Luz][].

**completion-ruby** is distributed under the [MIT license][].

The source is available in a [Git][] repository, [available at GitHub][repo].

For up-to-date information, visit [this project's permalink][permalink].

[bash]: http://www.gnu.org/software/bash/ (Bourne-Again Shell)
[Ruby]: http://www.ruby-lang.org/         (Ruby Programming Language)
[rake]: http://rake.rubyforge.org/        (Rake — Ruby Make)
[Daniel Luz]:  http://mernen.com/
[MIT license]: http://www.opensource.org/licenses/mit-license.php
[Git]:  http://git.or.cz/                 (Git — Fast Version Control System)
[repo]: http://github.com/mernen/completion-ruby/tree
[permalink]: http://mernen.com/projects/completion-ruby
