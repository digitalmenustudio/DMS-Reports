module UploadDataServices
    class ItemClicks
      def initialize(restaurant:, item_name:, event_count:)
        @restaurant = restaurant
        @item_name = item_name
        @event_count = event_count.to_i # Ensure event_count is an integer
      end
  
      def run!
        process_item_event
      end
  
      private
  
      def process_item_event
        # Normalize the item name
        normalized_name = normalize_item_name
  
        # Find or initialize the item by restaurant and name (ignoring item_type for now)
        item = Item.find_or_initialize_by(restaurant: @restaurant, name: normalized_name, item_type: "Food")
  
        # Increment clicks or likes based on the event type (view or like)
        if @item_name.start_with?('like_item')
          # Increment likes for like_item events
          item.likes += @event_count
        else
          # Increment clicks for view_item or view_favoris_item events
          item.clicks += @event_count
        end
  
        # Save the item record to the database
        item.save!
      end
  
      def normalize_item_name
        # Remove prefixes (like 'view_item', 'view_favoris_item', 'like_item')
        normalized_name = @item_name.sub(/(view|like|favoris)_item_/, '')
  
        # Remove 'description' from the end of the name, if present
        normalized_name.sub!('_description', '')
  
        # Replace underscores with spaces and capitalize each word
        normalized_name.split('_').map(&:capitalize).join(' ')
      end
    end
  end
  