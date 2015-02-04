Gem::Specification.new do |s|
  s.name        = 'jekyll-nested-menu-generator'
  s.version     = '0.0.1'
  s.date        = '2015-02-04'
  s.authors     = ['GovDelivery']
  s.email       = 'support@govdelivery.com'
  s.homepage    = 'https://github.com/govdelivery/jekyll-nested-menu-generator'
  s.license     = 'BSD-3-Clause'
  s.summary     = 'Tag for generating a nested navigation menu.'
  s.description = %q{Provides a tag that generates a nested navigation menu for
                     a specificed folder. Useful for automatically generating
                     a multilevel menu that mirrors your directory structure,
                     or generating a menu of generated pages.}

  s.add_runtime_dependency 'jekyll'

  s.files        = `git ls-files`.split($\)
  s.require_paths = ['lib']
end
