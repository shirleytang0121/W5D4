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

    validates :short_url, presence: true, uniqueness: true
    validates :long_url, presence: true

    belongs_to :the_user,
        primary_key: :id,
        foreign_key: :user_id,
        class_name: "User"
end
