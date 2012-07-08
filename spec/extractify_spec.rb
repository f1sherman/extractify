require 'spec_helper'

describe Extractify do
  describe :extract do
    it 'should extract css selectors' do
      Extractify.extract('<html><div class=bif>baz</div></html>', 'html' => { :bif => '.bif/text()' }).should == [{ :bif => 'baz' }]
    end
    it 'should extract xpath selectors' do
      Extractify.extract('<foo><bar>baz</bar></foo>', 'foo' => { :bar => '//bar/text()' }).should == [{ :bar => 'baz' }]
    end
    it 'should handle multiple instructions' do
      Extractify.extract('<html><div class=bif>baz</div><div class=baz>foo</div></html>', 'html' => { :bif => '.bif/text()', :baz => '.baz/text()' }).should == [{ :bif => 'baz', :baz => 'foo' }]
    end
    it 'should not find results outside of the container' do
      Extractify.extract('<html><div class=bif>baz</div><div class=baz>foo</div></html>', 'doesnotexist' => { :bif => '.bif/text()', :baz => '.baz/text()' }).should == []
    end
    it 'should search only within the container' do
      doc = '<parents>
              <parent>
                <child>child1</child>
              </parent>
              <parent>
                <child>child2</child>
              </parent>
            </parents>'
      Extractify.extract(doc, 'parent' => { :child => '//child/text()' }).should == [{:child => 'child1'}, {:child => 'child2'}]

    end
    
    it 'should group results in same order as instructions' do
      doc = '<?xml version="1.0"?>
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
                  <director>John Doe</director>
                  <genre>Comedy</genre>
                </movie>
                <movie>
                  <released>2009</released>
                  <length>105</length>
                  <director>Jim Doe</director>
                  <genre>Science Fiction</genre>
                </movie>
              </movies>'

        Extractify.extract(doc, '//movie' => { :name => '//title/text()', :runtime => '//length/text()' }).should == [
                                                                                              {:name => 'Very Scary Movie', :runtime => '117'},
                                                                                              {:name => 'Funny Movie'},
                                                                                              {:runtime => '105'},
                                                                                             ]
    end
    it 'should should allow Nokogiri documents to be passed in' do
      Extractify.extract(Nokogiri.parse('<html><div class=bif>baz</div></html>'), 'html' => { :bif => '.bif/text()' }).should == [{ :bif => 'baz' }]
    end
  end
end
