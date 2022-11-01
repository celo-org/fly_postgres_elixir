defmodule Fly.RemoteRepo do
  @moduledoc """
  As Fly.Repo but invokes everything on the primary region.
  """

  defmacro __using__(opts) do
    quote bind_quoted: [opts: opts] do
      @local_repo Keyword.fetch!(opts, :local_repo)
      @timeout Keyword.get(opts, :timeout, 5_000)
      @replication_timeout Keyword.get(opts, :replication_timeout, 5_000)

      @doc """
      See `Ecto.Repo.config/0` for full documentation.
      """
      @spec config() :: Keyword.t()
      def config do
        @local_repo.config()
      end

      @doc """
      Calculate the given `aggregate`.

      See `Ecto.Repo.aggregate/3` for full documentation.
      """
      def aggregate(queryable, aggregate, opts \\ []) do
        unquote(__MODULE__).__exec_on_primary__(:aggregate, [queryable, aggregate, opts], opts)
      end

      @doc """
      Calculate the given `aggregate` over the given `field`.

      See `Ecto.Repo.aggregate/4` for full documentation.
      """
      def aggregate(queryable, aggregate, field, opts) do
        unquote(__MODULE__).__exec_on_primary__(:aggregate, [queryable, aggregate, field, opts], opts)
      end

      @doc """
      Fetches all entries from the data store matching the given query.

      See `Ecto.Repo.all/2` for full documentation.
      """
      def all(queryable, opts \\ []) do
        unquote(__MODULE__).__exec_on_primary__(:all, [queryable, opts], opts)
      end

      @doc """
      Deletes a struct using its primary key.

      See `Ecto.Repo.delete/2` for full documentation.
      """
      def delete(struct_or_changeset, opts \\ []) do
        unquote(__MODULE__).__exec_on_primary__(:delete, [struct_or_changeset, opts], opts)
      end

      @doc """
      Same as `delete/2` but returns the struct or raises if the changeset is invalid.

      See `Ecto.Repo.delete!/2` for full documentation.
      """
      def delete!(struct_or_changeset, opts \\ []) do
        unquote(__MODULE__).__exec_on_primary__(:delete!, [struct_or_changeset, opts], opts)
      end

      @doc """
      Deletes all entries matching the given query.

      See `Ecto.Repo.delete_all/2` for full documentation.
      """
      def delete_all(queryable, opts \\ []) do
        unquote(__MODULE__).__exec_on_primary__(:delete_all, [queryable, opts], opts)
      end

      @doc """
      Checks if there exists an entry that matches the given query.

      See `Ecto.Repo.exists?/2` for full documentation.
      """
      def exists?(queryable, opts \\ []) do
        unquote(__MODULE__).__exec_on_primary__(:exists?, [queryable, opts], opts)
      end

      @doc """
      Fetches a single struct from the data store where the primary key matches the given id.

      See `Ecto.Repo.get/3` for full documentation.
      """
      def get(queryable, id, opts \\ []) do
        unquote(__MODULE__).__exec_on_primary__(:get, [queryable, id, opts], opts)
      end

      @doc """
      Similar to `get/3` but raises `Ecto.NoResultsError` if no record was found.

      See `Ecto.Repo.get!/3` for full documentation.
      """
      def get!(queryable, id, opts \\ []) do
        unquote(__MODULE__).__exec_on_primary__(:get!, [queryable, id, opts], opts)
      end

      @doc """
      Fetches a single result from the query.

      See `Ecto.Repo.get_by/3` for full documentation.
      """
      def get_by(queryable, clauses, opts \\ []) do
        unquote(__MODULE__).__exec_on_primary__(:get_by, [queryable, clauses, opts], opts)
      end

      @doc """
      Similar to `get_by/3` but raises `Ecto.NoResultsError` if no record was found.

      See `Ecto.Repo.get_by!/3` for full documentation.
      """
      def get_by!(queryable, clauses, opts \\ []) do
        unquote(__MODULE__).__exec_on_primary__(:get_by!, [queryable, clauses, opts], opts)
      end

      @doc """
      Returns the atom name or pid of the current repository.

      See `Ecto.Repo.get_dynamic_repo/0` for full documentation.
      """
      @spec get_dynamic_repo() :: Keyword.t()
      def get_dynamic_repo do
        @local_repo.get_dynamic_repo()
      end

      @doc """
      Inserts a struct defined via Ecto.Schema or a changeset.

      See `Ecto.Repo.insert/2` for full documentation.
      """
      def insert(struct_or_changeset, opts \\ []) do
        unquote(__MODULE__).__exec_on_primary__(:insert, [struct_or_changeset, opts], opts)
      end

      @doc """
      Same as `insert/2` but returns the struct or raises if the changeset is invalid.

      See `Ecto.Repo.insert!/2` for full documentation.
      """
      def insert!(struct_or_changeset, opts \\ []) do
        unquote(__MODULE__).__exec_on_primary__(:insert!, [struct_or_changeset, opts], opts)
      end

      @doc """
      Inserts all entries into the repository.

      See `Ecto.Repo.insert_all/3` for full documentation.
      """
      def insert_all(schema_or_source, entries_or_query, opts \\ []) do
        unquote(__MODULE__).__exec_on_primary__(
          :insert_all,
          [
            schema_or_source,
            entries_or_query,
            opts
          ],
          opts
        )
      end

      @doc """
      Inserts or updates a changeset depending on whether the struct is persisted or not

      See `Ecto.Repo.insert_or_update/2` for full documentation.
      """
      def insert_or_update(changeset, opts \\ []) do
        unquote(__MODULE__).__exec_on_primary__(:insert_or_update, [changeset, opts], opts)
      end

      @doc """
      Same as `insert_or_update!/2` but returns the struct or raises if the changeset is invalid.

      See `Ecto.Repo.insert_or_update!/2` for full documentation.
      """
      def insert_or_update!(changeset, opts \\ []) do
        unquote(__MODULE__).__exec_on_primary__(:insert_or_update!, [changeset, opts], opts)
      end

      @doc """
      Loads data into a schema or a map.

      See `Ecto.Repo.load/2` for full documentation.
      """
      def load(schema_or_map, data) do
        unquote(__MODULE__).__exec_local__(:load, [schema_or_map, data])
      end

      @doc """
      Fetches a single result from the query.

      See `Ecto.Repo.one/2` for full documentation.
      """
      def one(queryable, opts \\ []) do
        unquote(__MODULE__).__exec_on_primary__(:one, [queryable, opts], opts)
      end

      @doc """
      Similar to a `one/2` but raises Ecto.NoResultsError if no record was found.

      See `Ecto.Repo.one!/2` for full documentation.
      """
      def one!(queryable, opts \\ []) do
        unquote(__MODULE__).__exec_on_primary__(:one!, [queryable, opts], opts)
      end

      @doc """
      Preloads all associations on the given struct or structs.

      See `Ecto.Repo.preload/3` for full documentation.
      """
      def preload(structs_or_struct_or_nil, preloads, opts \\ []) do
        unquote(__MODULE__).__exec_on_primary__(:preload, [
          structs_or_struct_or_nil,
          preloads,
          opts
        ], opts)
      end

      @doc """
      A user customizable callback invoked for query-based operations.

      See `Ecto.Repo.preload/3` for full documentation.
      """
      def prepare_query(operation, query, opts \\ []) do
        unquote(__MODULE__).__exec_on_primary__(:prepare_query, [operation, query, opts], opts)
      end

      @doc """
      Sets the dynamic repository to be used in further interactions.

      See `Ecto.Repo.put_dynamic_repo/1` for full documentation.
      """
      def put_dynamic_repo(name_or_pid) do
        unquote(__MODULE__).__exec_on_primary__(:put_dynamic_repo, [name_or_pid], [])
      end

      @doc """
      The same as `query`, but raises on invalid queries.

      See `Ecto.Adapters.SQL.query/4` for full documentation.
      """
      def query(query, params \\ [], opts \\ []) do
        unquote(__MODULE__).__exec_on_primary__(:query, [query, params, opts], opts)
      end

      @doc """
      Run a custom SQL query.

      See `Ecto.Adapters.SQL.query!/4` for full documentation.
      """
      def query!(query, params \\ [], opts \\ []) do
        unquote(__MODULE__).__exec_on_primary__(:query!, [query, params, opts], opts)
      end

      @doc """
      Reloads a given schema or schema list from the database.

      See `Ecto.Repo.reload/2` for full documentation.
      """
      def reload(struct_or_structs, opts \\ []) do
        unquote(__MODULE__).__exec_on_primary__(:reload, [struct_or_structs, opts], opts)
      end

      @doc """
      Similar to `reload/2`, but raises when something is not found.

      See `Ecto.Repo.reload!/2` for full documentation.
      """
      def reload!(struct_or_structs, opts \\ []) do
        unquote(__MODULE__).__exec_on_primary__(:reload!, [struct_or_structs, opts], opts)
      end

      @doc """
      Rolls back the current transaction.

      Defaults to the primary database repo. Assumes the transaction was used for
      data modification.

      See `Ecto.Repo.rollback/1` for full documentation.
      """
      def rollback(value) do
        unquote(__MODULE__).__exec_on_primary__(:rollback, [value], [])
      end

      @doc """
      Returns a lazy enumerable that emits all entries from the data store matching the given query.

      See `Ecto.Repo.stream/2` for full documentation.
      """
      def stream(queryable, opts \\ []) do
        unquote(__MODULE__).__exec_on_primary__(:stream, [queryable, opts], opts)
      end

      @doc """
      Runs the given function or Ecto.Multi inside a transaction.

      This defaults to the primary (writable) repo as it is assumed this is being
      used for data modification. Override to operate on the replica.

      See `Ecto.Repo.transaction/2` for full documentation.
      """
      def transaction(fun_or_multi, opts \\ []) do
        unquote(__MODULE__).__exec_on_primary__(:transaction, [fun_or_multi, opts], opts)
      end

      @doc """
      Updates a changeset using its primary key.

      See `Ecto.Repo.update/2` for full documentation.
      """
      def update(changeset, opts \\ []) do
        unquote(__MODULE__).__exec_on_primary__(:update, [changeset, opts], opts)
      end

      @doc """
      Same as `update/2` but returns the struct or raises if the changeset is invalid.

      See `Ecto.Repo.update!/2` for full documentation.
      """
      def update!(changeset, opts \\ []) do
        unquote(__MODULE__).__exec_on_primary__(:update!, [changeset, opts], opts)
      end

      @doc """
      Updates all entries matching the given query with the given values.

      See `Ecto.Repo.update_all/3` for full documentation.
      """
      def update_all(queryable, updates, opts \\ []) do
        unquote(__MODULE__).__exec_on_primary__(:update_all, [queryable, updates, opts], opts)
      end

      def __exec_local__(func, args) do
        :telemetry.execute([:fly_postgres, :local_exec], %{}, %{func: func |> to_string()})

        apply(@local_repo, func, args)
      end

      def __exec_on_primary__(func, args, opts) do
        :telemetry.execute([:fly_postgres, :primary_exec], %{}, %{func: func |> to_string()})

        # Default behavior is to wait for replication. If `:await` is set to
        # false/falsey then skip the LSN query and waiting for replication.
        if Keyword.get(opts, :await, true) do
          rpc_timeout = Keyword.get(opts, :rpc_timeout, @timeout)
          replication_timeout = Keyword.get(opts, :replication_timeout, @replication_timeout)

          Fly.Postgres.rpc_and_wait(@local_repo, func, args,
            rpc_timeout: rpc_timeout,
            replication_timeout: replication_timeout,
            tracker: Keyword.get(opts, :tracker)
          )
        else
          Fly.rpc_primary(@local_repo, func, args, timeout: @timeout)
        end
      end
    end
  end
end
