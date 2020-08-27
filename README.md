[![Build Status](https://travis-ci.org/Granicus/jekyll-nested-menu-generator.svg?branch=master)](https://travis-ci.org/granicus/jekyll-nested-menu-generator)
[![Gem Version](https://badge.fury.io/rb/jekyll-nested-menu-generator.svg)](http://badge.fury.io/rb/jekyll-nested-menu-generator)

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

## Usage

Say you have a number of pages, organized into folders, some of which are in
other folders. For example, let's consider a website about music, with pages 
about albums organized into folders based on artists and year released:

```
 /
 |- Albums/ 
 | |- 1994/
 | | |- Oasis/
 | | | |- Definitely_Maybe/
 | | | | |- index.md
 | | |- The Offspring/
 | | | |- Smash/
 | | | | |- index.md
 | | |- index.md
 | |- 1995/
 | | |- Michael Jackson/
 | | | |- HIStory_Past_Present_and_Future_Book_I/
 | | | | |- index.md
 | | |- Radiohead/
 | | | |- The_Bends/
 | | | | |- index.md
 | | |- index.md
 | |- 1996/
 | | |- Jay Z/
 | | | |- Reasonable_Doubt/
 | | | | |- index.md
 | | |- Weezer/
 | | | |- Pinkerton/
 | | | | |- index.md
 | | |- index.md
 |- index.html
```

Let's assume that on index.md you would like to include a nested menu of all of
the pages under Albums. To do this, simply use the 'nested_menu' liquid tag like
so:

```
{% nested_menu Albums %}
```
