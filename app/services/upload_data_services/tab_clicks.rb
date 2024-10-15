module UploadDataServices
  class TabClicks
    def initialize(restaurant:, tab_name:, clicks:)
      @restaurant = restaurant
      @tab_name = tab_name
      @clicks = clicks.to_i
    end

    def run!
      process_tab_event
    end

    private

    def process_tab_event
      normalized_name = normalize_name

      # Find or initialize the tab_click record by restaurant and normalized tab name
      tab_click = TabClick.find_or_initialize_by(restaurant: @restaurant, tab_name: normalized_name)

      if tab_click.new_record?
        # If it's a new record, set the clicks count
        tab_click.clicks = @clicks
      else
        # If the record exists, increment the clicks count
        tab_click.clicks += @clicks
      end

      # Save the tab_click record to the database
      tab_click.save!
    end

    def normalize_name
      # Remove the 'select_menu_tab_' prefix and normalize the remaining name
      @tab_name.sub('select_menu_tab_', '').split('_').map(&:capitalize).join(' ')
    end
  end
end
