# Chaturbate Screen Recorder
> [!NOTE]
> This repository requires a lot of manual configuration and editing of code in order to make it function in your local environment.

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

## Usage
* Download the zip file of this repository and extract it
* Open an command prompt as administrator and enter ```cd C:\users\<your_user>\downloads\cbsc-manual```
* type `install.bat` and press enter.

All pre-requisite software will be installed.

> [!IMPORTANT]
> You must edit `C:\CBCap\SqlOnlineCheck.ps1` to replace all references to "Z:\CBCAP\" with your appropriate destination directory for video.