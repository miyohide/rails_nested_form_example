module NestedForm
  extend ActiveSupport::Concern

  def new_record?
    model.new_record?
  end
end
