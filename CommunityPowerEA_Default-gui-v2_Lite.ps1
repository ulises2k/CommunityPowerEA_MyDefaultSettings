# Set Default values for Production (live) Setting File
#
# Autor: Ulises Cune (@Ulises2k)
# v2.1
#
# !!!! It version is for CommunityPower EA v2.31 !!!!
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
        Expert_Id                   = "232"
        Expert_Comment              = "CP" + (Get-Date -Format "dd.MM.yyyy.HH:mm")
        Lot_Properties              = "===== Lot =============================================================================="
        GlobalAccount_Properties    = "===== Global Account =============================================================================="
        VolPV_Properties            = "===== Volatility for all parameters nominated in points =============================================================================="
        Pending_Properties          = "===== Pending entry =============================================================================="
        StopLoss_Properties         = "===== StopLoss =============================================================================="
		StopLoss_Global             = "===== Summ StopLoss (buy + sell) =============================================================================="
		StopLoss_Pause              = "===== Pause after loss =============================================================================="
        UseVirtualSL                = "false"
        TakeProfit_Properties       = "===== TakeProfit =============================================================================="
        TakeProfit_ReduceAfter      = "===== Reduce TakeProfit after minutes =============================================================================="
        TakeProfit_ReduceSeries     = "===== Reduce TakeProfit for every order =============================================================================="
        TakeProfit_Global           = "===== Summ TakeProfit (buy + sell) =============================================================================="
        MinProfitToClose_Properties = "===== Min profit to close on signal =============================================================================="
        UseVirtualTP                = "false"
        TrailingStop_Properties     = "===== TrailingStop =============================================================================="
        Martingail_Properties       = "===== Martingail =============================================================================="
        BE_Alert_After              = "0"
        PartialClose_Properties     = "===== Partial Close =============================================================================="
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

    if (!($comboBox.SelectedIndex -eq "-1")) {
        if ($comboBox.SelectedItem.ToString() -eq "EUR/USD" ) {
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

    if (!($comboBox.SelectedIndex -eq "-1")) {
        if ($comboBox.SelectedItem.ToString() -eq "XAU/USD" ) {
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
                # ; News settings
                News_Properties            = "===== News / XAU/USD =============================================================================="
                News_Mode                  = "2"
                News_Currencies            = "auto"
                News_Impact_H              = "true"
                News_Impact_M              = "true"
                News_Impact_L              = "false"
                News_Impact_N              = "false"
                News_FilterInclude         = "Fed,Employment,PIB,NFP,BCE"
                News_MinutesBefore         = "30"
                News_MinutesAfter          = "30"
                News_OpenOn                = "0"
                News_MartinOn              = "0"
                News_CloseOn               = "4"
                News_PartialCloseOn        = "0"
            }
        }
    }

    if (!($comboBox.SelectedIndex -eq "-1")) {
        if ($comboBox.SelectedItem.ToString() -eq "Disable Every Day/Friday and Monday " ) {
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
                #; Custom Schedule
                Custom_Schedule_Properties = "===== Custom Schedule ====="
                Custom_Schedule_On         = "false"
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
				# ; News settings
                News_Properties            = "===== News =============================================================================="
                News_Mode                  = "2"
                News_Currencies            = "auto"
                News_Impact_H              = "true"
                News_Impact_M              = "true"
                News_Impact_L              = "false"
                News_Impact_N              = "false"
                News_FilterInclude         = "Fed,Employment,PIB,NFP,BCE"
                News_MinutesBefore         = "30"
                News_MinutesAfter          = "30"
                News_OpenOn                = "0"
                News_MartinOn              = "0"
                News_CloseOn               = "4"
                News_PartialCloseOn        = "0"
            }
        }
    }

    if ($comboBox.SelectedIndex -eq "-1") {
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

    $ZZ_Type = [int]$inifile["ZZ_Type"]
    $MA_Filter_1_Type = [int]$inifile["MA_Filter_1_Type"]
    $MA_Filter_2_Type = [int]$inifile["MA_Filter_2_Type"]
    $MA_Filter_3_Type = [int]$inifile["MA_Filter_3_Type"]

    if (($ZZ_Type -eq 0) -and ($MA_Filter_1_Type -eq 0) -and ($MA_Filter_2_Type -eq 0) -and ($MA_Filter_3_Type -eq 0)) {
        Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
            VolMA_Type = "0"
        }
    }

    $StopLoss = [int]$inifile["StopLoss"]
    if ($StopLoss -eq 0) {
        Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
            StopLoss_Width = "0"
        }
    }
    else {
        Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
            StopLoss_Width = "2"
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
$form.Text = "Set Default Value only for each Sections - CommunityPower EA v2.31/v2.32"
$form.Size = '600,250'
$form.StartPosition = "CenterScreen"
$form.MinimumSize = $form.Size
$form.MaximizeBox = $False
$form.Topmost = $True

#Combobox
$tickets = @("EUR/USD", "XAU/USD", "Disable Every Day/Friday and Monday")
$comboBox = New-Object System.Windows.Forms.ComboBox
$comboBox.Location = '220, 10'
$comboBox.Size = '300, 50'
foreach ($ticket in $tickets) {
    $comboBox.Items.add($ticket)
}

### Define controls ###
$button = New-Object System.Windows.Forms.Button
$button.Location = '5,10'
$button.Size = '75,20'
$button.Width = 200
$button.Text = "My Defaults"

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
$listBox.Add_DragOver($listBox_DragOver)
$listBox.Add_DragDrop($listBox_DragDrop)
$form.Add_FormClosed($form_FormClosed)

#### Show form ###
[void] $form.ShowDialog()
