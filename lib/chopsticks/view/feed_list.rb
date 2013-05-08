module Chopsticks::View

  class FeedList < Window
    include Chopsticks::View::WindowTable

    def initialize(win, x, y, width, height)
      super
      @cached_unread_count = {}
      @cached_selected_flg = {}
    end

    def update_str(index = 0, item)
      x = 0
      url = item.url
      unread_count = @cached_unread_count[url] || item.unread_count
      @cached_unread_count[url] = unread_count

      if @cached_selected_flg[url]
        x = add_ch("*".ord | Ncurses::A_BOLD| Ncurses.COLOR_PAIR(1), x, index)
      else
        x = add_ch(" ".ord, x, index)
      end
      x = add_str(" | %4d | " %  unread_count, x, index, 9, 1)

      x = add_str(item.title, x, index, @width/5, 1)
      x = add_str("[", x, index, 1)
      url.each_char do |c|
        x = add_ch(c.ord | Ncurses::A_UNDERLINE | Ncurses.COLOR_PAIR(6), x, index)        
      end
      x = add_str("]", x, index, 1)
      x = add_str(" ", x, index, @width -x)
    end

    def open
      feed = @items[@selected_index]
      items = []
      items = feed.unread_items(@height)
      feed_entries = Chopsticks::View::FeedEntries.new @window, 0, 0, @width, @height
      feed_entries.update(items, feed)
      feed_entries.touchwin
      feed_entries.refresh
      $observers.push feed_entries
    end

    def check
      feed = @items[@selected_index]
      @cached_selected_flg[feed.url] = true
    end

    def uncheck
      feed = @items[@selected_index]
      @cached_selected_flg[feed.url] = false
    end
  end
end
