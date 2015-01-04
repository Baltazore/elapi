defmodule Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def up do
    "CREATE TABLE users(id serial primary key, name varchar(40))"
  end

  def down do
    "DROP TABLE users"
  end
end
