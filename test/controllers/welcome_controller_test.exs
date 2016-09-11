defmodule SomeApp.WelcomeControllerTest do
  use SomeApp.ConnCase

  test "shows index", %{conn: conn} do
    conn = get conn, welcome_path(conn, :index)
    assert response(conn, 200)
  end
end
