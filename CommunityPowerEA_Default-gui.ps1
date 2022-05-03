# Script to Upgrade .Set File From CommunityPower EA v2.30.x to v2.31.x
# Drag and drop file settings 2.30.x MT5 to windows form and press button
#
# Autor: Ulises Cune (@Ulises2k)
# v2.0


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

function MainConvertVersion ([string]$filePath) {

    #Detect Version 2.31
    if (!(Select-String -Path $filePath -Quiet -Pattern "MinMarginLevel")) {

        $PathDest = (Get-Item $filePath).BaseName + "-v2.31.set"
        $CurrentDir = Split-Path -Path "$filePath"
        $filePathNew = "$CurrentDir\$PathDest"
        Copy-Item "$filePath" -Destination $filePathNew

        $inifile = Get-IniFile($filePathNew)
        #This is the instruction
        #https://communitypowerea.userecho.com/en/communities/1/topics/28-all-pips-parameters-calculated-using-atr?redirect_to_reply=1857#comment-1857
        # Default Value 2.31
        #; Expert properties
        Set-OrAddIniValue -FilePath $filePathNew  -keyValueList @{
            MinMarginLevel = "0"
        }

        Add-Content -Path $filePathNew -Value "; Volatility for all parameters nominated in points"
        Add-Content -Path $filePathNew -Value "VolPV_Properties===================================================================================="
        Set-OrAddIniValue -FilePath $filePathNew  -keyValueList @{
            VolPV_Type = "1"
        }

        #ATR parameters must be set in the corresponding section.
        $StepATR_TF = $inifile['StepATR_TF']
        $StepATR_Period = $inifile['StepATR_Period']
        Set-OrAddIniValue -FilePath $filePathNew  -keyValueList @{
            VolPV_TF      = $StepATR_TF
            VolPV_Period  = $StepATR_Period
            VolPV_MinSize = "0"
            VolPV_MaxSize = "0"
        }



        #; Pending entry properties
        Set-OrAddIniValue -FilePath $filePathNew  -keyValueList @{
            Pending_Distance_ModeP = "0"
        }

        #; StopLoss properties
        Set-OrAddIniValue -FilePath $filePathNew  -keyValueList @{
            StopLoss_ModeP = "0"
        }

        #; TakeProfit properties
        Set-OrAddIniValue -FilePath $filePathNew  -keyValueList @{
            TakeProfit_ModeP       = "0"
            MinProfitToClose_ModeP = "0"
        }

        #; Global Account properties
        Add-Content -Path $filePathNew -Value "; Global Account properties"
        Add-Content -Path $filePathNew -Value "GlobalAccount_Properties===================================================================================="
        Set-OrAddIniValue -FilePath $filePathNew  -keyValueList @{
            GlobalAccountTakeProfit_ccy    = "0"
            GlobalAccountTakeProfit_perc   = "0"
            GlobalAccountTargetProfit_ccy  = "0"
            GlobalAccountTargetProfit_perc = "0"
        }


        #; TrailingStop properties
        Set-OrAddIniValue -FilePath $filePathNew  -keyValueList @{
            TrailingStop_ModeP = "0"
        }

        #Default
        Set-OrAddIniValue -FilePath $filePathNew  -keyValueList @{
            MartingailType   = "0"
            Martingail_ModeP = "0"
        }

        # ATR * coefficient" mode must be replaced with "Martingale enabled",
        if ([int]$inifile['MartingailType'] -eq 3) {
            #"Step size calc mode" must be set to "Coefficient to volatility",
            Set-OrAddIniValue -FilePath $filePathNew  -keyValueList @{
                MartingailType   = "1"
                Martingail_ModeP = "1"
            }
        }

        #Previous step * coefficient" mode must be replaced with "Martingale enabled".
        if ([int]$inifile['MartingailType'] -eq 2) {
            Set-OrAddIniValue -FilePath $filePathNew  -keyValueList @{
                MartingailType = "1"
            }
        }

        #Step increase coefficient" for "Fixed step" mode must be set 1.
        if ([int]$inifile['MartingailType'] -eq 1) {
            Set-OrAddIniValue -FilePath $filePathNew  -keyValueList @{
                StepCoeff = "1"
            }
        }

        #Add default values to replace below
        Set-OrAddIniValue -FilePath $filePathNew  -keyValueList @{
            AntiMartingailType   = "0"
            AntiMartingail_ModeP = "0"
        }

        # ATR * coefficient" mode must be replaced with "Martingale enabled",
        if ([int]$inifile['AntiMartingailType'] -eq 3) {
            #"Step size calc mode" must be set to "Coefficient to volatility",
            Set-OrAddIniValue -FilePath $filePathNew  -keyValueList @{
                AntiMartingailType   = "1"
                AntiMartingail_ModeP = "1"
            }
        }

        #Previous step * coefficient" mode must be replaced with "Martingale enabled".
        if ([int]$inifile['AntiMartingailType'] -eq 2) {
            Set-OrAddIniValue -FilePath $filePathNew  -keyValueList @{
                AntiMartingailType = "1"
            }
        }

        #Step increase coefficient" for "Fixed step" mode must be set 1.
        if ([int]$inifile['AntiMartingailType'] -eq 1) {
            Set-OrAddIniValue -FilePath $filePathNew  -keyValueList @{
                AntiStepCoeff = "0"
            }
        }


        #; Anti-Martingail properties
        Set-OrAddIniValue -FilePath $filePathNew  -keyValueList @{
            AntiStopLoss_ModeP = "0"
        }
        return $true
    }
    else {
        return $false
    }
}

#; Expert properties
function DefaultButton([string]$filePath) {
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
}

#; Lot properties
function DefaultButton1([string]$filePath) {
    Set-OrAddIniValue -FilePath $filePath  -keyValueList @{
        Lot_Type     = "3||0||0||4||N"
        Lot_Per_1000 = "0.01||0.005||0.005||0.01||N"
        Lot_Risk     = "0||0||0.000000||0.000000||N"
        Lot_Max      = "0||0||0.000000||0.000000||N"
    }
}

function DefaultButton2([string]$filePath) {
}

function DefaultButton3([string]$filePath) {
}

function DefaultButton4([string]$filePath) {
}

function DefaultButton5([string]$filePath) {
}

function DefaultButton6([string]$filePath) {
}

function DefaultButton6([string]$filePath) {
}

function DefaultButton7([string]$filePath) {
}

function DefaultButton8([string]$filePath) {
}

function DefaultButton9([string]$filePath) {
}

function DefaultButton10([string]$filePath) {
}



#######################GUI################################################################
### API Windows Forms ###
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")


### Create form ###
$form = New-Object System.Windows.Forms.Form
$form.Text = "Set Default Value - CommunityPower EA"
$form.Size = '512,600'
$form.StartPosition = "CenterScreen"
$form.MinimumSize = $form.Size
$form.MaximizeBox = $False
$form.Topmost = $True


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
$button3.Location = '5,70'  #Sumar 50 (.Location = 'X,50') + 20 ($button2.Size = 'x,20')
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
$button11.Text = "Oscillator #1 properties"


$button12 = New-Object System.Windows.Forms.Button
$button12.Location = '5,250'
$button12.Size = '75,20'
$button12.Width = 200
$button12.Text = "Oscillator #2 properties"


$button13 = New-Object System.Windows.Forms.Button
$button13.Location = '5,270'
$button13.Size = '75,20'
$button13.Width = 200
$button13.Text = "Oscillator #3 properties"

$button14 = New-Object System.Windows.Forms.Button
$button14.Location = '5,290'
$button14.Size = '75,20'
$button14.Width = 200
$button14.Text = "IdentifyTrend properties"


$button15 = New-Object System.Windows.Forms.Button
$button15.Location = '5,310'
$button15.Size = '75,20'
$button15.Width = 200
$button15.Text = "TDI properties"

$button16 = New-Object System.Windows.Forms.Button
$button16.Location = '5,330'
$button16.Size = '75,20'
$button16.Width = 200
$button16.Text = "MACD properties"

$button17 = New-Object System.Windows.Forms.Button
$button17.Location = '5,350'
$button17.Size = '75,20'
$button17.Width = 200
$button17.Text = "Parabolic SAR properties"

$button18 = New-Object System.Windows.Forms.Button
$button18.Location = '5,370'
$button18.Size = '75,20'
$button18.Width = 200
$button18.Text = "MA Filter #1 properties"

$button19 = New-Object System.Windows.Forms.Button
$button19.Location = '5,390'
$button19.Size = '75,20'
$button19.Width = 200
$button19.Text = "MA Filter #2 properties"

$button20 = New-Object System.Windows.Forms.Button
$button20.Location = '5,410'
$button20.Size = '75,20'
$button20.Width = 200
$button20.Text = "MA Filter #3 properties"

$button21 = New-Object System.Windows.Forms.Button
$button21.Location = '5,430'
$button21.Size = '75,20'
$button21.Width = 200
$button21.Text = "ZZ properties"

$button22 = New-Object System.Windows.Forms.Button
$button22.Location = '5,450'
$button22.Size = '75,20'
$button22.Width = 200
$button22.Text = "Volatility for MA and ZZ Filters distance"

$button23 = New-Object System.Windows.Forms.Button
$button23.Location = '5,470'
$button23.Size = '75,20'
$button23.Width = 200
$button23.Text = "Volatility Filter properties"

# Checkbox
$checkbox = New-Object Windows.Forms.Checkbox
$checkbox.Location = '220,8'
$checkbox.AutoSize = $True
$checkbox.Text = "Clear afterwards"

# Label
$label = New-Object Windows.Forms.Label
$label.Location = '5,40'
$label.AutoSize = $True
$label.Text = "Drag and Drop files settings here:"

# Listbox
$listBox = New-Object Windows.Forms.ListBox
$listBox.Location = '5,480'
$listBox.Height = 50
$listBox.Width = 480
$listBox.Anchor = ([System.Windows.Forms.AnchorStyles]::Bottom -bor [System.Windows.Forms.AnchorStyles]::Left -bor [System.Windows.Forms.AnchorStyles]::Right -bor [System.Windows.Forms.AnchorStyles]::Top)
$listBox.IntegralHeight = $False
$listBox.AllowDrop = $True

# StatusBar
$statusBar = New-Object System.Windows.Forms.StatusBar
$statusBar.Text = "Ready"


### Add controls to form ###
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




$form.Controls.Add($checkbox)
$form.Controls.Add($label)
$form.Controls.Add($listBox)
$form.Controls.Add($statusBar)
$form.ResumeLayout()


### Write event handlers ###
$button_Click = {
    foreach ($item in $listBox.Items) {
        if (!($i -is [System.IO.DirectoryInfo])) {
            if (DefaultButton -filePath $item) {
                [System.Windows.Forms.MessageBox]::Show('Successfully Default', 'Default Values', 0, 64)
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
        if (!($i -is [System.IO.DirectoryInfo])) {
            if (DefaultButton1 -filePath $item) {
                [System.Windows.Forms.MessageBox]::Show('Successfully Default1', 'Default Values', 0, 64)
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
        if (!($i -is [System.IO.DirectoryInfo])) {
            if (DefaultButton2 -filePath $item) {
                [System.Windows.Forms.MessageBox]::Show('Successfully Default2', 'Default Values', 0, 64)
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
        $listBox.remove_Click($button1_Click)
        $listBox.remove_Click($button2_Click)
        $listBox.remove_Click($button3_Click)
        $listBox.remove_Click($button4_Click)
        $listBox.remove_Click($button5_Click)
        $listBox.remove_Click($button6_Click)
        $listBox.remove_Click($button7_Click)
        $listBox.remove_Click($button8_Click)
        $listBox.remove_Click($button9_Click)
        $listBox.remove_Click($button10_Click)
        $listBox.remove_Click($button11_Click)
        $listBox.remove_Click($button12_Click)
        $listBox.remove_Click($button13_Click)
        $listBox.remove_Click($button14_Click)
        $listBox.remove_Click($button15_Click)
        $listBox.remove_Click($button16_Click)
        $listBox.remove_Click($button17_Click)
        $listBox.remove_Click($button18_Click)
        $listBox.remove_Click($button19_Click)
        $listBox.remove_Click($button20_Click)
        $listBox.remove_Click($button21_Click)
        $listBox.remove_Click($button22_Click)



        $listBox.remove_DragOver($listBox_DragOver)
        $listBox.remove_DragDrop($listBox_DragDrop)
        $listBox.remove_DragDrop($listBox_DragDrop)
        $form.remove_FormClosed($Form_Cleanup_FormClosed)
    }
    catch [Exception]
    { }
}


### Wire up events ###
$button.Add_Click($button_Click)
$button.Add_Click($button1_Click)
$button.Add_Click($button2_Click)
$button.Add_Click($button3_Click)
$button.Add_Click($button4_Click)
$button.Add_Click($button5_Click)
$button.Add_Click($button6_Click)
$button.Add_Click($button7_Click)
$button.Add_Click($button8_Click)
$button.Add_Click($button9_Click)
$button.Add_Click($button10_Click)
$button.Add_Click($button11_Click)
$button.Add_Click($button12_Click)
$button.Add_Click($button13_Click)
$button.Add_Click($button14_Click)
$button.Add_Click($button15_Click)
$button.Add_Click($button16_Click)
$button.Add_Click($button17_Click)
$button.Add_Click($button18_Click)
$button.Add_Click($button19_Click)
$button.Add_Click($button20_Click)
$button.Add_Click($button21_Click)
$button.Add_Click($button22_Click)
$button.Add_Click($button23_Click)



$listBox.Add_DragOver($listBox_DragOver)
$listBox.Add_DragDrop($listBox_DragDrop)
$form.Add_FormClosed($form_FormClosed)


#### Show form ###
[void] $form.ShowDialog()
