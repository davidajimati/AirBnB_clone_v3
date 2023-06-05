#!/usr/bin/python3
"""This script distributes an archive to web servers, using the function
do_deploy"""
import os
from fabric.api import run, env, cd, put
env.hosts = ['18.207.141.82', '34.227.101.66']
env.user = "ubuntu"


def do_deploy(archive_path):
    """Create a tar gzipped archive of the directory web_static."""
    if os.path.exists(archive_path) is False:
        return False
    else:
        try:
            put(archive_path, "/tmp/")
            """ putting the file to .tgz """
            file_name = archive_path.split("/")[1]
            """ splitting .tgz """
            file_name2 = file_name.split(".")[0]
            """ spliting archive """
            final_name = "/data/web_static/releases/" + file_name2 + "/"
            run("mkdir -p " + final_name)
            run("tar -xzf /tmp/" + file_name + " -C " + final_name)
            run("rm /tmp/" + file_name)
            run("mv " + final_name + "web_static/* " + final_name)
            run("rm -rf " + final_name + "web_static")
            run("rm -rf /data/web_static/current")
            run("ln -s " + final_name + " /data/web_static/current")
            print("New version deployed!")
            return True
        except Exception:
            return False
