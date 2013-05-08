module Chopsticks::View

  class Help < Window

    def initialize(win, x, y, width, height)
      @parent = win
      @width  = width
      @height = height
      @window = Ncurses.newwin(@height, @width, y, x)
      @cur_y = 0
      @cur_x = 0

      str = help_text
      add_str(str, 0, 1)
#      @window.box(0,0)
      @window.bkgd(Ncurses.COLOR_PAIR(5));
    end

    def help_text
  <<-eos

    Help for Chopsticks
    ------------------------------------------------

    Keys that can be used on header

    <ENTER>     - sort given field (press on header)
    <->         - press <minus> to reduce column width
    <+>         - press <plus> to increase column width

    Keys that can be used on data rows

    <space>     -  select a row
    <Ctr-space> - range select
    <u>         - unselect all (conflicts with vim keys!!)
    <a>         - select all
    <*>         - invert selection

    </>         - <slash> for searching, 
                  <n> to continue searching

    Keys specific to this example

    <e>         - edit current row
    <dd>        - delete current row or <num> rows
    <o>         - insert a row after current one
    <U>         - undo delete

         Motion keys 

    Usual for lists and textview such as :
    j, k, h, l
    w and b for (next/prev) column
    C-d and C-b
    gg and G

    eos
    end
    
    def show
      @window.touchwin
      Ncurses.wrefresh(@window)
      Ncurses.getch

      Ncurses.delwin(@window)
      Ncurses.touchwin(Ncurses.stdscr)
      Ncurses.refresh
    end
  end
end
