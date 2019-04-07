require 'activerecord/firewall/firewalled_id_type'

module ActiveRecord
  module FirewalledBelongsTo

    def firewalled_belongs_to(foreign_key_type, *args, report_only: false, **options)
      key_column_name = "#{foreign_key_type.to_s}_id"

      belongs_to foreign_key_type, *args, **options

      attribute key_column_name,
        FirewalledIDType.new(
          self,
          foreign_key_type,
          ActiveRecord::Firewall.current_name.constantize,
          report_only: report_only)

      after_find do |record|
        # This explicitly loads the foreign key and
        # deserializes the FirewalledIDType,
        # ensuring the FirewalledAccess exception will
        # get thrown
        record.send(key_column_name)
      end
    end
  end

  ActiveRecord::Base.singleton_class.prepend(FirewalledBelongsTo)
end
