require_relative './spec_helper.rb'

def test_content
  content = <<EOF
---
title: Test!
---

I'm testing things
EOF
end

describe 'nested_menu', fakefs:true do

  def setup_page(*args)
    dir, file = args
    dir, file = ['', dir] if file.nil?
    @page = Page.new(@site, source_dir, dir, file)
  end

  let(:page) { '{% nested_menu files %}' }

  before(:all) do
    FakeFS.activate!
    @site = Jekyll::Site.new(Jekyll.configuration({
      "source" => source_dir,
      "destination" => dest_dir,
      "skip_config_files" => true
    }))

    [
      'files/one',
      'files/two',
      'files/three',
      'files/one/a',
      'files/one/b',
      'content',
      'images'
    ].each do |dir|
      FileUtils.mkdir_p(File.join(source_dir, dir)) if not File.directory? File.join(source_dir, dir)
      File.open(File.join(source_dir, dir, 'index.md'), 'w') { |f| f << test_content }
      @site.pages << Jekyll::Page.new(@site, source_dir, dir, 'index.md')
    end
  end

  after(:all) do
    FakeFS.deactivate!
  end

  it 'Yields a nested menu of items in the specified folder' do
    t = Liquid::Template.parse(page)
    o = t.render!({'site' => {
        'pages' => @site.pages,
        'data' => {}
      }})

    o_obj = Nokogiri::XML.parse(o)
    binding.pry
    expect(o_obj.xpath('/ul')).not_to be_empty
    expect(o_obj.xpath('/ul/li[1]/a[.="Test!"][@href="/files/one/"]')).not_to be_empty
    expect(o_obj.xpath('/ul/li[2]/a[.="Test!"][@href="/files/two/"]')).not_to be_empty
    expect(o_obj.xpath('/ul/li[3]/a[.="Test!"][@href="/files/three/"]')).not_to be_empty
    expect(o_obj.xpath('/ul/li[1]/ul/li[1]/a[.="Test!"][@href="/files/one/a/"]')).not_to be_empty
    expect(o_obj.xpath('/ul/li[1]/ul/li[2]/a[.="Test!"][@href="/files/one/b/"]')).not_to be_empty
    expect(o_obj.xpath('//a[@href="/content/"]')).to be_empty
    expect(o_obj.xpath('//a[@href="/images/"]')).to be_empty

  end
end
