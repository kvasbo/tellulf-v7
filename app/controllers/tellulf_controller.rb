require 'google/apis/calendar_v3'
require 'googleauth'
require 'base64'

class TellulfController < ApplicationController
  def index

    # Decode the environment variable
    service_account_info = JSON.parse(Base64.decode64(ENV['GOOGLE_KEY_B64']))

    # Initialize the Google API Client
    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = Google::Auth::ServiceAccountCredentials.make_creds(
      json_key_io: StringIO.new(service_account_info.to_json),
      scope: Google::Apis::CalendarV3::AUTH_CALENDAR
    )

    calendar_id_events = ENV['CAL_ID_FELLES'] # or the specific calendar ID
    response = service.list_events(calendar_id_events, single_events: true, order_by: 'startTime', time_min: Time.now.iso8601, time_max: (Time.now + 14.days).iso8601)

    Rails.logger.info "Response: #{response.inspect}"
  

  end
end
