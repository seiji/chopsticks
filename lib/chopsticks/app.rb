require 'ncursesw'
require "google_reader_api"
require "net/netrc"

module Chopsticks

  class App
    attr_reader :feeds_panel
    attr_reader :status_line

    def initialize
      $observers = []
      @status_line  = Chopsticks::View::StatusLine.new  Ncurses.stdscr, 0, height - 2, 0, 1
      @command_line = Chopsticks::View::CommandLine.new Ncurses.stdscr, 0, height - 1, 0, 1
    end

    def method_missing(name, *args)
      $observers[-1].send(name, *args)
    end

    def help
      help_text = $observers[-1].help_text
      if help_text
        cols = Ncurses.getmaxx(Ncurses.stdscr)
        rows = height
        halfx = cols >> 1
        halfy = rows >> 1
        help = Chopsticks::View::Help.new Ncurses.stdscr, halfx >> 1, halfy >> 1, halfx, halfy
        help.show help_text
      end
    end

    def quit
      if $observers.size > 1
        old_win = $observers.pop
        next_win = $observers[-1]
        if next_win
          page = old_win.page
          if page > 0
            next_win.select page
          end
          next_win.touchwin
          next_win.refresh 
        end
      else
        @command_line.update "Quit? (Y/n)"
        ch = Ncurses.stdscr.getch
        case ch.chr
        when /Y/
          return false
        end
        @command_line.clear
      end
      return true
    end
    
    def loop
      Ncurses.stdscr.clear

      $rc = Net::Netrc.locate('reader.google.com') or raise ".netrc missing or no entry found"

      feed_list = Chopsticks::View::FeedList.new Ncurses.stdscr, 0, 0, 0, height - 2
      feed_list.update Chopsticks::Models::User.feeds
      $observers.push feed_list

      @status_line.update ""
      @command_line.update ""

      1 while Chopsticks::Keybinds.execute(self)
    end

    def height
      Ncurses.getmaxy(Ncurses.stdscr)
    end

    def width
      Ncurses.getmaxx(Ncurses.stdscr)
    end

  end
end
