require 'jekyll'
require 'rspec'
require 'nokogiri'
require 'fakefs/spec_helpers'
require_relative '../lib/jekyll-nested-menu-generator.rb'

RSpec.configure do |config|
  config.include FakeFS::SpecHelpers, fakefs:true
end

def dest_dir(*subdirs)
  test_dir('dest', *subdirs)
end

def source_dir(*subdirs)
  test_dir('source', *subdirs)
end

def test_dir(*subdirs)
  File.join(File.dirname(__FILE__), *subdirs)
end
