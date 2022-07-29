# Defaults Settings for Production (live) Setting File
#
# Autor: Ulises Cune (@Ulises2k)
#
#
# !!!! It version is for CommunityPower EA !!!!
#
#
# Windows 2008
# Set-ExecutionPolicy RemoteSigned
#
# Windows 2008
# Set-ExecutionPolicy Restricted
#
#RUN, open "cmd.exe" and write this:
#powershell -ExecutionPolicy Bypass -File "CommunityPowerEA_MyDefault.ps1"
#
#
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
#
#Correlaciones
#https://www.mataf.net/es/forex/tools/correlation
#
#; My Defaults
function MyDefault([string]$filePath) {

    #$PathDest = (Get-Item $filePath).BaseName + "-Optimized.set"
    $PathDest = (Get-Item $filePath).BaseName + ".set"
    $CurrentDir = Split-Path -Path "$filePath"
    $filePathNew = "$CurrentDir\$PathDest"
    #Copy-Item "$filePath" -Destination $filePathNew

    $filePath = $filePathNew

    Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
        BinanceTradeConnector_Settings = "===== Binance ====="
        Expert_Properties              = "===== Expert ====="
        Expert_Id                      = "249"
        Expert_Comment                 = "CP" + (Get-Date -Format "dd.MM.yyyy.HH:mm")
        Lot_Properties                 = "===== Lot ====="
        Hedge_Properties               = "===== Hedge ====="
        GlobalAccount_Properties       = "===== Global Account ====="
        DL_Properties                  = "===== Daily limits ====="
        WL_Properties                  = "===== Weekly limits ====="
        ML_Properties                  = "===== Monthly limits ====="
        CL_Properties                  = "===== Common limits properties ====="
        VolPV_Properties               = "===== Volatility for all parameters nominated in points ====="
        Pending_Properties             = "===== Pending entry ====="
        StopLoss_Properties            = "===== Stop Loss ====="
        StopLoss_Global                = "===== Summ Stop Loss (buy + sell) ====="
        StopLoss_Pause                 = "===== Pause after loss ====="
        UseVirtualSL                   = "false"
        TakeProfit_Properties          = "===== Take Profit ====="
        TakeProfit_ReduceAfter         = "===== Reduce Take Profit after minutes ====="
        TakeProfit_ReduceSeries        = "===== Reduce Take Profit for every order ====="
        TakeProfit_Global              = "===== Summ Take Profit (buy + sell) ====="
        MinProfitToClose_Properties    = "===== Min profit to close on signal ====="
        UseVirtualTP                   = "false"
    }

    Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
        TrailingStop_Properties     = "===== Trailing Stop ====="
        Martingale_Properties       = "===== Martingale ====="
        BE_Alert_After              = "0"
        AllowBoth_Properties        = "===== Allow both Martin and Anti-martin ====="
        PartialClose_Properties     = "===== Partial Close ====="
        GlobalMartingail_Properties = "===== Apply martin to the new deals ====="
        AntiMartingale_Properties   = "===== Anti-Martingale ====="
    }

    Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
        DirChange_Properties     = "===== Directional Change ====="
        BigCandle_Properties     = "===== Big Candle ====="
        Oscillators_Properties   = "===== Oscillator #1 ====="
        Oscillator2_Properties   = "===== Oscillator #2 ====="
        Oscillator3_Properties   = "===== Oscillator #3 ====="
        IdentifyTrend_Properties = "===== IdentifyTrend ====="
        TDI_Properties           = "===== TDI ====="
        MACD_Properties          = "===== MACD #1 ====="
        MACD2_Properties         = "===== MACD #2 ====="
        ADX_Properties           = "===== ADX ====="
        DTrend_Properties        = "===== DTrend ====="
        PSar_Properties          = "===== Parabolic SAR ====="
        MA_Filter_1_Properties   = "===== MA Filter #1 ====="
        MA_Filter_2_Properties   = "===== MA Filter #2 ====="
        MA_Filter_3_Properties   = "===== MA Filter #3 ====="
        ZZ_Properties            = "===== ZigZag ====="
        VolMA_Properties         = "===== Volatility for MA and ZigZag Filters distance ====="
        VolFilter_Properties     = "===== Volatility Filter ====="
        FIBO_Properties          = "===== FIBO #1 ====="
        FIB2_Properties          = "===== FIBO #2 ====="
        CustomIndy1_Properties   = "===== Custom Indy #1 ====="
        CustomIndy2_Properties   = "===== Custom Indy #2 ====="
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
        StopLoss_Style             = "3"
        StopLoss_ColorB            = "5737262"
        StopLoss_ColorS            = "1993170"
        BreakEven_Width            = "1"
        BreakEven_Style            = "0"
        TakeProfit_ColorB          = "65280"
        TakeProfit_ColorS          = "255"
        GUI_Settings               = "===== GUI ====="
        ManageManual               = "true"
        GUI_Enabled                = "false"
        ShowOrders_Settings        = "===== Show Orders ====="
        Show_Opened                = "1"
        Show_Closed                = "true"
        Color_Properties           = "===== Main Color ====="
        Profit_Properties          = "===== Take Profit ====="
        Profit_ShowInMoney         = "true"
        Profit_ShowInPoints        = "true"
        Profit_ShowInPercents      = "true"
        Profit_Aggregate           = "true"
        ProfitDigitsToShow         = "1"
        Style_Properties           = "===== Style ====="
        Open_Close_Line_Width      = "1"
        Open_Close_Line_Style      = "2"
        Open_PriceLabel_Width      = "1"
        Close_PriceLabel_Width     = "1"
        SL_TP_Dashes_Show          = "true"
        SL_TP_Lines_Width          = "1"
        SL_TP_Lines_Style          = "2"
        Expiration_Width           = "0"
        Expiration_Style           = "2"
        Notifications_Settings     = "===== Notifications ====="
        MessagesToGrammy           = "false"
        Alerts_Enabled             = "false"
        Sounds_Enabled             = "false"
        Optimization_Settings      = "===== Optimization ====="
    }

    Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
        TakeProfit_Width = "2"
        TakeProfit_Style = "3"
        BreakEven_ColorB = "3329330"
        BreakEven_ColorS = "17919"
        MaxHistoryDeals  = "10"
    }


    #Read All Setting File parameters
    $inifile = Get-IniFile($filePath)

    #Detect Exist a Custom Indicator. Version => 2.49.2.1(BETA)
    $CustomIndy1_Type = [int]$inifile["CustomIndy1_Type"]
    if ($CustomIndy1_Type -ne 0) {
        $CustomIndy1_DrawShortName = [string]$inifile["CustomIndy1_DrawShortName"]
        Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
            CustomIndy1_Properties = "===== " + $CustomIndy1_DrawShortName + " ====="
        }
    }
    $CustomIndy2_Type = [int]$inifile["CustomIndy2_Type"]
    if ($CustomIndy2_Type -ne 0) {
        $CustomIndy2_DrawShortName = [string]$inifile["CustomIndy2_DrawShortName"]
        Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
            CustomIndy2_Properties = "===== " + $CustomIndy2_DrawShortName + " ====="
        }
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
    #Tokyo      2:00    10:00 (Europe/Helsinki)
    #Hong Kong  3:00    11:00
    #Singapore  2:00    10:00
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
    #Frankfurt  9:00    17:00
    #London     10:00   18:00 (Europe/Helsinki)
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
    #New York   15:00   23:00 (Europe/Helsinki)
    #Chicago    16:00   24:00
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
    #Sidney     1:00    9:00 (Europe/Helsinki)
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

    #DateTime-EUR/USD Time
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

    #DateTime-XAU/USD Time
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

    #MyDefault-EUR/USD Time
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

    #Default-AUD/USD Time
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
    #$Pending_Type = [int]$inifile["Pending_Type"]
    #if ($Pending_Type -eq 0) {
    #    Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
    #        NextOrder_Width = "0"
    #        Show_Pending    = "false"
    #    }
    #}
    #else {
    #    Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
    #        NextOrder_Width = "1"
    #        Show_Pending    = "true"
    #    }
    #}

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


    #If not Enabled, Don't use for open
    $DirChange_Type = [int]$inifile["DirChange_Type"]
    if ($DirChange_Type -eq 0) {
        Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
            DirChange_OpenOn = "0"
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
            Oscillators_MartinOn       = "0"
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
    $ADX_OpenOn = [int]$inifile["ADX_OpenOn"]
    $ADX_MartinOn = [int]$inifile["ADX_MartinOn"]
    $ADX_CloseOn = [int]$inifile["ADX_CloseOn"]
    $ADX_PartialCloseOn = [int]$inifile["ADX_PartialCloseOn"]
    $ADX_HedgeOn = [int]$inifile["ADX_HedgeOn"]
    if (($ADX_OpenOn -eq 0) -and ($ADX_MartinOn -eq 0) -and ($ADX_CloseOn -eq 0) -and ($ADX_PartialCloseOn -eq 0) -and ($ADX_HedgeOn -eq 0)) {
        Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
            ADX_Type = "0"
        }
    }
    #If not Enabled, Don't use for open/Don't use for close/Don't use for partial close
    $ADX_Type = [int]$inifile["ADX_Type"]
    if ($ADX_Type -eq 0) {
        Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
            ADX_OpenOn         = "0"
            ADX_MartinOn       = "0"
            ADX_CloseOn        = "0"
            ADX_PartialCloseOn = "0"
            ADX_HedgeOn        = "0"
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
    $CustomIndy1_OpenOn = [int]$inifile["CustomIndy1_OpenOn"]
    $CustomIndy1_MartinOn = [int]$inifile["CustomIndy1_MartinOn"]
    $CustomIndy1_CloseOn = [int]$inifile["CustomIndy1_CloseOn"]
    $CustomIndy1_PartialCloseOn = [int]$inifile["CustomIndy1_PartialCloseOn"]
    $CustomIndy1_HedgeOn = [int]$inifile["CustomIndy1_HedgeOn"]
    if (($CustomIndy1_OpenOn -eq 0) -and ($CustomIndy1_MartinOn -eq 0) -and ($CustomIndy1_CloseOn -eq 0) -and ($CustomIndy1_PartialCloseOn -eq 0) -and ($CustomIndy1_HedgeOn -eq 0)) {
        Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
            CustomIndy1_Type = "0"
        }
    }
    #If not Enabled, Don't use for open/Don't use for close/Don't use for partial close
    $CustomIndy1_Type = [int]$inifile["CustomIndy1_Type"]
    if ($CustomIndy1_Mode -eq 0) {
        Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
            CustomIndy1_OpenOn         = "0"
            CustomIndy1_MartinOn       = "0"
            CustomIndy1_CloseOn        = "0"
            CustomIndy1_PartialCloseOn = "0"
            CustomIndy1_HedgeOn        = "0"
        }
    }

    #If not select Open/OpenMartin/Close/Partial/HedgeOn Disable Volatility Filter
    $CustomIndy2_OpenOn = [int]$inifile["CustomIndy2_OpenOn"]
    $CustomIndy2_MartinOn = [int]$inifile["CustomIndy2_MartinOn"]
    $CustomIndy2_CloseOn = [int]$inifile["CustomIndy2_CloseOn"]
    $CustomIndy2_PartialCloseOn = [int]$inifile["CustomIndy2_PartialCloseOn"]
    $CustomIndy2_HedgeOn = [int]$inifile["CustomIndy2_HedgeOn"]
    if (($CustomIndy2_OpenOn -eq 0) -and ($CustomIndy2_MartinOn -eq 0) -and ($CustomIndy2_CloseOn -eq 0) -and ($CustomIndy2_PartialCloseOn -eq 0) -and ($CustomIndy2_HedgeOn -eq 0)) {
        Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
            CustomIndy2_Type = "0"
        }
    }
    #If not Enabled, Don't use for open/Don't use for close/Don't use for partial close
    $CustomIndy2_Type = [int]$inifile["CustomIndy2_Type"]
    if ($CustomIndy2_Mode -eq 0) {
        Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
            CustomIndy2_OpenOn         = "0"
            CustomIndy2_MartinOn       = "0"
            CustomIndy2_CloseOn        = "0"
            CustomIndy2_PartialCloseOn = "0"
            CustomIndy2_HedgeOn        = "0"
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

#; Rename Setting File
function ButtonRename([string]$filePath) {

    $fileNewName = "_"

    #Read All Setting File parameters
    $inifile = Get-IniFile($filePath)

    $VolPV_Type = [int]$inifile["VolPV_Type"]
    if ($VolPV_Type -eq 1) {
        $fileNewName = $fileNewName + "VolParamATR_"
    }
    elseif ($VolPV_Type -eq 2) {
        $fileNewName = $fileNewName + "VolParamStdDev_"
    }
    elseif ($VolPV_Type -eq 3) {
        $fileNewName = $fileNewName + "VolParamATR_CloseOpen_"
    }
    elseif ($VolPV_Type -eq 4) {
        $fileNewName = $fileNewName + "VolParamWATR_"
    }
    elseif ($VolPV_Type -eq 5) {
        $fileNewName = $fileNewName + "VolParamVolume_"
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
        elseif ($Oscillators_Indicator -eq 5) {
            #Andrey change the number of index
            $fileNewName = $fileNewName + "StochasticD1_"
        }
        elseif ($Oscillators_Indicator -eq 4) {
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
        elseif ($Oscillator2_Indicator -eq 5) {
            #Andrey change the number of index
            $fileNewName = $fileNewName + "StochasticD2_"
        }
        elseif ($Oscillator2_Indicator -eq 4) {
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
        elseif ($Oscillator3_Indicator -eq 5) {
            #Andrey change the number of index
            $fileNewName = $fileNewName + "StochasticD3_"
        }
        elseif ($Oscillator3_Indicator -eq 4) {
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

    $ADX = [int]$inifile["ADX_Type"]
    if ($ADX -ne 0) {
        $fileNewName = $fileNewName + "ADX_"
    }

    $DTrend = [int]$inifile["DTrend_Type"]
    if ($DTrend -ne 0) {
        $fileNewName = $fileNewName + "DTrend_"
    }

    $PSar_Type = [int]$inifile["PSar_Type"]
    if ($PSar_Type -eq 1) {
        #Parabolic SAR Direction
        $fileNewName = $fileNewName + "PSarDirection_"
    }
    elseif ($PSar_Type -eq 2) {
        #Parabolic SAR Signal
        $fileNewName = $fileNewName + "PSarSignal_"
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
        elseif ($MA_Filter_1_Method -eq 9) {
            #Andrey not use Index 8(v2.38) "reserved for MODE_TRIX"
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
        elseif ($MA_Filter_2_Method -eq 9) {
            #Andrey not use Index 8(v2.38) "reserved for MODE_TRIX"
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
            #Andrey not use Index 8(v2.38) "reserved for MODE_TRIX"
            $fileNewName = $fileNewName + "MA3_HMA_"
        }
    }

    $ZZ = [int]$inifile["ZZ_Type"]
    if ($ZZ -ne 0) {
        $fileNewName = $fileNewName + "ZZ_"
    }

    $VolFilter = [int]$inifile["VolFilter_Type"]
    if ($VolFilter -eq 1) {
        $fileNewName = $fileNewName + "VolFilterATR_"
    }
    elseif ($VolFilter -eq 2) {
        $fileNewName = $fileNewName + "VolFilterStdDev_"
    }
    elseif ($VolFilter -eq 3) {
        $fileNewName = $fileNewName + "VolFilterATR_CloseOpen_"
    }
    elseif ($VolFilter -eq 4) {
        $fileNewName = $fileNewName + "VolFilterWATR_"
    }
    elseif ($VolFilter -eq 5) {
        $fileNewName = $fileNewName + "VolFilterVolume_"
    }

    $FIBO = [int]$inifile["FIBO_Type"]
    if ($FIBO -ne 0) {
        $fileNewName = $fileNewName + "FIBO1_"
    }

    $FIB2 = [int]$inifile["FIB2_Type"]
    if ($FIB2 -ne 0) {
        $fileNewName = $fileNewName + "FIBO2_"
    }

    $CustomIndy1 = [int]$inifile["CustomIndy1_Type"]
    if ($CustomIndy1 -ne 0) {
        $CustomIndy1_DrawShortName = [string]$inifile["CustomIndy1_DrawShortName"]
        $fileNewName = $fileNewName + "CustomIndy1_" + $CustomIndy1_DrawShortName + "_"
    }

    $CustomIndy2 = [int]$inifile["CustomIndy1_Type"]
    if ($CustomIndy2 -ne 0) {
        $CustomIndy2_DrawShortName = [string]$inifile["CustomIndy2_DrawShortName"]
        $fileNewName = $fileNewName + "CustomIndy2_" + $CustomIndy2_DrawShortName + "_"
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

function Button2EMACross_1([string]$filePath) {
    #$PathDest = (Get-Item $filePath).BaseName + "-Optimized.set"
    $PathDest = (Get-Item $filePath).BaseName + ".set"
    $CurrentDir = Split-Path -Path "$filePath"
    $filePathNew = "$CurrentDir\$PathDest"
    #Copy-Item "$filePath" -Destination $filePathNew

    $filePath = $filePathNew

    Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
        MACD_Properties      = "===== 2 EMA Cross #1 ====="
        MACD_Type            = "1"
        MACD_TF              = "5"
        MACD_PeriodFast      = "20"
        MACD_FastMA_Method   = "1"
        MACD_PeriodSlow      = "50"
        MACD_SlowMA_Method   = "1"
        MACD_PeriodSignal    = "9"
        MACD_SignalMA_Method = "0"
        MACD_Price           = "1"
        MACD_JMA_Phase       = "0"
        MACD_Reverse         = "false"
        MACD_UseClosedBars   = "true"
        MACD_OpenOn          = "1"
        MACD_MartinOn        = "0"
        MACD_HedgeOn         = "0"
        MACD_CloseOn         = "1"
        MACD_PartialCloseOn  = "0"

    }

    return $true
}

function Button2EMACross_2([string]$filePath) {
    #$PathDest = (Get-Item $filePath).BaseName + "-Optimized.set"
    $PathDest = (Get-Item $filePath).BaseName + ".set"
    $CurrentDir = Split-Path -Path "$filePath"
    $filePathNew = "$CurrentDir\$PathDest"
    #Copy-Item "$filePath" -Destination $filePathNew

    $filePath = $filePathNew

    Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
        MACD2_Properties      = "===== 2 EMA Cross #2 ====="
        MACD2_Type            = "1"
        MACD2_TF              = "5"
        MACD2_PeriodFast      = "20"
        MACD2_FastMA_Method   = "1"
        MACD2_PeriodSlow      = "50"
        MACD2_SlowMA_Method   = "1"
        MACD2_PeriodSignal    = "9"
        MACD2_SignalMA_Method = "0"
        MACD2_Price           = "1"
        MACD2_JMA_Phase       = "0"
        MACD2_Reverse         = "false"
        MACD2_UseClosedBars   = "true"
        MACD2_OpenOn          = "1"
        MACD2_MartinOn        = "0"
        MACD2_HedgeOn         = "0"
        MACD2_CloseOn         = "1"
        MACD2_PartialCloseOn  = "0"
    }

    return $true
}

#Bollinger Bands Explained
#https://academy.binance.com/en/articles/bollinger-bands-explained
#
#https://admiralmarkets.com/es/education/articles/forex-strategy/bandas-de-bollinger
#Bandas de Bollinger y RSI
#En esta estrategia de trading vamos a utilizar los indicadores Bandas de Bollinger y RSI. El indicador RSI actúa como filtro para tratar de mejorar la efectividad de las señales generadas con las bandas de Bollinger. Esto reduce el número de operaciones, pero debería aumentar la proporción de posiciones ganadoras.
#
#https://www.investopedia.com/terms/b/bollingerbands.asp
#The following traits are particular to the Bollinger Band:
#abrupt changes in prices tend to happen after the band has contracted due to decrease of volatility;
#if prices break through one of the bands, a continuation of the current trend is to be expected;
#if the pikes and hollows outside the band are followed by pikes and hollows inside the band, a reverse of trend may occur;
#the price movement that has started from one of the band’s lines usually reaches the opposite one.
#ML = SUM (CLOSE, N) / N = SMA (CLOSE, N)
#TL = ML + (D * StdDev)
#BL = ML - (D * StdDev)
function ButtonBollingerBands_1([string]$filePath) {

    #$PathDest = (Get-Item $filePath).BaseName + "-Optimized.set"
    $PathDest = (Get-Item $filePath).BaseName + ".set"
    $CurrentDir = Split-Path -Path "$filePath"
    $filePathNew = "$CurrentDir\$PathDest"
    #Copy-Item "$filePath" -Destination $filePathNew

    $filePath = $filePathNew

    Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
        MA_Filter_1_Properties     = "===== BollingerBands #1 ====="
        MA_Filter_1_Type           = "1"
        MA_Filter_1_TF             = "5"
        MA_Filter_1_Period         = "20"
        MA_Filter_1_Method         = "0"
        MA_Filter_1_Price          = "1"
        MA_Filter_1_DistType       = "1"
        MA_Filter_1_DistCoef       = "2"
        MA_Filter_1_OpenOn         = "1"
        MA_Filter_1_MartinOn       = "0"
        MA_Filter_1_CloseOn        = "1"
        MA_Filter_1_PartialCloseOn = "0"

    }
    Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
        VolMA_Properties = "===== Volatility for BollingerBands #1 ====="
        VolMA_Type       = "2"
        VolMA_TF         = "5"
        VolMA_Period     = "20"
    }

    return $true
}

#https://www.metatrader5.com/en/terminal/help/indicators/trend_indicators/bb
#https://www.investopedia.com/terms/b/bollingerbands.asp
#The following traits are particular to the Bollinger Band:
#abrupt changes in prices tend to happen after the band has contracted due to decrease of volatility;
#if prices break through one of the bands, a continuation of the current trend is to be expected;
#if the pikes and hollows outside the band are followed by pikes and hollows inside the band, a reverse of trend may occur;
#the price movement that has started from one of the band’s lines usually reaches the opposite one.
#ML = SUM (CLOSE, N) / N = SMA (CLOSE, N)
#TL = ML + (D * StdDev)
#BL = ML - (D * StdDev)
function ButtonBollingerBands_2([string]$filePath) {

    #$PathDest = (Get-Item $filePath).BaseName + "-Optimized.set"
    $PathDest = (Get-Item $filePath).BaseName + ".set"
    $CurrentDir = Split-Path -Path "$filePath"
    $filePathNew = "$CurrentDir\$PathDest"
    #Copy-Item "$filePath" -Destination $filePathNew

    $filePath = $filePathNew

    Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
        MA_Filter_2_Properties     = "===== BollingerBands #2 ====="
        MA_Filter_2_Type           = "1"
        MA_Filter_2_TF             = "5"
        MA_Filter_2_Period         = "20"
        MA_Filter_2_Method         = "0"
        MA_Filter_2_Price          = "1"
        MA_Filter_2_DistType       = "1"
        MA_Filter_2_DistCoef       = "2"
        MA_Filter_2_OpenOn         = "1"
        MA_Filter_2_MartinOn       = "0"
        MA_Filter_2_CloseOn        = "1"
        MA_Filter_2_PartialCloseOn = "0"

    }
    Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
        VolMA_Properties = "===== Volatility for BollingerBands #2 ====="
        VolMA_Type       = "2"
        VolMA_TF         = "5"
        VolMA_Period     = "20"
    }

    return $true
}

#https://www.investopedia.com/terms/b/bollingerbands.asp
#The following traits are particular to the Bollinger Band:
#abrupt changes in prices tend to happen after the band has contracted due to decrease of volatility;
#if prices break through one of the bands, a continuation of the current trend is to be expected;
#if the pikes and hollows outside the band are followed by pikes and hollows inside the band, a reverse of trend may occur;
#the price movement that has started from one of the band’s lines usually reaches the opposite one.
#ML = SUM (CLOSE, N) / N = SMA (CLOSE, N)
#TL = ML + (D * StdDev)
#BL = ML - (D * StdDev)
function ButtonBollingerBands_3([string]$filePath) {

    #$PathDest = (Get-Item $filePath).BaseName + "-Optimized.set"
    $PathDest = (Get-Item $filePath).BaseName + ".set"
    $CurrentDir = Split-Path -Path "$filePath"
    $filePathNew = "$CurrentDir\$PathDest"
    #Copy-Item "$filePath" -Destination $filePathNew

    $filePath = $filePathNew

    Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
        MA_Filter_3_Properties     = "===== BollingerBands #3 ====="
        MA_Filter_3_Type           = "1"
        MA_Filter_3_TF             = "5"
        MA_Filter_3_Period         = "20"
        MA_Filter_3_Method         = "0"
        MA_Filter_3_Price          = "1"
        MA_Filter_3_DistType       = "1"
        MA_Filter_3_DistCoef       = "2"
        MA_Filter_3_OpenOn         = "1"
        MA_Filter_3_MartinOn       = "0"
        MA_Filter_3_CloseOn        = "1"
        MA_Filter_3_PartialCloseOn = "0"

    }
    Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
        VolMA_Properties = "===== Volatility for BollingerBands #3 ====="
        VolMA_Type       = "2"
        VolMA_TF         = "5"
        VolMA_Period     = "20"
    }

    return $true
}


#https://www.mql5.com/en/market/product/79942?source=Site+Search#description
#BB Squeeze MT5
#KT BB Squeeze measures the contraction and expansion of market volatility with a momentum oscillator, which can be used to decide a trading direction. It measures the squeeze in volatility by deducing the relationship between the Bollinger Bands and Keltner channels.
#Momentum(20)
#Bollinger Bands Period(20)
#Bollinger Bands Deviation(2.0)
#Keltner Channels Period (20)
#Keltner Channels Multiplication (1.5)
#The gray dots represent the period of low volatility when Bollinger Bands are inside the Keltner channels.
#The white dots represent the period of high volatility when Bollinger Bands are outside the Keltner channels.


#Keltner Channel - indicator for MetaTrader 5
#https://www.mql5.com/en/code/399
#
#https://www.investopedia.com/terms/k/keltnerchannel.asp
#Keltner Channels are volatility-based bands that are placed on either side of an asset's price and can aid in determining the direction of a trend.
#The Keltner channel uses the average-true range (ATR) or volatility, with breaks above or below the top and bottom barriers signaling a continuation.
#Keltner Channel Calculation
#Keltner Channel Middle Line=EMA
#Keltner Channel Upper Band=EMA+2∗ATR
#Keltner Channel Lower Band=EMA−2∗ATR
#The exponential moving average (EMA) of a Keltner Channel is typically 20 periods, although this can be adjusted if desired.
#The upper and lower bands are typically set two times the average true range (ATR) above and below the EMA, although the multiplier can also be adjusted based on personal preference.
#Price reaching the upper Keltner Channel band is bullish, while reaching the lower band is bearish.
#The angle of the Keltner Channel also aids in identifying the trend direction. The price may also oscillate between the upper and lower Keltner Channel bands, which can be interpreted as resistance and support levels.

#Good Result
#TF=1M
#Smoothed(20) + 2*ATR(20)
#EMA(20) + 2*ATR(10)
function ButtonKeltnerChannel_1([string]$filePath) {

    #$PathDest = (Get-Item $filePath).BaseName + "-Optimized.set"
    $PathDest = (Get-Item $filePath).BaseName + ".set"
    $CurrentDir = Split-Path -Path "$filePath"
    $filePathNew = "$CurrentDir\$PathDest"
    #Copy-Item "$filePath" -Destination $filePathNew

    $filePath = $filePathNew

    Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
        MA_Filter_1_Properties     = "===== Keltner Channel #1 ====="
        MA_Filter_1_Type           = "1"
        MA_Filter_1_TF             = "1"
        MA_Filter_1_Period         = "20"
        MA_Filter_1_Method         = "1"
        MA_Filter_1_Price          = "1"
        MA_Filter_1_DistType       = "1"
        MA_Filter_1_DistCoef       = "2"
        MA_Filter_1_OpenOn         = "1"
        MA_Filter_1_MartinOn       = "0"
        MA_Filter_1_CloseOn        = "1"
        MA_Filter_1_PartialCloseOn = "0"
    }
    Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
        VolMA_Properties = "===== Volatility for Keltner Channel #1 ====="
        VolMA_Type       = "1"
        VolMA_TF         = "1"
        VolMA_Period     = "10"
    }

    return $true
}

#https://www.investopedia.com/terms/k/keltnerchannel.asp
#Keltner Channels are volatility-based bands that are placed on either side of an asset's price and can aid in determining the direction of a trend.
#The Keltner channel uses the average-true range (ATR) or volatility, with breaks above or below the top and bottom barriers signaling a continuation.
#Keltner Channel Calculation
#Keltner Channel Middle Line=EMA
#Keltner Channel Upper Band=EMA+2∗ATR
#Keltner Channel Lower Band=EMA−2∗ATR
#The exponential moving average (EMA) of a Keltner Channel is typically 20 periods, although this can be adjusted if desired.
#The upper and lower bands are typically set two times the average true range (ATR) above and below the EMA, although the multiplier can also be adjusted based on personal preference.
#Price reaching the upper Keltner Channel band is bullish, while reaching the lower band is bearish.
#The angle of the Keltner Channel also aids in identifying the trend direction. The price may also oscillate between the upper and lower Keltner Channel bands, which can be interpreted as resistance and support levels.
function ButtonKeltnerChannel_2([string]$filePath) {

    #$PathDest = (Get-Item $filePath).BaseName + "-Optimized.set"
    $PathDest = (Get-Item $filePath).BaseName + ".set"
    $CurrentDir = Split-Path -Path "$filePath"
    $filePathNew = "$CurrentDir\$PathDest"
    #Copy-Item "$filePath" -Destination $filePathNew

    $filePath = $filePathNew

    Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
        MA_Filter_2_Properties     = "===== Keltner Channel #2 ====="
        MA_Filter_2_Type           = "1"
        MA_Filter_2_TF             = "1"
        MA_Filter_2_Period         = "20"
        MA_Filter_2_Method         = "1"
        MA_Filter_2_Price          = "1"
        MA_Filter_2_DistType       = "1"
        MA_Filter_2_DistCoef       = "2"
        MA_Filter_2_OpenOn         = "1"
        MA_Filter_2_MartinOn       = "0"
        MA_Filter_2_CloseOn        = "1"
        MA_Filter_2_PartialCloseOn = "0"
    }
    Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
        VolMA_Properties = "===== Volatility for Keltner Channel #2 ====="
        VolMA_Type       = "1"
        VolMA_TF         = "1"
        VolMA_Period     = "20"
    }

    return $true
}

#https://www.investopedia.com/terms/k/keltnerchannel.asp
#Keltner Channels are volatility-based bands that are placed on either side of an asset's price and can aid in determining the direction of a trend.
#The Keltner channel uses the average-true range (ATR) or volatility, with breaks above or below the top and bottom barriers signaling a continuation.
#Keltner Channel Calculation
#Keltner Channel Middle Line=EMA
#Keltner Channel Upper Band=EMA+2∗ATR
#Keltner Channel Lower Band=EMA−2∗ATR
#The exponential moving average (EMA) of a Keltner Channel is typically 20 periods, although this can be adjusted if desired.
#The upper and lower bands are typically set two times the average true range (ATR) above and below the EMA, although the multiplier can also be adjusted based on personal preference.
#Price reaching the upper Keltner Channel band is bullish, while reaching the lower band is bearish.
#The angle of the Keltner Channel also aids in identifying the trend direction. The price may also oscillate between the upper and lower Keltner Channel bands, which can be interpreted as resistance and support levels.
function ButtonKeltnerChannel_3([string]$filePath) {

    #$PathDest = (Get-Item $filePath).BaseName + "-Optimized.set"
    $PathDest = (Get-Item $filePath).BaseName + ".set"
    $CurrentDir = Split-Path -Path "$filePath"
    $filePathNew = "$CurrentDir\$PathDest"
    #Copy-Item "$filePath" -Destination $filePathNew

    $filePath = $filePathNew

    Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
        MA_Filter_3_Properties     = "===== Keltner Channel #3 ====="
        MA_Filter_3_Type           = "1"
        MA_Filter_3_TF             = "1"
        MA_Filter_3_Period         = "20"
        MA_Filter_3_Method         = "0"
        MA_Filter_3_Price          = "1"
        MA_Filter_3_DistType       = "1"
        MA_Filter_3_DistCoef       = "2"
        MA_Filter_3_OpenOn         = "1"
        MA_Filter_3_MartinOn       = "0"
        MA_Filter_3_CloseOn        = "1"
        MA_Filter_3_PartialCloseOn = "0"
    }
    Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
        VolMA_Properties = "===== Volatility for Keltner Channel #3 ====="
        VolMA_Type       = "1"
        VolMA_TF         = "1"
        VolMA_Period     = "10"
    }

    return $true
}

#https://www.investopedia.com/terms/s/starc.asp
#Stoller Average Range Channel
#STARC Band +=SMA+(Multiplier×ATR)
#STARC Band −=SMA−(Multiplier×ATR)
function ButtonSTARC_1([string]$filePath) {

    #$PathDest = (Get-Item $filePath).BaseName + "-Optimized.set"
    $PathDest = (Get-Item $filePath).BaseName + ".set"
    $CurrentDir = Split-Path -Path "$filePath"
    $filePathNew = "$CurrentDir\$PathDest"
    #Copy-Item "$filePath" -Destination $filePathNew

    $filePath = $filePathNew

    Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
        MA_Filter_1_Properties     = "===== Stoller Average Range Channel #1 ====="
        MA_Filter_1_Type           = "1"
        MA_Filter_1_TF             = "1"
        MA_Filter_1_Period         = "20"
        MA_Filter_1_Method         = "0"
        MA_Filter_1_Price          = "1"
        MA_Filter_1_DistType       = "1"
        MA_Filter_1_DistCoef       = "2"
        MA_Filter_1_OpenOn         = "1"
        MA_Filter_1_MartinOn       = "0"
        MA_Filter_1_CloseOn        = "1"
        MA_Filter_1_PartialCloseOn = "0"
    }
    Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
        VolMA_Properties = "===== Volatility for Stoller Average Range Channel #1 ====="
        VolMA_Type       = "1"
        VolMA_TF         = "1"
        VolMA_Period     = "10"
    }

    return $true
}

#https://www.investopedia.com/terms/s/starc.asp
#Stoller Average Range Channel
#STARC Band +=SMA+(Multiplier×ATR)
#STARC Band −=SMA−(Multiplier×ATR)
function ButtonSTARC_2([string]$filePath) {

    #$PathDest = (Get-Item $filePath).BaseName + "-Optimized.set"
    $PathDest = (Get-Item $filePath).BaseName + ".set"
    $CurrentDir = Split-Path -Path "$filePath"
    $filePathNew = "$CurrentDir\$PathDest"
    #Copy-Item "$filePath" -Destination $filePathNew

    $filePath = $filePathNew

    Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
        MA_Filter_2_Properties     = "===== Stoller Average Range Channel #2 ====="
        MA_Filter_2_Type           = "1"
        MA_Filter_2_TF             = "1"
        MA_Filter_2_Period         = "20"
        MA_Filter_2_Method         = "0"
        MA_Filter_2_Price          = "1"
        MA_Filter_2_DistType       = "1"
        MA_Filter_2_DistCoef       = "2"
        MA_Filter_2_OpenOn         = "1"
        MA_Filter_2_MartinOn       = "0"
        MA_Filter_2_CloseOn        = "1"
        MA_Filter_2_PartialCloseOn = "0"
    }
    Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
        VolMA_Properties = "===== Volatility for Stoller Average Range Channel #2 ====="
        VolMA_Type       = "1"
        VolMA_TF         = "1"
        VolMA_Period     = "10"
    }

    return $true
}

#https://www.investopedia.com/terms/s/starc.asp
#Stoller Average Range Channel
#STARC Band +=SMA+(Multiplier×ATR)
#STARC Band −=SMA−(Multiplier×ATR)
function ButtonSTARC_3([string]$filePath) {

    #$PathDest = (Get-Item $filePath).BaseName + "-Optimized.set"
    $PathDest = (Get-Item $filePath).BaseName + ".set"
    $CurrentDir = Split-Path -Path "$filePath"
    $filePathNew = "$CurrentDir\$PathDest"
    #Copy-Item "$filePath" -Destination $filePathNew

    $filePath = $filePathNew

    Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
        MA_Filter_3_Properties     = "===== Stoller Average Range Channel #3 ====="
        MA_Filter_3_Type           = "1"
        MA_Filter_3_TF             = "1"
        MA_Filter_3_Period         = "20"
        MA_Filter_3_Method         = "1"
        MA_Filter_3_Price          = "1"
        MA_Filter_3_DistType       = "1"
        MA_Filter_3_DistCoef       = "2"
        MA_Filter_3_OpenOn         = "1"
        MA_Filter_3_MartinOn       = "0"
        MA_Filter_3_CloseOn        = "1"
        MA_Filter_3_PartialCloseOn = "0"
    }
    Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
        VolMA_Properties = "===== Volatility for Stoller Average Range Channel #3 ====="
        VolMA_Type       = "1"
        VolMA_TF         = "1"
        VolMA_Period     = "10"
    }

    return $true
}

function ButtonCustomIndy_1([string]$filePath) {

    #Buffer Reader For MT5
    #The Buffer Reader will help you to check and export the custom indicators buffers data for your current chart and timeframe.
    #https://www.mql5.com/en/market/product/52964?source=Unknown

    #CustomIndy #1
    if (!($comboBox1.SelectedIndex -eq "-1")) {

        #SuperTrend
        #https://www.mql5.com/en/code/576
        #SetIndexBuffer(0,Filled_a,INDICATOR_DATA);
        #SetIndexBuffer(1,Filled_b,INDICATOR_DATA);
        #SetIndexBuffer(2,SuperTrend,INDICATOR_DATA);
        #SetIndexBuffer(3,ColorBuffer,INDICATOR_COLOR_INDEX);
        #SetIndexBuffer(4,Atr,INDICATOR_CALCULATIONS);
        #SetIndexBuffer(5,Up,INDICATOR_CALCULATIONS);
        #SetIndexBuffer(6,Down,INDICATOR_CALCULATIONS);
        #SetIndexBuffer(7,Middle,INDICATOR_CALCULATIONS);
        #SetIndexBuffer(8,trend,INDICATOR_CALCULATIONS);
        if ($comboBox1.SelectedItem.ToString() -eq "SuperTrend" ) {
            Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
                CustomIndy1_Label                = "SuperTrend Label"
                CustomIndy1_Type                 = "3"
                CustomIndy1_TF                   = "5"
                CustomIndy1_PathAndName          = "supertrend"
                CustomIndy1_ParametersStr        = "10,3,0"
                CustomIndy1_BufferB              = "2"
                CustomIndy1_BufferS              = "2"
                CustomIndy1_ColorBufferB         = "3"
                CustomIndy1_ColorBufferS         = "3"
                CustomIndy1_ColorIndexB          = "0"
                CustomIndy1_ColorIndexS          = "1"
                CustomIndy1_LevelMaxB            = "-999"
                CustomIndy1_LevelMinB            = "-999"
                CustomIndy1_LevelMaxS            = "-999"
                CustomIndy1_LevelMinS            = "-999"
                CustomIndy1_Reverse              = "false"
                CustomIndy1_UseClosedBars        = "true"
                CustomIndy1_DrawShortName        = "Supertrend"
                CustomIndy1_DrawInSubwindow      = "false"
                CustomIndy1_AllowNegativeAndZero = "true"
                CustomIndy1_OpenOn               = "1"
                CustomIndy1_MartinOn             = "0"
                CustomIndy1_HedgeOn              = "0"
                CustomIndy1_CloseOn              = "2"
                CustomIndy1_PartialCloseOn       = "0"
            }
        }

        #Bollinger bands breakout
        #https://www.mql5.com/en/code/24612
        #SetIndexBuffer(0,fupu    ,INDICATOR_DATA);
        #SetIndexBuffer(1,fupd    ,INDICATOR_DATA);
        #SetIndexBuffer(2,fdnu    ,INDICATOR_DATA);
        #SetIndexBuffer(3,fdnd    ,INDICATOR_DATA);
        #SetIndexBuffer(4,bufferUp,INDICATOR_DATA);
        #SetIndexBuffer(5,bufferDn,INDICATOR_DATA);
        #SetIndexBuffer(6,bufferMe,INDICATOR_DATA);
        #SetIndexBuffer(7,breakup ,INDICATOR_DATA); PlotIndexSetInteger(5,PLOT_ARROW,217); PlotIndexSetInteger(5,PLOT_ARROW_SHIFT,-10);
        #SetIndexBuffer(8,breakdn ,INDICATOR_DATA);
        if ($comboBox1.SelectedItem.ToString() -eq "Bollinger bands breakout" ) {
            Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
                CustomIndy1_Label                = "Bollinger bands breakout"
                CustomIndy1_Type                 = "3"
                CustomIndy1_TF                   = "5"
                CustomIndy1_PathAndName          = "Bollinger bands breakout"
                CustomIndy1_ParametersStr        = "20,1,2.0,20.0,1"
                CustomIndy1_BufferB              = "7"
                CustomIndy1_BufferS              = "8"
                CustomIndy1_ColorBufferB         = "-1"
                CustomIndy1_ColorBufferS         = "-1"
                CustomIndy1_ColorIndexB          = "-1"
                CustomIndy1_ColorIndexS          = "-1"
                CustomIndy1_LevelMaxB            = "-999"
                CustomIndy1_LevelMinB            = "-999"
                CustomIndy1_LevelMaxS            = "-999"
                CustomIndy1_LevelMinS            = "-999"
                CustomIndy1_Reverse              = "false"
                CustomIndy1_UseClosedBars        = "true"
                CustomIndy1_DrawShortName        = "Bollinger bands breakout"
                CustomIndy1_DrawInSubwindow      = "false"
                CustomIndy1_OpenOn               = "1"
                CustomIndy1_MartinOn             = "0"
                CustomIndy1_HedgeOn              = "0"
                CustomIndy1_CloseOn              = "2"
                CustomIndy1_PartialCloseOn       = "0"
            }
        }

        #Disable Custom Indicator
        if ($comboBox1.SelectedItem.ToString() -eq "DisableCustomIndy" ) {
            Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
                CustomIndy1_Properties           = "===== Custom Indy #1 ====="
                CustomIndy1_Label                = "Custom Indicator Label"
                CustomIndy1_Type                 = "0"
                CustomIndy1_TF                   = "0"
                CustomIndy1_PathAndName          = "MyIndicators\MyBestIndy"
                CustomIndy1_ParametersStr        = ""
                CustomIndy1_BufferB              = "-1"
                CustomIndy1_BufferS              = "-1"
                CustomIndy1_ColorBufferB         = "-1"
                CustomIndy1_ColorBufferS         = "-1"
                CustomIndy1_ColorIndexB          = "-1"
                CustomIndy1_ColorIndexS          = "-1"
                CustomIndy1_LevelMaxB            = "-999"
                CustomIndy1_LevelMinB            = "-999"
                CustomIndy1_LevelMaxS            = "-999"
                CustomIndy1_LevelMinS            = "-999"
                CustomIndy1_Reverse              = "false"
                CustomIndy1_UseClosedBars        = "true"
                CustomIndy1_DrawShortName        = "MyBestIndy"
                CustomIndy1_DrawInSubwindow      = "false"
                CustomIndy1_AllowNegativeAndZero = "true"
                CustomIndy1_OpenOn               = "0"
                CustomIndy1_MartinOn             = "0"
                CustomIndy1_HedgeOn              = "0"
                CustomIndy1_CloseOn              = "0"
                CustomIndy1_PartialCloseOn       = "0"
            }
        }

        if (!($comboBox1.SelectedItem.ToString() -eq "DisableCustomIndy" )) {
            #Read All Setting File parameters
            $inifile = Get-IniFile($filePath)

            #Detect Exist a Custom Indicator. Version => 2.49.2.1(BETA)
            $CustomIndy1_Type = [int]$inifile["CustomIndy1_Type"]
            if ($CustomIndy1_Type -ne 0) {
                $CustomIndy1_DrawShortName = [string]$inifile["CustomIndy1_DrawShortName"]
                Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
                    CustomIndy1_Properties = "===== " + $CustomIndy1_DrawShortName + " #1 ====="
                }
            }
        }

    }
    return $true
}

function ButtonCustomIndy_2([string]$filePath) {

    #Buffer Reader For MT5
    #The Buffer Reader will help you to check and export the custom indicators buffers data for your current chart and timeframe.
    #https://www.mql5.com/en/market/product/52964?source=Unknown

    #CustomIndy #2
    if (!($comboBox2.SelectedIndex -eq "-1")) {

        #SuperTrend
        #https://www.mql5.com/en/code/576
        if ($comboBox2.SelectedItem.ToString() -eq "SuperTrend" ) {
            Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
                CustomIndy2_Label                = "SuperTrend Label"
                CustomIndy2_Type                 = "3"
                CustomIndy2_TF                   = "5"
                CustomIndy2_PathAndName          = "supertrend"
                CustomIndy2_ParametersStr        = "10,3,0"
                CustomIndy2_BufferB              = "2"
                CustomIndy2_BufferS              = "2"
                CustomIndy2_ColorBufferB         = "3"
                CustomIndy2_ColorBufferS         = "3"
                CustomIndy2_ColorIndexB          = "0"
                CustomIndy2_ColorIndexS          = "1"
                CustomIndy2_LevelMaxB            = "-999"
                CustomIndy2_LevelMinB            = "-999"
                CustomIndy2_LevelMaxS            = "-999"
                CustomIndy2_LevelMinS            = "-999"
                CustomIndy2_Reverse              = "false"
                CustomIndy2_UseClosedBars        = "true"
                CustomIndy2_DrawShortName        = "Supertrend"
                CustomIndy2_DrawInSubwindow      = "false"
                CustomIndy2_AllowNegativeAndZero = "true"
                CustomIndy2_OpenOn               = "1"
                CustomIndy2_MartinOn             = "0"
                CustomIndy2_HedgeOn              = "0"
                CustomIndy2_CloseOn              = "2"
                CustomIndy2_PartialCloseOn       = "0"
            }
        }

        #Disable Custom Indicator
        if ($comboBox2.SelectedItem.ToString() -eq "DisableCustomIndy" ) {
            Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
                CustomIndy2_Properties           = "===== Custom Indy #2 ====="
                CustomIndy2_Label                = "Custom Indicator Label"
                CustomIndy2_Type                 = "0"
                CustomIndy2_TF                   = "0"
                CustomIndy2_PathAndName          = "MyIndicators\MyBestIndy"
                CustomIndy2_ParametersStr        = ""
                CustomIndy2_BufferB              = "-1"
                CustomIndy2_BufferS              = "-1"
                CustomIndy2_ColorBufferB         = "-1"
                CustomIndy2_ColorBufferS         = "-1"
                CustomIndy2_ColorIndexB          = "-1"
                CustomIndy2_ColorIndexS          = "-1"
                CustomIndy2_LevelMaxB            = "-999"
                CustomIndy2_LevelMinB            = "-999"
                CustomIndy2_LevelMaxS            = "-999"
                CustomIndy2_LevelMinS            = "-999"
                CustomIndy2_Reverse              = "false"
                CustomIndy2_UseClosedBars        = "true"
                CustomIndy2_DrawShortName        = "MyBestIndy"
                CustomIndy2_DrawInSubwindow      = "false"
                CustomIndy2_AllowNegativeAndZero = "true"
                CustomIndy2_OpenOn               = "0"
                CustomIndy2_MartinOn             = "0"
                CustomIndy2_HedgeOn              = "0"
                CustomIndy2_CloseOn              = "0"
                CustomIndy2_PartialCloseOn       = "0"
            }
        }

        if (!($comboBox2.SelectedItem.ToString() -eq "DisableCustomIndy" )) {
            #Read All Setting File parameters
            $inifile = Get-IniFile($filePath)

            #Detect Exist a Custom Indicator. Version => 2.49.2.1(BETA)
            $CustomIndy2_Type = [int]$inifile["CustomIndy2_Type"]
            if ($CustomIndy2_Type -ne 0) {
                $CustomIndy2_DrawShortName = [string]$inifile["CustomIndy2_DrawShortName"]
                Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
                    CustomIndy2_Properties = "===== " + $CustomIndy2_DrawShortName + " #2 ====="
                }
            }
        }
    }
    return $true
}
#######################GUI################################################################
### API Windows Forms ###
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")

### Create form ###
$form = New-Object System.Windows.Forms.Form
$form.Text = "My Defaults, Rename Setting File and Create Indicators - CommunityPower EA"
$form.Size = '800,500'
$form.StartPosition = "CenterScreen"
$form.MinimumSize = $form.Size
$form.MaximizeBox = $False
$form.Topmost = $True

### Define controls ###
# Combobox
$comboBox = New-Object System.Windows.Forms.ComboBox
$comboBox.Location = '280,10'
$comboBox.Size = '280,50'
$comboBox.DropDownStyle = 'DropDownList'
$comboBox.AutoCompleteSource = 'ListItems'
$comboBox.AutoCompleteMode = 'Append'
$comboBox.Items.AddRange( @("", "DisableTime", "ASIA(Tokyo/Hong Kong/Singapore)", "EUROPA(Frankfurt/London)" , "AMERICA(New York/Chicago)", "PACIFICO(Wellington/Sidney)", "DateTime-EUR/USD", "DateTime-XAU/USD", "MyDefault-EUR/USD"))

# Combobox
$comboBox1 = New-Object System.Windows.Forms.ComboBox
$comboBox1.Location = '370,100'
$comboBox1.Size = '190,50'
$comboBox1.DropDownStyle = 'DropDownList'
$comboBox1.AutoCompleteSource = 'ListItems'
$comboBox1.AutoCompleteMode = 'Append'
$comboBox1.Items.AddRange( @("", "DisableCustomIndy", "SuperTrend", "Bollinger bands breakout"))

# Combobox
$comboBox2 = New-Object System.Windows.Forms.ComboBox
$comboBox2.Location = '370,120'
$comboBox2.Size = '190,50'
$comboBox2.DropDownStyle = 'DropDownList'
$comboBox2.AutoCompleteSource = 'ListItems'
$comboBox2.AutoCompleteMode = 'Append'
$comboBox2.Items.AddRange( @("", "DisableCustomIndy", "SuperTrend", "Bollinger bands breakout"))

# Button
$button = New-Object System.Windows.Forms.Button
$button.Location = '5,10'
$button.Size = '75,20'
$button.Width = 200
$button.Text = "My Defaults"

# Button
$button2 = New-Object System.Windows.Forms.Button
$button2.Location = '5,40'
$button2.Size = '75,20'
$button2.Width = 200
$button2.Text = "Rename Setting File"

# Button
$button3 = New-Object System.Windows.Forms.Button
$button3.Location = '5,60'
$button3.Size = '75,20'
$button3.Width = 200
$button3.Text = "Clear ListBox"

# Button
$button4 = New-Object System.Windows.Forms.Button
$button4.Location = '5,100'
$button4.Size = '75,20'
$button4.Width = 250
$button4.Text = "EMA Cross #1 / Fast:20 - Slow:50 (MACD #1)"

# Button
$button5 = New-Object System.Windows.Forms.Button
$button5.Location = '5,120'
$button5.Size = '75,20'
$button5.Width = 250
$button5.Text = "EMA Cross #2 / Fast:20 - Slow:50 (MACD #2)"

# Button
$button6 = New-Object System.Windows.Forms.Button
$button6.Location = '5,160'
$button6.Size = '75,20'
$button6.Width = 250
$button6.Text = "Bollinger Bands #1 (MA #1 && Volatility)"

# Button
$button7 = New-Object System.Windows.Forms.Button
$button7.Location = '5,180'
$button7.Size = '75,20'
$button7.Width = 250
$button7.Text = "Bollinger Bands #2 (MA #2 && Volatility)"

# Button
$button8 = New-Object System.Windows.Forms.Button
$button8.Location = '5,200'
$button8.Size = '75,20'
$button8.Width = 250
$button8.Text = "Bollinger Bands #3 (MA #3 && Volatility)"

# Button
#https://www.investopedia.com/terms/k/keltnerchannel.asp
$button9 = New-Object System.Windows.Forms.Button
$button9.Location = '5,240'
$button9.Size = '75,20'
$button9.Width = 250
$button9.Text = "Keltner Channel #1 (MA #1 && Volatility)"

# Button
#https://www.investopedia.com/terms/k/keltnerchannel.asp
$button10 = New-Object System.Windows.Forms.Button
$button10.Location = '5,260'
$button10.Size = '75,20'
$button10.Width = 250
$button10.Text = "Keltner Channel #2 (MA #2 && Volatility)"

# Button
#https://www.investopedia.com/terms/k/keltnerchannel.asp
$button11 = New-Object System.Windows.Forms.Button
$button11.Location = '5,280'
$button11.Size = '75,20'
$button11.Width = 250
$button11.Text = "Keltner Channel #3 (MA #3 && Volatility)"

# Button
# https://www.investopedia.com/terms/s/starc.asp
$button12 = New-Object System.Windows.Forms.Button
$button12.Location = '5,320'
$button12.Size = '75,20'
$button12.Width = 300
$button12.Text = "Stoller Average Range Channel #1 (MA #1 && Volatility)"

# Button
# https://www.investopedia.com/terms/s/starc.asp
$button13 = New-Object System.Windows.Forms.Button
$button13.Location = '5,340'
$button13.Size = '75,20'
$button13.Width = 300
$button13.Text = "Stoller Average Range Channel #2 (MA #2 && Volatility)"

# Button
# https://www.investopedia.com/terms/s/starc.asp
$button14 = New-Object System.Windows.Forms.Button
$button14.Location = '5,360'
$button14.Size = '75,20'
$button14.Width = 300
$button14.Text = "Stoller Average Range Channel #3 (MA #3 && Volatility)"

# Button
# https://www.investopedia.com/terms/s/starc.asp
$button15 = New-Object System.Windows.Forms.Button
$button15.Location = '580,100'
$button15.Size = '75,20'
$button15.Width = 120
$button15.Text = "Apply CustomIndy #1"

# Button
# https://www.investopedia.com/terms/s/starc.asp
$button16 = New-Object System.Windows.Forms.Button
$button16.Location = '580,120'
$button16.Size = '75,20'
$button16.Width = 120
$button16.Text = "Apply CustomIndy #2"

# Label
$label = New-Object System.Windows.Forms.Label
$label.Location = '220,12'
$label.AutoSize = $True
$label.Text = "Date Time:"

# Label
$label1 = New-Object System.Windows.Forms.Label
$label1.Location = '280,100'
$label1.AutoSize = $True
$label1.Text = "CustomIndy #1:"

# Label
$label2 = New-Object System.Windows.Forms.Label
$label2.Location = '280,120'
$label2.AutoSize = $True
$label2.Text = "CustomIndy #2:"

# Label
$label3 = New-Object System.Windows.Forms.Label
$label3.Location = '5,380'
$label3.AutoSize = $True
$label3.Text = "Drag and Drop files settings here:"

# Listbox
$listBox = New-Object System.Windows.Forms.ListBox
$listBox.Location = '5,400'
$listBox.Height = 40
$listBox.Width = 550
$listBox.Anchor = ([System.Windows.Forms.AnchorStyles]::Bottom -bor [System.Windows.Forms.AnchorStyles]::Left -bor [System.Windows.Forms.AnchorStyles]::Right -bor [System.Windows.Forms.AnchorStyles]::Top)
$listBox.IntegralHeight = $False
$listBox.AllowDrop = $True

# StatusBar
$statusBar = New-Object System.Windows.Forms.StatusBar
$statusBar.Text = "Ready"

## Add controls to form ###
$form.SuspendLayout()
$form.Controls.Add($button)
$form.Controls.Add($button2)
$form.Controls.Add($button3)
$form.Controls.Add($button4)
$form.Controls.Add($button5)
$form.Controls.Add($button6)
$form.Controls.Add($button7)
$form.Controls.Add($button8)
$form.Controls.Add($button9)
$form.Controls.Add($button10)
$form.Controls.Add($button11)
$form.Controls.Add($button12)
$form.Controls.Add($button13)
$form.Controls.Add($button14)
$form.Controls.Add($button15)
$form.Controls.Add($button16)
$form.Controls.Add($label)
$form.Controls.Add($label1)
$form.Controls.Add($label2)
$form.Controls.Add($label3)
$form.Controls.Add($listBox)
$form.Controls.Add($statusBar)
$form.Controls.Add($comboBox)
$form.Controls.Add($comboBox1)
$form.Controls.Add($comboBox2)
$form.ResumeLayout()

### Write event handlers ###
#Defaults
$button_Click = {
    foreach ($item in $listBox.Items) {
        $i = Get-Item -LiteralPath $item
        if (!($i -is [System.IO.DirectoryInfo])) {
            if (MyDefault -filePath $item) {
                [System.Windows.Forms.MessageBox]::Show('Successful - ' + $button.Text, 'Defaults Values', 0, 64)
            }
        }
    }
    $statusBar.Text = ("List contains $($listBox.Items.Count) items")
}

#Rename
$button2_Click = {
    foreach ($item in $listBox.Items) {
        $i = Get-Item -LiteralPath $item
        if (!($i -is [System.IO.DirectoryInfo])) {
            if (ButtonRename -filePath $item) {
                [System.Windows.Forms.MessageBox]::Show('Successful Renamed', 'Rename', 0, 64)
            }
        }
    }
    $statusBar.Text = ("$($listBox.Items.Count) files renamed")
}

# Clear ListBox
$button3_Click = {
    $listBox.Items.Clear()
}

#MA cross
$button4_Click = {
    foreach ($item in $listBox.Items) {
        $i = Get-Item -LiteralPath $item
        if (!($i -is [System.IO.DirectoryInfo])) {
            if (Button2EMACross_1 -filePath $item) {
                [System.Windows.Forms.MessageBox]::Show('MA cross signal #1 Applied', 'MA cross signal #1', 0, 64)
            }
        }
    }
    $statusBar.Text = ("$($listBox.Items.Count) MA cross signal #1 Applied")
}

#MA cross
$button5_Click = {
    foreach ($item in $listBox.Items) {
        $i = Get-Item -LiteralPath $item
        if (!($i -is [System.IO.DirectoryInfo])) {
            if (Button2EMACross_2 -filePath $item) {
                [System.Windows.Forms.MessageBox]::Show('MA cross signal #2 Applied', 'MA cross signal #2', 0, 64)
            }
        }
    }
    $statusBar.Text = ("$($listBox.Items.Count) MA cross signal #2 Applied")
}

#BollingerBands
$button6_Click = {
    foreach ($item in $listBox.Items) {
        $i = Get-Item -LiteralPath $item
        if (!($i -is [System.IO.DirectoryInfo])) {
            if (ButtonBollingerBands_1 -filePath $item) {
                [System.Windows.Forms.MessageBox]::Show('BollingerBands #1 Applied', 'BollingerBands #1', 0, 64)
            }
        }
    }
    $statusBar.Text = ("$($listBox.Items.Count) BollingerBands #1 Applied")
}

#BollingerBands
$button7_Click = {
    foreach ($item in $listBox.Items) {
        $i = Get-Item -LiteralPath $item
        if (!($i -is [System.IO.DirectoryInfo])) {
            if (ButtonBollingerBands_2 -filePath $item) {
                [System.Windows.Forms.MessageBox]::Show('BollingerBands #2 Applied', 'BollingerBands #2', 0, 64)
            }
        }
    }
    $statusBar.Text = ("$($listBox.Items.Count) BollingerBands #2 Applied")
}

#BollingerBands
$button8_Click = {
    foreach ($item in $listBox.Items) {
        $i = Get-Item -LiteralPath $item
        if (!($i -is [System.IO.DirectoryInfo])) {
            if (ButtonBollingerBands_3 -filePath $item) {
                [System.Windows.Forms.MessageBox]::Show('BollingerBands #3 Applied', 'BollingerBands #3', 0, 64)
            }
        }
    }
    $statusBar.Text = ("$($listBox.Items.Count) BollingerBands #3 Applied")
}

#Keltner Channel
$button9_Click = {
    foreach ($item in $listBox.Items) {
        $i = Get-Item -LiteralPath $item
        if (!($i -is [System.IO.DirectoryInfo])) {
            if (ButtonKeltnerChannel_1 -filePath $item) {
                [System.Windows.Forms.MessageBox]::Show('Keltner Channel #1 Applied', 'Keltner Channel #1', 0, 64)
            }
        }
    }
    $statusBar.Text = ("$($listBox.Items.Count) Keltner Channel #1 Applied")
}

#Keltner Channel
$button10_Click = {
    foreach ($item in $listBox.Items) {
        $i = Get-Item -LiteralPath $item
        if (!($i -is [System.IO.DirectoryInfo])) {
            if (ButtonKeltnerChannel_2 -filePath $item) {
                [System.Windows.Forms.MessageBox]::Show('Keltner Channel #2 Applied', 'Keltner Channel #2', 0, 64)
            }
        }
    }
    $statusBar.Text = ("$($listBox.Items.Count) Keltner Channel #2 Applied")
}

#Keltner Channel
$button11_Click = {
    foreach ($item in $listBox.Items) {
        $i = Get-Item -LiteralPath $item
        if (!($i -is [System.IO.DirectoryInfo])) {
            if (ButtonKeltnerChannel_3 -filePath $item) {
                [System.Windows.Forms.MessageBox]::Show('Keltner Channel #3 Applied', 'Keltner Channel #3', 0, 64)
            }
        }
    }
    $statusBar.Text = ("$($listBox.Items.Count) Keltner Channel #3 Applied")
}

#STARC Bands
$button12_Click = {
    foreach ($item in $listBox.Items) {
        $i = Get-Item -LiteralPath $item
        if (!($i -is [System.IO.DirectoryInfo])) {
            if (ButtonSTARC_1 -filePath $item) {
                [System.Windows.Forms.MessageBox]::Show('Stoller Average Range Channel #1 Applied', 'Stoller Average Range Channel #1', 0, 64)
            }
        }
    }
    $statusBar.Text = ("$($listBox.Items.Count) Stoller Average Range Channel #1 Applied")
}

#STARC Bands
$button13_Click = {
    foreach ($item in $listBox.Items) {
        $i = Get-Item -LiteralPath $item
        if (!($i -is [System.IO.DirectoryInfo])) {
            if (ButtonSTARC_2 -filePath $item) {
                [System.Windows.Forms.MessageBox]::Show('Stoller Average Range Channel #2 Applied', 'Stoller Average Range Channel #2', 0, 64)
            }
        }
    }
    $statusBar.Text = ("$($listBox.Items.Count) Stoller Average Range Channel #2 Applied")
}

#STARC Bands
$button14_Click = {
    foreach ($item in $listBox.Items) {
        $i = Get-Item -LiteralPath $item
        if (!($i -is [System.IO.DirectoryInfo])) {
            if (ButtonSTARC_3 -filePath $item) {
                [System.Windows.Forms.MessageBox]::Show('Stoller Average Range Channel #3 Applied', 'Stoller Average Range Channel #3', 0, 64)
            }
        }
    }
    $statusBar.Text = ("$($listBox.Items.Count) Stoller Average Range Channel #3 Applied")
}

#Apply CustomIndy 1
$button15_Click = {
    foreach ($item in $listBox.Items) {
        $i = Get-Item -LiteralPath $item
        if (!($i -is [System.IO.DirectoryInfo])) {
            if (ButtonCustomIndy_1 -filePath $item) {
                [System.Windows.Forms.MessageBox]::Show('CustomIndy #1 Applied', 'CustomIndy #1', 0, 64)
            }
        }
    }
    $statusBar.Text = ("$($listBox.Items.Count) CustomIndy #1 Applied")
}

#Apply CustomIndy 2
$button16_Click = {
    foreach ($item in $listBox.Items) {
        $i = Get-Item -LiteralPath $item
        if (!($i -is [System.IO.DirectoryInfo])) {
            if (ButtonCustomIndy_2 -filePath $item) {
                [System.Windows.Forms.MessageBox]::Show('CustomIndy #2 Applied', 'CustomIndy #2', 0, 64)
            }
        }
    }
    $statusBar.Text = ("$($listBox.Items.Count) CustomIndy #2 Applied")
}

$listBox_DragOver = [System.Windows.Forms.DragEventHandler] {
    if ($_.Data.GetDataPresent([Windows.Forms.DataFormats]::FileDrop)) {
        $_.Effect = 'Copy'
    }
    else {
        $_.Effect = 'None'
    }
}

$listBox_DragDrop = [System.Windows.Forms.DragEventHandler] {
    foreach ($filename in $_.Data.GetData([Windows.Forms.DataFormats]::FileDrop)) {
        $listBox.Items.Add($filename)
    }
    $statusBar.Text = ("List contains $($listBox.Items.Count) items")
}

### Wire up events ###
$button.Add_Click($button_Click)
$button2.Add_Click($button2_Click)
$button3.Add_Click($button3_Click)
$button4.Add_Click($button4_Click)
$button5.Add_Click($button5_Click)
$button6.Add_Click($button6_Click)
$button7.Add_Click($button7_Click)
$button8.Add_Click($button8_Click)
$button9.Add_Click($button9_Click)
$button10.Add_Click($button10_Click)
$button11.Add_Click($button11_Click)
$button12.Add_Click($button12_Click)
$button13.Add_Click($button13_Click)
$button14.Add_Click($button14_Click)
#Apply CustomIndy
$button15.Add_Click($button15_Click)
$button16.Add_Click($button16_Click)
$listBox.Add_DragOver($listBox_DragOver)
$listBox.Add_DragDrop($listBox_DragDrop)

#### Show form ###
[void] $form.ShowDialog()
