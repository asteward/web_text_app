class Message < ActiveRecord::Base
  before_save :send_message

private
  def send_message
    numbers = to.split(",")
    numbers.each do |number|
      response = RestClient::Request.new(
        :method => :post,
        :url => "https://api.twilio.com/2010-04-01/Accounts/#{ENV['TWILIO_ACCOUNT_SID']}/Messages.json",
        :user => ENV['TWILIO_ACCOUNT_SID'],
        :password => ENV['TWILIO_AUTH_TOKEN'],
        :payload => { :Body => body,
                      :To => number,
                      :From => from,
                      :MediaUrl => mediaUrl }
      ).execute
    end
  end
end
