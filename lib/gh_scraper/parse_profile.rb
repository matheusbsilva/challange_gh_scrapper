require 'nokogiri'

class ParseProfile

  attr_reader :document

  def initialize(content)
    @document = Nokogiri::HTML(content)
    @parsed_fields = fields.each_with_object({}) { |item, hash| hash[item] = nil }
  end

  def parse
    @parsed_fields
  end

  private

  def fields
    %i[username fullname num_followers num_following
       num_stars num_contributions_last_year profile_img
       organization location]
  end

end
