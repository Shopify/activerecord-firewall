module ActiveRecord
  class FirewalledIDType < ActiveRecord::Type::BigInteger
    class FirewalledAccess < ActiveRecord::RecordNotFound; end

    def initialize(model, protected_type, source, report_only: false)
      super()
      @model = model
      @protected_type = protected_type.to_sym
      @report_only = report_only
      @source = source
    end

    def deserialize(*)
      super.tap do |id|
        check_attribute!(id)
      end
    end

    private

    def cast_value(*)
      super.tap do |id|
        check_attribute!(id)
      end
    end

    def check_attribute!(id)
      current = @source.public_send(@protected_type)
      humanized_protected_type = @protected_type.to_s.humanize
      current_id = current&.id
      if current_id && id && current_id != id
        message = <<~END.gsub("\n", " ")
        #{@model || 'Record'} from #{humanized_protected_type}
        #{id} was accessed from #{humanized_protected_type} #{current_id}
        END

        if @report_only
          Rails.logger.info "[activerecord-firewall] #{message}"
        else
          raise FirewalledAccess, message
        end
      end
    end
  end
end
