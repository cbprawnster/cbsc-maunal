# Chaturbate Stream Recorder
> [!NOTE]
> This repository exists for educational purposes only. **NO SUPPORT**

> [!CAUTION]
> Should you choose to utilize this code, it is _**HIGHLY**_ recommended to use a VPN service to mask your IP traffic.

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

