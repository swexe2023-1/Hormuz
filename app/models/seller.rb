require 'bcrypt'
class Seller < ApplicationRecord
    validates :pass, presence: true, confirmation: true
    attr_accessor :pass, :pass_confirmation
    def pass=(val)
        if val.present?
            self.password = BCrypt::Password.create(val)
        end
        @pass = val
    end
end
