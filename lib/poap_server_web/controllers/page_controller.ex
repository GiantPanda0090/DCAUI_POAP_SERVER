defmodule PoapServerWeb.PageController do
  use PoapServerWeb, :controller

  alias List

  ## Not in used
  def index(conn, _params) do
    render(conn, "index.html")
  end

  ## obtain NXOS FW and md5
  def obtain_fw(conn, _params) do
    [version|_] = conn.params["version"]
    out_file = "assets/static/nxos_fw/" <> version
    send_download(conn, {:file, out_file}, filename: version)
  end

  ## obtain onbox streamer
  def obtain_onbox_streamer(conn, _params) do
    out_file = "assets/static/onbox_streamer/onbox_streamer.py"
    send_download(conn, {:file, out_file}, filename: "onbox_streamer.py")
  end


  ## stream config to poap client
  def get_config(conn, _params) do
    #conn = %{params: %{"s_no" => "9BBZDI7FT17"}}
    basedir = "assets/static/"
    [s_no|_] = conn.params["s_no"]
    [_|[s_no|_]]=String.split(s_no, "conf.")
    poap_info = []

    [vars|_] = :yamerl_constr.file(basedir <> "podvars.yml")
    switches = :proplists.get_value('switches', vars)
    pods = :proplists.get_value('pod', vars)

    for switch <- switches do
      s_no_yaml =List.to_string(:proplists.get_value('s_no', switch))
      switch_detail = :proplists.get_value('details', switch)
      if s_no == s_no_yaml do
        switch = [{'default_gw',:proplists.get_value('router', pods)} | switch]
        poap_info = [{'hostname',:proplists.get_value('hostname',switch_detail)} | poap_info ]
        poap_info = [{'router',:proplists.get_value('router', pods)} | poap_info ]
        out_file = "assets/static/config_gen/" <> "conf." <>  s_no <> ".cfg"
        #config templet. use Elixir EEx
        config_file_eex = EEx.eval_file(
          "assets/static/templates/conf_nxv.eex",
          hostname: :proplists.get_value('hostname', :proplists.get_value('details',switch)),
          default_gw: :proplists.get_value('default_gw',switch),
          mgmt0_ip: :proplists.get_value('mgmt0_ip', :proplists.get_value('details',switch))
          )

       case File.write(out_file,config_file_eex) do
        :ok ->
          send_download(conn, {:file, out_file}, filename: "conf." <>  s_no <> ".cfg")
        {:error, error_reason} ->
          IO.inspect(error_reason)
       end

      end

    end

  end

end
