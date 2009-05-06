require 'test_unit_test_case'
require File.join(File.dirname(__FILE__), '..', 'lib', 'rsolr-ext')
require 'helper'

class RSolrExtDocTest < Test::Unit::TestCase
  
  class DocX
    
    include RSolr::Ext::Doc
    
    def self.books(q='*:*', p={})
      find({:queries=>q, :phrase_filters=>{:format_facet=>'Book'}}.merge(p))
    end
    
    def title
      get :title_t
    end
    
  end
  
  test 'DocX responds to #default_params' do
    assert DocX.respond_to?(:default_params)
  end
  
  test 'DocX.default_params is a hash, with preset defaults' do
    defaults = {:qt=>:standard, :rows=>10}
    assert_equal defaults, DocX.default_params
  end
  
  test "DocX default connection" do
    assert_equal RSolr::Connection, DocX.connection.class
  end
  
  test "DocX find method" do
    DocX.find('*:*')
  end
  
  test "DocX find_by_id method" do
    DocX.find_by_id(1)
  end
  
  test "DocX.books" do
    DocX.books('b*', :sort=>'title_sort desc').each do |book|
      puts book.title
    end
  end
  
end