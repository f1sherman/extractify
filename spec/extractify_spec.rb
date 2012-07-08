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
    it 'should group results in same order as instructions' do
      @doc = '<html>'\
                '<div class=container>'\
                  '<div class=key1>'\
                    'val1'\
                  '</div>'\
                  '<div class=key2>'\
                    'val2'\
                  '</div>'\
                '</div>'\
                '<div class=container>'\
                  '<div class=key2>'\
                    'val3'\
                  '</div>'\
                '</div>'\
                '<div class=container>'\
                  '<div class=key1>'\
                    'val4'\
                  '</div>'\
                '</div>'\
             '</html>'
        Extractify.extract(@doc, '.container' => { :key1 => '.key1/text()', :key2 => '.key2/text()' }).should == [
                                                                                              {:key1 => 'val1', :key2 => 'val2'},
                                                                                              {:key2 => 'val3'},
                                                                                              {:key1 => 'val4'}
                                                                                             ]
    end
    it 'should should allow Nokogiri documents to be passed in' do
      Extractify.extract(Nokogiri.parse('<html><div class=bif>baz</div></html>'), 'html' => { :bif => '.bif/text()' }).should == [{ :bif => 'baz' }]
    end
  end
end
