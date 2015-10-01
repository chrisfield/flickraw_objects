require "flickraw_objects/version"
require "flickraw_objects/attributes"
require "flickraw"
require 'date'

module FlickrawObjects

  class Person 
    include Attributes

    def self.find_by_username(username)
      response = flickr.people.findByUsername username: username
      Person.new(response)
    end

    def get_photos(params = {})
      result = Array.new
      response = flickr.people.getPhotos user_id: id
      response.each do |photo|
        result << Photo.new(photo)
      end
      result
    end
    alias photos get_photos

    def get_photosets(params = {})
      result = Array.new
      response = flickr.photosets.getList user_id: id
      response.each do |photoset|
        result << Photoset.new(photoset)
      end
      result
    end
    alias photosets get_photosets

    def get_info
      @get_info ||= flickr.people.getInfo user_id: id
    end

    ##
    attribute :id         
    ##
    attribute :username

    attribute_source :get_info
    ##
    attribute :realname,                        path: [:realname]
    ##
    attribute :photos_count,     type: Integer, path: [:photos, :count]
    ##
    attribute :professional,     type: Boolean, path: [:ispro]
    ##
    attribute :first_date_taken ,type: Time,    path: [:photos, :firstdatetaken]
    ##
    attribute :first_date,       type: Time,    path: [:firstdate]

  end

  class Photoset
    include Attributes

    def self.find_by_id(id)
      Photoset.new(flickr.photosets.getInfo photoset_id: id)
    end

    def get_photos(params = {})
      result = Array.new
      response = flickr.photosets.getPhotos(photoset_id: id)
      response["photo"].each do |photo|
        result << Photo.new(photo)
      end
      result
    end

    alias photos get_photos

    def get_info()
      @get_info ||= flickr.photosets.getInfo photoset_id: id
    end
  
    ##
    attribute :id
    ##
    attribute :title
    ##
    attribute :description  

    attribute_source :get_info
    ##
    attribute :primary  

  end

  class Photo
    include Attributes

    def self.find_by_id(id)
      Photo.new(flickr.photos.getInfo photo_id: id)
    end

    ##
    attribute :id
    ##
    attribute :owner
    ##
    attribute :secret
    ##
    attribute :server
    ##
    attribute :farm
    ##
    attribute :title
    ##
    attribute :public, type: Boolean, path: [:ispublic]
    ##
    attribute :friend, type: Boolean, path: [:isfriend]
    ##
    attribute :family, type: Boolean, path: [:isfamily]

    def url_medium
      FlickRaw.url(init)
    end

    def self.url(meaning, letter) 
      define_method("url_#{meaning}") do
        FlickRaw.send("url_#{letter}", init)
      end
    end

    url :square,       :s
    url :large_square, :q
    url :thumbnail,    :t
    url :small,        :m
    url :small_320,    :n
    url :medium_640,   :z
    url :medium_800,   :c
    url :large,        :b
    url :original,     :o

  end

end
