class ResumePolicy < ApplicationPolicy

  def create?
    user.user?
  end

  def update?
    create?
  end

  def destroy?
    created?
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
