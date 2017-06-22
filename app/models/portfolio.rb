class Portfolio < ApplicationRecord
  
  include Placeholder
  
  validates_presence_of :title, :body, :main_image, :thumb_image
  
  # Method 1 to Implement Custom Scopes
  def self.angular
    where(subtitle: "Angular")
  end
  
  # Method 2 to Implement Custom Scopes
  scope :ruby_items, -> {where(subtitle: "Ruby on Rails")}
  
  after_initialize :set_defaults
  
  def set_defaults
    self.main_image ||= Placeholder.image_generator(height: '600', width: '400')
    self.thumb_image ||= Placeholder.image_generator(height: '350', width: '200')
  end
  
end
