require './spec/rails_helper'

RSpec.feature 'User Index Page', type: :system do
  # Assuming I have this sample users created for testing
  let!(:user1) { User.create(name: 'Test user 1', photo: 'https://randomuser.me/api/portraits/men/1.jpg' , bio: 'Bio for test user', posts_counter: 0) }
  let!(:user2) { User.create(name: 'Test user 2', photo: 'https://randomuser.me/api/portraits/men/2.jpg' , bio: 'Bio for test user', posts_counter: 0) }

  scenario 'I can see the username of all other users' do
    visit users_path
    sleep(2)
    expect(page).to have_content(user1.name)
    expect(page).to have_content(user2.name)
  end

  scenario 'I can see the profile picture for each user' do
    # Assuming I have implemented profile pictures for users
    visit users_path
    expect(page).to have_selector("img[src*='#{user1.photo}']")
    expect(page).to have_selector("img[src*='#{user2.photo}']")
  end

  scenario 'I can see the number of posts each user has written' do
    visit users_path
    expect(page).to have_content("Number of Posts: 0")
    expect(page).to have_content("Number of Posts: 0")
  end

  scenario 'When I click on a user, I am redirected to that user\'s show page' do
    visit users_path
    click_link(user1.name)
    sleep(2)
    expect(current_path).to eq(user_path(user1))
  end
end
