# RubyMyq

Ruby gem to control a Chamberlain MyQ system.

This is a forked version of https://github.com/pfeffed/liftmaster_myq, with updates for API changes.

## Installation

Add this line to your application's Gemfile:

    gem 'ruby_myq'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ruby_myq-X.X.X.gem (Note: X.X.X should be changed to the current version number)

## Usage

To create the gem:

	$ gem build /path/to/ruby_myq/ruby_myq.gemspec

To instantiate the system:

	$ require 'ruby_myq'
	$ system = RubyMyq::System.new('your_username','your_password')

To see your device list in all it's ruby glory:

	$ system.garage_doors
	$ system.garage_doors.count

Have fun with:

	$ system.garage_doors[0].open
	$ system.garage_doors[0].close
	$ system.garage_doors[0].status

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
