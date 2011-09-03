title: Some ruby
date: 25 May 1982
tags: test, ruby

~~~~~ ruby
require 'redcarpet'
markdown = Redcarpet.new("Hello World!")
puts markdown.to_html
~~~~~
