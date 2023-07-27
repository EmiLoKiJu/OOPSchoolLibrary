require_relative 'nameable'

class BaseDecorator < Nameable
  def initialize(object)
    super()
    @nameable = object
  end

  def correct_name
    @nameable.correct_name
  end
end
