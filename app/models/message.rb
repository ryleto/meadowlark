class Message < ActiveRecord::Base
    include ActiveModel::Model
    attr_accessor :name, :company, :email, :content
    validates :name, :email, :content, :presence => true
    validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
end
