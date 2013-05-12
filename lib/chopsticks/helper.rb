# -*- coding: utf-8 -*-
class String 

  def display_slice(len = 0)
    if len <= 0
      return self
    end

    str = ""
    i = 0
    self.each_char do |c|
      c = "'" if c == "’"
      c = "-" if c == "─" 
      screen_size = 0
      if c.bytesize > 2
        screen_size = 2
      else
        screen_size = 1
      end
      if i + screen_size > len
        break
      end
      i += screen_size
      str << c
    end
    return str.concat(" " * (len - i))
  end

  def each_char
    self.split("").each { |i| yield i }
  end

  def html2md
    html2md = Html2Md.new(self)
    begin
      str = html2md.parse
    rescue
      str = self
    ensure
    end
    str.gsub(/(\r\n){3,}|\r{3,}|\n{3,}/, "\n\n")
  end
end

module RSS::Atom
  class Feed
    def have_author?
      true
    end
  end
end

module GoogleReaderApi
  class SubscriptionList
    def unread_items
      feeds.map(&:unread_items)
    end
  end
end
