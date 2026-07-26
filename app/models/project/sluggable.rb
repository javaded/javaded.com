module Project::Sluggable
  extend ActiveSupport::Concern

  included do
    before_validation :assign_slug, on: :create
  end

  private
    def assign_slug
      self.slug = title.to_s.parameterize if slug.blank?
    end
end
