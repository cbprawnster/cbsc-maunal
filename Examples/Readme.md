# Example Methods
This folder contains examples of ways to further extend the repository

## Writing to NULL
If you wanted to simply consume CB bandwidth in a distributed model, you would implement FFMPEG like so:
`ffmpeg -i https://streamurivariable/playlist.m3u8 -f null -`

## PS - PowerShell
This directory contains additional PowerShell examples

### ModelLoader.ps1
While this script takes a long time to run, it will walk the entire site map and insert every model on Chaturbate into the database and set to record.

### MP4Converter.ps1
This script will interrogate the RecordLog table in the database and look for recordings that have completed and use FFMPEG to convert the MKV stream captures to MP4 format.

## PY - Python
While this repository doesn't cover a Linux/Python implementation. Here are some examples to get you started.

### GetAllModelURIs.py
Walks the site map and passes all model URI's into an array that can be further parsed

### OnlineCheckMethod.py
Demonstrates how to determine whether or not a model is online and then take an action

