feature 'Sign In' do


  scenario 'A user can sign in' do
    User.create(first_name: 'Luke', last_name: 'Cartledge', email: 'luke@lukecartledge.com', password: 'ABC123', password_confirmation: 'ABC123')
    visit 'sessions/new'
    expect(page.status_code).to eq 200
    fill_in 'Email:', with: 'luke@lukecartledge.com'
    fill_in 'Password:', with: 'ABC123'
    click_button 'Sign in'
    expect(current_path).to eq '/links'
    expect(page).to have_content 'Hi Luke!'
  end
end
