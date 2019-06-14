
module RailsSunset
  module Controller
    extend ActiveSupport::Concern

    module ClassMethods
      def sunset_method(method, datetime, link: nil)
        sunset(datetime, link: link, only: [method])
      end

      def sunset(datetime, link: nil, only: nil)
        after_action(only: only) do |controller|
          datetime = normalize_datetime(datetime)
          link = normalize_link(link)
          user_agent = request.headers['User-Agent']

          # Shove a deprecation warning into the console or wherever it goes
          klass = controller.class
          method = params['action']
          ActiveSupport::Deprecation.warn("#{klass}##{method} deprecated endpoint (sunset date #{datetime.iso8601}) has been called by #{user_agent}")

          # Shove a Sunset header into HTTP Response for clients to sniff on
          # https://tools.ietf.org/html/draft-wilde-sunset-header-03
          response.headers['Sunset'] = datetime.httpdate

          if link.present?
            sunset_link_header = sprintf('<%s>; rel="sunset";', link)
            if response.headers['Link'].present?
              response.headers['Link'] += (', ' + sunset_link_header)
            else
              response.headers['Link'] = sunset_link_header
            end
          end
        end
      end
    end

    protected

    def normalize_datetime(datetime)
      datetime = DateTime.parse(datetime) if datetime.is_a? String
      datetime = datetime.to_datetime if datetime.respond_to? :to_datetime
      return datetime if datetime.respond_to? :httpdate
      raise TypeError, 'The date should be a Date, DateTime, Time or string containing a valid date and time'
    end

    def normalize_link(link)
      link = instance_exec(&(link)) if link.respond_to? :call
      return if link.nil?
      return link if link.is_a? String
      raise TypeError, 'The link should be a string, or a proc/lambda that returns a string'
    end
  end
end
