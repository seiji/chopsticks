module Chopsticks::View

  class CommandLine < Window
    def initialize(win, x, y, width, height)
      super
      @window.bkgd Ncurses.COLOR_PAIR(6)
    end

    def update(text)
      @window.clear
      @window.insstr text
      show
    end
  end
end
