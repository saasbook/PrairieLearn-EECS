# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

questions = [
	[ "ANDS_AND_ORS_GALORE", 7 ],
	[ "LISZTOMANIA", 8 ],
	[ "The_MAGICAL_MYSTERY_MACHINE", 16 ],
	[ "AN_EXPANSION_OF_EXPAND", 6 ],
	[ "PAIR_MUTATIONS", 12],
	[ "HARD_ENV_DIAGRAM", 10 ],
	[ "REALLY_HARD_DECISON", 5 ],
	[ "DOGE_TO_THE_MOON", 1 ],
	[ "QUEENS_GAMBIT", 8 ],
	[ "CAPITAL_RIOTS", 10]
]

questions.each do |title, points|
	Question.create( title: title, points: points )
end