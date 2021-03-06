defmodule AdminAPI.V1.PaginatorSerializerTest do
  use AdminAPI.SerializerCase, :v1
  alias AdminAPI.V1.PaginatorSerializer
  alias EWallet.Web.Paginator

  describe "PaginatorSerializer.to_json/1" do
    test "serializes the given paginator into a list object" do
      paginator = %Paginator{
        data: "dummy_data",
        pagination: %{
          current_page: 2,
          per_page: 5,
          is_first_page: false,
          is_last_page: true
        }
      }

      expected = %{
        object: "list",
        data: "dummy_data",
        pagination: %{
          current_page: 2,
          per_page: 5,
          is_first_page: false,
          is_last_page: true
        }
      }

      assert PaginatorSerializer.to_json(paginator) == expected
    end
  end

  describe "PaginatorSerializer.to_json/2" do
    test "maps the data before serializing into a list object" do
      paginator = %Paginator{
        data: ["dummy", "another_dummy"],
        pagination: %{
          current_page: 2,
          per_page: 5,
          is_first_page: false,
          is_last_page: true
        }
      }

      expected = %{
        object: "list",
        data: ["replaced_data", "replaced_data"],
        pagination: %{
          current_page: 2,
          per_page: 5,
          is_first_page: false,
          is_last_page: true
        }
      }

      result = PaginatorSerializer.to_json(paginator, fn(_) -> "replaced_data" end)
      assert result == expected
    end
  end
end
