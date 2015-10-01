# FlickrawObjects

A slim, customisable object-oriented Flickr api that uses flickraw to do all the communication.
Use this gem as a simple way to use Flickraw but with an object-orientated "data model".
Classes for Person, Photoset and Photos are included. I anticipate 
users of this Gem will map other data they need. Look at flickraw_objects.rb to see how objects make 
Flickraw requests and define the attributes in the response.

## Installation

Add this line to your application's Gemfile:

    gem 'flickraw_objects'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install flickraw_objects

## Usage

Set your Flickr credentials using flickraw.

```ruby
require "flickraw"
require "flickraw_objects"

FlickRaw::api_key = "12345678901234567890123456789012"
FlickRaw::shared_secret = "abcdefghijkl"
```
If you don't have them yet, you can apply for them [here](http://www.flickr.com/services/apps/create/apply).

Example: Finding a particular Photo:

```ruby
pic = FlickrawObjects::Photo.find_by_id('9483891183')
puts pic.title
```

Example: Finding a particular album:

```ruby
pics = FlickrawObjects::Photoset.find_by_id('72157635151450677')
puts "#{pics.title}: #{pics.photos.length}"
```

Example: Finding a named album for a given user:

```ruby
me = FlickrawObjects::Person.find_by_username('your-flickr-name')
mySets = me.photosets
theSet = mySets.find {|y| y.title == "Some Album Title"}
thePhotos=theSet.photos
thePhotos.each do |pic|
  puts "#{pic.title} Small: (#{pic.url_small})"
end
```


## Contributing

I'm happy to recieve pull requests or to add simple things to the data model,
however, I'd like the data model to remain quite minimal because to do otherwise
would erode the introspection benefits of flickraw.
