feature 'Sign up' do
  before do
    visit '/signup'
    fill_in 'First Name:', with: 'Mannie'
    fill_in 'Last Name:', with: ''
    fill_in 'Email:', with: 'mannie.com'
    fill_in 'Password:', with: 'Password123'
  end
  
  scenario 'when a user signs up the User account count increases by 1' do
    fill_in 'Confirm Password:', with: 'Password123'
    click_button('Signup')
    expect(User.count).to eq 1
  end
  scenario 'user is shown a welcome page' do
    fill_in 'Confirm Password:', with: 'Password123'
    click_button('Signup')
    expect(page).to have_content 'Hi Mannie!'
  end
  scenario 'input email address is the same as database entry' do
    fill_in 'Confirm Password:', with: 'Password123'
    click_button('Signup')
    expect(User.first.email).to eq 'mannie.com'
  end

  scenario 'user enters different password in password confirmation' do
    fill_in 'Confirm Password:', with: 'Password122'
    click_button('Signup')
    expect(User.count).to eq 0
  end
end
