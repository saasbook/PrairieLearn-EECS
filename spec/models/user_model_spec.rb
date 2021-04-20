require 'rails_helper'

describe User do 
	describe 'User' do
		it 'finds user' do
			user = User.create(provider: 'github', uid: 'test123')
			expect(User.find_github_user('test123')).to eq(user)
		end
		it 'validates uid' do
			user = User.create(provider: 'github', uid: 'test123')
			user.valid?
			expect(user).to be_valid
		end
		it 'validates uid' do
			user1 = User.create(provider: 'github', uid: 'test123')
			user2 = User.create(provider: 'github', uid: 'test123')
			user2.valid?
			expect(user2).to_not be_valid
		end
	end
end