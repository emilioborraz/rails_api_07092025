require 'net/http'
require 'uri'
require 'json'

class ExternalApiError < StandardError
  def initialize(message = "External API request failed")
    super
  end
end

class InterviewsAccounts
  BASE_URL = "https://interviews-accounts.elevateapp.com/api/v1/"

  def initialize(api_key:)
    @api_key = Rails.application.credentials.dig(:interviews_account_api_key)
  end

  def fetch_data(resource)

    uri = URI("#{BASE_URL}/#{resource}")
    request = Net::HTTP::Get.new(uri)
    request["Authorization"] = "Bearer #{@api_key}"

    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') do |http|
      http.request(request)
    end

    case response
    when Net::HTTPSuccess
      JSON.parse(response.body)
    else
      raise ExternalApiError, "API Error: #{response.code} - #{response.message}"
    end
  end
end