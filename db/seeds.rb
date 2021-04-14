# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

questions = [
	[ "ANDS_AND_ORS_GALORE", "0", "0" ],
	[ "LISZTOMANIA", "0", "0" ],
	[ "The_MAGICAL_MYSTERY_MACHINE", "0", "0" ],
	[ "AN_EXPANSION_OF_EXPAND", "0", "0" ],
	[ "PAIR_MUTATIONS", "0", "0" ],
	[ "HARD_ENV_DIAGRAM", "0", "0" ],
	[ "REALLY_HARD_DECISON", "0", "0" ],
	[ "DOGE_TO_THE_MOON", "0", "0" ],
	[ "QUEENS_GAMBIT", "0", "0" ],
	[ "CAPITAL_RIOTS", "0", "0" ]
]

questions.each do |title, user_id, repo|
	Question.create( title: title, user_id: user_id, repo: repo )
end