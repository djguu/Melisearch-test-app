class Product < ApplicationRecord
  after_save :update_search_index
  after_destroy :delete_from_search_index

  def update_search_index
    MeiliSearch::Client.new('http://localhost:7700').index('products').add_documents([self.as_json(only: [:id, :name, :description])])
  end

  def delete_from_search_index
    MeiliSearch::Client.new('http://localhost:7700').index('products').delete_documents([self.id])
  end

  def self.search(query)
    MeiliSearch::Client.new('http://localhost:7700').index('products').search(query)
  end
end