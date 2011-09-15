require 'set'
require 'time'
require 'redcarpet'
require 'atom'
require_relative 'syntactical'

# This is mostly stolen from Nesta, with a bunch of removals and assumptions.
# We're all about hardcoding here.
class PostModel
  @@renderer = Redcarpet::Markdown.new(Syntactical, :fenced_code_blocks => true)
  attr_reader :filename, :mtime

  def self.linkify(path)
    path = path.sub(/^content\//, '')
    path.sub(/\.md$/, '')
  end

  def self.unlinkify(path)
    "content/#{path}.md"
  end
  
  def initialize(filename)
    @filename = filename
    @mtime = Time.now
    @metadata, @content = parse_file
  end
  
  def title
    metadata("title") || "(Unknown Title)"
  end
  
  def date
    @date ||= metadata("date") ? DateTime.parse(metadata("date")) : nil
  end
  
  def body
    @rendered_body ||= @@renderer.render(@content)
  end

  def tags
    @tags ||= metadata("tags") ? metadata("tags").split(",").map{|tag| tag.strip} : []
  end

  def linkify
    PostModel.linkify(@filename)
  end

  def to_atom_entry(root)
    Atom::Entry.new do |entry|
      entry.title = title
      entry.updated = date
      entry.id = "#{root},#{linkify}"
      entry.links << Atom::Link.new(:href => "http://#{root}/#{linkify}")
      entry.content = Atom::Content::Html.new(body)
    end
  end

  private
  
  def metadata(key)
    @metadata[key]
  end
  
  def parse_file
    def metadata?(text)
      text.split("\n").first =~ /^[\w ]+:/
    end
    
    contents = File.open(@filename).read
  rescue Errno::ENOENT
    raise Sinatra::NotFound
  else
    first_paragraph, remaining = contents.split(/\r?\n\r?\n/, 2)
    metadata = {}
    if metadata?(first_paragraph)
      first_paragraph.split("\n").each do |line|
        key, value = line.split(/\s*:\s*/, 2)
        metadata[key.downcase] = value.chomp
      end
    end
    markup = metadata?(first_paragraph) ? remaining : contents
    return metadata, markup
  end
end
