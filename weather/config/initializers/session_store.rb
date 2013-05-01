# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_weather_session',
  :secret      => '7ce69738e7fe8937d32ec5d30a884922b8b528f7b8e0deb7ae73878bf0bc7ce3726fa86a831430c41da8e4de05f529b1401a622aae02b7cae45e0ee848a178ca'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
