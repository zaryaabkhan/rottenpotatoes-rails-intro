class Movie < ActiveRecord::Base
  RATINGS = %w[G PG PG-13 R].freeze

  def self.all_ratings
    RATINGS
  end

  def self.with_ratings(ratings_list)
    return all if ratings_list.nil? || ratings_list.empty?
    where(rating: ratings_list)
  end
end
