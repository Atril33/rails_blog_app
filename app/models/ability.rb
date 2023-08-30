class Ability
  include CanCan::Ability

  def initialize(user)
    # user ||= User.new # Guest user (not logged in)
    user ||= current_user
    if user.role == 'admin'
      can :manage, :all
    else
      can :read, :all
      can :create, Comment
      can :destroy, Post, author_id: user.id
      can :destroy, Comment, author_id: user.id
    end
  end
end