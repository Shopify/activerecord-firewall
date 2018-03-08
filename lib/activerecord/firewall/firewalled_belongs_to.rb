require 'activerecord/firewall/firewalled_id_type'

module ActiveRecord
  module FirewalledBelongsTo

    def firewalled_belongs_to(type, *args)
      id_type = "#{type.to_s}_id"

      belongs_to type

      attribute id_type, FirewalledIDType.new(self, type)

      after_find do |record|
        record.send(id_type) # Will throw the exception
      end
    end
  end

  ActiveRecord::Base.singleton_class.prepend(FirewalledBelongsTo)
end
