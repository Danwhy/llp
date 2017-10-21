defmodule LlpWeb.PageControllerTest do
  use LlpWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Hello Llp!"
  end
end
