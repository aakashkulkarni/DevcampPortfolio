class Portfolio < ApplicationRecord
  
  has_many :technologies
  accepts_nested_attributes_for :technologies,
                                allow_destroy: true,
                                reject_if: lambda { |attrs| attrs['name'].blank? }
  
  validates_presence_of :title, :body
  
  mount_uploader :thumb_image, PortfolioUploader
  mount_uploader :main_image, PortfolioUploader
  
  # Method 1 to Implement Custom Scopes
  def self.angular
    where(subtitle: "Angular")
  end
  
  def self.by_position
    order("position ASC")
  end
  
  # Method 2 to Implement Custom Scopes
  scope :ruby_items, -> {where(subtitle: "Ruby on Rails")}
end


