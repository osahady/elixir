defmodule HttpServer do
  @port 8000
  @http_options [active: false, packet: :http_bin, reuseaddr: true]

  def init() do
    :gen_tcp.listen(@port, @http_options)
  end
end
