module Chopsticks::Models
  class User
    def self.feeds
      user = GoogleReaderApi::User.new({
                                          :email    => $rc.login,
                                          :password => $rc.password
                                        })

      feeds = user.feeds
      # feeds.unshift Feed.total_feed # too slow 
      feeds
    end

    def self.subscriptions
      user = GoogleReaderApi::User.new({
                                          :email    => $rc.login,
                                          :password => $rc.password
                                        })
      user.subscriptions
    end
  end
end
