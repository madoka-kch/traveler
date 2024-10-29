class Comment < ApplicationRecord
    belongs_to :user
    belongs=to :post
end
