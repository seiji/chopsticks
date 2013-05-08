module Chopsticks
  class Keybinds

    def self.execute(app)
      ch = Ncurses.getch

      case ch
      when Ncurses::KEY_DOWN
        app.panel_evaluate "next"
      when Ncurses::KEY_UP
        app.panel_evaluate "prev"
      when 13,14 # Ncurses::KEY_ENTER
        app.subwin_open
      when 22 # Ncurses::KEY_ENTER
        app.subwin_open

      when 'j'.ord
        app.panel_evaluate "next"
      when 'k'.ord
        app.panel_evaluate "prev"
      when 'o'.ord
        app.subwin_open
      when 'q'.ord
        return app.subwin_close
        
        # when 'r'.ord
        #   @command_line.update "Loading..."
        # when 'q'.ord
        #   @command_line.update "quit? (Y/n)"
        #   ch=Ncurses.getch
        #   if ch == 'y'.ord
        #     break
        #   end
        #   #            @command_line.clear
      else
        app.status_line.update "#{ch}"
      end
      app.status_line.update "#{ch}"
      
      return true
    end
  end
end
