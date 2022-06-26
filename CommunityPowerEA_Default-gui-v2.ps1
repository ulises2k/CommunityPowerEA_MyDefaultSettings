# Script to Upgrade .Set File From CommunityPower EA v2.30.x to v2.31.x
# Drag and drop file settings 2.30.x MT5 to windows form and press button
#
# Autor: Ulises Cune (@Ulises2k)
# v2.0
#
# !!!! It version is for CommunityPower EA v2.31 !!!!
# !!!! This script was created automaticaly !!!!
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

#; My Defaults
function Button([string]$filePath) {
    Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
        Expert_Properties           = "===== Expert =============================================================================="
		Expert_Id                   = "231"
        Expert_Comment              = "CP" + (Get-Date -Format "dd.MM.yyyy.HH:mm")
        Lot_Properties              = "===== Lot =============================================================================="
        GlobalAccount_Properties    = "===== Global Account =============================================================================="
        VolPV_Properties            = "===== Volatility for all parameters nominated in points =============================================================================="
        Pending_Properties          = "===== Pending entry =============================================================================="
        StopLoss_Properties         = "===== StopLoss =============================================================================="
        UseVirtualSL                = "false"
        TakeProfit_Properties       = "===== TakeProfit =============================================================================="
        TakeProfit_ReduceAfter      = "===== Reduce TakeProfit after minutes =============================================================================="
        TakeProfit_ReduceSeries     = "===== Reduce TakeProfit for every order =============================================================================="
        TakeProfit_Global           = "===== Global TakeProfit =============================================================================="
        MinProfitToClose_Properties = "===== Min profit to close on signal =============================================================================="
        UseVirtualTP                = "false"
        TrailingStop_Properties     = "===== TrailingStop =============================================================================="
        Martingail_Properties       = "======= Martingail =============================================================================="
        BE_Alert_After              = "0"
        PartialClose_Properties     = "===== Partial =============================================================================="
        GlobalMartingail_Properties = "===== Apply martin to the new deals =============================================================================="
        AutoHedge_Properties        = "===== Auto-hedge =============================================================================="
        AntiMartingail_Properties   = "===== AntiMartingail =============================================================================="
        BigCandle_Properties        = "===== Big candle =============================================================================="
        Oscillators_Properties      = "===== Oscillator #1 =============================================================================="
        Oscillator2_Properties      = "===== Oscillator #2 =============================================================================="
        Oscillator3_Properties      = "===== Oscillator #3 =============================================================================="
        IdentifyTrend_Properties    = "===== IdentifyTrend =============================================================================="
        TDI_Properties              = "===== TDI =============================================================================="
        MACD_Properties             = "===== MACD =============================================================================="
        PSar_Properties             = "===== SAR =============================================================================="
        MA_Filter_1_Properties      = "===== MA Filter #1 =============================================================================="
        MA_Filter_2_Properties      = "===== MA Filter #2 =============================================================================="
        MA_Filter_3_Properties      = "===== MA Filter #3 =============================================================================="
        ZZ_Properties               = "===== ZigZag =============================================================================="
        VolMA_Properties            = "===== Volatility for MA and ZigZag Filters distance =============================================================================="
        VolFilter_Properties        = "===== Volatility Filter =============================================================================="
        FIBO_Properties             = "===== FIBO #1 =============================================================================="
        FIB2_Properties             = "===== FIBO #2 =============================================================================="
        Spread_Settings             = "===== Spread =============================================================================="
        Time_Settings               = "===== Time =============================================================================="
        Time_ApplyTo                = "0"
        Time_DST_Mode               = "1"
        Time_Manual_GMT_Offset      = "2"
        Custom_Schedule_Properties  = "===== Custom Schedule ====="
        NewYear_Properties          = "===== New Year Holidays ====="
        LastDecemberDay             = "15"
        FirstJanuaryDay             = "15"
        News_Properties             = "===== News =============================================================================="
        News_Draw_Properties        = "===== Visualization ====="
        Lines_Settings              = "===== Lines =============================================================================="
        GUI_Settings                = "========== GUI =============================================================================="
        ManageManual                = "true"
        GUI_Enabled                 = "false"
        ShowOrders_Settings         = "========== Show Orders =============================================================================="
        Show_Opened                 = "1"
        Show_Closed                 = "true"
        Show_Pending                = "false"
        MaxHistoryDeals             = "500"
        Color_Properties            = "========== Main Color =============================================================================="
        Color_B_Open                = "16748574"
        Color_B                     = "16748574"
        Color_B_Loss                = "15130800"
        Color_S_Open                = "17919"
        Color_S                     = "17919"
        Color_S_Loss                = "12695295"
        Profit_Properties           = "========== TakeProfit =============================================================================="
        Profit_ShowInMoney          = "true"
        Profit_ShowInPoints         = "true"
        Profit_ShowInPercents       = "true"
        Profit_Aggregate            = "true"
        ProfitDigitsToShow          = "1"
        Font                        = "Arial"
        FontSize                    = "9"
        Style_Properties            = "========== Style =============================================================================="
        Open_Close_Line_Width       = "1"
        Open_Close_Line_Style       = "2"
        Open_PriceLabel_Width       = "1"
        Close_PriceLabel_Width      = "1"
        SL_TP_Dashes_Show           = "true"
        SL_TP_Lines_Width           = "2"
        SL_TP_Lines_Style           = "2"
        Expiration_Width            = "0"
        Expiration_Style            = "2"
        Notifications_Settings      = "===== Notifications =============================================================================="
        MessagesToGrammy            = "false"
        Alerts_Enabled              = "false"
        Sounds_Enabled              = "false"
        Optimization_Settings       = "===== Optimization =============================================================================="
    }

    if (!($comboBox1.SelectedIndex -eq "-1")) {
        if ($comboBox1.SelectedItem.ToString() -eq "EUR/USD" ) {
            Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
                #; Friday and Monday
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
                #; Custom Schedule
                Custom_Schedule_Properties = "===== Custom Schedule / EUR/USD ====="
                Custom_Schedule_On         = "true"
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

    if (!($comboBox1.SelectedIndex -eq "-1")) {
        if ($comboBox1.SelectedItem.ToString() -eq "XAU/USD" ) {
            Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
                EveryDay_Properties     = "===== Every Day / XAU/USD ====="
                EveryDay_StartHour      = "1"
                EveryDay_StartMinute    = "5"
                EveryDay_EndHour        = "23"
                EveryDay_EndMinute      = "0"
                EveryDay_CloseHour      = "-1"
                EveryDay_CloseMinute    = "0"
                FridayMonday_Properties = "===== Friday and Monday / XAU/USD ====="
                FridayStop_Hour         = "22"
                FridayStop_Minute       = "0"
                FridayClose_Hour        = "-1"
                FridayClose_Minute      = "0"
                MondayStart_Hour        = "0"
                MondayStart_Minute      = "5"
                #; Custom Schedule
                Custom_Schedule_Properties = "===== Custom Schedule / XAU/USD ====="
                Custom_Schedule_On         = "true"
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
            }
        }
    }

    if (!($comboBox1.SelectedIndex -eq "-1")) {
        if ($comboBox1.SelectedItem.ToString() -eq "Every Day/Friday and Monday (Disable)" ) {
            Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
                EveryDay_Properties     = "===== Every Day ====="
                EveryDay_StartHour      = "-1"
                EveryDay_StartMinute    = "0"
                EveryDay_EndHour        = "-1"
                EveryDay_EndMinute      = "0"
                EveryDay_CloseHour      = "-1"
                EveryDay_CloseMinute    = "0"
                FridayMonday_Properties = "===== Friday and Monday ====="
                FridayStop_Hour         = "-1"
                FridayStop_Minute       = "0"
                FridayClose_Hour        = "-1"
                FridayClose_Minute      = "0"
                MondayStart_Hour        = "-1"
                MondayStart_Minute      = "0"
                #; Custom Schedule
                Custom_Schedule_Properties = "===== Custom Schedule ====="
                Custom_Schedule_On         = "true"
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
            }
        }
    }

    if ($comboBox1.SelectedIndex -eq "-1") {
        Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
            EveryDay_Properties     = "===== Every Day ====="
            EveryDay_StartHour      = "-1"
            EveryDay_StartMinute    = "0"
            EveryDay_EndHour        = "-1"
            EveryDay_EndMinute      = "0"
            EveryDay_CloseHour      = "-1"
            EveryDay_CloseMinute    = "0"
            FridayMonday_Properties = "===== Friday and Monday ====="
            FridayStop_Hour         = "-1"
            FridayStop_Minute       = "0"
            FridayClose_Hour        = "-1"
            FridayClose_Minute      = "0"
            MondayStart_Hour        = "-1"
            MondayStart_Minute      = "0"
        }
    }

	$inifile = Get-IniFile($filePath)
    $Pending_Type = [int]$inifile["Pending_Type"]
	if ($Pending_Type -eq 0){
		Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
			NextOrder_Width="0"
		}
	}else{
		Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
			NextOrder_Width="1"
		}
	}

	$ZZ_Type = [int]$inifile["ZZ_Type"]
	$MA_Filter_1_Type = [int]$inifile["MA_Filter_1_Type"]
	$MA_Filter_2_Type = [int]$inifile["MA_Filter_2_Type"]
	$MA_Filter_3_Type = [int]$inifile["MA_Filter_3_Type"]

	if (($ZZ_Type -eq 0) -and ($MA_Filter_1_Type -eq 0) -and ($MA_Filter_2_Type -eq 0) -and ($MA_Filter_3_Type -eq 0)){
		Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
			VolMA_Type="0"
		}
	}

	$StopLoss = [int]$inifile["StopLoss"]
	if ($StopLoss -eq 0){
		Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
			StopLoss_Width="0"
		}
	}else{
		Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
			StopLoss_Width="2"
		}
	}


    return $true
}


#; Expert properties
function Button1([string]$filePath) {
    Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
        Expert_Id           = "3040||3040||1||30400||N"
        Expert_Comment      = "CP"
        TradeDirection      = "0||-1||0||1||N"
        Signal_TimeFrame    = "5||0||0||49153||N"
        NewDealOnNewBar     = "true||false||0||true||N"
        AllowHedge          = "true||false||0||true||N"
        MaxFloatingLoss     = "0||0||0.000000||0.000000||N"
        MinMarginLevel      = "0||0||0.000000||0.000000||N"
        UseCustomCommission = "0||0||0.000000||0.000000||N"
        ManageManual        = "false||false||0||true||N"
    }
    return $true
}

#; Lot properties
function Button2([string]$filePath) {
    Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
        Lot_Type     = "3||0||0||4||N"
        Lot_Per_1000 = "0.01||0.005||0.005||0.01||N"
        Lot_Risk     = "0||0||0.000000||0.000000||N"
        Lot_Max      = "0||0||0.000000||0.000000||N"
    }
    return $true
}

#; Global Account properties
function Button3([string]$filePath) {
    Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
        GlobalAccountTakeProfit_ccy    = "0||0||0.000000||0.000000||N"
        GlobalAccountTakeProfit_perc   = "0||0||0.000000||0.000000||N"
        GlobalAccountTargetProfit_ccy  = "0||0||0.000000||0.000000||N"
        GlobalAccountTargetProfit_perc = "0||0||0.000000||0.000000||N"
    }
    return $true
}

#; Volatility for all parameters nominated in points
function Button4([string]$filePath) {
    Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
        VolPV_Type    = "0||0||0||5||N"
        VolPV_TF      = "16408||0||0||49153||N"
        VolPV_Period  = "20||20||1||200||N"
        VolPV_MinSize = "0||0||0.000000||0.000000||N"
        VolPV_MaxSize = "0||0||0.000000||0.000000||N"
    }
    return $true
}

#; Pending entry properties
function Button5([string]$filePath) {
    Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
        Pending_Type             = "0||0||0||2||N"
        Pending_Distance         = "5||0||5||20||N"
        Pending_Bar              = "1||0||1||5||N"
        Pending_TrailMode        = "2||1||0||2||N"
        Pending_CancelOnOpposite = "true||false||0||true||N"
        Pending_CancelDistance   = "15||0||1||200.000000||N"
        Pending_CancelBar        = "0||0||1||10||N"
        Pending_Distance_ModeP   = "0||0||0||1||N"
    }
    return $true
}

#; StopLoss properties
function Button6([string]$filePath) {
    Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
        StopLoss           = "0||150||10||300||N"
        StopLoss_Mode      = "1||0||0||2||N"
        StopLoss_ModeP     = "0||0||0||1||N"
        GlobalStopLoss_ccy = "0||0||0.000000||0.000000||N"
        GlobalStopLoss     = "0||0||1.000000||50.000000||N"
        PauseAfterLoss     = "0||0||1||10||N"
        UseVirtualSL       = "true||false||0||true||N"
    }
    return $true
}

#; TakeProfit properties
function Button7([string]$filePath) {
    Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
        TakeProfit                   = "0||30||5||70||Y"
        TakeProfitMode               = "0||0||0||1||N"
        TakeProfit_ModeP             = "0||0||0||1||N"
        TakeProfit_ReduceAfter_mins  = "0||0||5||30||N"
        TakeProfit_ReduceAfter_coeff = "0.1||0.1||0.1||2||N"
        TakeProfit_ReduceSize        = "0||0||0.000000||0.000000||N"
        TakeProfit_ReduceCoeff       = "1||1||0.100000||10.000000||N"
        TakeProfit_MinSize           = "0||0||0.000000||0.000000||N"
        GlobalTakeProfit             = "0||0||0.000000||0.000000||N"
        MinProfitToClose             = "0||0||1||20||N"
        MinProfitToClose_ModeP       = "0||0||0||1||N"
        UseVirtualTP                 = "false||false||0||true||N"
    }
    return $true
}

#; TrailingStop properties
function Button8([string]$filePath) {
    Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
        TrailingStop       = "10||10||10||40||N"
        TrailingStep       = "3||10||10||40||N"
        TrailingStopAfter  = "0||10||10||40||N"
        TrailingStopMode   = "0||0||0||1||N"
        TrailingStop_ModeP = "0||0||0||1||N"
    }
    return $true
}

#; Martingail properties
function Button9([string]$filePath) {
    Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
        MartingailType              = "1||0||0||3||N"
        MaxTrades                   = "100||1||1||10||N"
        MartingailOnTheBarEnd       = "true||false||0||true||N"
        MinPause_Bars               = "0||0||1||10||N"
        MartingailLotMode           = "2||0||0||2||N"
        LotExponent                 = "1.75||1.5||0.25||2||N"
        PipStep                     = "15||0||5||50||N"
        Martingail_ModeP            = "0||0||0||1||N"
        StepCoeff                   = "0.75||0||0.1||2||N"
        MinStepSize                 = "0||0||0.000000||0.000000||N"
        BreakEven_AfterOrder        = "0||0||1||10||N"
        BreakEven_MinProfit         = "0||0||1||20||N"
        BE_Alert_After              = "0||3||1||30||N"
        PartialClose_After          = "0||0||1||10||N"
        PartialClose_MinProfit      = "0||0||1||20||N"
        PartialClose_MinProfit_Perc = "0||0||1||20||N"
        ApplyAfterClosedLoss        = "false||false||0||true||N"
        AutoHedge_AfterOrder        = "0||0||1||10||N"
    }
    return $true
}

#; Anti-Martingail properties
function Button10([string]$filePath) {
    Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
        AntiMartingailType       = "0||0||0||3||N"
        AntiMaxTrades            = "10||10||1||100||N"
        AntiMartingailLotMode    = "2||0||0||2||N"
        AntiLotExponent          = "0.9||0.9||0.090000||9.000000||N"
        AntiPipStep              = "15||15||1.500000||150.000000||N"
        AntiMartingail_ModeP     = "0||0||0||1||N"
        AntiStepCoeff            = "0.9||0.9||0.090000||9.000000||N"
        AntiMinStepSize          = "0||0||0.000000||0.000000||N"
        AntiStopLoss             = "10||10||1.000000||100.000000||N"
        AntiStopLoss_ReduceSize  = "0||0||0.000000||0.000000||N"
        AntiStopLoss_ReduceCoeff = "1||1||0.100000||10.000000||N"
        AntiStopLoss_MinSize     = "5||5||0.500000||50.000000||N"
        AntiStopLoss_Mode        = "1||0||0||1||N"
        AntiStopLoss_ModeP       = "0||0||0||1||N"
    }
    return $true
}

#; Big candle properties
function Button11([string]$filePath) {
    Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
        BigCandle_Type           = "3||0||0||3||N"
        BigCandle_MinSize        = "10||100||10.000000||1000.000000||N"
        BigCandle_TF             = "0||0||0||49153||N"
        BigCandle_CurrentBar     = "true||false||0||true||N"
        BigCandle_OpenOn         = "0||0||0||3||N"
        BigCandle_MartinOn       = "1||0||0||3||N"
        BigCandle_CloseOn        = "0||0||0||4||N"
        BigCandle_PartialCloseOn = "0||0||0||3||N"
    }
    return $true
}

#; Oscillator #1 properties
function Button12([string]$filePath) {
    Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
        Oscillators_Type           = "1||1||0||3||N"
        Oscillators_Indicator      = "3||0||0||3||N"
        Oscillators_TF             = "5||0||0||16388||N"
        Oscillators_Period         = "9||1||1||30||N"
        Oscillators_Price          = "1||1||0||7||N"
        Oscillators_MA_Period      = "3||3||1||30||N"
        Oscillators_MA_Method      = "0||0||0||3||N"
        Oscillators_Slowing        = "3||3||1||30||N"
        Oscillators_STO_Price      = "0||0||0||1||N"
        Oscillators_Level_UP_Min   = "90||60||5||95||N"
        Oscillators_Level_DN_Min   = "-999||-999||-99.900000||-9990.000000||N"
        Oscillators_ContrTrend     = "false||false||0||true||N"
        Oscillators_OpenOn         = "2||0||0||3||N"
        Oscillators_MartinOn       = "0||0||0||3||N"
        Oscillators_CloseOn        = "2||0||0||4||N"
        Oscillators_PartialCloseOn = "1||0||0||3||N"
    }
    return $true
}

#; Oscillator #2 properties
function Button13([string]$filePath) {
    Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
        Oscillators_Type           = "1||1||0||3||N"
        Oscillators_Indicator      = "3||0||0||3||N"
        Oscillators_TF             = "5||0||0||16388||N"
        Oscillators_Period         = "9||1||1||30||N"
        Oscillators_Price          = "1||1||0||7||N"
        Oscillators_MA_Period      = "3||3||1||30||N"
        Oscillators_MA_Method      = "0||0||0||3||N"
        Oscillators_Slowing        = "3||3||1||30||N"
        Oscillators_STO_Price      = "0||0||0||1||N"
        Oscillators_Level_UP_Min   = "90||60||5||95||N"
        Oscillators_Level_DN_Min   = "-999||-999||-99.900000||-9990.000000||N"
        Oscillators_ContrTrend     = "false||false||0||true||N"
        Oscillators_OpenOn         = "2||0||0||3||N"
        Oscillators_MartinOn       = "0||0||0||3||N"
        Oscillators_CloseOn        = "2||0||0||4||N"
        Oscillators_PartialCloseOn = "1||0||0||3||N"
    }
    return $true
}

#; Oscillator #3 properties
function Button14([string]$filePath) {
    Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
        Oscillator3_Type           = "0||0||0||4||N"
        Oscillator3_Indicator      = "2||0||0||4||N"
        Oscillator3_TF             = "16408||0||0||49153||N"
        Oscillator3_Period         = "14||14||1||140||N"
        Oscillator3_Price          = "1||1||0||7||N"
        Oscillator3_MA_Period      = "3||3||1||30||N"
        Oscillator3_MA_Method      = "0||0||0||3||N"
        Oscillator3_Slowing        = "3||3||1||30||N"
        Oscillator3_STO_Price      = "0||0||0||1||N"
        Oscillator3_Level_UP_Min   = "80||80||8.000000||800.000000||N"
        Oscillator3_Level_DN_Min   = "-999||-999||-99.900000||-9990.000000||N"
        Oscillator3_ContrTrend     = "false||false||0||true||N"
        Oscillator3_OpenOn         = "0||0||0||3||N"
        Oscillator3_MartinOn       = "0||0||0||3||N"
        Oscillator3_CloseOn        = "0||0||0||4||N"
        Oscillator3_PartialCloseOn = "0||0||0||3||N"
    }
    return $true
}

#; IdentifyTrend properties
function Button15([string]$filePath) {
    Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
        IdentifyTrend_Enable         = "true||false||0||true||N"
        IdentifyTrend_TF             = "16408||0||0||16390||N"
        IdentifyTrend_AppliedPrice   = "5||1||0||7||N"
        IdentifyTrend_MainPeriod     = "3||2||1||5||N"
        IdentifyTrend_Reverse        = "false||false||0||true||N"
        IdentifyTrend_UseClosedBars  = "false||false||0||true||N"
        IdentifyTrend_OpenOn         = "2||0||0||3||N"
        IdentifyTrend_MartinOn       = "0||0||0||3||N"
        IdentifyTrend_CloseOn        = "0||0||0||4||N"
        IdentifyTrend_PartialCloseOn = "0||0||0||3||N"
    }
    return $true
}

#; TDI properties
function Button16([string]$filePath) {
    Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
        TDI_Mode            = "1||0||0||1||N"
        TDI_TF              = "16385||0||0||49153||N"
        TDI_SignalLevel     = "50||18||16||98||N"
        TDI_PeriodRSI       = "21||21||1||210||N"
        TDI_AppliedPriceRSI = "1||1||0||7||N"
        TDI_PeriodSmRSI     = "2||2||1||20||N"
        TDI_MethodSmRSI     = "0||0||0||3||N"
        TDI_PeriodSmSig     = "7||7||1||70||N"
        TDI_MethodSmSig     = "0||0||0||3||N"
        TDI_PeriodVolBand   = "34||34||1||340||N"
        TDI_StdDev          = "1.6185||1.6185||0.161850||16.185000||N"
        TDI_Reverse         = "false||false||0||true||N"
        TDI_UseClosedBars   = "true||false||0||true||N"
        TDI_OpenOn          = "2||0||0||3||N"
        TDI_MartinOn        = "0||0||0||3||N"
        TDI_CloseOn         = "0||0||0||4||N"
        TDI_PartialCloseOn  = "0||0||0||3||N"
    }
    return $true
}

#; MACD properties
function Button17([string]$filePath) {
    Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
        MACD_Type           = "0||0||0||3||N"
        MACD_TF             = "0||0||0||49153||N"
        MACD_PeriodFast     = "12||12||1||120||N"
        MACD_PeriodSlow     = "27||27||1||270||N"
        MACD_PeriodSignal   = "9||9||1||90||N"
        MACD_Price          = "1||1||0||7||N"
        MACD_Reverse        = "false||false||0||true||N"
        MACD_UseClosedBars  = "true||false||0||true||N"
        MACD_OpenOn         = "0||0||0||3||N"
        MACD_MartinOn       = "0||0||0||3||N"
        MACD_CloseOn        = "0||0||0||4||N"
        MACD_PartialCloseOn = "0||0||0||3||N"
    }
    return $true
}

#; Parabolic SAR properties
function Button18([string]$filePath) {
    Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
        PSar_Type           = "0||1||0||2||Y"
        PSar_TF             = "0||16385||0||16408||Y"
        PSar_Step           = "0.02||0.02||0.002000||0.200000||N"
        PSar_Maximum        = "0.2||0.2||0.020000||2.000000||N"
        PSar_Reverse        = "false||false||0||true||N"
        PSar_OpenOn         = "0||0||0||3||N"
        PSar_MartinOn       = "0||0||0||3||N"
        PSar_CloseOn        = "0||0||0||4||N"
        PSar_PartialCloseOn = "0||0||0||3||N"
    }
    return $true
}

#; MA Filter #1 properties
function Button19([string]$filePath) {
    Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
        MA_Filter_1_Type           = "0||0||0||2||N"
        MA_Filter_1_TF             = "0||0||0||49153||N"
        MA_Filter_1_Period         = "50||20||5||100||N"
        MA_Filter_1_Method         = "1||0||0||3||N"
        MA_Filter_1_Price          = "1||1||0||7||N"
        MA_Filter_1_DistType       = "0||0||0||1||N"
        MA_Filter_1_DistCoef       = "0||25||25||75||N"
        MA_Filter_1_OpenOn         = "0||0||0||3||N"
        MA_Filter_1_MartinOn       = "0||0||0||3||N"
        MA_Filter_1_CloseOn        = "0||0||0||4||N"
        MA_Filter_1_PartialCloseOn = "0||0||0||3||N"
    }
    return $true
}

#; MA Filter #2 properties
function Button20([string]$filePath) {
    Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
        MA_Filter_2_Type           = "0||0||0||2||N"
        MA_Filter_2_TF             = "0||15||0||16385||N"
        MA_Filter_2_Period         = "50||0||50||300||N"
        MA_Filter_2_Method         = "1||0||0||3||N"
        MA_Filter_2_Price          = "1||1||0||7||N"
        MA_Filter_2_DistType       = "0||0||0||1||N"
        MA_Filter_2_DistCoef       = "0||0||0.000000||0.000000||N"
        MA_Filter_2_OpenOn         = "0||0||0||3||N"
        MA_Filter_2_MartinOn       = "0||0||0||3||N"
        MA_Filter_2_CloseOn        = "0||0||0||4||N"
        MA_Filter_2_PartialCloseOn = "0||0||0||3||N"
    }
    return $true
}

#; MA Filter #3 properties
function Button21([string]$filePath) {
    Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
        MA_Filter_3_Type           = "0||0||0||2||N"
        MA_Filter_3_TF             = "0||16392||0||16396||N"
        MA_Filter_3_Period         = "50||0||100||100||N"
        MA_Filter_3_Method         = "1||0||0||3||N"
        MA_Filter_3_Price          = "1||1||0||7||N"
        MA_Filter_3_DistType       = "0||0||0||1||N"
        MA_Filter_3_DistCoef       = "0||0||0.000000||0.000000||N"
        MA_Filter_3_OpenOn         = "0||0||0||3||N"
        MA_Filter_3_MartinOn       = "0||0||0||3||N"
        MA_Filter_3_CloseOn        = "0||0||0||4||N"
        MA_Filter_3_PartialCloseOn = "0||0||0||3||N"
    }
    return $true
}

#; ZZ properties
function Button22([string]$filePath) {
    Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
        ZZ_Type            = "0||0||0||4||N"
        ZZ_TF              = "0||0||0||49153||N"
        ZZ_Period          = "12||12||1||120||N"
        ZZ_MinAmplitude    = "10||10||1||100||N"
        ZZ_MinMotion       = "0||0||1||10||N"
        ZZ_DistanceType    = "0||0||0||2||N"
        ZZ_SignalDistCoeff = "0||0||0.000000||0.000000||N"
        ZZ_Reverse         = "false||false||0||true||N"
        ZZ_UseClosedBars   = "false||false||0||true||N"
        ZZ_OpenOn          = "0||0||0||3||N"
        ZZ_MartinOn        = "0||0||0||3||N"
        ZZ_CloseOn         = "0||0||0||4||N"
        ZZ_PartialCloseOn  = "0||0||0||3||N"
    }
    return $true
}

#; Volatility for MA and ZZ Filters distance
function Button23([string]$filePath) {
    Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
        VolMA_Type   = "2||0||0||4||N"
        VolMA_TF     = "0||0||0||49153||N"
        VolMA_Period = "14||20||5||100||N"
    }
    return $true
}

#; Volatility Filter properties
function Button24([string]$filePath) {
    Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
        VolFilter_Type             = "0||0||0||4||N"
        VolFilter_TF               = "0||0||0||16408||N"
        VolFilter_Period           = "20||8||6||38||N"
        VolFilter_Min              = "0||1||5||30||N"
        VolFilter_Max              = "0||0||0.000000||0.000000||N"
        VolFilter_Smoothing_Mode   = "0||0||0||2||N"
        VolFilter_Smoothing_Period = "20||50||100||150||N"
        VolFilter_OpenOn           = "0||0||0||3||N"
        VolFilter_MartinOn         = "0||0||0||3||N"
        VolFilter_CloseOn          = "0||0||0||4||N"
        VolFilter_PartialCloseOn   = "0||0||0||3||N"
    }
    return $true
}

#; FIBO #1 properties
function Button25([string]$filePath) {
    Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
        FIBO_Type           = "0||0||0||1||N"
        FIBO_TF             = "16385||0||0||49153||N"
        FIBO_CheckInterval  = "1||0||0||10||N"
        FIBO_Bars           = "120||120||1||1200||N"
        FIBO_Level          = "61.8||61.8||6.180000||618.000000||N"
        FIBO_UseClosedBars  = "true||false||0||true||N"
        FIBO_OpenOn         = "0||0||0||3||N"
        FIBO_MartinOn       = "0||0||0||3||N"
        FIBO_CloseOn        = "0||0||0||4||N"
        FIBO_PartialCloseOn = "0||0||0||3||N"
    }
    return $true
}

#; FIBO #2 properties
function Button26([string]$filePath) {
    Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
        FIB2_Type           = "0||0||0||3||N"
        FIB2_TF             = "16385||0||0||49153||N"
        FIB2_CheckInterval  = "1||0||0||10||N"
        FIB2_Bars           = "120||120||1||1200||N"
        FIB2_Level          = "61.8||61.8||6.180000||618.000000||N"
        FIB2_UseClosedBars  = "true||false||0||true||N"
        FIB2_OpenOn         = "0||0||0||3||N"
        FIB2_MartinOn       = "0||0||0||3||N"
        FIB2_CloseOn        = "0||0||0||4||N"
        FIB2_PartialCloseOn = "0||0||0||3||N"
    }
    return $true
}

#; Spread settings
function Button27([string]$filePath) {
    Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
        Spread_MaxCurrent       = "0||0||0.000000||0.000000||N"
        Spread_MaxAverage       = "30||0||0.000000||0.000000||N"
        Spread_SecondsToAnalyze = "30||30||1||300||N"
    }
    return $true
}

#; Time settings
function Button28([string]$filePath) {
    Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
        Time_ApplyTo           = "1||0||0||3||N"
        Time_DST_Mode          = "2||0||0||4||N"
        Time_Manual_GMT_Offset = "2||2||1||20||N"
    }
    return $true
}

#; Every Day
function Button29([string]$filePath) {
    Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
        EveryDay_StartHour   = "-1||-1||0||23||N"
        EveryDay_StartMinute = "0||0||0||55||N"
        EveryDay_EndHour     = "-1||-1||0||23||N"
        EveryDay_EndMinute   = "0||0||0||59||N"
        EveryDay_CloseHour   = "-1||-1||0||23||N"
        EveryDay_CloseMinute = "0||0||0||55||N"
    }
    return $true
}

#; Friday and Monday
function Button30([string]$filePath) {
    Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
        FridayStop_Hour    = "-1||-1||0||23||N"
        FridayStop_Minute  = "0||0||0||55||N"
        FridayClose_Hour   = "-1||-1||0||23||N"
        FridayClose_Minute = "0||0||0||55||N"
        MondayStart_Hour   = "-1||-1||0||23||N"
        MondayStart_Minute = "0||0||0||55||N"
    }
    return $true
}

#; Custom Schedule
function Button31([string]$filePath) {
    Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
        Custom_Schedule_On    = "false||false||0||true||N"
        Monday_StartHour      = "-1||-1||0||23||N"
        Monday_StartMinute    = "0||0||0||55||N"
        Monday_EndHour        = "-1||-1||0||23||N"
        Monday_EndMinute      = "0||0||0||55||N"
        Tuesday_StartHour     = "-1||-1||0||23||N"
        Tuesday_StartMinute   = "0||0||0||55||N"
        Tuesday_EndHour       = "-1||-1||0||23||N"
        Tuesday_EndMinute     = "0||0||0||55||N"
        Wednesday_StartHour   = "-1||-1||0||23||N"
        Wednesday_StartMinute = "0||0||0||55||N"
        Wednesday_EndHour     = "-1||-1||0||23||N"
        Wednesday_EndMinute   = "0||0||0||55||N"
        Thursday_StartHour    = "-1||-1||0||23||N"
        Thursday_StartMinute  = "0||0||0||55||N"
        Thursday_EndHour      = "-1||-1||0||23||N"
        Thursday_EndMinute    = "0||0||0||55||N"
        Friday_StartHour      = "-1||-1||0||23||N"
        Friday_StartMinute    = "0||0||0||55||N"
        Friday_EndHour        = "-1||-1||0||23||N"
        Friday_EndMinute      = "0||0||0||55||N"
    }
    return $true
}

#; New Year Holidays
function Button32([string]$filePath) {
    Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
        LastDecemberDay = "0||0||1||10||N"
        FirstJanuaryDay = "0||0||1||10||N"
    }
    return $true
}

#; News settings
function Button33([string]$filePath) {
    Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
        News_Mode           = "0||0||0||2||N"
        News_Currencies     = "auto"
        News_Impact_H       = "true||false||0||true||N"
        News_Impact_M       = "true||false||0||true||N"
        News_Impact_L       = "false||false||0||true||N"
        News_Impact_N       = "false||false||0||true||N"
        News_FilterInclude  = ""
        News_MinutesBefore  = "15||15||1||150||N"
        News_MinutesAfter   = "15||15||1||150||N"
        News_OpenOn         = "0||0||0||3||N"
        News_MartinOn       = "0||0||0||3||N"
        News_CloseOn        = "0||0||0||4||N"
        News_PartialCloseOn = "0||0||0||3||N"
        News_ShowOnChart    = "true"
        News_Style_History  = "0"
        News_Style_Future   = "3"
        News_Color_ImpactH  = "255"
        News_Color_ImpactM  = "65535"
        News_Color_ImpactL  = "32768"
        News_Color_ImpactN  = "12632256"
    }
    return $true
}

#; Lines settings
function Button34([string]$filePath) {
    Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
        NextOrder_Width   = "1"
        NextOrder_Style   = "2"
        NextOrder_ColorB  = "65280"
        NextOrder_ColorS  = "255"
        StopLoss_Width    = "1"
        StopLoss_Style    = "1"
        StopLoss_ColorB   = "16711935"
        StopLoss_ColorS   = "16711935"
        BreakEven_Width   = "1"
        BreakEven_Style   = "0"
        BreakEven_ColorB  = "65471"
        BreakEven_ColorS  = "33023"
        TakeProfit_Width  = "1"
        TakeProfit_Style  = "4"
        TakeProfit_ColorB = "65280"
        TakeProfit_ColorS = "255"
    }
    return $true
}

#; GUI settings
function Button35([string]$filePath) {
    Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
        GUI_Enabled          = "true"
        GUI_FontName         = "Segoe UI"
        GUI_Window_Alpha     = "255"
        GUI_ShowSignals      = "true"
        GUI_Color_Signal     = "13350833"
        GUI_Color_SignalText = "0"
        GUI_Color_B_Back     = "16777184"
        GUI_Color_B_Button   = "15130800"
        GUI_Color_B_ButtonP  = "16748574"
        GUI_Color_B_Border   = "15570276"
        GUI_Color_B_Text     = "0"
        GUI_Color_S_Back     = "16118015"
        GUI_Color_S_Button   = "12695295"
        GUI_Color_S_ButtonP  = "17919"
        GUI_Color_S_Border   = "8421616"
        GUI_Color_S_Text     = "0"
    }
    return $true
}

#; Show orders
function Button36([string]$filePath) {
    Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
        Show_Opened            = "1||0||0||3||N"
        Show_Closed            = "true||false||0||true||N"
        Show_Pending           = "true||false||0||true||N"
        MaxHistoryDeals        = "500||500||1||5000||N"
        Color_Properties       = ""
        Color_B_Open           = "16748574"
        Color_B                = "16748574"
        Color_B_Loss           = "15130800"
        Color_S_Open           = "17919"
        Color_S                = "17919"
        Color_S_Loss           = "12695295"
        Profit_Properties      = ""
        Profit_ShowInMoney     = "true||false||0||true||N"
        Profit_ShowInPoints    = "true||false||0||true||N"
        Profit_ShowInPercents  = "false||false||0||true||N"
        Profit_Aggregate       = "true||false||0||true||N"
        ProfitDigitsToShow     = "1||1||1||10||N"
        Font                   = "Arial"
        FontSize               = "9||9||1||90||N"
        Style_Properties       = ""
        Open_Close_Line_Width  = "1||1||1||10||N"
        Open_Close_Line_Style  = "2||0||0||4||N"
        Open_PriceLabel_Width  = "0||0||1||10||N"
        Close_PriceLabel_Width = "0||0||1||10||N"
        SL_TP_Dashes_Show      = "true||false||0||true||N"
        SL_TP_Lines_Width      = "0||0||1||10||N"
        SL_TP_Lines_Style      = "2||0||0||4||N"
        Expiration_Width       = "0||0||1||10||N"
        Expiration_Style       = "2||0||0||4||N"
    }
    return $true
}

#; Notifications settings
function Button37([string]$filePath) {
    Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
        MessagesToGrammy      = "false||false||0||true||N"
        Alerts_Enabled        = "false"
        Sounds_Enabled        = "false"
        Sounds_OpenFirst      = "expert.wav"
        Sounds_OpenMartin     = "alert2.wav"
        Sounds_OpenAntiMartin = "alert2.wav"
        Sounds_Close          = "alert.wav"
    }
    return $true
}

#; Optimization settings
function Button38([string]$filePath) {
    Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
        InpEquityRecorderType = "1"
        InpEquityRecorderCorr = "0"
    }
    return $true
}

#######################GUI################################################################
### API Windows Forms ###
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")


### Create form ###
$form = New-Object System.Windows.Forms.Form
$form.Text = "Set Default Value only for each Sections - CommunityPower EA v2.31"
$form.Size = '600,850'
$form.StartPosition = "CenterScreen"
$form.MinimumSize = $form.Size
$form.MaximizeBox = $False
$form.Topmost = $True

#Combobox
$tickets = @("EUR/USD", "XAU/USD", "Every Day/Friday and Monday (Disable)")
$comboBox1 = New-Object System.Windows.Forms.ComboBox
$comboBox1.Location = '220, 10'
$comboBox1.Size = '300, 50'
foreach ($ticket in $tickets) {
    $comboBox1.Items.add($ticket)
}

### Define controls ###
$button = New-Object System.Windows.Forms.Button
$button.Location = '5,10'
$button.Size = '75,20'
$button.Width = 200
$button.Text = "My Defaults"

$button1 = New-Object System.Windows.Forms.Button
$button1.Location = '5,30'
$button1.Size = '75,20'
$button1.Width = 200
$button1.Text = "Expert properties"

$button2 = New-Object System.Windows.Forms.Button
$button2.Location = '5,50'
$button2.Size = '75,20'
$button2.Width = 200
$button2.Text = "Lot properties"

$button3 = New-Object System.Windows.Forms.Button
$button3.Location = '5,70'
$button3.Size = '75,20'
$button3.Width = 200
$button3.Text = "Global Account properties"

$button4 = New-Object System.Windows.Forms.Button
$button4.Location = '5,90'
$button4.Size = '75,20'
$button4.Width = 200
$button4.Text = "Volatility for all parameters nominated in points"

$button5 = New-Object System.Windows.Forms.Button
$button5.Location = '5,110'
$button5.Size = '75,20'
$button5.Width = 200
$button5.Text = "Pending entry properties"

$button6 = New-Object System.Windows.Forms.Button
$button6.Location = '5,130'
$button6.Size = '75,20'
$button6.Width = 200
$button6.Text = "StopLoss properties"

$button7 = New-Object System.Windows.Forms.Button
$button7.Location = '5,150'
$button7.Size = '75,20'
$button7.Width = 200
$button7.Text = "TakeProfit properties"

$button8 = New-Object System.Windows.Forms.Button
$button8.Location = '5,170'
$button8.Size = '75,20'
$button8.Width = 200
$button8.Text = "TrailingStop properties"

$button9 = New-Object System.Windows.Forms.Button
$button9.Location = '5,190'
$button9.Size = '75,20'
$button9.Width = 200
$button9.Text = "Martingail properties"

$button10 = New-Object System.Windows.Forms.Button
$button10.Location = '5,210'
$button10.Size = '75,20'
$button10.Width = 200
$button10.Text = "Anti-Martingail properties"

$button11 = New-Object System.Windows.Forms.Button
$button11.Location = '5,230'
$button11.Size = '75,20'
$button11.Width = 200
$button11.Text = "Big candle properties"

$button12 = New-Object System.Windows.Forms.Button
$button12.Location = '5,250'
$button12.Size = '75,20'
$button12.Width = 200
$button12.Text = "Oscillator #1 properties"

$button13 = New-Object System.Windows.Forms.Button
$button13.Location = '5,270'
$button13.Size = '75,20'
$button13.Width = 200
$button13.Text = "Oscillator #2 properties"

$button14 = New-Object System.Windows.Forms.Button
$button14.Location = '5,290'
$button14.Size = '75,20'
$button14.Width = 200
$button14.Text = "Oscillator #3 properties"

$button15 = New-Object System.Windows.Forms.Button
$button15.Location = '5,310'
$button15.Size = '75,20'
$button15.Width = 200
$button15.Text = "IdentifyTrend properties"

$button16 = New-Object System.Windows.Forms.Button
$button16.Location = '5,330'
$button16.Size = '75,20'
$button16.Width = 200
$button16.Text = "TDI properties"

$button17 = New-Object System.Windows.Forms.Button
$button17.Location = '5,350'
$button17.Size = '75,20'
$button17.Width = 200
$button17.Text = "MACD properties"

$button18 = New-Object System.Windows.Forms.Button
$button18.Location = '5,370'
$button18.Size = '75,20'
$button18.Width = 200
$button18.Text = "Parabolic SAR properties"

$button19 = New-Object System.Windows.Forms.Button
$button19.Location = '5,390'
$button19.Size = '75,20'
$button19.Width = 200
$button19.Text = "MA Filter #1 properties"

$button20 = New-Object System.Windows.Forms.Button
$button20.Location = '5,410'
$button20.Size = '75,20'
$button20.Width = 200
$button20.Text = "MA Filter #2 properties"

$button21 = New-Object System.Windows.Forms.Button
$button21.Location = '5,430'
$button21.Size = '75,20'
$button21.Width = 200
$button21.Text = "MA Filter #3 properties"

$button22 = New-Object System.Windows.Forms.Button
$button22.Location = '5,450'
$button22.Size = '75,20'
$button22.Width = 200
$button22.Text = "ZZ properties"

$button23 = New-Object System.Windows.Forms.Button
$button23.Location = '5,470'
$button23.Size = '75,20'
$button23.Width = 200
$button23.Text = "Volatility for MA and ZZ Filters distance"

$button24 = New-Object System.Windows.Forms.Button
$button24.Location = '5,490'
$button24.Size = '75,20'
$button24.Width = 200
$button24.Text = "Volatility Filter properties"

$button25 = New-Object System.Windows.Forms.Button
$button25.Location = '5,510'
$button25.Size = '75,20'
$button25.Width = 200
$button25.Text = "FIBO #1 properties"

$button26 = New-Object System.Windows.Forms.Button
$button26.Location = '5,530'
$button26.Size = '75,20'
$button26.Width = 200
$button26.Text = "FIBO #2 properties"

$button27 = New-Object System.Windows.Forms.Button
$button27.Location = '5,550'
$button27.Size = '75,20'
$button27.Width = 200
$button27.Text = "Spread settings"

$button28 = New-Object System.Windows.Forms.Button
$button28.Location = '5,570'
$button28.Size = '75,20'
$button28.Width = 200
$button28.Text = "Time settings"

$button29 = New-Object System.Windows.Forms.Button
$button29.Location = '5,590'
$button29.Size = '75,20'
$button29.Width = 200
$button29.Text = "Every Day"

$button30 = New-Object System.Windows.Forms.Button
$button30.Location = '5,610'
$button30.Size = '75,20'
$button30.Width = 200
$button30.Text = "Friday and Monday"

$button31 = New-Object System.Windows.Forms.Button
$button31.Location = '5,630'
$button31.Size = '75,20'
$button31.Width = 200
$button31.Text = "Custom Schedule"

$button32 = New-Object System.Windows.Forms.Button
$button32.Location = '5,650'
$button32.Size = '75,20'
$button32.Width = 200
$button32.Text = "New Year Holidays"

$button33 = New-Object System.Windows.Forms.Button
$button33.Location = '5,670'
$button33.Size = '75,20'
$button33.Width = 200
$button33.Text = "News settings"

$button34 = New-Object System.Windows.Forms.Button
$button34.Location = '5,690'
$button34.Size = '75,20'
$button34.Width = 200
$button34.Text = "Lines settings"

$button35 = New-Object System.Windows.Forms.Button
$button35.Location = '5,710'
$button35.Size = '75,20'
$button35.Width = 200
$button35.Text = "GUI settings"

$button36 = New-Object System.Windows.Forms.Button
$button36.Location = '5,730'
$button36.Size = '75,20'
$button36.Width = 200
$button36.Text = "Show orders"

$button37 = New-Object System.Windows.Forms.Button
$button37.Location = '5,750'
$button37.Size = '75,20'
$button37.Width = 200
$button37.Text = "Notifications settings"

$button38 = New-Object System.Windows.Forms.Button
$button38.Location = '5,770'
$button38.Size = '75,20'
$button38.Width = 200
$button38.Text = "Optimization settings"

# Checkbox
$checkbox = New-Object Windows.Forms.Checkbox
$checkbox.Location = '220,50'
$checkbox.AutoSize = $True
$checkbox.Text = "Clear afterwards"

# Label
$label = New-Object Windows.Forms.Label
$label.Location = '220,90'
$label.AutoSize = $True
$label.Text = "Drag and Drop files settings here:"

# Listbox
$listBox = New-Object Windows.Forms.ListBox
$listBox.Location = '220,110'
$listBox.Height = 50
$listBox.Width = 350
$listBox.Anchor = ([System.Windows.Forms.AnchorStyles]::Bottom -bor [System.Windows.Forms.AnchorStyles]::Left -bor [System.Windows.Forms.AnchorStyles]::Right -bor [System.Windows.Forms.AnchorStyles]::Top)
$listBox.IntegralHeight = $False
$listBox.AllowDrop = $True

# StatusBar
$statusBar = New-Object System.Windows.Forms.StatusBar
$statusBar.Text = "Ready - This script was created by Ulises Cune (@ulises2k)"

## Add controls to form ###
$form.SuspendLayout()
$form.Controls.Add($button)
$form.Controls.Add($button1)
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
$form.Controls.Add($button17)
$form.Controls.Add($button18)
$form.Controls.Add($button19)
$form.Controls.Add($button20)
$form.Controls.Add($button21)
$form.Controls.Add($button22)
$form.Controls.Add($button23)
$form.Controls.Add($button24)
$form.Controls.Add($button25)
$form.Controls.Add($button26)
$form.Controls.Add($button27)
$form.Controls.Add($button28)
$form.Controls.Add($button29)
$form.Controls.Add($button30)
$form.Controls.Add($button31)
$form.Controls.Add($button32)
$form.Controls.Add($button33)
$form.Controls.Add($button34)
$form.Controls.Add($button35)
$form.Controls.Add($button36)
$form.Controls.Add($button37)
$form.Controls.Add($button38)
$form.Controls.Add($checkbox)
$form.Controls.Add($label)
$form.Controls.Add($listBox)
$form.Controls.Add($statusBar)
$form.Controls.Add($comboBox1)
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

$button1_Click = {
    foreach ($item in $listBox.Items) {
        $i = Get-Item -LiteralPath $item
        if (!($i -is [System.IO.DirectoryInfo])) {
            if (Button1 -filePath $item) {
                [System.Windows.Forms.MessageBox]::Show('Successful - ' + $button1.Text, 'Default Values', 0, 64)
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
                [System.Windows.Forms.MessageBox]::Show('Successful - ' + $button2.Text, 'Default Values', 0, 64)
            }
        }
    }
    if ($checkbox.Checked -eq $True) {
        $listBox.Items.Clear()
    }

    $statusBar.Text = ("List contains $($listBox.Items.Count) items")
}

$button3_Click = {
    foreach ($item in $listBox.Items) {
        $i = Get-Item -LiteralPath $item
        if (!($i -is [System.IO.DirectoryInfo])) {
            if (Button3 -filePath $item) {
                [System.Windows.Forms.MessageBox]::Show('Successful - ' + $button3.Text, 'Default Values', 0, 64)
            }
        }
    }
    if ($checkbox.Checked -eq $True) {
        $listBox.Items.Clear()
    }

    $statusBar.Text = ("List contains $($listBox.Items.Count) items")
}

$button4_Click = {
    foreach ($item in $listBox.Items) {
        $i = Get-Item -LiteralPath $item
        if (!($i -is [System.IO.DirectoryInfo])) {
            if (Button4 -filePath $item) {
                [System.Windows.Forms.MessageBox]::Show('Successful - ' + $button4.Text, 'Default Values', 0, 64)
            }
        }
    }
    if ($checkbox.Checked -eq $True) {
        $listBox.Items.Clear()
    }

    $statusBar.Text = ("List contains $($listBox.Items.Count) items")
}

$button5_Click = {
    foreach ($item in $listBox.Items) {
        $i = Get-Item -LiteralPath $item
        if (!($i -is [System.IO.DirectoryInfo])) {
            if (Button5 -filePath $item) {
                [System.Windows.Forms.MessageBox]::Show('Successful - ' + $button5.Text, 'Default Values', 0, 64)
            }
        }
    }
    if ($checkbox.Checked -eq $True) {
        $listBox.Items.Clear()
    }

    $statusBar.Text = ("List contains $($listBox.Items.Count) items")
}

$button6_Click = {
    foreach ($item in $listBox.Items) {
        $i = Get-Item -LiteralPath $item
        if (!($i -is [System.IO.DirectoryInfo])) {
            if (Button6 -filePath $item) {
                [System.Windows.Forms.MessageBox]::Show('Successful - ' + $button6.Text, 'Default Values', 0, 64)
            }
        }
    }
    if ($checkbox.Checked -eq $True) {
        $listBox.Items.Clear()
    }

    $statusBar.Text = ("List contains $($listBox.Items.Count) items")
}

$button7_Click = {
    foreach ($item in $listBox.Items) {
        $i = Get-Item -LiteralPath $item
        if (!($i -is [System.IO.DirectoryInfo])) {
            if (Button7 -filePath $item) {
                [System.Windows.Forms.MessageBox]::Show('Successful - ' + $button7.Text, 'Default Values', 0, 64)
            }
        }
    }
    if ($checkbox.Checked -eq $True) {
        $listBox.Items.Clear()
    }

    $statusBar.Text = ("List contains $($listBox.Items.Count) items")
}

$button8_Click = {
    foreach ($item in $listBox.Items) {
        $i = Get-Item -LiteralPath $item
        if (!($i -is [System.IO.DirectoryInfo])) {
            if (Button8 -filePath $item) {
                [System.Windows.Forms.MessageBox]::Show('Successful - ' + $button8.Text, 'Default Values', 0, 64)
            }
        }
    }
    if ($checkbox.Checked -eq $True) {
        $listBox.Items.Clear()
    }

    $statusBar.Text = ("List contains $($listBox.Items.Count) items")
}

$button9_Click = {
    foreach ($item in $listBox.Items) {
        $i = Get-Item -LiteralPath $item
        if (!($i -is [System.IO.DirectoryInfo])) {
            if (Button9 -filePath $item) {
                [System.Windows.Forms.MessageBox]::Show('Successful - ' + $button9.Text, 'Default Values', 0, 64)
            }
        }
    }
    if ($checkbox.Checked -eq $True) {
        $listBox.Items.Clear()
    }

    $statusBar.Text = ("List contains $($listBox.Items.Count) items")
}

$button10_Click = {
    foreach ($item in $listBox.Items) {
        $i = Get-Item -LiteralPath $item
        if (!($i -is [System.IO.DirectoryInfo])) {
            if (Button10 -filePath $item) {
                [System.Windows.Forms.MessageBox]::Show('Successful - ' + $button10.Text, 'Default Values', 0, 64)
            }
        }
    }
    if ($checkbox.Checked -eq $True) {
        $listBox.Items.Clear()
    }

    $statusBar.Text = ("List contains $($listBox.Items.Count) items")
}

$button11_Click = {
    foreach ($item in $listBox.Items) {
        $i = Get-Item -LiteralPath $item
        if (!($i -is [System.IO.DirectoryInfo])) {
            if (Button11 -filePath $item) {
                [System.Windows.Forms.MessageBox]::Show('Successful - ' + $button11.Text, 'Default Values', 0, 64)
            }
        }
    }
    if ($checkbox.Checked -eq $True) {
        $listBox.Items.Clear()
    }

    $statusBar.Text = ("List contains $($listBox.Items.Count) items")
}

$button12_Click = {
    foreach ($item in $listBox.Items) {
        $i = Get-Item -LiteralPath $item
        if (!($i -is [System.IO.DirectoryInfo])) {
            if (Button12 -filePath $item) {
                [System.Windows.Forms.MessageBox]::Show('Successful - ' + $button12.Text, 'Default Values', 0, 64)
            }
        }
    }
    if ($checkbox.Checked -eq $True) {
        $listBox.Items.Clear()
    }

    $statusBar.Text = ("List contains $($listBox.Items.Count) items")
}

$button13_Click = {
    foreach ($item in $listBox.Items) {
        $i = Get-Item -LiteralPath $item
        if (!($i -is [System.IO.DirectoryInfo])) {
            if (Button13 -filePath $item) {
                [System.Windows.Forms.MessageBox]::Show('Successful - ' + $button13.Text, 'Default Values', 0, 64)
            }
        }
    }
    if ($checkbox.Checked -eq $True) {
        $listBox.Items.Clear()
    }

    $statusBar.Text = ("List contains $($listBox.Items.Count) items")
}

$button14_Click = {
    foreach ($item in $listBox.Items) {
        $i = Get-Item -LiteralPath $item
        if (!($i -is [System.IO.DirectoryInfo])) {
            if (Button14 -filePath $item) {
                [System.Windows.Forms.MessageBox]::Show('Successful - ' + $button14.Text, 'Default Values', 0, 64)
            }
        }
    }
    if ($checkbox.Checked -eq $True) {
        $listBox.Items.Clear()
    }

    $statusBar.Text = ("List contains $($listBox.Items.Count) items")
}

$button15_Click = {
    foreach ($item in $listBox.Items) {
        $i = Get-Item -LiteralPath $item
        if (!($i -is [System.IO.DirectoryInfo])) {
            if (Button15 -filePath $item) {
                [System.Windows.Forms.MessageBox]::Show('Successful - ' + $button15.Text, 'Default Values', 0, 64)
            }
        }
    }
    if ($checkbox.Checked -eq $True) {
        $listBox.Items.Clear()
    }

    $statusBar.Text = ("List contains $($listBox.Items.Count) items")
}

$button16_Click = {
    foreach ($item in $listBox.Items) {
        $i = Get-Item -LiteralPath $item
        if (!($i -is [System.IO.DirectoryInfo])) {
            if (Button16 -filePath $item) {
                [System.Windows.Forms.MessageBox]::Show('Successful - ' + $button16.Text, 'Default Values', 0, 64)
            }
        }
    }
    if ($checkbox.Checked -eq $True) {
        $listBox.Items.Clear()
    }

    $statusBar.Text = ("List contains $($listBox.Items.Count) items")
}

$button17_Click = {
    foreach ($item in $listBox.Items) {
        $i = Get-Item -LiteralPath $item
        if (!($i -is [System.IO.DirectoryInfo])) {
            if (Button17 -filePath $item) {
                [System.Windows.Forms.MessageBox]::Show('Successful - ' + $button17.Text, 'Default Values', 0, 64)
            }
        }
    }
    if ($checkbox.Checked -eq $True) {
        $listBox.Items.Clear()
    }

    $statusBar.Text = ("List contains $($listBox.Items.Count) items")
}

$button18_Click = {
    foreach ($item in $listBox.Items) {
        $i = Get-Item -LiteralPath $item
        if (!($i -is [System.IO.DirectoryInfo])) {
            if (Button18 -filePath $item) {
                [System.Windows.Forms.MessageBox]::Show('Successful - ' + $button18.Text, 'Default Values', 0, 64)
            }
        }
    }
    if ($checkbox.Checked -eq $True) {
        $listBox.Items.Clear()
    }

    $statusBar.Text = ("List contains $($listBox.Items.Count) items")
}

$button19_Click = {
    foreach ($item in $listBox.Items) {
        $i = Get-Item -LiteralPath $item
        if (!($i -is [System.IO.DirectoryInfo])) {
            if (Button19 -filePath $item) {
                [System.Windows.Forms.MessageBox]::Show('Successful - ' + $button19.Text, 'Default Values', 0, 64)
            }
        }
    }
    if ($checkbox.Checked -eq $True) {
        $listBox.Items.Clear()
    }

    $statusBar.Text = ("List contains $($listBox.Items.Count) items")
}

$button20_Click = {
    foreach ($item in $listBox.Items) {
        $i = Get-Item -LiteralPath $item
        if (!($i -is [System.IO.DirectoryInfo])) {
            if (Button20 -filePath $item) {
                [System.Windows.Forms.MessageBox]::Show('Successful - ' + $button20.Text, 'Default Values', 0, 64)
            }
        }
    }
    if ($checkbox.Checked -eq $True) {
        $listBox.Items.Clear()
    }

    $statusBar.Text = ("List contains $($listBox.Items.Count) items")
}

$button21_Click = {
    foreach ($item in $listBox.Items) {
        $i = Get-Item -LiteralPath $item
        if (!($i -is [System.IO.DirectoryInfo])) {
            if (Button21 -filePath $item) {
                [System.Windows.Forms.MessageBox]::Show('Successful - ' + $button21.Text, 'Default Values', 0, 64)
            }
        }
    }
    if ($checkbox.Checked -eq $True) {
        $listBox.Items.Clear()
    }

    $statusBar.Text = ("List contains $($listBox.Items.Count) items")
}

$button22_Click = {
    foreach ($item in $listBox.Items) {
        $i = Get-Item -LiteralPath $item
        if (!($i -is [System.IO.DirectoryInfo])) {
            if (Button22 -filePath $item) {
                [System.Windows.Forms.MessageBox]::Show('Successful - ' + $button22.Text, 'Default Values', 0, 64)
            }
        }
    }
    if ($checkbox.Checked -eq $True) {
        $listBox.Items.Clear()
    }

    $statusBar.Text = ("List contains $($listBox.Items.Count) items")
}

$button23_Click = {
    foreach ($item in $listBox.Items) {
        $i = Get-Item -LiteralPath $item
        if (!($i -is [System.IO.DirectoryInfo])) {
            if (Button23 -filePath $item) {
                [System.Windows.Forms.MessageBox]::Show('Successful - ' + $button23.Text, 'Default Values', 0, 64)
            }
        }
    }
    if ($checkbox.Checked -eq $True) {
        $listBox.Items.Clear()
    }

    $statusBar.Text = ("List contains $($listBox.Items.Count) items")
}

$button24_Click = {
    foreach ($item in $listBox.Items) {
        $i = Get-Item -LiteralPath $item
        if (!($i -is [System.IO.DirectoryInfo])) {
            if (Button24 -filePath $item) {
                [System.Windows.Forms.MessageBox]::Show('Successful - ' + $button24.Text, 'Default Values', 0, 64)
            }
        }
    }
    if ($checkbox.Checked -eq $True) {
        $listBox.Items.Clear()
    }

    $statusBar.Text = ("List contains $($listBox.Items.Count) items")
}

$button25_Click = {
    foreach ($item in $listBox.Items) {
        $i = Get-Item -LiteralPath $item
        if (!($i -is [System.IO.DirectoryInfo])) {
            if (Button25 -filePath $item) {
                [System.Windows.Forms.MessageBox]::Show('Successful - ' + $button25.Text, 'Default Values', 0, 64)
            }
        }
    }
    if ($checkbox.Checked -eq $True) {
        $listBox.Items.Clear()
    }

    $statusBar.Text = ("List contains $($listBox.Items.Count) items")
}

$button26_Click = {
    foreach ($item in $listBox.Items) {
        $i = Get-Item -LiteralPath $item
        if (!($i -is [System.IO.DirectoryInfo])) {
            if (Button26 -filePath $item) {
                [System.Windows.Forms.MessageBox]::Show('Successful - ' + $button26.Text, 'Default Values', 0, 64)
            }
        }
    }
    if ($checkbox.Checked -eq $True) {
        $listBox.Items.Clear()
    }

    $statusBar.Text = ("List contains $($listBox.Items.Count) items")
}

$button27_Click = {
    foreach ($item in $listBox.Items) {
        $i = Get-Item -LiteralPath $item
        if (!($i -is [System.IO.DirectoryInfo])) {
            if (Button27 -filePath $item) {
                [System.Windows.Forms.MessageBox]::Show('Successful - ' + $button27.Text, 'Default Values', 0, 64)
            }
        }
    }
    if ($checkbox.Checked -eq $True) {
        $listBox.Items.Clear()
    }

    $statusBar.Text = ("List contains $($listBox.Items.Count) items")
}

$button28_Click = {
    foreach ($item in $listBox.Items) {
        $i = Get-Item -LiteralPath $item
        if (!($i -is [System.IO.DirectoryInfo])) {
            if (Button28 -filePath $item) {
                [System.Windows.Forms.MessageBox]::Show('Successful - ' + $button28.Text, 'Default Values', 0, 64)
            }
        }
    }
    if ($checkbox.Checked -eq $True) {
        $listBox.Items.Clear()
    }

    $statusBar.Text = ("List contains $($listBox.Items.Count) items")
}

$button29_Click = {
    foreach ($item in $listBox.Items) {
        $i = Get-Item -LiteralPath $item
        if (!($i -is [System.IO.DirectoryInfo])) {
            if (Button29 -filePath $item) {
                [System.Windows.Forms.MessageBox]::Show('Successful - ' + $button29.Text, 'Default Values', 0, 64)
            }
        }
    }
    if ($checkbox.Checked -eq $True) {
        $listBox.Items.Clear()
    }

    $statusBar.Text = ("List contains $($listBox.Items.Count) items")
}

$button30_Click = {
    foreach ($item in $listBox.Items) {
        $i = Get-Item -LiteralPath $item
        if (!($i -is [System.IO.DirectoryInfo])) {
            if (Button30 -filePath $item) {
                [System.Windows.Forms.MessageBox]::Show('Successful - ' + $button30.Text, 'Default Values', 0, 64)
            }
        }
    }
    if ($checkbox.Checked -eq $True) {
        $listBox.Items.Clear()
    }

    $statusBar.Text = ("List contains $($listBox.Items.Count) items")
}

$button31_Click = {
    foreach ($item in $listBox.Items) {
        $i = Get-Item -LiteralPath $item
        if (!($i -is [System.IO.DirectoryInfo])) {
            if (Button31 -filePath $item) {
                [System.Windows.Forms.MessageBox]::Show('Successful - ' + $button31.Text, 'Default Values', 0, 64)
            }
        }
    }
    if ($checkbox.Checked -eq $True) {
        $listBox.Items.Clear()
    }

    $statusBar.Text = ("List contains $($listBox.Items.Count) items")
}

$button32_Click = {
    foreach ($item in $listBox.Items) {
        $i = Get-Item -LiteralPath $item
        if (!($i -is [System.IO.DirectoryInfo])) {
            if (Button32 -filePath $item) {
                [System.Windows.Forms.MessageBox]::Show('Successful - ' + $button32.Text, 'Default Values', 0, 64)
            }
        }
    }
    if ($checkbox.Checked -eq $True) {
        $listBox.Items.Clear()
    }

    $statusBar.Text = ("List contains $($listBox.Items.Count) items")
}

$button33_Click = {
    foreach ($item in $listBox.Items) {
        $i = Get-Item -LiteralPath $item
        if (!($i -is [System.IO.DirectoryInfo])) {
            if (Button33 -filePath $item) {
                [System.Windows.Forms.MessageBox]::Show('Successful - ' + $button33.Text, 'Default Values', 0, 64)
            }
        }
    }
    if ($checkbox.Checked -eq $True) {
        $listBox.Items.Clear()
    }

    $statusBar.Text = ("List contains $($listBox.Items.Count) items")
}

$button34_Click = {
    foreach ($item in $listBox.Items) {
        $i = Get-Item -LiteralPath $item
        if (!($i -is [System.IO.DirectoryInfo])) {
            if (Button34 -filePath $item) {
                [System.Windows.Forms.MessageBox]::Show('Successful - ' + $button34.Text, 'Default Values', 0, 64)
            }
        }
    }
    if ($checkbox.Checked -eq $True) {
        $listBox.Items.Clear()
    }

    $statusBar.Text = ("List contains $($listBox.Items.Count) items")
}

$button35_Click = {
    foreach ($item in $listBox.Items) {
        $i = Get-Item -LiteralPath $item
        if (!($i -is [System.IO.DirectoryInfo])) {
            if (Button35 -filePath $item) {
                [System.Windows.Forms.MessageBox]::Show('Successful - ' + $button35.Text, 'Default Values', 0, 64)
            }
        }
    }
    if ($checkbox.Checked -eq $True) {
        $listBox.Items.Clear()
    }

    $statusBar.Text = ("List contains $($listBox.Items.Count) items")
}

$button36_Click = {
    foreach ($item in $listBox.Items) {
        $i = Get-Item -LiteralPath $item
        if (!($i -is [System.IO.DirectoryInfo])) {
            if (Button36 -filePath $item) {
                [System.Windows.Forms.MessageBox]::Show('Successful - ' + $button36.Text, 'Default Values', 0, 64)
            }
        }
    }
    if ($checkbox.Checked -eq $True) {
        $listBox.Items.Clear()
    }

    $statusBar.Text = ("List contains $($listBox.Items.Count) items")
}

$button37_Click = {
    foreach ($item in $listBox.Items) {
        $i = Get-Item -LiteralPath $item
        if (!($i -is [System.IO.DirectoryInfo])) {
            if (Button37 -filePath $item) {
                [System.Windows.Forms.MessageBox]::Show('Successful - ' + $button37.Text, 'Default Values', 0, 64)
            }
        }
    }
    if ($checkbox.Checked -eq $True) {
        $listBox.Items.Clear()
    }

    $statusBar.Text = ("List contains $($listBox.Items.Count) items")
}

$button38_Click = {
    foreach ($item in $listBox.Items) {
        $i = Get-Item -LiteralPath $item
        if (!($i -is [System.IO.DirectoryInfo])) {
            if (Button38 -filePath $item) {
                [System.Windows.Forms.MessageBox]::Show('Successful - ' + $button38.Text, 'Default Values', 0, 64)
            }
        }
    }
    if ($checkbox.Checked -eq $True) {
        $listBox.Items.Clear()
    }

    $statusBar.Text = ("List contains $($listBox.Items.Count) items")
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

### Wire up events ###
$button.Add_Click($button_Click)
$button1.Add_Click($button1_Click)
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
$button15.Add_Click($button15_Click)
$button16.Add_Click($button16_Click)
$button17.Add_Click($button17_Click)
$button18.Add_Click($button18_Click)
$button19.Add_Click($button19_Click)
$button20.Add_Click($button20_Click)
$button21.Add_Click($button21_Click)
$button22.Add_Click($button22_Click)
$button23.Add_Click($button23_Click)
$button24.Add_Click($button24_Click)
$button25.Add_Click($button25_Click)
$button26.Add_Click($button26_Click)
$button27.Add_Click($button27_Click)
$button28.Add_Click($button28_Click)
$button29.Add_Click($button29_Click)
$button30.Add_Click($button30_Click)
$button31.Add_Click($button31_Click)
$button32.Add_Click($button32_Click)
$button33.Add_Click($button33_Click)
$button34.Add_Click($button34_Click)
$button35.Add_Click($button35_Click)
$button36.Add_Click($button36_Click)
$button37.Add_Click($button37_Click)
$button38.Add_Click($button38_Click)
$listBox.Add_DragOver($listBox_DragOver)
$listBox.Add_DragDrop($listBox_DragDrop)

#### Show form ###
[void] $form.ShowDialog()
