require 'activesupport/current_attributes'
require 'activerecord/firewall/firewalled_id_type'
require 'activerecord/firewall/firewalled_belongs_to'

module ActiveRecord
  module Firewall
    mattr_accessor :current_name
    self.current_name = 'Current'
  end
end
