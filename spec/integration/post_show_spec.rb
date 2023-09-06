require './spec/rails_helper'

RSpec.describe 'Post Show Page', type: :system do
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

  scenario "I can see the post's title" do
    visit user_post_path(user, post)
    expect(page).to have_content(post.title)
  end

  scenario 'I can see who wrote the post' do
    visit user_post_path(user, post)
    expect(page).to have_content(user.name)
  end

  scenario 'I can see how many comments it has' do
    visit user_post_path(user, post)
    expect(page).to have_content("Comments: #{post.comments_counter}")
  end

  scenario 'I can see how many likes it has' do
    visit user_post_path(user, post)
    expect(page).to have_content("Likes: #{post.likes_counter}")
  end

  scenario 'I can see the post body' do
    visit user_post_path(user, post)
    expect(page).to have_content(post.text)
  end

  scenario 'I can see the username of each commentor' do
    comment1 = post.comments.create(text: 'Comment 1', author: user)
    comment2 = post.comments.create(text: 'Comment 2', author: user)

    visit user_post_path(user, post)
    sleep(1)

    expect(page).to have_content(comment1.author.name)
    expect(page).to have_content(comment2.author.name)
  end

  scenario 'I can see the comment each commentor left' do
    comment1 = post.comments.create(text: 'Comment 1', author: user)
    comment2 = post.comments.create(text: 'Comment 2', author: user)

    visit user_post_path(user, post)
    sleep(1)

    expect(page).to have_content(comment1.text)
    expect(page).to have_content(comment2.text)
  end
end
