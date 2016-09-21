defmodule Rumbl.VideoControllerTest do
  use Rumbl.ConnCase
  alias Rumbl.Video
  @valid_attrs %{url: "http://youtube.be", title: "the title", description: "a nice description"}
  @invalid_attrs %{title: "invalid title"}

  setup %{conn: conn} = config do
    if username = config[:login_as] do
      user = insert_user(username: username)
      conn = assign(conn, :current_user, user)
      {:ok, conn: conn, user: user}
    else
      :ok
    end
  end

  test "requires user authenticated on all actions", %{conn: conn} do
    Enum.each([
      get(conn, video_path(conn, :new)),
      get(conn, video_path(conn, :index)),
      get(conn, video_path(conn, :show, "123")),
      get(conn, video_path(conn, :edit, "123")),
      get(conn, video_path(conn, :update, "123", %{})),
      get(conn, video_path(conn, :create, %{})),
      get(conn, video_path(conn, :delete, "123"))
      ], fn conn ->
        assert html_response(conn, 302)
        assert conn.halted
      end)
  end

  @tag login_as: "max"
  test "authorizes actions against access by other users", %{conn: conn, user: owner} do
    video = insert_video(owner, @valid_attrs)
    non_owner = insert_user(username: "bad man")
    conn = assign(conn, :current_user, non_owner)

    assert_error_sent :not_found, fn ->
      get(conn, video_path(conn, :show, video))
    end
    assert_error_sent :not_found, fn ->
      get(conn, video_path(conn, :edit, video))
    end
    assert_error_sent :not_found, fn ->
      get(conn, video_path(conn, :update, video, video: @valid_attrs))
    end
    assert_error_sent :not_found, fn ->
      get(conn, video_path(conn, :delete, video))
    end
  end

  @tag login_as: "max"
  test "lists all user's videos on index", %{conn: conn, user: user} do
    user_video = insert_video(user, title: "first one")
    other_video = insert_video(insert_user(username: "other user"), title: "second one")

    conn = get conn, video_path(conn, :index)
    assert html_response(conn, 200) =~ ~r/Listing videos/
    assert String.contains?(conn.resp_body, user_video.title)
    refute String.contains?(conn.resp_body, other_video.title)
  end

  defp video_count(query) do
      Repo.one(from v in query, select: count(v.id))
  end

  @tag login_as: "max"
  test "creates user video and redirects", %{conn: conn, user: user} do
    conn = post conn, video_path(conn, :create), video: @valid_attrs
    assert redirected_to(conn) == video_path(conn, :index)
    assert Repo.get_by!(Video, @valid_attrs).user_id == user.id
  end

  @tag login_as: "max"
  test "does not create video and renders errors when invalid", %{conn: conn} do
    count_before = video_count(Video)
    conn = post conn, video_path(conn, :create), video: @invalid_attrs
    assert html_response(conn, 200) =~ "check the errors"
    assert video_count(Video) == count_before
  end

  @tag login_as: "max"
  test "does not craete a video and renders errors when invalid", %{conn: conn, user: user} do
    count_before = video_count(Video)
    conn = post conn, video_path(conn, :create), video: @invalid_attrs
    assert video_count(Video) == count_before
    assert html_response(conn, 200) =~ "check the errors"
  end

  @tag login_as: "max"
  test "edits shows video edit page", %{conn: conn, user: user} do
    video = insert_video(user, @valid_attrs)
    conn = get conn, video_path(conn, :edit, video)
    assert html_response(conn, :ok) =~ ~r/Edit video.*#{video.title}/s
  end

  @tag login_as: "max"
  test "updates existing video and redirects", %{conn: conn, user: user} do
    video = insert_video(user, @valid_attrs)
    conn = put conn, video_path(conn, :update, video), video: %{title: "New"}
    assert html_response(conn, 302)
    assert Repo.get(Video, video.id).title == "New"
  end

  @tag login_as: "max"
  test "does not update invalid video", %{conn: conn, user: user} do
    video = insert_video(user, @valid_attrs)
    conn = put conn, video_path(conn, :update, video), video: %{title: ""}
    assert html_response(conn, 200) =~ "check the errors"
    assert Repo.get(Video, video.id).title == video.title
  end

  @tag login_as: "max"
  test "deletes existing video", %{conn: conn, user: user} do
    video = insert_video(user, @valid_attrs)
    conn = delete conn, video_path(conn, :delete, video)
    assert html_response(conn, 302)
    refute Repo.get(Video, video.id)
  end

end
