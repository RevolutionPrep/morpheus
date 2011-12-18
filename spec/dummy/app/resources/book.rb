class Book < Morpheus::Base
  property :title
  belongs_to :author
end
