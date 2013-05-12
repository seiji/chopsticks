module Chopsticks::Models
  class Feed
    attr_reader :url, :title

    def self.total_feed
      feed = FeedTotal.new
      feed
    end
    
    def unread_count
      -1
    end

    def unread_items(count = 20)
      []
    end
    
    def inspect
      to_s
    end

    def to_s
      "<Chopsticks::Models::Feed: #{title} url:#{url}>>"
    end
    
  end

  class FeedTotal < Feed
    def initialize
      @url = "-"
      @title = "All Feed"
    end

    def unread_items(count = 20)
      User.subscriptions.unread_items
    end
    
    def unread_count
      User.subscriptions.total_unread
    end
  end
end
