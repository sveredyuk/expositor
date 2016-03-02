# Expositor

## Description

Gem allow you create class methods which delegate it to objects

## Installation & Setup

In console:
```ruby
gem install expositor
```

And in your ruby file:
```ruby
require 'expositor'
```

## Example

You initiating Policy that allow you explicit some 'checks' to special policy class

```ruby
class NamingPolicy

  def initialize(name)
    @name = name
  end

  def john?
    @name == 'John'
  end

  def jack?
    @name == 'Jack'
  end

  def james?
    @name == 'James'
  end
end
```
And now for get right answer you need do all this:

```ruby
m = NamingPolicy.new('John')
m.john? #=> true
m.jack? #=> false

NamingPolicy.new('James').james? #=> true
```
too boring... not ruby-way...

### Much more pretty if...

```ruby
require 'expositor'

class NamingPolicy
  extend Expositor

  def initialize(name)
    @name = name
  end

  def john?
    @name == 'John'
  end

  def jack?
    @name == 'Jack'
  end

  def james?
    @name == 'James'
  end
end
```

And now you available:
```ruby
NamingPolicy.john?('John') #=> true
NamingPolicy.jack('John') #=> false
NamingPolicy.max?('Max') #=> undefined method `max?'
```

### How to use

By default it expose all public method, but you can easy handle this through `expose` method:

Only some methods:
```ruby
class NamingPolicy
  extend Expositor

  expose only: [:john?, :jack]
  #...

NamingPolicy.john?('John') #=> true
NamingPolicy.jack('John') #=> false
NamingPolicy.james?('James') #=> undefined method `james?'
```

All except:
```ruby
class NamingPolicy
  extend Expositor

  expose except: [:john?]
  #...

NamingPolicy.john?('John')  #=> undefined method `james?'
NamingPolicy.jack('Jack') #=> true
NamingPolicy.james?('John') #=> false
```

And combie:
```ruby
class NamingPolicy
  extend Expositor

  expose only: [:jack, :john], except: [:john?]
  #...
NamingPolicy.john?('John')  #=> undefined method `john?'
NamingPolicy.jack('Jack') #=> true
NamingPolicy.james?('James') #=> true
```

## TODO
* Some improvements ? =)


