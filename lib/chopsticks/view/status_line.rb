module Chopsticks::View

  class StatusLine < Window
    def initialize(win, x, y, width, height)
      super
      @window.bkgd Ncurses.COLOR_PAIR(5)
    end

    def update(text)
      @window.clear
      @window.mvprintw 0, 0, "%s", text
      show
    end
  end
end
