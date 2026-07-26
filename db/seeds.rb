Project.find_or_create_by!(slug: "scoutspin") do |p|
  p.title = "ScoutSpin"
  p.tagline = "Table Tennis Analytics"
  p.description = "A powerful table tennis analysis tool that helps players and coaches track performance and gain insights from match data."
  p.status = :live
  p.url = "https://scoutspin.com"
  p.featured = true
end

Project.find_or_create_by!(slug: "buildcue") do |p|
  p.title = "Buildcue"
  p.tagline = "Software Development"
  p.description = "An innovative platform designed to streamline the product-building process from ideation to launch for makers and startups."
  p.status = :building
  p.url = "https://buildcue.com"
  p.featured = false
end

Project.find_or_create_by!(slug: "tthistory-media") do |p|
  p.title = "TTHistory Media"
  p.tagline = "Media &amp; Archives"
  p.description = "A media project preserving and sharing the rich history of table tennis through stories, archives, and digital content."
  p.status = :live
  p.url = "https://tthistory.com"
  p.featured = false
end

Project.find_or_create_by!(slug: "javaded-youtube") do |p|
  p.title = "JavadED YouTube"
  p.tagline = "Content &amp; Tutorials"
  p.description = "My personal channel exploring the intersection of technology, making, and the sport of table tennis through tutorials and vlogs."
  p.status = :live
  p.url = "https://youtube.com/"
  p.featured = false
end

Post.find_or_create_by!(slug: "the-art-of-simplicity-in-design") do |post|
  post.title = "The Art of Simplicity in Design"
  post.excerpt = "Exploring how minimalism and thoughtful reduction can lead to more effective and elegant user experiences in product development."
  post.body = <<~BODY
    Simplicity is not the absence of features; it is the deliberate subtraction of the inessential. When we design products, our first instinct is often to add — more options, more controls, more ways to please every possible user. But every addition has a cost: a heavier cognitive load, a more cluttered interface, a wider surface area for bugs.

    The best products I've ever used felt effortless. Not because they were shallow, but because the depth was hidden until you needed it. The defaults were so well-chosen that 90% of users never needed to look further. The 10% who did were rewarded with thoughtful, progressive disclosure.

    In practice, simplicity means saying no — a lot. It means choosing one default instead of a settings panel. It means picking the right metaphor so users don't have to learn a new vocabulary. It means trusting your taste enough to ship something focused.

    Over the years, I've learned to treat every new feature request as a hypothesis to be disproved. Can the user achieve their goal with what already exists? Can we extend an existing concept instead of inventing a new one? The answer is almost always yes, if we are willing to be patient and creative.

    This philosophy is at the heart of everything I build — from ScoutSpin to this very website. Quiet confidence, honest defaults, and the belief that what you leave out matters as much as what you put in.
  BODY
  post.published_at = Date.new(2024, 4, 15)
  post.reading_time = 5
end

Post.find_or_create_by!(slug: "lessons-from-a-table-tennis-innovator") do |post|
  post.title = "Lessons from a Table Tennis Innovator"
  post.excerpt = "A reflection on the parallels between innovating in sports and building a technology startup from the ground up."
  post.body = <<~BODY
    Table tennis is a game of millimeters and milliseconds. The difference between a winner and an unforced error is often invisible to the casual observer — a slight tilt of the paddle, a fraction more topspin, a half-step better footwork. Innovation, in sport as in software, lives in those tiny margins.

    When I started building ScoutSpin, I assumed my technical skills would carry me. They didn't hurt, but they were not the differentiator. The differentiator was the years I'd spent at the table — feeling the rhythm of a rally, recognizing patterns in an opponent's game, knowing intuitively which shot would break their rhythm.

    The lesson, I think, is that domain expertise compounds in ways you can't shortcut. You can build a generic tool, but a tool built by someone who has lived the problem will always feel different. It will anticipate. It will fit.

    The same applies to startups. The founders who win are usually the ones who have been obsessed with the problem for a decade before they started the company. They have a backlog of insights no market research could surface. They know which details matter and which are noise.

    So my advice to anyone building something new: pick a problem you already love. The skill you need most is not coding or design or sales — it's the patience to have been paying attention for a long time before you started.
  BODY
  post.published_at = Date.new(2024, 3, 22)
  post.reading_time = 6
end

Post.find_or_create_by!(slug: "why-im-betting-on-long-form-video") do |post|
  post.title = "Why I'm Betting on Long-Form Video"
  post.excerpt = "In an age of short attention spans, there is a surprising and growing appetite for deep, meaningful video content. Here's my approach."
  post.body = <<~BODY
    Everyone says the algorithm wants short. Everyone says attention spans are shrinking. Everyone says you have to hook viewers in the first three seconds or you've lost them.

    I think they're half right — and that half is hiding something important.

    Yes, short content is easy to consume. Yes, it dominates the feed. But the relationship it builds with an audience is shallow. They will forget you tomorrow. They will not subscribe for the right reasons. They will not buy what you sell, because they do not trust you.

    Long-form video, by contrast, is a trust engine. A 30-minute tutorial says: I respect your time enough to actually teach you something. A deep-dive analysis says: I have put in the work, and I expect you to put in the work too. The audience that stays is the audience that cares — and that audience is worth more than a million casual scrollers.

    This is why I'm building my YouTube channel around long-form, not shorts. Every video is a bet that some viewers will reward depth. Some of them have. More will.

    The internet is full of fast food. I'd rather serve a slow-cooked meal to a smaller table.
  BODY
  post.published_at = Date.new(2024, 2, 10)
  post.reading_time = 4
end
