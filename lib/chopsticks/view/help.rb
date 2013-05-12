module Chopsticks::View

  class Help < Window

    def initialize(win, x, y, width, height)
      @parent = win
      @width  = width
      @height = height
      @window = Ncurses.newwin(@height, @width, y, x)
      @cur_y = 0
      @cur_x = 0

      @window.bkgd(Ncurses.COLOR_PAIR(5));
    end

    
    def show(text)
      add_str(text, 0, 1)

      @window.touchwin
      Ncurses.wrefresh(@window)
      Ncurses.getch

      Ncurses.delwin(@window)
      Ncurses.touchwin(Ncurses.stdscr)
      Ncurses.refresh
    end
  end
end
