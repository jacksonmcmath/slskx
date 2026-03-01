defmodule SLSKX.EnvConfigTest do
  @moduledoc """
  Verifies that runtime environment configuration is consistent and applied.

  - Ensures .env.example lists the same variables that config/runtime.exs reads for :slskx.
  - Verifies that in test env, runtime config is applied (e.g. default web_password).
  """
  use ExUnit.Case, async: true

  # Must match the variables read in config/runtime.exs for config :slskx
  @expected_env_vars [
    "SOULSEEK_USERNAME",
    "SOULSEEK_PASSWORD",
    "SOULSEEK_SERVER_HOST",
    "SOULSEEK_SERVER_PORT",
    "SLSKX_USERNAME",
    "SLSKX_PASSWORD",
    "SHARED_DIRECTORIES",
    "COMPLETE_DIRECTORY",
    "INCOMPLETE_DIRECTORY"
  ]

  describe ".env.example and runtime.exs stay in sync" do
    test ".env.example contains the variables that runtime.exs reads for :slskx config" do
      path = Path.join(File.cwd!(), ".env.example")
      assert File.exists?(path), ".env.example not found at #{path}"

      content = File.read!(path)

      from_example =
        content
        |> String.split("\n", trim: false)
        |> Enum.reject(&match?("", String.trim(&1)))
        |> Enum.reject(&String.starts_with?(String.trim_leading(&1), "#"))
        |> Enum.filter(&String.contains?(&1, "="))
        |> Enum.map(fn line ->
          line |> String.split("=", parts: 2) |> List.first() |> String.trim()
        end)
        |> Enum.uniq()

      for var <- @expected_env_vars do
        assert var in from_example,
               "Variable #{var} is read in config/runtime.exs but missing from .env.example. " <>
                 "Add it to .env.example to keep them in sync."
      end
    end
  end

  describe "runtime config applied in test" do
    test "slskx application config has runtime-loaded values (defaults in test)" do
      # runtime.exs runs before tests
      assert Application.get_env(:slskx, :web_password) == "slskx"
      assert Application.get_env(:slskx, :soulseek_server_host) in ["soulfind", nil]
      assert Application.get_env(:slskx, :soulseek_server_port) in [2242, nil]
      assert Application.get_env(:slskx, :download_directory) in ["./downloads", nil]
    end
  end
end
