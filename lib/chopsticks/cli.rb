# -*- coding: utf-8 -*-
require 'thor'
require "net/netrc"

module Chopsticks
  class CLI < Thor::Group
    def initialize(*args)
      super
    end

    def start
      begin
        stdscr = Ncurses.initscr()
        Ncurses.start_color();
        Ncurses.cbreak();
        Ncurses.noecho();
        Ncurses.keypad(stdscr, true);
        Ncurses.curs_set 0        # if possible

        # Ncurses.init_pair 1, Ncurses::COLOR_RED,   Ncurses::COLOR_WHITE
        # Ncurses.init_pair 2, Ncurses::COLOR_GREEN, Ncurses::COLOR_WHITE
        # Ncurses.init_pair 3, Ncurses::COLOR_BLUE,  Ncurses::COLOR_WHITE
        # Ncurses.init_pair 4, Ncurses::COLOR_CYAN,  Ncurses::COLOR_WHITE
        # Ncurses.init_pair 5, Ncurses::COLOR_YELLOW,  Ncurses::COLOR_WHITE

        # Ncurses.init_pair 11, Ncurses::COLOR_BLUE,   Ncurses::COLOR_BLACK
        # Ncurses.init_pair 12, Ncurses::COLOR_RED,   Ncurses::COLOR_BLACK
        # Ncurses.init_pair 13, Ncurses::COLOR_CYAN,  Ncurses::COLOR_BLACK
        # Ncurses.init_pair 14, Ncurses::COLOR_YELLOW,  Ncurses::COLOR_BLACK

        # initialize all the colors
        Ncurses.init_pair 1, Ncurses::COLOR_RED,   Ncurses::COLOR_BLACK
        Ncurses.init_pair 2, Ncurses::COLOR_GREEN, Ncurses::COLOR_BLACK
        Ncurses.init_pair 3, Ncurses::COLOR_BLUE,  Ncurses::COLOR_BLACK
        Ncurses.init_pair 4, Ncurses::COLOR_CYAN,  Ncurses::COLOR_BLACK
        Ncurses.init_pair 5, Ncurses::COLOR_WHITE, Ncurses::COLOR_BLUE

        Ncurses.init_pair 6, Ncurses::COLOR_WHITE, Ncurses::COLOR_BLACK
        Ncurses.init_pair 7, Ncurses::COLOR_GREEN, Ncurses::COLOR_WHITE
        Ncurses.init_pair 8, Ncurses::COLOR_WHITE, Ncurses::COLOR_GREEN
        Ncurses.init_pair 9, Ncurses::COLOR_BLACK, Ncurses::COLOR_YELLOW

        stdscr.clear

        app = Chopsticks::App.new
        app.loop

      rescue Exception => e
        Ncurses.printw e.inspect + "\n"
        Ncurses.printw e.backtrace.join("\n")
        Ncurses.getch
      ensure
        Ncurses.endwin()
      end
    end
  end
end
