#Its not named EmailService because in theory this can be expanded to use sms, push notifs etc.

class Notifier
  def initialize(user, movie, vote)
    @username  = user.name
    @movie = movie.title
    @email = user.email
    @vote = vote.to_s
  end
  
  def send_email
    VoteNotification.vote_notify(@username, @email , @movie, @vote).deliver_later
  end
end