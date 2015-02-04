jekyll-nested-menu-generator
=======================

Provides a tag that will generated a nested navigation menu for files contained
in a specified folder. Generated menus are cached during site build.

## Installation

Add the following to your application's Gemfile:

    gem 'jekyll-nested-menu-generator'

and then execute:

    bundle install

Or install it manually:

    gem install jekyll-nested-menu-generator

Then, include a script tag in your page or layout to fetch the required
javascript:

    <script type="text/javascript" src="/js/jekyll-nested-menu.js"></script>

You may also overwrite the provided javascript by writing a `jekyll-nested-menu.js`
file in the `/js/` directory of your Jekyll project.

