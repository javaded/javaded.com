class Project < ApplicationRecord
  include Project::Sluggable

  has_rich_text :description

  STATUS_BADGE = {
    live:     [ "bg-green-100", "text-green-700" ],
    building: [ "bg-blue-100",  "text-blue-700"  ],
    archived: [ "bg-stone-100", "text-stone-600" ]
  }.freeze

  enum :status, %w[ live building archived ].index_by(&:itself), default: :live

  scope :featured_first, -> { order(featured: :desc, created_at: :asc) }

  normalizes :slug, with: ->(value) { value.to_s.parameterize }

  def to_param = slug

  def status_badge_classes = STATUS_BADGE[status.to_sym] || STATUS_BADGE[:live]
end
