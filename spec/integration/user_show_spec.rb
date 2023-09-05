require './spec/rails_helper'

RSpec.feature 'Blogify app -', type: :system do
  describe 'User Show Page' do
    let!(:user) do
      User.create(
        name: 'Test user',
        photo: 'https://randomuser.me/api/portraits/men/1.jpg',
        bio: 'Bio for test user',
        posts_counter: 0
      )
    end

    scenario "I can see the user's profile picture" do
      visit user_path(user)
      expect(page).to have_selector("img[src*='#{user.photo}']")
    end

    scenario "I can see the user's username" do
      visit user_path(user)
      expect(page).to have_content(user.name)
    end

    scenario "I can see the number of posts the user has written" do
      visit user_path(user)
      expect(page).to have_content("Number of Posts: #{user.posts_counter}")
    end

    scenario "I can see the user's bio" do
      visit user_path(user)
      expect(page).to have_content(user.bio)
    end

    scenario "I can see the user's first 3 posts" do
      post1 = user.posts.create(title: 'Post 1', text: 'Text of Post 1', comments_counter: 0, likes_counter: 0)
      post2 = user.posts.create(title: 'Post 2', text: 'Text of Post 2', comments_counter: 0, likes_counter: 0)
      post3 = user.posts.create(title: 'Post 3', text: 'Text of Post 3', comments_counter: 0, likes_counter: 0)
       
      visit user_path(user)     
      expect(page).to have_content(post1.title)
      expect(page).to have_content(post2.title)
      expect(page).to have_content(post3.title)
    end

    scenario "I can see a button that lets me See all of a user's posts" do
      visit user_path(user)
      expect(page).to have_link('See all posts', href: user_posts_path(user))
    end

    scenario "When I click a user's post, it redirects me to that post's show page" do
      post = user.posts.create(title: 'Title post 1', text: 'Text of Post 1', comments_counter: 0, likes_counter: 0)

      visit user_path(user)
      click_link(post.title)
      sleep(1)
      expect(current_path).to eq(user_post_path(user, post))
    end

    scenario "When I click to see all posts, it redirects me to the user's post's index page" do
      visit user_path(user)
      sleep(1)
      click_link('See all posts')
      sleep(1)

      expect(current_path).to eq(user_posts_path(user))
    end
  end
end
