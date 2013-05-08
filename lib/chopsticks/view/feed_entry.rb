require 'html2md'

module Chopsticks::View
  class FeedEntry < Chopsticks::View::Window

    def initialize(win, x, y, width, height)
      @parent = win
      @width  = width
      @height = height
      @window = Ncurses.newwin(@height, @width, y, x)
    end

    def update(selected_index, items, data=nil)
      @data = data
      @items = items
      @selected_index = selected_index
      select()
    end

    def select
      @window.clear
      item = current_item
      entry = item.entry
      updated_locatime = entry.updated.content.localtime.strftime("%Y/%m/%d %H:%M")

      x,y = 0, 0
      x = add_str("     Feed: ", x, y)
      x = add_str(@data.title, x, y)
      y += 1
      
      x = add_str("    Title: ", 0, y)
      x = add_str(entry.title.content, x, y, @width -x)

      y += 1

      x = add_str("     Link: ", 0, y)
      x = add_str(entry.link.href, x, y)
      y += 1

      x = add_str("  Updated: ", 0, y)
      x = add_str(updated_locatime, x, y)
      y += 1

      @window.mvhline(y, 0, Ncurses::ACS_HLINE, @width)

      y += 2
      if entry.content
        html2md = Html2Md.new(entry.content.content)
        str = html2md.parse
        str.gsub!(/(\r\n){3,}|\r{3,}|\n{3,}/, "\n\n")
        x = add_str(str, 0, y)
        y += 1
      elsif entry.summary
        html2md = Html2Md.new(entry.summary.content)
        begin
          str = html2md.parse
        rescue
          str = entry.summary.content
        ensure
        end
        str.gsub!(/(\r\n){3,}|\r{3,}|\n{3,}/, "\n\n")
        x = add_str(str, 0, y)
        y += 1        
      end
      @window.move(2,11);
      @window.noutrefresh()
    end

    def next
      new_index = @selected_index + 1
      if new_index >=  @items.size
        return
      end
      @selected_index += 1
      select
    end

    def prev
      new_index = @selected_index - 1
      if new_index < 0
        return
      end
      @selected_index -= 1
      select
    end

    def open
      entry = current_item.entry
      href = entry.link.href
      script_path = File.join Chopsticks.scripts, "open_chrome.scpt"
      system "osascript #{script_path} #{href}"
      self.next
    end

    private
    def current_item
      @items[@selected_index]
    end
  end
end
