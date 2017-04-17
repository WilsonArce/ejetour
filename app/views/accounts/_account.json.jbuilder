json.extract! account, :id, :user_id, :role, :state, :category, :location, :created_at, :updated_at
json.url account_url(account, format: :json)
