feature 'Add multiple tags' do
  scenario 'add tags to the links in my bookmark manager' do
    visit('/links/new')
    fill_in 'url', with: 'http://www.makersacademy.com'
    fill_in 'title', with: 'Makers Academy'
    fill_in 'tags', with: 'education coding'

    click_button 'Create link'
    link = Link.first
    expect(link.tags.map(&:name).join(' ')).to include('education coding')
  end
end
