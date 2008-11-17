class Article
  include DataMapper::Resource
  
  property :id, Serial

  property :title, String
  property :author, String
  property :created_at, DateTime

  validates_present :title
end
