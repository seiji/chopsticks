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

    def loop
      Ncurses.stdscr.clear

      rc = Net::Netrc.locate('reader.google.com') or raise ".netrc missing or no entry found"
      $user = GoogleReaderApi::User.new({
                                          :email    => rc.login,
                                          :password => rc.password
                                        })
      feed_list = Chopsticks::View::FeedList.new Ncurses.stdscr, 0, 0, 0, height - 2
      file = "data.txt"
      lines = File.open(file,'r').read.split("\n")
      
      feed_list.update $user.feeds
      $observers.push feed_list

      @status_line.update ""
      @command_line.update ""
      
      while true
        c = Ncurses.stdscr.getch
        if c > 0 and c < 255
          case c.chr
          when /\?/, /h/i
            cols = Ncurses.getmaxx(Ncurses.stdscr)
            rows = height
            halfx = cols >> 1
            halfy = rows >> 1
            help = Chopsticks::View::Help.new Ncurses.stdscr, halfx >> 1, halfy >> 1, halfx, halfy
            help.show
          when /j/i
            current_window.next
          when /k/i
            current_window.prev
          when /m/i
            current_window.check
            current_window.next
          when /u/i
            current_window.uncheck
            current_window.next
          when /q/i
            if $observers.size > 1
              $observers.pop
              next_win = $observers[-1]
              if next_win
                next_win.touchwin
                next_win.refresh 
              end
            else
              @command_line.update "Quit? (Y/n)"
              ch = Ncurses.getch
              case ch.chr
              when /Y/
                break
              end
              @command_line.clear
            end
          else
            case c
            when 10             # Ncurses::KEY_ENTER
              current_window.open
            when 32             # Space key
              current_window.pagedown
            end
            @status_line.update "#{c}"
          end
        else
          case c
          when Ncurses::KEY_DOWN
            current_window.next
          when Ncurses::KEY_UP
            current_window.prev
          end
        end
      end
    end

    def height
      Ncurses.getmaxy(Ncurses.stdscr)
    end

    def width
      Ncurses.getmaxx(Ncurses.stdscr)
    end

    private
    def current_window
      $observers[-1]
    end
  end
end
