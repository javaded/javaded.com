# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Project.create!(
  title: "ScoutSpin",
  slug: "scoutspin",
  description: "Table tennis match analysis and scouting tools.",
  status: "building",
  features: true
)

Post.create!(
  title: "Why I Still Love Ruby on Rails",
  slug: "why-i-still-love-rails",
  excerpt: "A reflection on calm software and long-term thinking.",
  body: "Long-form writing here...",
)
