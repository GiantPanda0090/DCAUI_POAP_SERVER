#!/usr/bin/python

import os
from cli import *
import re
import logging
import sys
import json


def main():
    logging_setup()
    version_json = json.loads(clid("show version"))
    sn = version_json['proc_board_id']
    args = sys.argv
    config_stream = config_retr(args[1],args[2],sn)
    configuring(config_stream)
    logging.info("Session End")

        
def config_retr(server_ip,port,sn):
    stream = os.popen('curl '+ server_ip +':'+ port +'/conf.'+sn)
    output = stream.read()
    config_stream = re.sub(r'\n  ', ' ; ', output)
    return config_stream

def configuring(config_stream):
    config = 'configure terminal ; '
    config_lst = re.split('\n\n|\n',config_stream)
    for lines in config_lst:
        logging.info('Configuring: '+lines)
        logging.debug('Output: '+ str(cli(config + lines)))
        
def logging_setup():
    root = logging.getLogger()
    root.setLevel(logging.DEBUG)

    handler = logging.StreamHandler(sys.stdout)
    handler.setLevel(logging.DEBUG)
    formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
    handler.setFormatter(formatter)
    root.addHandler(handler)
        
if __name__ == '__main__':
    main()