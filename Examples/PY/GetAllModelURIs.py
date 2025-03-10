# Import Required Modules
from bs4 import BeautifulSoup
import requests

# Converted Modules
import os
import time
from datetime import datetime
import subprocess

# Base Sitemap URI
url = "https://chaturbate.com/sitemap.xml"

# Read Sitemap Contents
xml = requests.get(url)
soup = BeautifulSoup(xml.content, 'xml')

# Parse broadcasters
xml_tags = soup.find_all('loc')

tags = []

for tag in xml_tags:
    tags.append(tag.text)

# Isolate Broacaster Maps
substring = "broadcasters"

broadcasters = [item for item in tags if substring in item]

for stuff in broadcasters:
    print(stuff)

# Parse Model URIs and store in an array
modelURIs = []

for broadcaster in broadcasters:
    xml = requests.get(broadcaster)
    soup = BeautifulSoup(xml.content, 'xml')

    xml_tags = soup.find_all('loc')

    for tag in xml_tags:
        modelURIs.append(tag.text)


print(modelURIs)