module Chopsticks
  class Keybinds
    def self.execute(app)
      ch = Ncurses.stdscr.getch
      case ch
      when 10 # Ncurses::KEY_ENTER
        app.open
      when 'h'.ord, '?'.ord
        app.help
      when 'j'.ord, Ncurses::KEY_DOWN
        app.next
      when 'k'.ord, Ncurses::KEY_UP
        app.prev
      when 'm'.ord
        app.check
        app.next
      when 'o'.ord
        app.open
      when 'q'.ord
        return app.quit
      when 'r'.ord
        app.reload
      when 'u'.ord
        app.uncheck
        app.next
      when 'x'.ord
        app.marks
      when 'X'.ord
        app.mark
      end
      app.status_line.update "#{ch}" # debug
      return true
    end
  end
end
