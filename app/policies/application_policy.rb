class ApplicationPolicy
  include ApplicationHelper
  attr_reader :current_admin, :record

  def initialize(current_admin, record)
    raise Pundit::NotAuthorizedError, "must be logged in" unless current_admin 
    @admin = current_admin
    @record=record
  end

  def index?
    @admin
  end

  def show?
    @admin
  end

  def create?
    @admin
  end

  def new?
    @admin
  end

  def update?
    @admin
  end

  def edit?
    @admin
  end

  def destroy?
    @admin
  end

  class Scope
    attr_reader :current_admin, :scope

    def initialize(current_admin, scope)
      @admin = current_admin
      @scope = scope
    end

    def resolve
      scope.all
    end
  end
end


