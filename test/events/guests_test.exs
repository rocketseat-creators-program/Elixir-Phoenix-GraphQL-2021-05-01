defmodule Events.GuestsTest do
  use Events.DataCase

  alias Events.Guests

  describe "guests" do
    alias Events.Guests.Guest

    @valid_attrs %{
      birth_date: ~N[2010-04-17 14:00:00],
      email: "some email",
      guests: "some guests",
      name: "some name"
    }
    @update_attrs %{
      birth_date: ~N[2011-05-18 15:01:01],
      email: "some updated email",
      guests: "some updated guests",
      name: "some updated name"
    }
    @invalid_attrs %{birth_date: nil, email: nil, guests: nil, name: nil}

    def guest_fixture(attrs \\ %{}) do
      {:ok, guest} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Guests.create_guest()

      guest
    end

    test "list_guests/0 returns all guests" do
      guest = guest_fixture()
      assert Guests.list_guests() == [guest]
    end

    test "get_guest!/1 returns the guest with given id" do
      guest = guest_fixture()
      assert Guests.get_guest!(guest.id) == guest
    end

    test "create_guest/1 with valid data creates a guest" do
      
    end

    test "create_guest/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Guests.create_guest(@invalid_attrs)
    end

    test "update_guest/2 with valid data updates the guest" do
      guest = guest_fixture()
      assert {:ok, %Guest{} = guest} = Guests.update_guest(guest, @update_attrs)
      assert guest.birth_date == ~N[2011-05-18 15:01:01]
      assert guest.email == "some updated email"
      assert guest.guests == "some updated guests"
      assert guest.name == "some updated name"
    end

    test "update_guest/2 with invalid data returns error changeset" do
      guest = guest_fixture()
      assert {:error, %Ecto.Changeset{}} = Guests.update_guest(guest, @invalid_attrs)
      assert guest == Guests.get_guest!(guest.id)
    end

    test "delete_guest/1 deletes the guest" do
      guest = guest_fixture()
      assert {:ok, %Guest{}} = Guests.delete_guest(guest)
      assert_raise Ecto.NoResultsError, fn -> Guests.get_guest!(guest.id) end
    end

    test "change_guest/1 returns a guest changeset" do
      guest = guest_fixture()
      assert %Ecto.Changeset{} = Guests.change_guest(guest)
    end
  end
end
