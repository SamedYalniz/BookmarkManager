feature 'sign up' do
  scenario 'user can sign up' do
    visit '/users/new'
    fill_in 'email', with: 's.yalniz@hotmail.de'
    fill_in 'password', with: 'password123'
    fill_in 'password_confirmation', with: 'password123'
    click_button 'Sign up'
    expect(User.count).to eq 1
    expect(page).to have_content('Welcome s.yalniz@hotmail.de')
    expect(User.first.email).to eq 's.yalniz@hotmail.de'
  end

  scenario 'no user is created with wrong password confirmation' do
    visit '/users/new'
    fill_in 'email', with: 's.yalniz@hotmail.de'
    fill_in 'password', with: 'password123'
    fill_in 'password_confirmation', with: 'password1234'
    click_button 'Sign up'
    expect(User.count).to eq 0
    expect(current_path).to eq '/users'
    expect(page).to have_content 'Password and confirmation password do not match'
  end
end
