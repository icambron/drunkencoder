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
