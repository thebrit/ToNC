# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_newfinance_session',
  :secret      => 'c7cf83c7113cd4527c41c288f2faf5886d6af7d67954e9fc3775e1ffd2a7afb19f4d47f6f70a912c6c3afe626314e5623522d3e5151e0743c32d26ed6a1fb100'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
