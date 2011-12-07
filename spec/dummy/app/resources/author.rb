class Author < Morpheus::Base
  property :name

  has_many :books
end
