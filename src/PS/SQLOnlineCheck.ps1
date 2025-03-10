# Read Output.conf
$Output = Get-Content "C:\CBCAP\Output.conf"

#This loops indefintely since it doesn't want to run as a scheduled task. Will consider fixing that later if I get motivated enough.
$looper = get-date -format yyyy
while($looper -ne '1979'){
        Clear

        # Connect to database and create a dataset with all of the model information
        $SqlConnection = New-Object System.Data.SqlClient.SqlConnection
        $SqlConnection.ConnectionString = "Server=localhost\SQLEXPRESS;Database=cbscreencap;Integrated Security=True"
        $SqlCmd = New-Object System.Data.SqlClient.SqlCommand
        $SqlCmd.CommandText = "select ScreenName, Online, URL, PID from models where DoRecord = 1 ORDER BY ScreenName"
        $SqlCmd.Connection = $SqlConnection
        $SqlCmd.CommandTimeout = 0
        $SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter
        $SqlAdapter.SelectCommand = $SqlCmd
        $DataSet = New-Object System.Data.DataSet
        $SqlAdapter.Fill($DataSet)
        $SqlConnection.Close()
        # Creates an array of all model ScreenNames
        $ScreenName = $DataSet.Tables[0] | select -ExpandProperty ScreenName
        Clear        
        Write-Host "Chaturbate Stream Recorder"
        write-host ""
        
        foreach ($Model in $ScreenName){
            # If a new model has been added to the database, or this is run fresh,
            # the script will check to make sure there is a place to store the stream data
            $dir = "$Output\$model"
            if(!(Test-Path -Path $dir )){
            New-Item -ItemType directory -Path $dir
            }
            Write-Host "Checking if $Model is online"

            # Do a boolean check to see if a model is online by looking for the stream URL in the page source
            $camhtml = Invoke-WebRequest -Uri chaturbate.com/$Model/ -UseBasicParsing
            $progressPreference = 'silentlyContinue'
            $online = $camhtml.Content.Contains("m3u8")
                    if($online -eq 1){
                        # Query the database to check to see if the DB thinks the model is already online
                        $PIDCheckSQL = "SELECT PID from Models WHERE ScreenName = '$Model';"
                        $PIDCheck = Invoke-Sqlcmd -query $PIDCheckSQL -ConnectionString "Data Source=localhost\SQLEXPRESS;Initial Catalog=CBScreenCap;Integrated Security=True"
                        $PIDNo = $PIDCheck | Select -ExpandProperty PID
                   
                        # Scrape the source of the webpage to find the stream URL
                        $URLStart = $camhtml.Content.IndexOf("https://edge")
                        $URLEnd = $camhtml.Content.IndexOf(".m3u8")

                        $URLLength = $URLEnd - $URLStart
                        $RawURL = $camhtml.Content.Substring($URLStart,($URLLength+5))
                        $CleanURL = $RawURL.Replace("\u002D","-")

                        $CleanURL
                        
                        $StreamURL = $CleanURL
                        
                            # If the database check for the model shows that there is no running PID,
                            # this will start FFMPEG and begin capturing the stream to disk                
                            if($PIDNo -eq ''){
                                #Start FFMPEG Stream Recording

                                $timestamp = get-date -Format yyyy-MM-dd_HHmmss
                                # Starts FFMPEG - If the stream stops, FFMPEG will automatically quit
                                $FFMPEGPID = start-process -WindowStyle hidden -FilePath "ffmpeg.exe" -WorkingDirectory "C:\CBCAP" -ArgumentList "-i $CleanURL -c copy $Output\$model\$model-$timestamp.mkv" -PassThru
                                $DBPID = $FFMPEGPID.Id
                                                                
                                # Write the pertinent data to the datbase to log that recording is taking place
                                $RecordingSQL = "UPDATE Models SET Online = 'Y', URL = '$StreamURL', PID = '$DBPID' WHERE ScreenName ='$Model';"
                                $RecordingOutput = Invoke-Sqlcmd -query $RecordingSQL -ConnectionString "Data Source=localhost\SQLEXPRESS;Initial Catalog=CBScreenCap;Integrated Security=True" 
                                $LogSQL = "INSERT INTO [dbo].[RecordLog] ([ScreenName],[PID],[FilePath],[RecordStart],[Converted],[ConversionPath],[ConversionDate]) VALUES ('$Model','$DBPID','$Output\$model\$model-$timestamp.mkv',getdate(),0,'',NULL)"
                                $LogOutput = Invoke-Sqlcmd -query $LogSQL -ConnectionString "Data Source=localhost\SQLEXPRESS;Initial Catalog=CBScreenCap;Integrated Security=True" 

                                write-host $model "ONLINE - Recording Started"
                            }

                            # This handles a wierd anomaly that came up where FFMPEG stopped recording
                            # but the model is still online. It will restart the stream capture and
                            # update the corresponding PID to match the new FFMPEG process
                            elseif($PIDNo -ne ''){
                            $RunningPID = Get-Process -Id $PIDNo -ErrorAction Ignore | Select -expandProperty ProcessName
                                if(($PIDNo -ne '') -and ($RunningPID -ne 'ffmpeg')){
                                    #set the database records to reflect that they are offline
                                        $timestamp = get-date -Format yyyy-mm-dd_HHmmss
                                        # Starts FFMPEG - If the stream stops, FFMPEG will automatically quit
                                        $FFMPEGPID = start-process -WindowStyle hidden -FilePath "ffmpeg.exe" -WorkingDirectory "C:\CBCAP" -ArgumentList "-i $CleanURL -c copy $Output\$model\$model-$timestamp.mkv" -PassThru
                                        $DBPID = $FFMPEGPID.Id
                                                                
                                        # Write the pertinent data to the datbase to log that recording is taking place
                                        $RecordingSQL = "UPDATE Models SET Online = 'Y', URL = '$StreamURL', PID = '$DBPID' WHERE ScreenName ='$Model';"
                                        $RecordingOutput = Invoke-Sqlcmd -query $RecordingSQL -ConnectionString "Data Source=localhost\SQLEXPRESS;Initial Catalog=CBScreenCap;Integrated Security=True" 
                                        $LogSQL = "INSERT INTO [dbo].[RecordLog] ([ScreenName],[PID],[FilePath],[RecordStart],[Converted],[ConversionPath],[ConversionDate]) VALUES ('$Model','$DBPID','$Output\$model\$model-$timestamp.mkv',getdate(),0,'',NULL)"
                                        $LogOutput = Invoke-Sqlcmd -query $LogSQL -ConnectionString "Data Source=localhost\SQLEXPRESS;Initial Catalog=CBScreenCap;Integrated Security=True" 
                                        write-host $model "ONLINE - Recording Started"
                                        }
                            }
                        }

  
                    # If the boolean check for model status returns false, this will update
                    # the database to show them offline, provided the FFMPEG PID that was associated with
                    # the recording no longer exists.
                    #
                    # There is a problem where a model may go into a private chat and FFMPEG keeps the stream
                    # alive, but the webpage no longer contains the stream URL. This will handle for those
                    # situations.
                    elseif($online -eq 0){
                            $PIDCheckSQL = "SELECT PID from Models WHERE ScreenName = '$Model';"
                            $PIDCheck = Invoke-Sqlcmd -query $PIDCheckSQL -ConnectionString "Data Source=localhost\SQLEXPRESS;Initial Catalog=CBScreenCap;Integrated Security=True"
                            $PIDNo = $PIDCheck | Select -ExpandProperty PID
                            $RunningPID = Get-Process -Id $PIDNo -ErrorAction Ignore | Select -expandProperty ProcessName
                                if(($PIDNo -ne '') -and ($RunningPID -ne 'ffmpeg')){
                                    #set the database records to reflect that they are offline
                                        $OfflineSQL = "UPDATE Models SET Online = 'N', URL = '', PID = '' WHERE ScreenName ='$Model';"
                                        $OfflineOutput = Invoke-Sqlcmd -query $OfflineSQL -ConnectionString "Data Source=localhost\SQLEXPRESS;Initial Catalog=CBScreenCap;Integrated Security=True" 
                                        write-host $model "Has gone offline"
                                        $LogSQL = "UPDATE [dbo].[RecordLog] SET RecordEnd = getdate() WHERE ScreenName = '$Model' and PID = '$PIDNo'"
                                        $LogOutput = Invoke-Sqlcmd -query $LogSQL -ConnectionString "Data Source=localhost\SQLEXPRESS;Initial Catalog=CBScreenCap;Integrated Security=True" 
                                    }
                    }
			start-sleep -seconds 10
            }
        Write-host ""
        write-host "Waiting 60 seconds to begin again"
        start-sleep -seconds 60
    }