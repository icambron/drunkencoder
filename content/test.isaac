title: Some ruby
date: 25 May 1982
tags: test, ruby

~~~~~ ruby
class PostModel
  @@renderer = Redcarpet::Markdown.new(Syntactical, :fenced_code_blocks => true)
  attr_reader :filename, :mtime

  def self.linkify(path)
    path = path.sub(/^content\//, '')
    path.sub(/\.md$/, '')
  end
end
~~~~~
