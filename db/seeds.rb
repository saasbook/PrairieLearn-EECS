# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

questions = [
	[ "Q5_HARD_ENV_DIAGRAM", 10 ],
	[ "Q6_REALLY_HARD_DECISON", 5 ],
	[ "Q7_DOGE_TO_THE_MOON", 1 ],
	[ "Q8_QUEENS_GAMBIT", 8 ],
	[ "Q9_CAPITAL_RIOTS", 10]
]

questions.each do |title, points|
	Question.create( title: title, points: points )
end
