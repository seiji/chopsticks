require "chopsticks/version"
require "chopsticks/cli"
require "chopsticks/app"
require "chopsticks/helper"
require "chopsticks/keybinds"

require "chopsticks/model"
require "chopsticks/models/user"
require "chopsticks/models/feed"

require "chopsticks/view/window"
require "chopsticks/view/window_table"
require "chopsticks/view/feed_list"
require "chopsticks/view/help"
require "chopsticks/view/status_line"
require "chopsticks/view/command_line"
require "chopsticks/view/feed_entries"
require "chopsticks/view/feed_entry"

module Chopsticks
  def self.root
    File.expand_path '../..', __FILE__
  end

  def self.scripts
    File.join root, 'scripts'
  end

  def self.lib
    File.join root, 'lib'
  end
end
