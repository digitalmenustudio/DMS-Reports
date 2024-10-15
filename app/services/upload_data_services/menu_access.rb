module UploadDataServices
    class MenuAccess
      def initialize(restaurant:, access_time:, event_count:, day:)
        @restaurant = restaurant
        @access_time = access_time
        @event_count = event_count.to_i
        @day = day
      end
  
      def run!
        process_menu_access
      end
  
      private
  
      def process_menu_access
        normalized_time_frame = normalize_time_frame
  
        # Find or initialize the record in the menu_access_logs table
        menu_access_log = MenuAccessLog.find_or_initialize_by(
          restaurant: @restaurant,
          day_of_week: @day,
          time_frame: normalized_time_frame
        )
  
        if menu_access_log.new_record?
          # If it's a new record, set the visitors count
          menu_access_log.visitors = @event_count
        else
          # If the record exists, increment the visitors count
          menu_access_log.visitors += @event_count
        end
  
        # Save the record to the database
        menu_access_log.save!
      end
  
      def normalize_time_frame
        # Remove the 'menu_access_' prefix and normalize the time frame
        time_frame = @access_time.sub('menu_access_', '')
  
        # Handle special cases like 'midnight-3am' and '3am-3pm'
        case time_frame
        when 'midnight-3am' || '00am-3am'
          '00:00-03:00'
        when '3am-3pm' || '3am-15pm'
          '03:00-15:00'
        else
          # Normalize other time frames like '2230-2300' or '1600-1630'
          time_frame.split('-').map { |t| format_time(t) }.join('-')
        end
      end
  
      def format_time(time_string)
        # Normalize the time format (e.g., '2230' -> '22:30', '3am' -> '03:00')
        if time_string.match?(/\A\d{4}\z/)
          # Format '2230' to '22:30'
          time_string.insert(2, ':')
        elsif time_string.include?('am') || time_string.include?('pm')
          # Format '3am' or '3pm' to '03:00' or '15:00'
          Time.parse(time_string).strftime('%H:%M')
        else
          # Default to just returning the time string (this is a fallback case)
          time_string
        end
      end
    end
  end
  