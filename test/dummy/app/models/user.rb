class User < ApplicationRecord
  def initialize(*args)
    super
    Current.user = self
  end
end
