module UploadDataServices
    class CsvUpload
      require 'csv'
  
      def initialize(restaurant:, file:, day:)
        @restaurant = restaurant
        @file = file
        @day = day
      end
  
      def run!
        process_csv
      end
  
      private
  
      def process_csv
        CSV.foreach(@file.path, headers: true, col_sep: ';') do |row|
          process_row(row.to_hash)
        end
      end
  
      def process_row(row)
        event_name = row['Event name']
  
        if event_name.start_with?('select_menu')
            UploadDataServices::TabClicks.new(restaurant: @restaurant, tab_name: event_name, clicks: row['Event count'] ).run!
        elsif event_name.start_with?('view_item') || event_name.start_with?('view_favoris') || event_name.start_with?('like_item')
            UploadDataServices::ItemClicks.new(restaurant: @restaurant, item_name: event_name, event_count: row['Event count']).run!
        elsif event_name.start_with?('interact_promotion')  || event_name.start_with?('view_promotion')
            UploadDataServices::PromotionViews.new(restaurant: @restaurant, promotion_name: event_name, event_count: row['Event count']).run!
        elsif event_name.start_with?('menu_access') 
            UploadDataServices::MenuAccess.new(restaurant: @restaurant, access_time: event_name, event_count: row['Event count'], day: @day).run!
        else
          puts "Skipping event: #{event_name}"
        end
      end
    end
  end
  