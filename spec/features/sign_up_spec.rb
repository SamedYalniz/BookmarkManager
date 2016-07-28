feature 'Sign up' do
  before do
    visit '/users'
    fill_in 'First Name:', with: 'Mannie'
    fill_in 'Last Name:', with: 'Mannie'
    fill_in 'Email:', with: 'mannie@mannie.com'
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
    expect(User.first.email).to eq 'mannie@mannie.com'
  end

  scenario 'user enters different password in password confirmation' do
    fill_in 'Confirm Password:', with: 'Password122'
    click_button('Signup')
    expect(User.count).to eq 0
    expect(current_path).to eq '/users'
    expect(page).to have_content("Password does not match the confirmation")
    email = find_field("Email").value
    expect(email).to eq "mannie@mannie.com"
  end

  scenario 'user does not enter an email address' do
    fill_in 'Email', with: nil
    fill_in 'Confirm Password:', with: 'Password123'
    click_button('Signup')
    expect(User.count).to eq 0
  end

  scenario 'user enters an invalid/incomplete email address' do
    fill_in 'Email', with: 'mannie.com'
    fill_in 'Confirm Password:', with: 'Password123'
    click_button('Signup')
    expect(User.count).to eq 0

  end

  scenario 'user cannot sign up with already registered email address' do
    fill_in 'Confirm Password:', with: 'Password123'
    click_button("Signup")
    visit '/users'
    fill_in 'First Name:', with: 'Mannie'
    fill_in 'Last Name:', with: 'Mannie'
    fill_in 'Email:', with: 'mannie@mannie.com'
    fill_in 'Password:', with: 'Password123'
    fill_in 'Confirm Password:', with: 'Password123'
    click_button("Signup")
    expect(User.count).to eq 1
    expect(page).to have_content("Email is already taken")
  end
end
