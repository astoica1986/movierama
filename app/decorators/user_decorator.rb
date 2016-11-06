class UserDecorator < Draper::Decorator
  delegate_all

  def likes?(movie)
    movie.likers.include?(object)
  end

  def hates?(movie)
    movie.haters.include?(object)
  end
  
  def notifiable?
    object.notifiable == "true"
  end
  #Redis/Ohm won's save anything that isn't convertable to String..urgh!
  def subscribe
    object.update notifiable: "true"
  end
  
  def unsubscribe
    object.update notifiable: "false"
  end
end

