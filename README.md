<img src="https://storage.googleapis.com/golden-wind/experts-club/capa-github.svg" />

## Elixir-Phoenix-GraphQL: criando queries e mutations

Nesta aula vamos aprender como utilizar o graphQL no Elixir. E como essas duas tecnologias se combinam. O estilo funcional do Elixir se encaixa muito natural com GraphQL, tornando o trabalho muito mais simples.

Iremos utilizar a base de dados MySQL. Porém você pode usar o PostgresSQL.

E ao final dessa aula você será capaz de aplicar esses conceitos para analisar e melhorar o desempenho das suas apis.

## Primeiros passos 🏁

Clone o repositório.

```terminal
git clone https://github.com/rocketseat-experts-club/Elixir-Phoenix-GraphQL-2021-05-01.git
```

`cd` no diretório.

```
cd events
```

Configuração Mysql:

config/dev-example.exs altere para config/dev.exs

e adicione username e password da sua base de dados local. 

```config :events, Events.Repo,
  adapter: Ecto.Adapters.MySQL,
  username: "",
  password: "",
  database: "events_dev",
  hostname: "localhost"
  ```

Configuração Postgres:
Remova dentro do: ```config/dev.exs```

`adapter: Ecto.Adapters.MySQL`

e altere no `mix.exs`:

``` defp deps do:
 {:myxql, ">= 0.0.0"},
```
para

``` defp deps do:
 {:postgrex, ">= 0.0.0"},
```

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
