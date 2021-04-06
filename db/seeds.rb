# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

questions = [
	[ "ANDS_AND_ORS_GALORE" ],
	[ "LISZTOMANIA" ],
	[ "The_MAGICAL_MYSTERY_MACHINE" ],
	[ "AN_EXPANSION_OF_EXPAND" ],
	[ "PAIR_MUTATIONS" ],
	[ "HARD_ENV_DIAGRAM" ],
	[ "REALLY_HARD_DECISON" ],
	[ "DOGE_TO_THE_MOON" ],
	[ "QUEENS_GAMBIT" ],
	[ "CAPITAL_RIOTS" ]
]

questions.each do |title, points|
	Question.create( title: title )
end