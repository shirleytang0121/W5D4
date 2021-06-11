require 'securerandom'

# == Schema Information
#
# Table name: shortened_urls
#
#  id        :bigint           not null, primary key
#  long_url  :string           not null
#  short_url :string           not null
#  user_id   :integer          not null
#
class ShortenedUrl < ApplicationRecord
   
    def self.random_code
        success = false
        until success
            random_url = SecureRandom.base64
            search_result = ShortenedUrl.exists?(:short_url => random_url)
            return random_url unless search_result
        end   
    end


    def self.generate_url(user, long_url)
        short_url = ShortenedUrl.random_code
        ShortenedUrl.create!(:user_id=> user.id, :long_url=>long_url, :short_url=>short_url)
    end

    def num_clicks
        
    end

    


    validates :short_url, presence: true, uniqueness: true
    validates :long_url, presence: true

    belongs_to :submitter,
        primary_key: :id,
        foreign_key: :user_id,
        class_name: "User"

    has_many :clicks,
        primary_key: :id,
        foreign_key: :url_id,
        class_name: 'Visit'
    
    has_many :visitors,
        through: :clicks,
        source: :visited_by
end
