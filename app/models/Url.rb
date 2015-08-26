class Url < ActiveRecord::Base

validates_format_of :long_url, with: URI.regexp(['http', 'https'])

before_save :create_short_url

def create_short_url(length)
  short_url = rand(36**length).to_s(36)
  end
end