class PlaceSerializer < ActiveModel::Serializer
  attributes :id, :name, :lat, :lng

  has_many :events, embed: :ids
end