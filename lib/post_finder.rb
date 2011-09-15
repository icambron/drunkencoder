require 'atom'

class PostFinder

  @@post_cache = {}
  @@tags = nil
    
  def find_all
    @posts ||= Dir.glob("content/**/*.md").map do |path|
      load(PostModel.linkify(path), path)
    end
  end

  def find_by_path(linkified)
    return load(linkified)
  end
  
  def find_posts(options = {})
    find_all.select do |page|
      is_valid = page.date && page.date < DateTime.now
      is_valid &&= page.tags.include? options[:tag] if options[:tag]
      is_valid
    end.sort { |x, y| y.date <=> x.date }
  end

  def atom_feed(count, author, root, path_to_xml)
    articles = find_posts.take(count)
    Atom::Feed.new do |f|
      f.id = root
      f.links << Atom::Link.new(:href => "http://#{root}#{path_to_xml}", :rel => "self")
      f.links << Atom::Link.new(:href => "http://#{root}", :rel => "alternate")
      f.authors << Atom::Person.new(:name => author)
      f.updated = articles[0].date if articles[0]
      articles.each do |post|
        f.entries << post.to_atom_entry(root)
      end  
    end.to_xml
  end

  def all_tags
    unless @@tags
      @@tags = Set.new
      find_posts.each do |post|
        post.tags.each{|cat| @@tags.add(cat)}
      end
    end
    @@tags.to_a
  end

  def load(linkified, path = PostModel.unlinkify(linkified))
    if @@post_cache[linkified].nil? || File.mtime(path) > @@post_cache[linkified].mtime
      @@post_cache[linkified] = PostModel.new(path) 
    else
      @@post_cache[linkified]
    end
  end

end
