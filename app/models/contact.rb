class Contact < ApplicationRecord
  belongs_to :user
  belongs_to :contact_user, foreign_key: :contact_user_id, class_name: "User"
end
