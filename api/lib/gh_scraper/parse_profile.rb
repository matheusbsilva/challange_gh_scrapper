require 'nokogiri'

class ParseProfile

  attr_reader :document

  def initialize(content)
    @document = Nokogiri::HTML(content)
    @parsed_fields = fields.each_with_object({}) { |item, hash| hash[item] = nil }
  end

  def parse
    @parsed_fields.each do |key, _|
      # Call method of given field name
      @parsed_fields[key] = send(key)
    end
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

    valuesk_to_i(element&.text)
  end

  def num_following
    user = username
    element_query = "a[href=\"/#{user}?tab=following\"]"
    element = @document.search(element_query).css('span').first
    valuesk_to_i(element&.text)
  end

  def num_stars
    user = username
    element_query = "a[href=\"/#{user}?tab=stars\"]"
    element = @document.search(element_query).css('span').first
    valuesk_to_i(element&.text)
  end

  def num_contributions_last_year
    element_query = 'div.js-yearly-contributions'
    element = @document.search(element_query).css('h2').first

    # Extract only the number of contributions from string
    element.text[/\n\s+(?<value>\d+)/, :value].to_i unless element.nil?
  end

  def profile_img
    element = @document.css('div.clearfix').css('div.position-relative').css('img.avatar').first
    element.attributes['src'].value unless element.nil?
  end

  def organization
    element = @document.css('li.vcard-detail').css('span.p-org').first
    element&.text
  end

  def location
    element = @document.css('li.vcard-detail').css('span.p-label').first
    element&.text
  end

  private

  def fields
    %i[fullname num_followers num_following
       num_stars num_contributions_last_year profile_img
       organization location]
  end

end
