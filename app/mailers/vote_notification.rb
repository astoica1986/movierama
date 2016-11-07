class VoteNotification < ActionMailer::Base
  default from: "stoica.adrian86@gmail.com"
  
  def vote_notify(user,email, movie, vote)
    @user = user
    @email = email
    @movie = movie
    @voted = _vote_string(vote)
    mail(to: @email, subject: _subject(@user, vote))
  end
  
  private
  def _subject(username, vote)
    case vote
      when "like" then "Wonderful news #{username}"
      when "hate" then "Bad news, #{username}"
      else raise
    end
  end
  
  def _vote_string(vote)
    case vote
      when "like" then "liked"
      when "hate" then "disliked"
      else raise
    end
  end
end
