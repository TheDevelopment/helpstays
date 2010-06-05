# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_helpstays_session',
  :secret      => 'e63042999722498ac844e6fd4f99b46ddca3337f453e1771b144a64d0cb441c00392956931bae37ec193b9030067d8ccb89f9dc95384a3faf543420b8bdace65'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
