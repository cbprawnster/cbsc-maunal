# Chaturbate Stream Recorder
> [!NOTE]
> ~~It appears Chaturbate has rectified this design flaw after publicly releasing this repository. The repository will archived and remain available for historical purposes. Only took half a decade to get them to fix it by publicly shaming them, but it's done.~~
> Their "Fix" was apparently only temporary. This method is still **FULLY** available. Repo unarchived. Have fun... This has been reported to Chaturbate. Again...

> [!NOTE]
> This repository exists for educational purposes only. **NO SUPPORT**

> [!CAUTION]
> Should you choose to utilize this code, it is _**HIGHLY**_ recommended to use a VPN service to mask your IP traffic.

## Ass Covering
Models, you need to know that this method is being investigated. I don't know what will happen. This is the most recent report (not the first):
https://hackerone.com/reports/3037437

![Capture2](https://github.com/user-attachments/assets/cc77be91-62bc-46ca-a245-8628b6969ddf)


## Summary
This repository highlights a significant design flaw in Chaturbate.com. Model streams are easily captured programmatically in bulk. Reports on this flaw have gone completely ignored. From the standpoint of re-distribution of model streams, this is highly problematic from a monetization standpoint.

There is an additonal consideration that Chaturbate.com has ignored from a business perspective. This method _could_ result in a DDoS botnet attack which _could_ have a monetary impact for both the Chaturbate.com and their models.

This method only applies to public streams and does not apply to private/ticket shows.

For context, based on investigation, this method does not apply to other major streaming sites whether adult or gaming in nature.

This information is important for models to understand when choosing which platforms to stream on.

This repository exists as an example of a "personal usage" method. It should be known that this is easily scalable to capture every online stream simultaneously for re-distribution or as a DDoS attack capturing every online stream simultaneously many times over with no storage required.

## General System Requirements
* x64 Windows PC or Virtual Machine
* Windows 10 or newer
* Administrative privileges on the machine
* Dual core or better CPU (more required depending on the number of concurrent streams)
* 8 GB of RAM minimum (more required depending on the number of concurrent streams)
* 50 Mbps or greater internet speeds (more required depending on the number of concurrent streams)
* OS and Software drive: 128GB or larger
* Video storage drive: Minimum 1TB recommended (Streams are very large. Expect ~36MB/Min)

## Usage
* Download the zip file of this repository and extract it
* Open an command prompt as administrator and enter ```cd C:\users\<your_user>\downloads\cbsc-manual-main\cbsc-manual-main```
* type `install.bat` and press enter.
* Open a regular command prompt and enter ```cd C:\users\<your_user>\downloads\cbsc-manual-main\cbsc-manual-main```
* type `configure.bat` and press enter.
* With the regular command prompt enter ```cd C:\CBCAP```
* Run ```Configure.bat``` to specify the stream capture output location
* Run ```AddModel.bat``` to add Chaturbate model screen names to the database to record
* Run ```CBSC.bat``` to begin monitoring for a model to come online and start recording the stream

Output is stored in the destination folder you specified with Configure.bat under each model's screen name.

## Install Summary
This section explains what everything does as part of the installation process.

### install.bat
This batch file calls a PowerShell script that downloads and installs the following required software
* SQL Server Express 2022
* 7-Zip
* FFMPEG

### configure.bat
This batch file calls a PowerShell script that performs the following actions
* Unpacks FFMPEG
* Creates the database Schema
* Creates the application directory C:\CBCap
* Copies the necessary files to C:\CBCap

## Operational Summary
This section explains what everything in C:\CBCap does

### Configure.bat
This batch file calls `outputconf.ps1` which prompts for user input to specify the output location for stream captures. This generates the file `Output.conf` in C:\CBCap.

This can be run again to update the output location if necessary.

### AddModel.bat
This batch file calls `modeladder.ps1` which prompts for user input to specify the screen name of a Chaturbate model that the user wishes to record. This then adds a record to the SQL database setting the record flag to true.

### CBSC.bat
This batch file calls `SQLOnlineCheck.ps1` which is the main code used for stream captures. It continuously loops through the model screen names stored in the database to check if they are online. If the model is online it will use FFMPEG to capture the stream and save it to the output directory specified with Configure.bat
