defmodule Dispatcher do
  use Plug.Router

  def start(_argv) do
    port = 80
    IO.puts "Starting Plug with Cowboy on port #{port}"
    Plug.Adapters.Cowboy.http __MODULE__, [], port: port
    :timer.sleep(:infinity)
  end

  plug Plug.Logger
  plug :match
  plug :dispatch

  # In order to forward the 'themes' resource to the
  # resource service, use the following forward rule.
  #
  # docker-compose stop; docker-compose rm; docker-compose up
  # after altering this file.
  #
  # match "/themes/*path" do
  #   Proxy.forward conn, path, "http://resource/themes/"
  # end

  match "/tracking-sessions/*path" do
    Proxy.forward conn, path, "http://resource/tracking-sessions/"
  end

  match "/anchors-configurations/*path" do
    Proxy.forward conn, path, "http://resource/anchors-configurations/"
  end

  match "/deployed-anchors/*path" do
    Proxy.forward conn, path, "http://resource/deployed-anchors/"
  end

  match "/points-coordinates/*path" do
    Proxy.forward conn, path, "http://resource/points-coordinates/"
  end

  match "/raw-trackings-data/*path" do
    Proxy.forward conn, path, "http://datakart-raw-tracking-data-service/raw-trackings-data/"
  end

  match _ do
    send_resp( conn, 404, "Route not found.  See config/dispatcher.ex" )
  end

end
