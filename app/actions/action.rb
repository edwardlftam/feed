class Action
  extend Forwardable

  attr_accessor :controller

  CONTROLLER_DELEGATIONS = [
    :params,
    :render,
    :success!,
    :created!,
    :error!,
    :invalid!,
    :not_found!
  ]

  def_delegators :controller, *CONTROLLER_DELEGATIONS
  
  def initialize(controller)
    @controller = controller
  end

  def perform
    raise "Implement Me!"
  end
end
