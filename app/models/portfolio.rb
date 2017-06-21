class Portfolio < ApplicationRecord
  
  validates_presence_of :title, :body, :main_image, :thumb_image
  
  # Method 1 to Implement Custom Scopes
  def self.angular
    where(subtitle: "Angular")
  end
  
  # Method 2 to Implement Custom Scopes
  scope :ruby_items, -> {where(subtitle: "Ruby on Rails")}
  
end
