module Chopsticks::View

  class FeedList < Window
    include Chopsticks::View::WindowTable

    def initialize(win, x, y, width, height)
      super
      @cached_unread_count = {}
      @cached_selected_flg = {}
    end

    def help_text
  <<-eos

    Help for Chopsticks <feed list>
    ------------------------------------------------

    Keys that can be used on navigation

    <h>,<?>        - Show Help (this window)
    <o>,<ENTER>    - Open feed entries
    <j>,<KEY_DOWN> - Move down row
    <k>,<KEY_UP>   - Move up row
    <m>            - Select a feed and Move down
    <u>            - Unselect a feed and Move down
    <q>            - Quit this appication

    Keys that can be used on action
    <s>            - Toggle star
    <l>            - Toggle like
    <v>            - Browse original site
    <m>            - Toggle readed
    <A>            - mark all as read
    </>            - Search

    <D>            - Unsubscribe this feed
    <r>            - Reload feed rows
    <x>            - Mark selected feeds all as read
    <X>            - Mark this feed all as read

    eos
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
      x = add_str(" | %5d | " %  unread_count, x, index, 10, 1)

      x = add_str(item.title, x, index, @width/5, 1)
      x = add_str("[", x, index, 1)
      url.each_char do |c|
        x = add_ch(c.ord | Ncurses::A_UNDERLINE | Ncurses.COLOR_PAIR(6), x, index)        
      end
      x = add_str("]", x, index, 1)
      x = add_str(" ", x, index, @width -x)
    end

    # Commands
    def open
      feed = @items[@selected_index]
      items = feed.unread_items(@height) || []

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

    def mark
      feed = @items[@selected_index]

      url = feed.url
      unread_count = @cached_unread_count[url] || item.unread_count
      @cached_unread_count[url] = unread_count

      feed.unread_items(unread_count).each do |entry|
        entry.toggle_read
      end
    end

    def marks

    end

    def reload
      clear
      update Chopsticks::Models::User.feeds
    end
  end
end
