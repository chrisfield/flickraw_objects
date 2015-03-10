# FlickrawObjects

Use this gem as a simple way to map Flickraw results to a object-orientated "data model".
Classes for People and Photos are included: These are there by way of an example. I anticipate 
users of this Gem will map the data they need - it's easy to do.

## Installation

Add this line to your application's Gemfile:

    gem 'flickraw_objects'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install flickraw_objects

## Usage

Create an initializer where you set your Flickr credentials.

```ruby
FlickrawObjects.configure do |config|
  config.api_key = "Your Api Key"
  config.shared_secret = "Shared Secret"
end
```
If you don't have them yet, you can apply for them [here](http://www.flickr.com/services/apps/create/apply).


Example usage:

```ruby
person = FlickrawObjects::Person.find_by_username "chrisfield1968"
puts "realname: #{person.realname}" # get_info api call happens automatically

puts "photos_count #{person.photos_count}"                # returns as an Integer
puts "person.first_date_taken #{person.first_date_taken}" # returns as a Date
puts "professional?: #{person.professional?}"             # returns as a true/false

person.get_photos.each_with_index do |item,i|
  puts "item #{i}: #{item.title} - #{item.url} - #{item.public?}"
end
```

## Contributing

1. Fork it ( http://github.com/<my-github-username>/flickraw_objects/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
