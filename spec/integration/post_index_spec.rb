require './spec/rails_helper'

RSpec.feature 'Blogify app -', type: :system do
  describe 'Post Index Page' do
    let!(:user) do
      User.create(
        name: 'Test user',
        photo: 'https://randomuser.me/api/portraits/men/1.jpg',
        bio: 'Bio for test user',
        posts_counter: 0
      )
    end

    let!(:post) do
      user.posts.create(
        title: 'Test Post',
        text: 'This is the text of the test post',
        comments_counter: 2,
        likes_counter: 5
      )
    end

    scenario "I can see the user's profile picture" do
      visit user_posts_path(user)
      expect(page).to have_selector("img[src*='#{user.photo}']")
    end

    scenario "I can see the user's username" do
      visit user_posts_path(user)
      expect(page).to have_content(user.name)
    end

    scenario "I can see the number of posts the user has written" do
      visit user_posts_path(user)
      expect(page).to have_content("Number of Posts: #{user.posts_counter}")
    end

    scenario "I can see a post's title" do
      visit user_posts_path(user)
      expect(page).to have_content(post.title)
    end

    scenario "I can see some of the post's text" do
      visit user_posts_path(user)
      expect(page).to have_content(post.text)
    end

    scenario "I can see the first comments on a post" do
      comment1 = post.comments.create(text: 'Text of Post 1', author: user)
      comment2 = post.comments.create(text: 'Text of Post 2', author: user)
      comment3 = post.comments.create(text: 'Text of Post 3', author: user)
      
      visit user_posts_path(user)
      sleep(1)

      expect(page).to have_content(comment1.text)
      expect(page).to have_content(comment2.text)
      expect(page).to have_content(comment3.text)    end

    scenario "I can see how many comments a post has" do
      visit user_posts_path(user)
      expect(page).to have_content("Comments: #{post.comments_counter}")
    end

    scenario "I can see how many likes a post has" do
      visit user_posts_path(user)
      expect(page).to have_content("Likes: #{post.likes_counter}")
    end

    scenario "I can see a section for pagination if there are more posts than fit on the view" do
      visit user_posts_path(user)
      expect(page).to have_selector('.pagination-button')
    end

    scenario "When I click on a post, it redirects me to that post's show page" do
      visit user_posts_path(user)
      click_link(post.title)
      sleep(1)
      expect(current_path).to eq(user_post_path(user, post))
    end
  end
end
