class Image < ApplicationRecord
  firewalled_belongs_to :user, report_only: true
end
