module UploadDataServices
    class PromotionViews
      def initialize(restaurant:, promotion_name:, event_count:)
        @restaurant = restaurant
        @promotion_name = promotion_name
        @event_count = event_count.to_i # Ensure event_count is an integer
      end
  
      def run!
        process_promotion_event
      end
  
      private
  
      def process_promotion_event
        # Normalize the promotion name
        normalized_name = normalize_promotion_name
  
        # Find or initialize the promotion by restaurant and name
        promotion = Promotion.find_or_initialize_by(restaurant: @restaurant, name: normalized_name)
  
        if promotion.new_record?
          # If the record is new, set the event_count
          promotion.view_count = @event_count
        else
          # If the record exists, increment the event_count
          promotion.view_count += @event_count
        end
  
        # Save the promotion record to the database
        promotion.save!
      end
  
      def normalize_promotion_name
        # Remove prefixes (like 'interact_promotion' or 'view_promotion')
        normalized_name = @promotion_name.sub(/(interact_|view_)promotion_/, '')
  
        # Replace underscores with spaces and capitalize each word
        normalized_name.split('_').map(&:capitalize).join(' ')
      end
    end
  end
  