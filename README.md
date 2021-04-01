# DCAUI_POAP_SERVER  
Practice POAP Server for Cisco Automating Data Center Solutions. Inspired by Cisco DCAUTI CDLL Training.  
The Original code from Cisco CDLL is written in Python. Since Elixir are more efficient at message passing and multithreading, theoretically Elixir should be more suitable for POAP Server.  
The purpose of this code base is to test the difference when running the POAP server in Python and Elixir.     
The code is based on Elixir Pheonix.  
  
## External Resource
Nexus POAP Script From Cisco  
The POAP script can be found at  
 https://github.com/datacenter/nexus9000/blob/master/nx-os/poap/poap.py.  

Cisco Nexus 9000 Series NX-OS Fundamentals Configuration Guide, Release 7.x  
https://www.cisco.com/c/en/us/td/docs/switches/datacenter/nexus9000/sw/7-x/fundamentals/configuration/guide/b_Cisco_Nexus_9000_Series_NX-OS_Fundamentals_Configuration_Guide_7x/b_Cisco_Nexus_9000_Series_NX-OS_Fundamentals_Configuration_Guide_7x_chapter_0100.html  


## Test Bed
The POAP Script is run with the following option:  
```
options = {  
   "username": "tftp",  
   "password": "x",  
   "hostname": "192.168.46.130:4000",  
   "transfer_protocol": "http",  
   "mode": "serial_number",  
   "target_system_image": "nxos.7.0.3.I7.9.bin",  
   "disable_md5": False,  
   "use_nxos_boot": True,  
   "bypass_bios": True <<< customized parameter    
}
```
The poap script that used for testing can be found in the "test_poap_script" folder.

Suggest to test the library with Cisco Devnet Sandbox:  

NXOS:  
https://devnetsandbox.cisco.com/RM/Diagram/Index/0e22761d-f813-415d-a557-24fa0e17ab50?diagramType=Topology  

OR

With Nexus9000v.   
Sample testbed connectivity
```
Nexus 9000v <-> Ubuntu9000 (serial connection: minicom ttyS1, Management: Virtual Network Mgmt,  Data: Virtual Network Data)
```

## Sample output for HTTP Config pull
```  
$ wget http://localhost:4000/conf.9EZ8IGDBM5S  
--2021-04-01 21:42:45--  http://localhost:4000/conf.9EZ8IGDBM5S  
Resolving localhost (localhost)... 127.0.0.1  
Connecting to localhost (localhost)|127.0.0.1|:4000... connected.  
HTTP request sent, awaiting response... 200 OK  
Length: 2160 (2.1K) [application/octet-stream]  
Saving to: ‘conf.9EZ8IGDBM5S.1’  
  
conf.9EZ8IGDBM5S.1                           100%[===========================================================================================>]   2.11K  --.-KB/s      in   0.001s    

2021-04-01 21:42:47 (2.65 MB/s) - ‘conf.9EZ8IGDBM5S.1’ saved [2160/2160]  
```

## Main Repositiory
https://github.com/GiantPanda0090/DCAUI_ToolSet

## Installation Method
To start your Phoenix server:  

  * Install dependencies with `mix deps.get`  
  * Install Node.js dependencies with `npm install` inside the `assets` directory  
  * Start Phoenix endpoint with `mix phx.server`  

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.  

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).  

 
## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
