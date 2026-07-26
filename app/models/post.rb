class Post < ApplicationRecord
  include Post::Sluggable

  scope :published, -> { where.not(published_at: nil) }
  scope :newest_first, -> { order(published_at: :desc, created_at: :desc) }
  scope :chronological, -> { order(published_at: :asc, created_at: :asc) }
  scope :recent, ->(count = 3) { newest_first.limit(count) }

  normalizes :slug, with: ->(value) { value.to_s.parameterize }

  def to_param = slug

  def published? = published_at.present? && published_at <= Time.current

  def paragraphs
    body.to_s.split(/\n\s*\n/).map(&:strip).reject(&:blank?)
  end
end
