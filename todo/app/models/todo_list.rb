class TodoList < ActiveRecord::Base
  has_many :list_items
end
