require 'open-uri'
require 'net/http'
require 'debugger'

class Url < ActiveRecord::Base
  belongs_to :user

  attr_accessible :original_url
  
  # validates :original_url, :with => :valid_url?
  # validate :original_url, :if => :valid_url?
  validates :original_url, :presence => true
  before_create :set_click_count, :shorten

  def self.update_count(shortened_url)
    url = Url.find_by_shortened_url(shortened_url)
    url.click_count += 1
    url.save
  end

  private

  def shorten
    shortened = SecureRandom.hex(3)
    shorten unless is_unique?(shortened)
    self.shortened_url = shortened
  end

  def valid_url?
    begin 
      response = open(self.original_url)
      debugger
      puts response
    rescue Exception => e
      e.message
    end
    return true if response
    return false
  end

  def is_unique?(shortened)
    Url.where("shortened_url = ?", shortened)
  end

  def set_click_count
    self.click_count = 0
  end
end
