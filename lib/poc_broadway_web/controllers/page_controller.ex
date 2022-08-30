defmodule PocBroadwayWeb.PageController do
  use PocBroadwayWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def create(conn, params) do
    {:ok, connection} = AMQP.Connection.open
    {:ok, channel} = AMQP.Channel.open(connection)

    AMQP.Queue.declare(channel, "poc_broadway", durable: true)
    AMQP.Basic.publish(channel, "", "poc_broadway", Jason.encode!(params))
    AMQP.Connection.close(connection)

    render(conn, "index.html")
  end
end
