class ReviewDecorator < Draper::Decorator
  delegate_all

  def author
  	"#{object.user.firstname} #{object.user.lastname}"
  end

end
