class BlogPost < ApplicationRecord
  firewalled_belongs_to :user
end
