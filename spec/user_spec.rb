require './app/models/user'

  describe User do
    let!(:user) do
      User.create(first_name: 'Luke', last_name: 'Cartledge', email: 'luke@lukecartledge.com', password: 'ABC123', password_confirmation: 'ABC123')
    end

    context '#authenticate' do
      it 'authenticates user when given a valid email address and password' do
        authenticated_user = User.authenticate(user.email, user.password)
        expect(authenticated_user).to eq user
      end
      it 'does not authenticate when given an incorrect password' do
        expect(User.authenticate(user.email, 'not_abc123')).to be_nil
      end
    end
  end
