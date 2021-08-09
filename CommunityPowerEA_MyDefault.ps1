# Defaults Settings for Production (live) Setting File
#
# Autor: Ulises Cune (@Ulises2k)
# v2.2
#
# !!!! It version is for CommunityPower EA v2.36 !!!!
#Correlaciones
#https://www.mataf.net/es/forex/tools/correlation

#
# Windows 2008
# Set-ExecutionPolicy RemoteSigned
# Windows 2008
# Set-ExecutionPolicy Restricted
Function Get-IniFile ($file) {
    $ini = [ordered]@{}
    switch -regex -file $file {
        "^\s*(.+?)\s*=\s*(.*)$" {
            $name, $value = $matches[1..2]
            # skip comments that start with semicolon:
            if (!($name.StartsWith(";"))) {
                if ($value.Contains('||') ) {
                    $ini[$name] = $value.Split('||')[0]
                    continue
                }
                else {
                    $ini[$name] = $value
                    continue
                }
            }
        }
    }
    $ini
}

function Set-OrAddIniValue {
    Param(
        [string]$FilePath,
        [hashtable]$keyValueList
    )

    $content = Get-Content $FilePath
    $keyValueList.GetEnumerator() | ForEach-Object {
        if ($content -match "^$($_.Key)\s*=") {
            $content = $content -replace "$($_.Key)\s*=(.*)", "$($_.Key)=$($_.Value)"
        }
        else {
            $content += "$($_.Key)=$($_.Value)"
        }
    }

    $content | Set-Content $FilePath
}

#; My Defaults
function Button([string]$filePath) {

    #$PathDest = (Get-Item $filePath).BaseName + "-Optimized.set"
    $PathDest = (Get-Item $filePath).BaseName + ".set"
    $CurrentDir = Split-Path -Path "$filePath"
    $filePathNew = "$CurrentDir\$PathDest"
    #Copy-Item "$filePath" -Destination $filePathNew

    $filePath = $filePathNew

    Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
        Expert_Properties           = "===== Expert ====="
        Expert_Id                   = "235"
        Expert_Comment              = "CP" + (Get-Date -Format "dd.MM.yyyy.HH:mm")
        Lot_Properties              = "===== Lot ====="
        Hedge_Properties            = "===== Hedge ====="
        GlobalAccount_Properties    = "===== Global Account ====="
        VolPV_Properties            = "===== Volatility for all parameters nominated in points ====="
        Pending_Properties          = "===== Pending entry ====="
        StopLoss_Properties         = "===== StopLoss ====="
        StopLoss_Global             = "===== Summ StopLoss (buy + sell) ====="
        StopLoss_Pause              = "===== Pause after loss ====="
        UseVirtualSL                = "false"
        TakeProfit_Properties       = "===== TakeProfit ====="
        TakeProfit_ReduceAfter      = "===== Reduce TakeProfit after minutes ====="
        TakeProfit_ReduceSeries     = "===== Reduce TakeProfit for every order ====="
        TakeProfit_Global           = "===== Summ TakeProfit (buy + sell) ====="
        MinProfitToClose_Properties = "===== Min profit to close on signal ====="
        UseVirtualTP                = "false"
        TrailingStop_Properties     = "===== TrailingStop ====="
        Martingale_Properties       = "===== Martingale ====="
        BE_Alert_After              = "0"
        AllowBoth_Properties        = "===== Allow both Martin and Anti-martin ====="
        PartialClose_Properties     = "===== Partial Close ====="
        GlobalMartingail_Properties = "===== Apply martin to the new deals ====="
    }

    Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
        AntiMartingale_Properties = "===== Anti-Martingale ====="
        BigCandle_Properties      = "===== Big candle ====="
        Oscillators_Properties    = "===== Oscillator #1 ====="
        Oscillator2_Properties    = "===== Oscillator #2 ====="
        Oscillator3_Properties    = "===== Oscillator #3 ====="
        IdentifyTrend_Properties  = "===== IdentifyTrend ====="
        TDI_Properties            = "===== TDI ====="
        MACD_Properties           = "===== MACD #1 ====="
        MACD2_Properties          = "===== MACD #2 ====="
        DTrend_Properties         = "===== DTrend ====="
        PSar_Properties           = "===== SAR ====="
        MA_Filter_1_Properties    = "===== MA Filter #1 ====="
        MA_Filter_2_Properties    = "===== MA Filter #2 ====="
        MA_Filter_3_Properties    = "===== MA Filter #3 ====="
        ZZ_Properties             = "===== ZigZag ====="
        VolMA_Properties          = "===== Volatility for MA and ZigZag Filters distance ====="
        VolFilter_Properties      = "===== Volatility Filter ====="
        FIBO_Properties           = "===== FIBO #1 ====="
        FIB2_Properties           = "===== FIBO #2 ====="
    }

    Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
        Spread_Settings            = "===== Spread ====="
        Time_Settings              = "===== Time ====="
        Time_DST_Mode              = "1"
        Time_Manual_GMT_Offset     = "2"
        Custom_Schedule_Properties = "===== Custom Schedule ====="
        NewYear_Properties         = "===== New Year Holidays ====="
        News_Properties            = "===== News ====="
        News_Draw_Properties       = "===== Visualization ====="
        Lines_Settings             = "===== Lines ====="
        NextOrder_Width            = "1"
        NextOrder_Style            = "2"
        NextOrder_ColorB           = "65280"
        NextOrder_ColorS           = "255"
        StopLoss_Width             = "1"
        StopLoss_Style             = "1"
        StopLoss_ColorB            = "16711935"
        StopLoss_ColorS            = "16711935"
        BreakEven_Width            = "1"
        BreakEven_Style            = "0"
        BreakEven_ColorB           = "65471"
        BreakEven_ColorS           = "33023"
        TakeProfit_Width           = "1"
        TakeProfit_Style           = "4"
        TakeProfit_ColorB          = "65280"
        TakeProfit_ColorS          = "255"
        GUI_Settings               = "========== GUI =========="
        ManageManual               = "true"
        GUI_Enabled                = "false"
        ShowOrders_Settings        = "========== Show Orders =========="
        Show_Opened                = "1"
        Show_Closed                = "true"
        MaxHistoryDeals            = "500"
        Color_Properties           = "========== Main Color =========="
        Profit_Properties          = "========== TakeProfit =========="
        Profit_ShowInMoney         = "true"
        Profit_ShowInPoints        = "true"
        Profit_ShowInPercents      = "true"
        Profit_Aggregate           = "true"
        ProfitDigitsToShow         = "1"
        Style_Properties           = "========== Style =========="
        Open_Close_Line_Width      = "1"
        Open_Close_Line_Style      = "2"
        Open_PriceLabel_Width      = "1"
        Close_PriceLabel_Width     = "1"
        SL_TP_Dashes_Show          = "true"
        SL_TP_Lines_Width          = "0"
        SL_TP_Lines_Style          = "2"
        Expiration_Width           = "0"
        Expiration_Style           = "2"
        Notifications_Settings     = "===== Notifications ====="
        MessagesToGrammy           = "false"
        Alerts_Enabled             = "false"
        Sounds_Enabled             = "false"
        Optimization_Settings      = "===== Optimization ====="
    }

    if (!($comboBox.SelectedIndex -eq "-1")) {
        if ($comboBox.SelectedItem.ToString() -eq "DisableTime" ) {
            Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
                EveryDay_Properties        = "===== Every Day ====="
                EveryDay_StartHour         = "-1"
                EveryDay_StartMinute       = "0"
                EveryDay_EndHour           = "-1"
                EveryDay_EndMinute         = "0"
                EveryDay_CloseHour         = "-1"
                EveryDay_CloseMinute       = "0"
                FridayMonday_Properties    = "===== Friday and Monday ====="
                FridayStop_Hour            = "-1"
                FridayStop_Minute          = "0"
                FridayClose_Hour           = "-1"
                FridayClose_Minute         = "0"
                MondayStart_Hour           = "-1"
                MondayStart_Minute         = "0"
                Custom_Schedule_Properties = "===== Custom Schedule ====="
                Monday_StartHour           = "-1"
                Monday_StartMinute         = "0"
                Monday_EndHour             = "-1"
                Monday_EndMinute           = "0"
                Tuesday_StartHour          = "-1"
                Tuesday_StartMinute        = "0"
                Tuesday_EndHour            = "-1"
                Tuesday_EndMinute          = "0"
                Wednesday_StartHour        = "-1"
                Wednesday_StartMinute      = "0"
                Wednesday_EndHour          = "-1"
                Wednesday_EndMinute        = "0"
                Thursday_StartHour         = "-1"
                Thursday_StartMinute       = "0"
                Thursday_EndHour           = "-1"
                Thursday_EndMinute         = "0"
                Friday_StartHour           = "-1"
                Friday_StartMinute         = "0"
                Friday_EndHour             = "-1"
                Friday_EndMinute           = "0"
            }
        }
    }

    #http://www.timezoneconverter.com/cgi-bin/zoneinfo
    #
    #https://forex.timezoneconverter.com/?timezone=Europe/Helsinki;
    #
    #https://www.compareforexbrokers.com/forex-trading/hours/
    #
    #OVERLAPS – BEST TIMES TO TRADE THE FOREX MARKET?
    #https://forexboat.com/forex-trading-hours/
    #
    #https://drive.google.com/drive/folders/1N0ksZWjYVLWVBiWR8wBkScewmOg3Jv6X
    #GMT+2 (Europe/Helsinki)
    #https://drive.google.com/file/d/1GpbCap8Etmxl2IcvC6oExe_U06m8Svw4/view?usp=sharing
    #
    #https://roboforex.com/beginners/info/forex-trading-hours/
    #ASIA
    #Tokyo	    2:00	10:00 (Europe/Helsinki)
    #Hong Kong	3:00	11:00
    #Singapore	2:00	10:00
    if (!($comboBox.SelectedIndex -eq "-1")) {
        if ($comboBox.SelectedItem.ToString() -eq "ASIA(Tokyo/Hong Kong/Singapore)" ) {
            Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
                EveryDay_Properties        = "===== Every Day / ASIA ====="
                EveryDay_StartHour         = "2"
                EveryDay_StartMinute       = "0"
                EveryDay_EndHour           = "10"
                EveryDay_EndMinute         = "0"
                EveryDay_CloseHour         = "-1"
                EveryDay_CloseMinute       = "0"
                FridayMonday_Properties    = "===== Friday and Monday ====="
                FridayStop_Hour            = "-1"
                FridayStop_Minute          = "0"
                FridayClose_Hour           = "-1"
                FridayClose_Minute         = "0"
                MondayStart_Hour           = "-1"
                MondayStart_Minute         = "0"
                Custom_Schedule_Properties = "===== Custom Schedule ====="
                Monday_StartHour           = "-1"
                Monday_StartMinute         = "0"
                Monday_EndHour             = "-1"
                Monday_EndMinute           = "0"
                Tuesday_StartHour          = "-1"
                Tuesday_StartMinute        = "0"
                Tuesday_EndHour            = "-1"
                Tuesday_EndMinute          = "0"
                Wednesday_StartHour        = "-1"
                Wednesday_StartMinute      = "0"
                Wednesday_EndHour          = "-1"
                Wednesday_EndMinute        = "0"
                Thursday_StartHour         = "-1"
                Thursday_StartMinute       = "0"
                Thursday_EndHour           = "-1"
                Thursday_EndMinute         = "0"
                Friday_StartHour           = "-1"
                Friday_StartMinute         = "0"
                Friday_EndHour             = "-1"
                Friday_EndMinute           = "0"
            }
        }
    }

    #Europa
    #Frankfurt	9:00	17:00
    #London	    10:00	18:00 (Europe/Helsinki)
    if (!($comboBox.SelectedIndex -eq "-1")) {
        if ($comboBox.SelectedItem.ToString() -eq "EUROPA(Frankfurt/London)" ) {
            Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
                EveryDay_Properties        = "===== Every Day / EUROPA ====="
                EveryDay_StartHour         = "9"
                EveryDay_StartMinute       = "0"
                EveryDay_EndHour           = "18"
                EveryDay_EndMinute         = "0"
                EveryDay_CloseHour         = "-1"
                EveryDay_CloseMinute       = "0"
                FridayMonday_Properties    = "===== Friday and Monday ====="
                FridayStop_Hour            = "-1"
                FridayStop_Minute          = "0"
                FridayClose_Hour           = "-1"
                FridayClose_Minute         = "0"
                MondayStart_Hour           = "-1"
                MondayStart_Minute         = "0"
                Custom_Schedule_Properties = "===== Custom Schedule ====="
                Monday_StartHour           = "-1"
                Monday_StartMinute         = "0"
                Monday_EndHour             = "-1"
                Monday_EndMinute           = "0"
                Tuesday_StartHour          = "-1"
                Tuesday_StartMinute        = "0"
                Tuesday_EndHour            = "-1"
                Tuesday_EndMinute          = "0"
                Wednesday_StartHour        = "-1"
                Wednesday_StartMinute      = "0"
                Wednesday_EndHour          = "-1"
                Wednesday_EndMinute        = "0"
                Thursday_StartHour         = "-1"
                Thursday_StartMinute       = "0"
                Thursday_EndHour           = "-1"
                Thursday_EndMinute         = "0"
                Friday_StartHour           = "-1"
                Friday_StartMinute         = "0"
                Friday_EndHour             = "-1"
                Friday_EndMinute           = "0"
            }
        }
    }

    #América
    #New York	15:00	23:00 (Europe/Helsinki)
    #Chicago	16:00	24:00
    if (!($comboBox.SelectedIndex -eq "-1")) {
        if ($comboBox.SelectedItem.ToString() -eq "AMERICA(New York/Chicago)" ) {
            Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
                EveryDay_Properties        = "===== Every Day / AMERICA ====="
                EveryDay_StartHour         = "15"
                EveryDay_StartMinute       = "0"
                EveryDay_EndHour           = "24"
                EveryDay_EndMinute         = "0"
                EveryDay_CloseHour         = "-1"
                EveryDay_CloseMinute       = "0"
                FridayMonday_Properties    = "===== Friday and Monday ====="
                FridayStop_Hour            = "-1"
                FridayStop_Minute          = "0"
                FridayClose_Hour           = "-1"
                FridayClose_Minute         = "0"
                MondayStart_Hour           = "-1"
                MondayStart_Minute         = "0"
                Custom_Schedule_Properties = "===== Custom Schedule ====="
                Monday_StartHour           = "-1"
                Monday_StartMinute         = "0"
                Monday_EndHour             = "-1"
                Monday_EndMinute           = "0"
                Tuesday_StartHour          = "-1"
                Tuesday_StartMinute        = "0"
                Tuesday_EndHour            = "-1"
                Tuesday_EndMinute          = "0"
                Wednesday_StartHour        = "-1"
                Wednesday_StartMinute      = "0"
                Wednesday_EndHour          = "-1"
                Wednesday_EndMinute        = "0"
                Thursday_StartHour         = "-1"
                Thursday_StartMinute       = "0"
                Thursday_EndHour           = "-1"
                Thursday_EndMinute         = "0"
                Friday_StartHour           = "-1"
                Friday_StartMinute         = "0"
                Friday_EndHour             = "-1"
                Friday_EndMinute           = "0"
            }
        }
    }

    #Pacífico
    #Sidney	    1:00	9:00 (Europe/Helsinki)
    if (!($comboBox.SelectedIndex -eq "-1")) {
        if ($comboBox.SelectedItem.ToString() -eq "PACIFICO(Wellington/Sidney)" ) {
            Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
                EveryDay_Properties        = "===== Every Day / PACIFICO ====="
                EveryDay_StartHour         = "1"
                EveryDay_StartMinute       = "0"
                EveryDay_EndHour           = "9"
                EveryDay_EndMinute         = "0"
                EveryDay_CloseHour         = "-1"
                EveryDay_CloseMinute       = "0"
                FridayMonday_Properties    = "===== Friday and Monday ====="
                FridayStop_Hour            = "-1"
                FridayStop_Minute          = "0"
                FridayClose_Hour           = "-1"
                FridayClose_Minute         = "0"
                MondayStart_Hour           = "-1"
                MondayStart_Minute         = "0"
                Custom_Schedule_Properties = "===== Custom Schedule ====="
                Monday_StartHour           = "-1"
                Monday_StartMinute         = "0"
                Monday_EndHour             = "-1"
                Monday_EndMinute           = "0"
                Tuesday_StartHour          = "-1"
                Tuesday_StartMinute        = "0"
                Tuesday_EndHour            = "-1"
                Tuesday_EndMinute          = "0"
                Wednesday_StartHour        = "-1"
                Wednesday_StartMinute      = "0"
                Wednesday_EndHour          = "-1"
                Wednesday_EndMinute        = "0"
                Thursday_StartHour         = "-1"
                Thursday_StartMinute       = "0"
                Thursday_EndHour           = "-1"
                Thursday_EndMinute         = "0"
                Friday_StartHour           = "-1"
                Friday_StartMinute         = "0"
                Friday_EndHour             = "-1"
                Friday_EndMinute           = "0"
            }
        }
    }

    if (!($comboBox.SelectedIndex -eq "-1")) {
        if ($comboBox.SelectedItem.ToString() -eq "DateTime-EUR/USD" ) {
            Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
                EveryDay_Properties        = "===== Every Day / EUR/USD ====="
                EveryDay_StartHour         = "0"
                EveryDay_StartMinute       = "5"
                EveryDay_EndHour           = "23"
                EveryDay_EndMinute         = "45"
                EveryDay_CloseHour         = "-1"
                EveryDay_CloseMinute       = "0"
                FridayMonday_Properties    = "===== Friday and Monday / EUR/USD ====="
                FridayStop_Hour            = "22"
                FridayStop_Minute          = "0"
                FridayClose_Hour           = "-1"
                FridayClose_Minute         = "0"
                MondayStart_Hour           = "0"
                MondayStart_Minute         = "5"
                Custom_Schedule_Properties = "===== Custom Schedule / EUR/USD ====="
                Monday_StartHour           = "0"
                Monday_StartMinute         = "5"
                Monday_EndHour             = "23"
                Monday_EndMinute           = "45"
                Tuesday_StartHour          = "0"
                Tuesday_StartMinute        = "5"
                Tuesday_EndHour            = "23"
                Tuesday_EndMinute          = "50"
                Wednesday_StartHour        = "0"
                Wednesday_StartMinute      = "5"
                Wednesday_EndHour          = "23"
                Wednesday_EndMinute        = "45"
                Thursday_StartHour         = "0"
                Thursday_StartMinute       = "5"
                Thursday_EndHour           = "23"
                Thursday_EndMinute         = "45"
                Friday_StartHour           = "0"
                Friday_StartMinute         = "5"
                Friday_EndHour             = "22"
                Friday_EndMinute           = "0"
            }
        }
    }

    if (!($comboBox.SelectedIndex -eq "-1")) {
        if ($comboBox.SelectedItem.ToString() -eq "DateTime-XAU/USD" ) {
            Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
                EveryDay_Properties        = "===== Every Day / XAU/USD ====="
                EveryDay_StartHour         = "1"
                EveryDay_StartMinute       = "5"
                EveryDay_EndHour           = "23"
                EveryDay_EndMinute         = "0"
                EveryDay_CloseHour         = "-1"
                EveryDay_CloseMinute       = "0"
                FridayMonday_Properties    = "===== Friday and Monday / XAU/USD ====="
                FridayStop_Hour            = "22"
                FridayStop_Minute          = "0"
                FridayClose_Hour           = "-1"
                FridayClose_Minute         = "0"
                MondayStart_Hour           = "0"
                MondayStart_Minute         = "5"
                Custom_Schedule_Properties = "===== Custom Schedule / XAU/USD ====="
                Monday_StartHour           = "1"
                Monday_StartMinute         = "5"
                Monday_EndHour             = "23"
                Monday_EndMinute           = "45"
                Tuesday_StartHour          = "1"
                Tuesday_StartMinute        = "5"
                Tuesday_EndHour            = "23"
                Tuesday_EndMinute          = "45"
                Wednesday_StartHour        = "1"
                Wednesday_StartMinute      = "5"
                Wednesday_EndHour          = "22"
                Wednesday_EndMinute        = "0"
                Thursday_StartHour         = "1"
                Thursday_StartMinute       = "5"
                Thursday_EndHour           = "23"
                Thursday_EndMinute         = "45"
                Friday_StartHour           = "1"
                Friday_StartMinute         = "5"
                Friday_EndHour             = "22"
                Friday_EndMinute           = "0"
                News_Properties            = "===== News / XAU/USD ====="
                News_Currencies            = "auto"
                News_Impact_H              = "true"
                News_Impact_M              = "true"
                News_Impact_L              = "false"
                News_Impact_N              = "false"
                News_FilterInclude         = "Fed,Employment,PIB,NFP,BCE"
                News_MinutesBefore         = "30"
                News_MinutesAfter          = "30"
            }
        }
    }

    if (!($comboBox.SelectedIndex -eq "-1")) {
        if ($comboBox.SelectedItem.ToString() -eq "MyDefault-EUR/USD" ) {
            Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
                EveryDay_Properties        = "===== Every Day / EUR/USD ====="
                EveryDay_StartHour         = "0"
                EveryDay_StartMinute       = "5"
                EveryDay_EndHour           = "23"
                EveryDay_EndMinute         = "0"
                EveryDay_CloseHour         = "-1"
                EveryDay_CloseMinute       = "0"
                FridayMonday_Properties    = "===== Friday and Monday / EUR/USD ====="
                FridayStop_Hour            = "22"
                FridayStop_Minute          = "0"
                FridayClose_Hour           = "-1"
                FridayClose_Minute         = "0"
                MondayStart_Hour           = "0"
                MondayStart_Minute         = "5"
                Custom_Schedule_Properties = "===== Custom Schedule / EUR/USD ====="
                Monday_StartHour           = "0"
                Monday_StartMinute         = "5"
                Monday_EndHour             = "23"
                Monday_EndMinute           = "45"
                Tuesday_StartHour          = "0"
                Tuesday_StartMinute        = "5"
                Tuesday_EndHour            = "23"
                Tuesday_EndMinute          = "45"
                Wednesday_StartHour        = "0"
                Wednesday_StartMinute      = "5"
                Wednesday_EndHour          = "23"
                Wednesday_EndMinute        = "45"
                Thursday_StartHour         = "0"
                Thursday_StartMinute       = "5"
                Thursday_EndHour           = "23"
                Thursday_EndMinute         = "45"
                Friday_StartHour           = "0"
                Friday_StartMinute         = "5"
                Friday_EndHour             = "22"
                Friday_EndMinute           = "0"
            }
        }
    }

    #
    if (!($comboBox.SelectedIndex -eq "-1")) {
        if ($comboBox.SelectedItem.ToString() -eq "Default-AUD/USD" ) {
            Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
                EveryDay_Properties        = "===== Every Day / AUD/USD ====="
                EveryDay_StartHour         = "21"
                EveryDay_StartMinute       = "0"
                EveryDay_EndHour           = "6"
                EveryDay_EndMinute         = "0"
                EveryDay_CloseHour         = "-1"
                EveryDay_CloseMinute       = "0"
                FridayMonday_Properties    = "===== Friday and Monday / AUD/USD ====="
                FridayStop_Hour            = "-1"
                FridayStop_Minute          = "0"
                FridayClose_Hour           = "-1"
                FridayClose_Minute         = "0"
                MondayStart_Hour           = "-1"
                MondayStart_Minute         = "0"
                Custom_Schedule_Properties = "===== Custom Schedule / AUD/USD ====="
                Monday_StartHour           = "-1"
                Monday_StartMinute         = "0"
                Monday_EndHour             = "-1"
                Monday_EndMinute           = "0"
                Tuesday_StartHour          = "-1"
                Tuesday_StartMinute        = "0"
                Tuesday_EndHour            = "-1"
                Tuesday_EndMinute          = "0"
                Wednesday_StartHour        = "-1"
                Wednesday_StartMinute      = "0"
                Wednesday_EndHour          = "-1"
                Wednesday_EndMinute        = "0"
                Thursday_StartHour         = "-1"
                Thursday_StartMinute       = "0"
                Thursday_EndHour           = "-1"
                Thursday_EndMinute         = "0"
                Friday_StartHour           = "-1"
                Friday_StartMinute         = "0"
                Friday_EndHour             = "-1"
                Friday_EndMinute           = "0"
            }
        }
    }


    #Read All Setting File parameters
    $inifile = Get-IniFile($filePath)

    #Pending_Type
    $Pending_Type = [int]$inifile["Pending_Type"]
    if ($Pending_Type -eq 0) {
        Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
            NextOrder_Width = "0"
        }
    }
    else {
        Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
            NextOrder_Width = "1"
        }
    }


    #If not use StopLoss disable line
    $StopLoss = [int]$inifile["StopLoss"]
    $GlobalStopLoss = [int]$inifile["GlobalStopLoss"]
    $GlobalStopLoss_ccy = [int]$inifile["GlobalStopLoss_ccy"]
    if (($StopLoss -eq 0) -and ($GlobalStopLoss -eq 0) -and ($GlobalStopLoss_ccy -eq 0)) {
        Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
            StopLoss_Width = "0"
        }
    }
    else {
        Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
            StopLoss_Width = "2"
        }
    }

    #If not use Pending disable line
    $Pending_Type = [int]$inifile["Pending_Type"]
    if ($Pending_Type -eq 0) {
        Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
            Show_Pending = "false"
        }
    }
    else {
        Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
            Show_Pending = "true"
        }
    }

    #The stop level: This can be considered as a normal stop loss. When you add a trailing stop to an open position, your trailing stop is not active immediately. The market needs to move in your favour by the step distance for the trailing stop to be activated. If the market moves far enough against you before your trailing stop is activated, your position will be closed at this stop level.
    #The stop distance: This will be the distance between your trailing stop and the market level once your trailing stop is activated. The trailing stop will maintain this stop distance as it tracks the market.
    #The step distance: This is the number of points the market needs to move in your favour for the trailing stop to be adjusted upward or downward, depending on whether you are going long or short.
    #ATR disable is not used
    $Pending_Distance_ModeP = [int]$inifile["Pending_Distance_ModeP"]
    $StopLoss_ModeP = [int]$inifile["StopLoss_ModeP"]
    $TakeProfit_ModeP = [int]$inifile["TakeProfit_ModeP"]
    $MinProfitToClose_ModeP = [int]$inifile["MinProfitToClose_ModeP"]
    $TrailingStop_ModeP = [int]$inifile["TrailingStop_ModeP"]
    $Martingail_ModeP = [int]$inifile["Martingail_ModeP"]
    $AntiMartingail_ModeP = [int]$inifile["AntiMartingail_ModeP"]
    $AntiStopLoss_ModeP = [int]$inifile["AntiStopLoss_ModeP"]
    if (($Pending_Distance_ModeP -eq 0) -and ($StopLoss_ModeP -eq 0) -and ($TakeProfit_ModeP -eq 0) -and ($MinProfitToClose_ModeP -eq 0) -and ($TrailingStop_ModeP -eq 0) -and ($Martingail_ModeP -eq 0) -and ($AntiMartingail_ModeP -eq 0) -and ($AntiStopLoss_ModeP -eq 0)) {
        Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
            VolPV_Type = "0"
        }
    }


    #ZigZag AND (MA_Filter 1 2 && 3) Distance
    $ZZ_Type = [int]$inifile["ZZ_Type"]
    $MA_Filter_1_Type = [int]$inifile["MA_Filter_1_Type"]
    $MA_Filter_2_Type = [int]$inifile["MA_Filter_2_Type"]
    $MA_Filter_3_Type = [int]$inifile["MA_Filter_3_Type"]
    if (($ZZ_Type -eq 0) -and ($MA_Filter_1_Type -eq 0) -and ($MA_Filter_2_Type -eq 0) -and ($MA_Filter_3_Type -eq 0)) {
        Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
            VolMA_Type = "0"
        }
    }


    #If not select Open/OpenMartin/Close/Partial Disable
    $BigCandle_OpenOn = [int]$inifile["BigCandle_OpenOn"]
    $BigCandle_MartinOn = [int]$inifile["BigCandle_MartinOn"]
    $BigCandle_CloseOn = [int]$inifile["BigCandle_CloseOn"]
    $BigCandle_PartialCloseOn = [int]$inifile["BigCandle_PartialCloseOn"]
    $BigCandle_HedgeOn = [int]$inifile["BigCandle_HedgeOn"]
    if (($BigCandle_OpenOn -eq 0) -and ($BigCandle_MartinOn -eq 0) -and ($BigCandle_CloseOn -eq 0) -and ($BigCandle_PartialCloseOn -eq 0) -and ($BigCandle_HedgeOn -eq 0)) {
        Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
            BigCandle_Type = "0"
        }
    }

    #If not Enabled, Don't use for open/Don't use for close/Don't use for partial close
    $BigCandle_Type = [int]$inifile["BigCandle_Type"]
    if ($BigCandle_Type -eq 0) {
        Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
            BigCandle_OpenOn         = "0"
            BigCandle_MartinOn       = "0"
            BigCandle_CloseOn        = "0"
            BigCandle_PartialCloseOn = "0"
            BigCandle_HedgeOn        = "0"
        }
    }


    #If not select Open/OpenMartin/Close/Partial/HedgeOn Disable
    $Oscillators_OpenOn = [int]$inifile["Oscillators_OpenOn"]
    $Oscillators_MartinOn = [int]$inifile["Oscillators_MartinOn"]
    $Oscillators_CloseOn = [int]$inifile["Oscillators_CloseOn"]
    $Oscillators_PartialCloseOn = [int]$inifile["Oscillators_PartialCloseOn"]
    $Oscillators_HedgeOn = [int]$inifile["Oscillators_HedgeOn"]
    if (($Oscillators_OpenOn -eq 0) -and ($Oscillators_MartinOn -eq 0) -and ($Oscillators_CloseOn -eq 0) -and ($Oscillators_PartialCloseOn -eq 0) -and (($Oscillators_HedgeOn -eq 0))) {
        Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
            Oscillators_Type = "0"
        }
    }

    #If not Enabled, Don't use for open/Don't use for close/Don't use for partial close
    $Oscillators_Type = [int]$inifile["Oscillators_Type"]
    if ($Oscillators_Type -eq 0) {
        Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
            Oscillators_OpenOn         = "0"
            Oscillators_MartinOm       = "0"
            Oscillators_CloseOn        = "0"
            Oscillators_PartialCloseOn = "0"
            Oscillators_HedgeOn        = "0"
        }
    }


    #If not select Open/OpenMartin/Close/Partial/HedgeOn Disable
    $Oscillator2_OpenOn = [int]$inifile["Oscillator2_OpenOn"]
    $Oscillator2_MartinOn = [int]$inifile["Oscillator2_MartinOn"]
    $Oscillator2_CloseOn = [int]$inifile["Oscillator2_CloseOn"]
    $Oscillator2_PartialCloseOn = [int]$inifile["Oscillator2_PartialCloseOn"]
    $Oscillator2_HedgeOn = [int]$inifile["Oscillator2_HedgeOn"]
    if (($Oscillator2_OpenOn -eq 0) -and ($Oscillator2_MartinOn -eq 0) -and ($Oscillator2_CloseOn -eq 0) -and ($Oscillator2_PartialCloseOn -eq 0) -and ($Oscillator2_HedgeOn -eq 0)) {
        Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
            Oscillator2_Type = "0"
        }
    }

    #If not Enabled, Don't use for open/Don't use for close/Don't use for partial close
    $Oscillator2_Type = [int]$inifile["Oscillator2_Type"]
    if ($Oscillator2_Type -eq 0) {
        Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
            Oscillator2_OpenOn         = "0"
            Oscillator2_MartinOn       = "0"
            Oscillator2_CloseOn        = "0"
            Oscillator2_PartialCloseOn = "0"
            Oscillator2_HedgeOn        = "0"
        }
    }


    #If not select Open/OpenMartin/Close/Partial/HedgeOn Disable
    $Oscillator3_OpenOn = [int]$inifile["Oscillator3_OpenOn"]
    $Oscillator3_MartinOn = [int]$inifile["Oscillator3_MartinOn"]
    $Oscillator3_CloseOn = [int]$inifile["Oscillator3_CloseOn"]
    $Oscillator3_PartialCloseOn = [int]$inifile["Oscillator3_PartialCloseOn"]
    $Oscillator3_HedgeOn = [int]$inifile["Oscillator3_HedgeOn"]
    if (($Oscillator3_OpenOn -eq 0) -and ($Oscillator3_MartinOn -eq 0) -and ($Oscillator3_CloseOn -eq 0) -and ($Oscillator3_PartialCloseOn -eq 0) -and ($Oscillator3_HedgeOn -eq 0)) {
        Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
            Oscillator3_Type = "0"
        }
    }

    #If not Enabled, Don't use for open/Don't use for close/Don't use for partial close
    $Oscillator3_Type = [int]$inifile["Oscillator3_Type"]
    if ($Oscillator3_Type -eq 0) {
        Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
            Oscillator3_OpenOn         = "0"
            Oscillator3_MartinOn       = "0"
            Oscillator3_CloseOn        = "0"
            Oscillator3_PartialCloseOn = "0"
            Oscillator3_HedgeOn        = "0"
        }
    }


    #If not select Open/OpenMartin/Close/Partial/HedgeOn Disable
    $IdentifyTrend_OpenOn = [int]$inifile["IdentifyTrend_OpenOn"]
    $IdentifyTrend_MartinOn = [int]$inifile["IdentifyTrend_MartinOn"]
    $IdentifyTrend_CloseOn = [int]$inifile["IdentifyTrend_CloseOn"]
    $IdentifyTrend_PartialCloseOn = [int]$inifile["IdentifyTrend_PartialCloseOn"]
    $IdentifyTrend_HedgeOn = [int]$inifile["IdentifyTrend_HedgeOn"]
    if (($IdentifyTrend_OpenOn -eq 0) -and ($IdentifyTrend_MartinOn -eq 0) -and ($IdentifyTrend_CloseOn -eq 0) -and ($IdentifyTrend_PartialCloseOn -eq 0) -and ($IdentifyTrend_HedgeOn -eq 0)) {
        Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
            IdentifyTrend_Enable = "false"
        }
    }

    #If not Enabled, Don't use for open/Don't use for close/Don't use for partial close
    $IdentifyTrend_Enable = [string]$inifile["IdentifyTrend_Enable"]
    if ([string]$IdentifyTrend_Enable -eq "false") {
        Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
            IdentifyTrend_OpenOn         = "0"
            IdentifyTrend_MartinOn       = "0"
            IdentifyTrend_CloseOn        = "0"
            IdentifyTrend_PartialCloseOn = "0"
            IdentifyTrend_HedgeOn        = "0"
        }
    }


    #If not select Open/OpenMartin/Close/Partial/HedgeOn Disable
    $TDI_OpenOn = [int]$inifile["TDI_OpenOn"]
    $TDI_MartinOn = [int]$inifile["TDI_MartinOn"]
    $TDI_CloseOn = [int]$inifile["TDI_CloseOn"]
    $TDI_PartialCloseOn = [int]$inifile["TDI_PartialCloseOn"]
    $TDI_HedgeOn = [int]$inifile["TDI_HedgeOn"]
    if (($TDI_OpenOn -eq 0) -and ($TDI_MartinOn -eq 0) -and ($TDI_CloseOn -eq 0) -and ($TDI_PartialCloseOn -eq 0) -and ($TDI_HedgeOn -eq 0)) {
        Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
            TDI_Mode = "0"
        }
    }

    #If not Enabled, Don't use for openDon't use for close/Don't use for partial close
    $TDI_Mode = [int]$inifile["TDI_Mode"]
    if ($TDI_Mode -eq 0) {
        Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
            TDI_OpenOn         = "0"
            TDI_MartinOn       = "0"
            TDI_CloseOn        = "0"
            TDI_PartialCloseOn = "0"
            TDI_HedgeOn        = "0"
        }
    }


    #If not select Open/OpenMartin/Close/Partial/HedgeOn Disable
    $MACD_OpenOn = [int]$inifile["MACD_OpenOn"]
    $MACD_MartinOn = [int]$inifile["MACD_MartinOn"]
    $MACD_CloseOn = [int]$inifile["MACD_CloseOn"]
    $MACD_PartialCloseOn = [int]$inifile["MACD_PartialCloseOn"]
    $MACD_HedgeOn = [int]$inifile["MACD_HedgeOn"]
    if (($MACD_OpenOn -eq 0) -and ($MACD_MartinOn -eq 0) -and ($MACD_CloseOn -eq 0) -and ($MACD_PartialCloseOn -eq 0) -and ($MACD_HedgeOn -eq 0)) {
        Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
            MACD_Type = "0"
        }
    }

    #If not Enabled, Don't use for open/Don't use for close/Don't use for partial close
    $MACD_Type = [int]$inifile["MACD_Type"]
    if ($MACD_Type -eq 0) {
        Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
            MACD_OpenOn         = "0"
            MACD_MartinOn       = "0"
            MACD_CloseOn        = "0"
            MACD_PartialCloseOn = "0"
            MACD_HedgeOn        = "0"
        }
    }

    #If not select Open/OpenMartin/Close/Partial/HedgeOn Disable
    $MACD2_OpenOn = [int]$inifile["MACD2_OpenOn"]
    $MACD2_MartinOn = [int]$inifile["MACD2_MartinOn"]
    $MACD2_CloseOn = [int]$inifile["MACD2_CloseOn"]
    $MACD2_PartialCloseOn = [int]$inifile["MACD2_PartialCloseOn"]
    $MACD2_HedgeOn = [int]$inifile["MACD2_HedgeOn"]
    if (($MACD2_OpenOn -eq 0) -and ($MACD2_MartinOn -eq 0) -and ($MACD2_CloseOn -eq 0) -and ($MACD2_PartialCloseOn -eq 0) -and ($MACD2_HedgeOn -eq 0)) {
        Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
            MACD2_Type = "0"
        }
    }

    #If not Enabled, Don't use for open/Don't use for close/Don't use for partial close
    $MACD2_Type = [int]$inifile["MACD2_Type"]
    if ($MACD2_Type -eq 0) {
        Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
            MACD2_OpenOn         = "0"
            MACD2_MartinOn       = "0"
            MACD2_CloseOn        = "0"
            MACD2_PartialCloseOn = "0"
            MACD2_HedgeOn        = "0"
        }
    }

    #If not select Open/OpenMartin/Close/Partial/HedgeOn Disable
    $DTrend_OpenOn = [int]$inifile["DTrend_OpenOn"]
    $DTrend_MartinOn = [int]$inifile["DTrend_MartinOn"]
    $DTrend_CloseOn = [int]$inifile["DTrend_CloseOn"]
    $DTrend_PartialCloseOn = [int]$inifile["DTrend_PartialCloseOn"]
    $DTrend_HedgeOn = [int]$inifile["DTrend_HedgeOn"]
    if (($DTrend_OpenOn -eq 0) -and ($DTrend_MartinOn -eq 0) -and ($DTrend_CloseOn -eq 0) -and ($DTrend_PartialCloseOn -eq 0) -and ($DTrend_HedgeOn -eq 0)) {
        Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
            DTrend_Type = "0"
        }
    }

    #If not Enabled, Don't use for open/Don't use for close/Don't use for partial close
    $DTrend_Type = [int]$inifile["DTrend_Type"]
    if ($DTrend_Type -eq 0) {
        Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
            DTrend_OpenOn         = "0"
            DTrend_MartinOn       = "0"
            DTrend_CloseOn        = "0"
            DTrend_PartialCloseOn = "0"
            DTrend_HedgeOn        = "0"
        }
    }

    #If not select Open/OpenMartin/Close/Partial/HedgeOn Disable
    $PSar_OpenOn = [int]$inifile["PSar_OpenOn"]
    $PSar_MartinOn = [int]$inifile["PSar_MartinOn"]
    $PSar_CloseOn = [int]$inifile["PSar_CloseOn"]
    $PSar_PartialCloseOn = [int]$inifile["PSar_PartialCloseOn"]
    $PSar_HedgeOn = [int]$inifile["PSar_HedgeOn"]
    if (($PSar_OpenOn -eq 0) -and ($PSar_MartinOn -eq 0) -and ($PSar_CloseOn -eq 0) -and ($PSar_PartialCloseOn -eq 0) -and ($PSar_HedgeOn -eq 0)) {
        Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
            PSar_Type = "0"
        }
    }

    #If not Enabled, Don't use for open/Don't use for close/Don't use for partial close
    $PSar_Type = [int]$inifile["PSar_Type"]
    if ($PSar_Type -eq 0) {
        Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
            PSar_OpenOn         = "0"
            PSar_MartinOn       = "0"
            PSar_CloseOn        = "0"
            PSar_PartialCloseOn = "0"
            PSar_HedgeOn        = "0"
        }
    }


    #If not select Open/OpenMartin/Close/Partial/HedgeOn Disable
    $MA_Filter_1_OpenOn = [int]$inifile["MA_Filter_1_OpenOn"]
    $MA_Filter_1_MartinOn = [int]$inifile["MA_Filter_1_MartinOn"]
    $MA_Filter_1_CloseOn = [int]$inifile["MA_Filter_1_CloseOn"]
    $MA_Filter_1_PartialCloseOn = [int]$inifile["MA_Filter_1_PartialCloseOn"]
    $MA_Filter_1_HedgeOn = [int]$inifile["MA_Filter_1_HedgeOn"]
    if (($MA_Filter_1_OpenOn -eq 0) -and ($MA_Filter_1_MartinOn -eq 0) -and ($MA_Filter_1_CloseOn -eq 0) -and ($MA_Filter_1_PartialCloseOn -eq 0) -and ($MA_Filter_1_HedgeOn -eq 0)) {
        Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
            MA_Filter_1_Type = "0"
        }
    }

    #If not Enabled, Don't use for open/Don't use for close/Don't use for partial close
    $MA_Filter_1_Type = [int]$inifile["MA_Filter_1_Type"]
    if ($MA_Filter_1_Type -eq 0) {
        Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
            MA_Filter_1_OpenOn         = "0"
            MA_Filter_1_MartinOn       = "0"
            MA_Filter_1_CloseOn        = "0"
            MA_Filter_1_PartialCloseOn = "0"
            MA_Filter_1_HedgeOn        = "0"
        }
    }


    #If not select Open/OpenMartin/Close/Partial/HedgeOn Disable
    $MA_Filter_2_OpenOn = [int]$inifile["MA_Filter_2_OpenOn"]
    $MA_Filter_2_MartinOn = [int]$inifile["MA_Filter_2_MartinOn"]
    $MA_Filter_2_CloseOn = [int]$inifile["MA_Filter_2_CloseOn"]
    $MA_Filter_2_PartialCloseOn = [int]$inifile["MA_Filter_2_PartialCloseOn"]
    $MA_Filter_2_HedgeOn = [int]$inifile["MA_Filter_2_HedgeOn"]
    if (($MA_Filter_2_OpenOn -eq 0) -and ($MA_Filter_2_MartinOn -eq 0) -and ($MA_Filter_2_CloseOn -eq 0) -and ($MA_Filter_2_PartialCloseOn -eq 0) -and ($MA_Filter_2_HedgeOn -eq 0)) {
        Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
            MA_Filter_2_Type = "0"
        }
    }

    #If not Enabled, Don't use for open/Don't use for close/Don't use for partial close
    $MA_Filter_2_Type = [int]$inifile["MA_Filter_2_Type"]
    if ($MA_Filter_2_Type -eq 0) {
        Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
            MA_Filter_2_OpenOn         = "0"
            MA_Filter_2_MartinOn       = "0"
            MA_Filter_2_CloseOn        = "0"
            MA_Filter_2_PartialCloseOn = "0"
            MA_Filter_2_HedgeOn        = "0"
        }
    }

    #If not select Open/OpenMartin/Close/Partial/ Disable
    $MA_Filter_3_OpenOn = [int]$inifile["MA_Filter_3_OpenOn"]
    $MA_Filter_3_MartinOn = [int]$inifile["MA_Filter_3_MartinOn"]
    $MA_Filter_3_CloseOn = [int]$inifile["MA_Filter_3_CloseOn"]
    $MA_Filter_3_PartialCloseOn = [int]$inifile["MA_Filter_3_PartialCloseOn"]
    $MA_Filter_3_HedgeOn = [int]$inifile["MA_Filter_3_HedgeOn"]
    if (($MA_Filter_3_OpenOn -eq 0) -and ($MA_Filter_3_MartinOn -eq 0) -and ($MA_Filter_3_CloseOn -eq 0) -and ($MA_Filter_3_PartialCloseOn -eq 0) -and ($MA_Filter_3_HedgeOn -eq 0)) {
        Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
            MA_Filter_3_Type = "0"
        }
    }

    #If not Enabled, Don't use for open/Don't use for close/Don't use for partial close
    $MA_Filter_3_Type = [int]$inifile["MA_Filter_3_Type"]
    if ($MA_Filter_3_Type -eq 0) {
        Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
            MA_Filter_3_OpenOn         = "0"
            MA_Filter_3_MartinOn       = "0"
            MA_Filter_3_CloseOn        = "0"
            MA_Filter_3_PartialCloseOn = "0"
            MA_Filter_3_HedgeOn        = "0"
        }
    }



    #If not select Open/OpenMartin/Close/Partial/HedgeOn Disable
    $ZZ_OpenOn = [int]$inifile["ZZ_OpenOn"]
    $ZZ_MartinOn = [int]$inifile["ZZ_MartinOn"]
    $ZZ_CloseOn = [int]$inifile["ZZ_CloseOn"]
    $ZZ_PartialCloseOn = [int]$inifile["ZZ_PartialCloseOn"]
    $ZZ_HedgeOn = [int]$inifile["ZZ_HedgeOn"]
    if (($ZZ_OpenOn -eq 0) -and ($ZZ_MartinOn -eq 0) -and ($ZZ_CloseOn -eq 0) -and ($ZZ_PartialCloseOn -eq 0) -and ($ZZ_HedgeOn -eq 0)) {
        Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
            ZZ_Type = "0"
        }
    }

    #If not Enabled, Don't use for open/Don't use for close/Don't use for partial close
    $ZZ_Type = [int]$inifile["ZZ_Type"]
    if ($ZZ_Type -eq 0) {
        Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
            ZZ_OpenOn         = "0"
            ZZ_MartinOn       = "0"
            ZZ_CloseOn        = "0"
            ZZ_PartialCloseOn = "0"
            ZZ_HedgeOn        = "0"
        }
    }



    #If not select Open/OpenMartin/Close/Partial/HedgeOn Disable Volatility Filter
    $VolFilter_OpenOn = [int]$inifile["VolFilter_OpenOn"]
    $VolFilter_MartinOn = [int]$inifile["VolFilter_MartinOn"]
    $VolFilter_CloseOn = [int]$inifile["VolFilter_CloseOn"]
    $VolFilter_PartialCloseOn = [int]$inifile["VolFilter_PartialCloseOn"]
    $VolFilter_HedgeOn = [int]$inifile["VolFilter_HedgeOn"]
    if (($VolFilter_OpenOn -eq 0) -and ($VolFilter_MartinOn -eq 0) -and ($VolFilter_CloseOn -eq 0) -and ($VolFilter_PartialCloseOn -eq 0) -and ($VolFilter_HedgeOn -eq 0)) {
        Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
            VolFilter_Type = "0"
        }
    }

    #If not Enabled, Don't use for open/Don't use for close/Don't use for partial close
    $VolFilter_Type = [int]$inifile["VolFilter_Type"]
    if ($VolFilter_Type -eq 0) {
        Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
            VolFilter_OpenOn         = "0"
            VolFilter_MartinOn       = "0"
            VolFilter_CloseOn        = "0"
            VolFilter_PartialCloseOn = "0"
            VolFilter_HedgeOn        = "0"
        }
    }


    #If not select Open/OpenMartin/Close/Partial/HedgeOn Disable Volatility Filter
    $FIBO_OpenOn = [int]$inifile["FIBO_OpenOn"]
    $FIBO_MartinOn = [int]$inifile["FIBO_MartinOn"]
    $FIBO_CloseOn = [int]$inifile["FIBO_CloseOn"]
    $FIBO_PartialCloseOn = [int]$inifile["FIBO_PartialCloseOn"]
    $FIBO_HedgeOn = [int]$inifile["FIBO_HedgeOn"]
    if (($FIBO_OpenOn -eq 0) -and ($FIBO_MartinOn -eq 0) -and ($FIBO_CloseOn -eq 0) -and ($FIBO_PartialCloseOn -eq 0) -and ($FIBO_HedgeOn -eq 0)) {
        Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
            FIBO_Type = "0"
        }
    }

    #If not Enabled, Don't use for open/Don't use for close/Don't use for partial close
    $FIBO_Type = [int]$inifile["FIBO_Type"]
    if ($FIBO_Type -eq 0) {
        Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
            FIBO_OpenOn         = "0"
            FIBO_MartinOn       = "0"
            FIBO_CloseOn        = "0"
            FIBO_PartialCloseOn = "0"
            FIBO_HedgeOn        = "0"
        }
    }


    #If not select Open/OpenMartin/Close/Partial/HedgeOn Disable Volatility Filter
    $FIB2_OpenOn = [int]$inifile["FIB2_OpenOn"]
    $FIB2_MartinOn = [int]$inifile["FIB2_MartinOn"]
    $FIB2_CloseOn = [int]$inifile["FIB2_CloseOn"]
    $FIB2_PartialCloseOn = [int]$inifile["FIB2_PartialCloseOn"]
    $FIB2_HedgeOn = [int]$inifile["FIB2_HedgeOn"]
    if (($FIB2_OpenOn -eq 0) -and ($FIB2_MartinOn -eq 0) -and ($FIB2_CloseOn -eq 0) -and ($FIB2_PartialCloseOn -eq 0) -and ($FIB2_HedgeOn -eq 0)) {
        Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
            FIB2_Type = "0"
        }
    }

    #If not Enabled, Don't use for open/Don't use for close/Don't use for partial close
    $FIB2_Type = [int]$inifile["FIB2_Type"]
    if ($FIB2_Type -eq 0) {
        Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
            FIB2_OpenOn         = "0"
            FIB2_MartinOn       = "0"
            FIB2_CloseOn        = "0"
            FIB2_PartialCloseOn = "0"
            FIB2_HedgeOn        = "0"
        }
    }


    #If not select Open/OpenMartin/Close/Partial/HedgeOn Disable Volatility Filter
    $News_OpenOn = [int]$inifile["News_OpenOn"]
    $News_MartinOn = [int]$inifile["News_MartinOn"]
    $News_CloseOn = [int]$inifile["News_CloseOn"]
    $News_PartialCloseOn = [int]$inifile["News_PartialCloseOn"]
    $News_HedgeOn = [int]$inifile["News_HedgeOn"]
    if (($News_OpenOn -eq 0) -and ($News_MartinOn -eq 0) -and ($News_CloseOn -eq 0) -and ($News_PartialCloseOn -eq 0) -and ($News_HedgeOn -eq 0)) {
        Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
            News_Mode = "0"
        }
    }

    #If not Enabled, Don't use for open/Don't use for close/Don't use for partial close
    $News_Mode = [int]$inifile["News_Mode"]
    if ($News_Mode -eq 0) {
        Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
            News_OpenOn         = "0"
            News_MartinOn       = "0"
            News_CloseOn        = "0"
            News_PartialCloseOn = "0"
            News_HedgeOn        = "0"
        }
    }


    #Si PartialClose_After=0 AND PartialCloseHedge_After=0 los PartialClose One en las señales son al pedo.
    return $true
}

#; Rename
function Button2([string]$filePath) {

    $fileNewName = "_"

    #Read All Setting File parameters
    $inifile = Get-IniFile($filePath)

    $VolPV_Type = [int]$inifile["VolPV_Type"]
    if ($VolPV_Type -eq 1) {
        $fileNewName = $fileNewName + "ATR_"
    }
    elseif ($VolPV_Type -eq 2) {
        $fileNewName = $fileNewName + "StdDev_"
    }
    elseif ($VolPV_Type -eq 3) {
        $fileNewName = $fileNewName + "ATR_CloseOpen_"
    }
    elseif ($VolPV_Type -eq 4) {
        $fileNewName = $fileNewName + "WATR_"
    }
    elseif ($VolPV_Type -eq 5) {
        $fileNewName = $fileNewName + "Volume_"
    }

    $BigCandle = [int]$inifile["BigCandle_Type"]
    if ($BigCandle -ne 0) {
        $fileNewName = $fileNewName + "BigCandle_"
    }

    $Oscillators = [int]$inifile["Oscillators_Type"]
    if ($Oscillators -ne 0) {
        $Oscillators_Indicator = [int]$inifile["Oscillators_Indicator"]
        if ($Oscillators_Indicator -eq 0) {
            $fileNewName = $fileNewName + "CCI1_"
        }
        elseif ($Oscillators_Indicator -eq 1) {
            $fileNewName = $fileNewName + "WPR1_"
        }
        elseif ($Oscillators_Indicator -eq 2) {
            $fileNewName = $fileNewName + "RSI1_"
        }
        elseif ($Oscillators_Indicator -eq 3) {
            $fileNewName = $fileNewName + "StochasticK1_"
        }
        elseif ($Oscillators_Indicator -eq 4) {
            $fileNewName = $fileNewName + "StochasticD1_"
        }
        elseif ($Oscillators_Indicator -eq 5) {
            $fileNewName = $fileNewName + "Momentum1_"
        }
    }


    $Oscillator2 = [int]$inifile["Oscillator2_Type"]
    if ($Oscillator2 -ne 0) {
        $Oscillator2_Indicator = [int]$inifile["Oscillator2_Indicator"]
        if ($Oscillator2_Indicator -eq 0) {
            $fileNewName = $fileNewName + "CCI2_"
        }
        elseif ($Oscillator2_Indicator -eq 1) {
            $fileNewName = $fileNewName + "WPR2_"
        }
        elseif ($Oscillator2_Indicator -eq 2) {
            $fileNewName = $fileNewName + "RSI2_"
        }
        elseif ($Oscillator2_Indicator -eq 3) {
            $fileNewName = $fileNewName + "StochasticK2_"
        }
        elseif ($Oscillator2_Indicator -eq 4) {
            $fileNewName = $fileNewName + "StochasticD2_"
        }
        elseif ($Oscillator2_Indicator -eq 5) {
            $fileNewName = $fileNewName + "Momentum2_"
        }
    }

    $Oscillator3 = [int]$inifile["Oscillator3_Type"]
    if ($Oscillator3 -ne 0) {
        $Oscillator3_Indicator = [int]$inifile["Oscillator3_Indicator"]
        if ($Oscillator3_Indicator -eq 0) {
            $fileNewName = $fileNewName + "CCI3_"
        }
        elseif ($Oscillator3_Indicator -eq 1) {
            $fileNewName = $fileNewName + "WPR3_"
        }
        elseif ($Oscillator3_Indicator -eq 2) {
            $fileNewName = $fileNewName + "RSI3_"
        }
        elseif ($Oscillator3_Indicator -eq 3) {
            $fileNewName = $fileNewName + "StochasticK3_"
        }
        elseif ($Oscillator3_Indicator -eq 4) {
            $fileNewName = $fileNewName + "StochasticD3_"
        }
        elseif ($Oscillator3_Indicator -eq 5) {
            $fileNewName = $fileNewName + "Momentum3_"
        }
    }

    $IdentifyTrend = [string]$inifile["IdentifyTrend_Enable"]
    if ($IdentifyTrend -eq "true") {
        $fileNewName = $fileNewName + "IdentifyTrend_"
    }

    $TDI = [int]$inifile["TDI_Mode"]
    if ($TDI -ne 0) {
        $fileNewName = $fileNewName + "TDI_"
    }

    $MACD = [int]$inifile["MACD_Type"]
    if ($MACD -ne 0) {
        $fileNewName = $fileNewName + "MACD1_"
    }

    $MACD2 = [int]$inifile["MACD2_Type"]
    if ($MACD2 -ne 0) {
        $fileNewName = $fileNewName + "MACD2_"
    }

    $DTrend = [int]$inifile["DTrend_Type"]
    if ($DTrend -ne 0) {
        $fileNewName = $fileNewName + "DTrend_"
    }

    $SAR = [int]$inifile["PSar_Type"]
    if ($SAR -ne 0) {
        $fileNewName = $fileNewName + "PSAR_"
    }

    $MA_Filter_1 = [int]$inifile["MA_Filter_1_Type"]
    if ($MA_Filter_1 -ne 0) {
        $MA_Filter_1_Method = [int]$inifile["MA_Filter_1_Method"]
        if ($MA_Filter_1_Method -eq 0) {
            #Simple Moving Average (SMA)
            $fileNewName = $fileNewName + "MA1_Simple_"
        }
        elseif ($MA_Filter_1_Method -eq 1) {
            #Exponential Moving Average (EMA)
            $fileNewName = $fileNewName + "MA1_Exponencial_"
        }
        elseif ($MA_Filter_1_Method -eq 2) {
            #Smoothed Moving Average (SMMA)
            $fileNewName = $fileNewName + "MA1_Smoothed_"
        }
        elseif ($MA_Filter_1_Method -eq 3) {
            #Linear Weighted Moving Average (LWMA)
            $fileNewName = $fileNewName + "MA1_Linear_weighted_"
        }
        elseif ($MA_Filter_1_Method -eq 4) {
            $fileNewName = $fileNewName + "MA1_JurikMA_"
        }
        elseif ($MA_Filter_1_Method -eq 5) {
            #https://www.metatrader5.com/es/terminal/help/indicators/trend_indicators/fama
            $fileNewName = $fileNewName + "MA1_FRAMA_"
        }
        elseif ($MA_Filter_1_Method -eq 6) {
            $fileNewName = $fileNewName + "MA1_TMA_"
        }
        elseif ($MA_Filter_1_Method -eq 7) {
            $fileNewName = $fileNewName + "MA1_TEMA_"
        }
        elseif ($MA_Filter_1_Method -eq 8) {
            $fileNewName = $fileNewName + "MA1_HMA_"
        }
    }

    $MA_Filter_2 = [int]$inifile["MA_Filter_2_Type"]
    if ($MA_Filter_2 -ne 0) {
        $MA_Filter_2_Method = [int]$inifile["MA_Filter_2_Method"]
        if ($MA_Filter_2_Method -eq 0) {
            $fileNewName = $fileNewName + "MA2_Simple_"
        }
        elseif ($MA_Filter_2_Method -eq 1) {
            $fileNewName = $fileNewName + "MA2_Exponencial_"
        }
        elseif ($MA_Filter_2_Method -eq 2) {
            $fileNewName = $fileNewName + "MA2_Smoothed_"
        }
        elseif ($MA_Filter_2_Method -eq 3) {
            $fileNewName = $fileNewName + "MA2_Linear_weighted_"
        }
        elseif ($MA_Filter_2_Method -eq 4) {
            $fileNewName = $fileNewName + "MA2_JurikMA_"
        }
        elseif ($MA_Filter_2_Method -eq 5) {
            $fileNewName = $fileNewName + "MA2_FRAMA_"
        }
        elseif ($MA_Filter_2_Method -eq 6) {
            $fileNewName = $fileNewName + "MA2_TMA_"
        }
        elseif ($MA_Filter_2_Method -eq 7) {
            $fileNewName = $fileNewName + "MA2_TEMA_"
        }
        elseif ($MA_Filter_2_Method -eq 8) {
            $fileNewName = $fileNewName + "MA2_HMA_"
        }
    }

    $MA_Filter_3 = [int]$inifile["MA_Filter_3_Type"]
    if ($MA_Filter_3 -ne 0) {
        $MA_Filter_3_Method = [int]$inifile["MA_Filter_3_Method"]
        if ($MA_Filter_3_Method -eq 0) {
            $fileNewName = $fileNewName + "MA3_Simple_"
        }
        elseif ($MA_Filter_3_Method -eq 1) {
            $fileNewName = $fileNewName + "MA3_Exponencial_"
        }
        elseif ($MA_Filter_3_Method -eq 2) {
            $fileNewName = $fileNewName + "MA3_Smoothed_"
        }
        elseif ($MA_Filter_3_Method -eq 3) {
            $fileNewName = $fileNewName + "MA3_Linear_weighted_"
        }
        elseif ($MA_Filter_3_Method -eq 4) {
            $fileNewName = $fileNewName + "MA3_JurikMA_"
        }
        elseif ($MA_Filter_3_Method -eq 5) {
            $fileNewName = $fileNewName + "MA3_FRAMA_"
        }
        elseif ($MA_Filter_3_Method -eq 6) {
            $fileNewName = $fileNewName + "MA3_TMA_"
        }
        elseif ($MA_Filter_3_Method -eq 7) {
            $fileNewName = $fileNewName + "MA3_TEMA_"
        }
        elseif ($MA_Filter_3_Method -eq 8) {
            $fileNewName = $fileNewName + "MA3_HMA_"
        }
    }

    $ZZ = [int]$inifile["ZZ_Type"]
    if ($ZZ -ne 0) {
        $fileNewName = $fileNewName + "ZZ_"
    }

    $VolFilter = [int]$inifile["VolFilter_Type"]
    if ($VolFilter -ne 0) {
        $fileNewName = $fileNewName + "ZigZag_"
    }

    $FIBO = [int]$inifile["FIBO_Type"]
    if ($FIBO -ne 0) {
        $fileNewName = $fileNewName + "FIBO1_"
    }

    $FIB2 = [int]$inifile["FIB2_Type"]
    if ($FIB2 -ne 0) {
        $fileNewName = $fileNewName + "FIBO2_"
    }

    $News = [int]$inifile["News_Mode"]
    if ($News -eq 1) {
        $fileNewName = $fileNewName + "News_"
    }


    $fileNewName = $fileNewName.Substring(0, $fileNewName.Length - 1)
    $PathDest = (Get-Item $filePath).BaseName + $fileNewName + ".set"
    $CurrentDir = Split-Path -Path "$filePath"
    $filePathNew = "$CurrentDir\$PathDest"
    Copy-Item "$filePath" -Destination $filePathNew

    return $true
}

#######################GUI################################################################
### API Windows Forms ###
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")

### Create form ###
$form = New-Object System.Windows.Forms.Form
$form.Text = "My Defaults And Rename Strategy - CommunityPower EA"
$form.Size = '600,250'
$form.StartPosition = "CenterScreen"
$form.MinimumSize = $form.Size
$form.MaximizeBox = $False
$form.Topmost = $True

#Combobox
$setTimes = @("DisableTime", "ASIA(Tokyo/Hong Kong/Singapore)", "EUROPA(Frankfurt/London)" , "AMERICA(New York/Chicago)", "PACIFICO(Wellington/Sidney)", "DateTime-EUR/USD", "DateTime-XAU/USD", "MyDefault-EUR/USD")
$comboBox = New-Object System.Windows.Forms.ComboBox
$comboBox.Location = '220, 10'
$comboBox.Size = '300, 50'
foreach ($setTime in $setTimes) {
    $comboBox.Items.add($setTime)
}

### Define controls ###
$button = New-Object System.Windows.Forms.Button
$button.Location = '5,10'
$button.Size = '75,20'
$button.Width = 200
$button.Text = "My Defaults"

### Define controls ###
$button2 = New-Object System.Windows.Forms.Button
$button2.Location = '5,40'
$button2.Size = '75,20'
$button2.Width = 200
$button2.Text = "Rename Setting File"

# Checkbox
$checkbox = New-Object Windows.Forms.Checkbox
$checkbox.Location = '220,50'
$checkbox.AutoSize = $True
$checkbox.Text = "Clear afterwards"

# Label
$label = New-Object Windows.Forms.Label
$label.Location = '5,90'
$label.AutoSize = $True
$label.Text = "Drag and Drop files settings here:"

# Listbox
$listBox = New-Object Windows.Forms.ListBox
$listBox.Location = '5,110'
$listBox.Height = 50
$listBox.Width = 550
$listBox.Anchor = ([System.Windows.Forms.AnchorStyles]::Bottom -bor [System.Windows.Forms.AnchorStyles]::Left -bor [System.Windows.Forms.AnchorStyles]::Right -bor [System.Windows.Forms.AnchorStyles]::Top)
$listBox.IntegralHeight = $False
$listBox.AllowDrop = $True

# StatusBar
$statusBar = New-Object System.Windows.Forms.StatusBar
$statusBar.Text = "Ready - This script was created by Ulises Cune (@ulises2k)"

## Add controls to form ###
$form.SuspendLayout()
$form.Controls.Add($button)
$form.Controls.Add($button2)
$form.Controls.Add($checkbox)
$form.Controls.Add($label)
$form.Controls.Add($listBox)
$form.Controls.Add($statusBar)
$form.Controls.Add($comboBox)
$form.ResumeLayout()

### Write event handlers ###
$button_Click = {
    foreach ($item in $listBox.Items) {
        $i = Get-Item -LiteralPath $item
        if (!($i -is [System.IO.DirectoryInfo])) {
            if (Button -filePath $item) {
                [System.Windows.Forms.MessageBox]::Show('Successful - ' + $button.Text, 'Defaults Values', 0, 64)
            }
        }
    }

    if ($checkbox.Checked -eq $True) {
        $listBox.Items.Clear()
    }

    $statusBar.Text = ("List contains $($listBox.Items.Count) items")
}

$button2_Click = {
    foreach ($item in $listBox.Items) {
        $i = Get-Item -LiteralPath $item
        if (!($i -is [System.IO.DirectoryInfo])) {
            if (Button2 -filePath $item) {
                [System.Windows.Forms.MessageBox]::Show('Successful Renamed', 'Rename', 0, 64)
            }
        }
    }

    $statusBar.Text = ("Renamed $($listBox.Items.Count)")
}



$listBox_DragOver = [System.Windows.Forms.DragEventHandler] {
    if ($_.Data.GetDataPresent([Windows.Forms.DataFormats]::FileDrop)) {
        # $_ = [System.Windows.Forms.DragEventArgs]
        $_.Effect = 'Copy'
    }
    else {
        $_.Effect = 'None'
    }
}

$listBox_DragDrop = [System.Windows.Forms.DragEventHandler] {
    foreach ($filename in $_.Data.GetData([Windows.Forms.DataFormats]::FileDrop)) {
        # $_ = [System.Windows.Forms.DragEventArgs]
        $listBox.Items.Add($filename)
    }
    $statusBar.Text = ("List contains $($listBox.Items.Count) items")
}

$form_FormClosed = {
    try {
        $listBox.remove_Click($button_Click)
        $listBox.remove_Click($button2_Click)
        $listBox.remove_DragOver($listBox_DragOver)
        $listBox.remove_DragDrop($listBox_DragDrop)
        $form.remove_FormClosed($Form_Cleanup_FormClosed)
    }
    catch [Exception]
    { }
}

### Wire up events ###
### Wire up events ###
$button.Add_Click($button_Click)
$button2.Add_Click($button2_Click)
$listBox.Add_DragOver($listBox_DragOver)
$listBox.Add_DragDrop($listBox_DragDrop)
$form.Add_FormClosed($form_FormClosed)

#### Show form ###
[void] $form.ShowDialog()
