# DataStructures101 [![Build Status](https://travis-ci.org/renehernandez/data_structures_101.svg)](https://travis-ci.org/renehernandez/data_structures_101) [![Gem Version](https://badge.fury.io/rb/data_structures_101.svg)](https://badge.fury.io/rb/data_structures_101)

DataStructures101 is a simple gem that groups several implementations of common data structures usually taught in Computer Science courses. The overall goal of the gem is to provide easy to use functionality (trying to match the behavior of existent structures in Ruby) while providing the user with a framework to test and compare their implementations against.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'data_structures_101'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install data_structures_101

## Usage

```ruby
require 'data_structures_101'
```

### LinkedList

To create a LinkedList

```ruby
list = DataStructures101::LinkedList.new
```

For more information in the `LinkedList` class, check [this post](https://bitsofknowledge.net/2017/08/05/data-structures-101-linkedlist-implementation) and read the documentation.

## Contributing

In lieu of a formal styleguide, take care to maintain the existing coding style. Add specs for any new or changed functionality and tests it using RSpec.

Bug reports and pull requests are welcome on GitHub at https://github.com/renehernandez/data_structures_101.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

