defmodule SLSKX.RepoTest do
  use SLSKX.DataCase, async: false

  describe "supervision" do
    test "Repo is running under the application supervisor" do
      assert Process.whereis(SLSKX.Repo) != nil
    end
  end

  describe "database connectivity" do
    test "Repo can perform a trivial query" do
      assert {:ok, _result} = Repo.query("SELECT 1")
    end
  end
end
