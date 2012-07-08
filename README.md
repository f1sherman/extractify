# Extractify

A trivial library to extract groups of data from XML or HTML.

Do you have a crusty XML api or an HTML page that you want to do some quick and dirty scraping from?  Extractify might just be able to help you.

Extractify uses the power of the mighty [Nokogiri](https://github.com/sparklemotion/nokogiri).

## Installation

Add this line to your application's Gemfile:

    gem 'extractify'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install extractify

## Usage

Say you have some XML that you want to pull some data out of.

```Ruby
xml = '<?xml version="1.0"?>
<movies>
  <movie>
    <title>Very Scary Movie</title>
    <released>1999</released>
    <length>117</length>
    <director>Jane Doe</director>
    <genre>Horror</genre>
  </movie>
  <movie>
    <title>Funny Movie</title>
    <released>2005</released>
    <length>120</length>
    <director>John Doe</director>
    <genre>Comedy</genre>
  </movie>
  <movie>
    <title>SciFi Movie</title>
    <released>2009</released>
    <length>105</length>
    <director>Jim Doe</director>
    <genre>Science Fiction</genre>
  </movie>
</movies>'

Extractify.extract xml, '//movie' => { :name => '//title/text()', :runtime => '//length/text()' }
=> [{:name=>"Very Scary Movie", :runtime=>"117"}, 
    {:name=>"Funny Movie", :runtime=>"120"}, 
    {:name=>"SciFi Movie", :runtime=>"105"}]
```

This also works with CSS selectors for HTML.
```Ruby
html = '
<html>
  <div class=movies>
    <div class=movie>
      <span class=title>Very Scary Movie</span>
      <span class=released>1999</span>
      <span class=length>117</span>
      <span class=director>Jane Doe</span>
      <span class=genre>Horror</span>
    </div>
    <div class=movie>
      <span class=title>Funny Movie</span>
      <span class=released>2005</span>
      <span class=length>120</span>
      <span class=director>John Doe</span>
      <span class=genre>Comedy</span>
    </div>
    <div class=movie>
      <span class=title>SciFi Movie</span>
      <span class=released>2009</span>
      <span class=length>105</span>
      <span class=director>Jim Doe</span>
      <span class=genre>Science Fiction</span>
    </div>
  </div>
</html>'

Extractify.extract html, '.movie' => { :name => '.title/text()', :runtime => '.length/text()' }
=> [{:name=>"Very Scary Movie", :runtime=>"117"}, 
    {:name=>"Funny Movie", :runtime=>"120"}, 
    {:name=>"SciFi Movie", :runtime=>"105"}]
```






## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
