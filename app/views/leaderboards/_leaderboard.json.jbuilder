json.extract! leaderboard, :id, :genre, :user, :subgenre, :question, :total_qns, :attempted, :score, :created_at, :updated_at
json.url leaderboard_url(leaderboard, format: :json)
