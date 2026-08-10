require "io/console"

namespace :admin do
  desc "Reset a user's password. Usage: bin/rails admin:reset_password[email,password]"
  task :reset_password, [ :email, :password ] => :environment do |_t, args|
    email = (args[:email] || prompt("Email: ")).to_s.strip.downcase
    user = User.find_by(email_address: email)
    abort "No user found with email '#{email}'." unless user

    password = args[:password] || prompt_secret("New password: ")
    abort "Password can't be blank." if password.blank?

    user.update!(password: password, password_confirmation: password)
    puts "Password updated for #{user.email_address}. Sign in at /session/new."
  end

  def prompt(text)
    print text
    $stdin.gets&.strip
  end

  def prompt_secret(text)
    print text
    $stdin.noecho(&:gets).to_s.strip
  ensure
    puts
  end
end
