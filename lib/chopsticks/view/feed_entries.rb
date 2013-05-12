module Chopsticks::View
  class FeedEntries < Window
    include Chopsticks::View::WindowTable

    attr_reader :cached_selected_flg
    def initialize(win, x, y, width, height)
      @parent = win
      @width  = width
      @height = height
      @window = Ncurses.newwin(@height, @width, y, x)
      @cur_y = 0
      @cur_x = 0
      @window.scrollok true
      @selected_index = 0
      @scroll_offset = 0
      @cached_selected_flg = {}
      @page = 0
    end

    def update_str(index = 0, item)
      entry = item.entry        # RSS::Atom::Feed::Entry
      updated_locatime = entry.updated.content.localtime.strftime("%Y/%m/%d %H:%M")
      time_len = updated_locatime.length

      x = 0
      if index == @selected_index - @scroll_offset or @cached_selected_flg[index]
        x = add_ch(" ".ord , x, index)
        @cached_selected_flg[index] = true
      else
        x = add_ch("U".ord | Ncurses::A_BOLD| Ncurses.COLOR_PAIR(1), x, index)
      end

      x = add_str(" | %5d | " % index, x, index, 10, 1)
      x = add_str(@data.title, x, index, @width/5, 1)
      x = add_ch(Ncurses::ACS_VLINE | Ncurses::A_BOLD | Ncurses.COLOR_PAIR(6), x, index)
      x = add_ch(" ".ord, x, index)
      
      x = add_str(entry.title.content, x, index, @width -x - time_len)
      x = ins_str(updated_locatime, x, index)
    end

    def open
      entry = Chopsticks::View::FeedEntry.new self, 0, 0, @width, @height
      entry.update(@selected_index, @items, @data)
      entry.touchwin
      entry.refresh
      $observers.push entry
    end

    def touchwin
      update(@items, @data)
      super
    end

  end
end
