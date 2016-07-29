feature 'sign in' do
  scenario 'user can sign in' do
    User.create(email: "s.yalniz@hotmail.de", password: "password123", password_confirmation: "password123")
    visit '/users'
    fill_in 'email', with: 's.yalniz@hotmail.de'
    fill_in 'password', with: "password123"
    click_button "Sign in"
    require 'pry'; binding.pry
    expect(page).to have_content("Welcome s.yalniz@hotmail.de")
  end
end
