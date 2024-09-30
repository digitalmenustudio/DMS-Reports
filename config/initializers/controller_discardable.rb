module ControllerDiscardable
  extend ActiveSupport::Concern

  class_methods do
    def add_discard_filtering(name, options = {})
      before_action options do
        @_records_to_apply_discard_filter = "@#{name}"
      end
    end
  end

  def render(*args)
    if @_records_to_apply_discard_filter.present?
      records = instance_variable_get(@_records_to_apply_discard_filter)
      instance_variable_set(@_records_to_apply_discard_filter, apply_discard_filtering(records))
    end

    super(*args)
  end

  def apply_discard_filtering(records)
    return records unless records.respond_to?(:kept)

    case params[:discarded]
    when "all"
      records.with_discarded
    when "true"
      records.discarded
    else
      records.kept
    end
  end
end

ActiveSupport.on_load(:action_controller) { prepend ControllerDiscardable }
