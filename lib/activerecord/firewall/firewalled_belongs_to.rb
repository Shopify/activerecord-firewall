require 'activerecord/firewall/firewalled_id_type'

module ActiveRecord
  module FirewalledBelongsTo
    def firewalled_belongs_to(type, *args)
      belongs_to type

      attribute "#{type.to_s}_id", FirewalledIDType.new(self, type)
    end
  end

  ActiveRecord::Base.singleton_class.prepend(FirewalledBelongsTo)
end
