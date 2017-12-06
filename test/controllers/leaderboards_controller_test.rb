require 'test_helper'

class LeaderboardsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @leaderboard = leaderboards(:one)
  end

  test "should get index" do
    get leaderboards_url
    assert_response :success
  end

  test "should get new" do
    get new_leaderboard_url
    assert_response :success
  end

  test "should create leaderboard" do
    assert_difference('Leaderboard.count') do
      post leaderboards_url, params: { leaderboard: { attempted: @leaderboard.attempted, genre: @leaderboard.genre, question: @leaderboard.question, score: @leaderboard.score, subgenre: @leaderboard.subgenre, total_qns: @leaderboard.total_qns, user: @leaderboard.user } }
    end

    assert_redirected_to leaderboard_url(Leaderboard.last)
  end

  test "should show leaderboard" do
    get leaderboard_url(@leaderboard)
    assert_response :success
  end

  test "should get edit" do
    get edit_leaderboard_url(@leaderboard)
    assert_response :success
  end

  test "should update leaderboard" do
    patch leaderboard_url(@leaderboard), params: { leaderboard: { attempted: @leaderboard.attempted, genre: @leaderboard.genre, question: @leaderboard.question, score: @leaderboard.score, subgenre: @leaderboard.subgenre, total_qns: @leaderboard.total_qns, user: @leaderboard.user } }
    assert_redirected_to leaderboard_url(@leaderboard)
  end

  test "should destroy leaderboard" do
    assert_difference('Leaderboard.count', -1) do
      delete leaderboard_url(@leaderboard)
    end

    assert_redirected_to leaderboards_url
  end
end
