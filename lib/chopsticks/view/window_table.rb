module Chopsticks::View::WindowTable

  attr_reader :selected_index
  def initialize(win, x, y, width, height)
    super
    @window.scrollok false
    @selected_index = 0
    @scroll_offset = 0
  end

  def update(items, data=nil)
    @data = data
    @items = items
    items.each_with_index do |item, i|
      update_row i, item
    end
    @window.noutrefresh()
  end
  
  def update_row(index = 0, item)
    return if (index < 0 or index >= @height)
    if index == @selected_index - @scroll_offset
      @window.attron(Ncurses::A_REVERSE)
    end
    update_str(index, item)
    @window.move(index, @width -1)
    @window.attroff(Ncurses::A_REVERSE)
    @window.touchline(index,1)
  end

  def update_str(index = 0, item)
    x = 0
    x = add_str(index.to_s, x, index)
    x = add_str(item.chomp.to_s, x, index, @width-x)    
  end

  def next
    new_index = @selected_index + 1
    if new_index >=  @items.size
      return
    end
    
    if new_index > @height - 1
      scroll 1
#      update_row(0, @items[@scroll_offset])
    end
    select new_index
  end

  def prev
    new_index = @selected_index - 1
    if new_index < 0
      return
    end
    if new_index > @height - 2
      scroll -1
      update_row(0, @items[@scroll_offset])
    end
    select new_index
  end

  def select(new_index = 0)
    old_index = @selected_index 
    @selected_index = new_index
    update_row(old_index - @scroll_offset, @items[old_index])
    update_row(new_index - @scroll_offset, @items[new_index])
    @window.noutrefresh()
  end

  def scroll(line)
    @window.scrollok true
    Ncurses.wscrl(@window, line)
    @window.scrollok false

    @scroll_offset += line
  end

  def check
    
  end

  def uncheck
    
  end
  
  def pageup

  end
  
  def pagedown
    new_index = @selected_index + @height
    if new_index >=  @items.size
      return
    end
    scroll @height
    self.clear
    select new_index
    update(@items, @data)
  end
end
