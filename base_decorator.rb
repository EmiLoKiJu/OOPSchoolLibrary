require_relative 'nameable'

class BaseDecorator < Nameable
  def initialize(object)
    @nameable = object
  end

  def correct_name
    @nameable.correct_name
  end
end