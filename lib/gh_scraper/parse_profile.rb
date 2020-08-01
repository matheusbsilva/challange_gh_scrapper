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

  def fullname
    element_query = 'span.vcard-fullname'
    element = @document.css(element_query).first
    element&.text
  end

  def username
    element_query = 'span.vcard-username'
    element = @document.css(element_query).first
    element&.text
  end

  def valuesk_to_i(text)
    text.gsub('k', '00').gsub('.', '').to_i unless text.nil?
  end

  def num_followers
    user = username
    element_query = "a[href=\"/#{user}?tab=followers\"]"
    element = @document.search(element_query).css('span').first

    valuesk_to_i(element.text)
  end

  def num_following
    user = username
    element_query = "a[href=\"/#{user}?tab=following\"]"
    element = @document.search(element_query).css('span').first
    valuesk_to_i(element.text)
  end

  def num_stars
    user = username
    element_query = "a[href=\"/#{user}?tab=stars\"]"
    element = @document.search(element_query).css('span').first
    valuesk_to_i(element.text)
  end

  private

  def fields
    %i[username fullname num_followers num_following
       num_stars num_contributions_last_year profile_img
       organization location]
  end

end
