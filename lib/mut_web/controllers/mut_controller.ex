defmodule MutWeb.MutController do
  use MutWeb, :controller

  @tick 100

  def new(conn, %{"code" => code}) do
    Mut.State.start(code)
    resp(conn, 201, "")
  end

  def update(conn, %{"code" => code, "num" => num, "val" => val}) do
    Mut.State.put({:via, Registry, {Mut.Registry, code}}, num, val)
    resp(conn, 201, "")
  rescue
    _ -> resp(conn, 400, "")
  end

  def show(conn, %{"code" => code, "num" => num}) do
    :timer.sleep(@tick - rem(:os.system_time(:millisecond), @tick))
    state = Mut.State.get({:via, Registry, {Mut.Registry, code}}, num)

    IO.inspect(:os.system_time(:millisecond), label: "Response: ")
    resp(conn, 200, state)
  rescue
    _ -> resp(conn, 400, "")
  end
end
