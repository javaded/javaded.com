# JavadED

Personal website and blog for Javad Effat Doost — developer, maker, and lifelong table tennis learner.

## Stack

- Rails 8 (vanilla — no SPA, no service objects, no policy framework)
- SQLite + Solid Cache/Queue/Cable
- Tailwind CSS v4 (CSS-based `@theme` config)
- Hotwire (Turbo + Stimulus)
- Propshaft + Importmap
- Minitest + fixtures
- Omakase RuboCop (no overrides)

## Convention

Follow `~/.config/opencode/rails-style/CORE.md`. The short version:

- Behavior goes in per-model concerns (`app/models/post/sluggable.rb`, not `app/models/concerns/sluggable.rb`).
- Controllers are conductors — `before_action` setters + thin actions + `head :forbidden` for auth.
- `Current` carries request state. No `current_user` helper.
- Bang methods inside `transaction do` on the model.
- Tests are behavioral sentences in Minitest clothing, fixtures referenced by symbol.

## Local development

```bash
bin/rails db:setup
bin/dev
```

Visit http://localhost:3000.

## Testing & linting

```bash
bin/rails test
bundle exec rubocop
```
