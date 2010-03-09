require File.expand_path(File.dirname(__FILE__) + "/../test_helper")

class Admin::BlogPostsIntegrationTest < ActionController::IntegrationTest
  def test_comes_back_to_index_sorted_by_published_at_after_successful_creation
#  test "comes back to index sorted by published_at after successful creation" do
    user = User.find_or_create_by_username 'soren'
    BlogPost.create! :title => random_word, :user => user
    visit "/admin/blog_posts"
    click_link "Published at"
    click_link "New blog post"
    fill_in "blog_post[title]", :with => 'Funny ha ha'
    select "soren", :from => "blog_post[user_id]"
    click_button 'Create'
    assert_select 'th.asc', :text => 'Published at'
  end
end
