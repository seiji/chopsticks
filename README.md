# Chopsticks

Feed reader client using ncurses

## Installation

Checkout this project:

    hub clone seiji/chopsticks

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install chopsticks

## Usage
Create your .netrc And then

Execute this script

    chop

Or

    bundle exec bin/chop


#### Using `.netrc` for stored credentials

now supports [`.netrc`][netrc] files for storing your feed access
credentials. Given a `~/.netrc` like the following

```
machine reader.google.com login seiji password chopchop
```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
