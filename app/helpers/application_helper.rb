module ApplicationHelper
  def bool_to_text(value)
    value ? t("simple_form.yes") : t("simple_form.no")
  end
  
  def format_time_spent(minutes, seconds)
    formatted_minutes = minutes.to_i
    formatted_seconds = seconds.to_i
    format('%02d:%02d', formatted_minutes, formatted_seconds) # e.g., "05:30"
  end
end
