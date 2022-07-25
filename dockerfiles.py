#!/usr/bin/python

from jinja2 import Template,Environment,FileSystemLoader
import os
import sys, getopt

def main(argv):
   image_version = ''
   outputfile = ''
   try:
      opts, args = getopt.getopt(argv,"hi:o:",["iversion="])
   except getopt.GetoptError:
      print('dockerfiles.py --iversion <image_version>')
      sys.exit(2)
   for opt, arg in opts:
      if opt == '-h':
         print('dockerfiles.py --iversion <image_version>')
         sys.exit()
      elif opt in ("-v", "--iversion"):
         image_version = arg
   print('Image version is', image_version)

   THIS_DIR = os.path.dirname(os.path.abspath(__file__))
   j2_env = Environment(loader=FileSystemLoader(THIS_DIR), trim_blocks=True)

   debian_sdk_version='6.0.302-bullseye-slim-amd64'
   alpine_sdk_version='6.0.302-alpine3.16-amd64'
   template_file="image/Dockerfile.j2"
   with open("image/Dockerfile.debian", "w") as text_file:
       text_file.write(j2_env.get_template(template_file).render(
           base_tag=debian_sdk_version,
           enable_mono=False,
           os_family='debian',
           os_dist='bullseye'))

   with open("image/Dockerfile.alpine", "w") as text_file:
       text_file.write(j2_env.get_template(template_file).render(
           base_tag=alpine_sdk_version,
           enable_mono=False,
           os_family='alpine',
           os_dist='alpine3.16'))

if __name__ == "__main__":
   main(sys.argv[1:])
