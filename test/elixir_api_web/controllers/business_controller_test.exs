defmodule ElixirApiWeb.BusinessControllerTest do
  use ElixirApiWeb.ConnCase

  alias ElixirApi.Directory
  alias ElixirApi.Directory.Business

  @create_attrs %{
    description: "some description",
    name: "some name",
    tag: "some tag"
  }
  @update_attrs %{
    description: "some updated description",
    name: "some updated name",
    tag: "some updated tag"
  }
  @invalid_attrs %{description: nil, name: nil, tag: nil}

  def fixture(:business) do
    {:ok, business} = Directory.create_business(@create_attrs)
    business
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all businesses", %{conn: conn} do
      conn = get(conn, Routes.business_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create business" do
    test "renders business when data is valid", %{conn: conn} do
      conn = post(conn, Routes.business_path(conn, :create), business: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.business_path(conn, :show, id))

      assert %{
               "id" => id,
               "description" => "some description",
               "name" => "some name",
               "tag" => "some tag"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.business_path(conn, :create), business: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update business" do
    setup [:create_business]

    test "renders business when data is valid", %{conn: conn, business: %Business{id: id} = business} do
      conn = put(conn, Routes.business_path(conn, :update, business), business: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.business_path(conn, :show, id))

      assert %{
               "id" => id,
               "description" => "some updated description",
               "name" => "some updated name",
               "tag" => "some updated tag"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, business: business} do
      conn = put(conn, Routes.business_path(conn, :update, business), business: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete business" do
    setup [:create_business]

    test "deletes chosen business", %{conn: conn, business: business} do
      conn = delete(conn, Routes.business_path(conn, :delete, business))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.business_path(conn, :show, business))
      end
    end
  end

  defp create_business(_) do
    business = fixture(:business)
    {:ok, business: business}
  end
end
