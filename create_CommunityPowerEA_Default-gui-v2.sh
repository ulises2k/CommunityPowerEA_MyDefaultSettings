#!/bin/bash
#Crea automaticamente el script CommunityPowerEA_Default-gui-v2.ps1

echo "Function Get-IniFile ($file) {"
echo "    \$ini = [ordered]@{}"
echo "    switch -regex -file \$file {"
echo '        "^\s*(.+?)\s*=\s*(.*)$" {'
echo "            \$name, \$value = \$matches[1..2]"
echo "            # skip comments that start with semicolon:"
echo '            if (!($name.StartsWith(";"))) {'
echo "                if ($value.Contains('||') ) {"
echo "                    \$ini[$name] = \$value.Split('||')[0]"
echo "                    continue"
echo "                }"
echo "                else {"
echo "                    \$ini[$name] = \$value"
echo "                    continue"
echo "                }"
echo "            }"
echo "        }"
echo "    }"
echo "    \$ini"
echo "}"
echo " "

echo "function Set-OrAddIniValue {"
echo "    Param("
echo "        [string]\$FilePath,"
echo "        [hashtable]\$keyValueList"
echo "    )"
echo "    \$content = Get-Content \$FilePath"
echo "    \$keyValueList.GetEnumerator() | ForEach-Object {"
echo '        if (\$content -match "^\$(\$_.Key)\s*=") {'
echo '            \$content = \$content -replace "\$(\$_.Key)\s*=(.*)", "\$(\$_.Key)=\$(\$_.Value)"'
echo "        }"
echo "        else {"
echo '            \$content += "\$(\$_.Key)=\$(\$_.Value)"'
echo "        }"
echo "    }"
echo "    \$content | Set-Content \$FilePath"
echo "}"

echo "#; My Defaults"
echo "function Button([string]\$filePath) {"
echo "    Set-OrAddIniValue -FilePath \$filePath  -keyValueList @{"
echo '        Expert_Comment         = "CP-" + (Get-Date -Format "dd/MM/yyyy_HH:mm_")'
echo '        Time_Manual_GMT_Offset = "3||2||1||20||N"'
echo '        GUI_Enabled            = "false"'
echo '        BE_Alert_After         = "0||3||1||30||N"'
echo '        MessagesToGrammy       = "false||false||0||true||N"'
echo '        Alerts_Enabled         = "false"'
echo '        Sounds_Enabled         = "false"'
echo "    }"
echo "    return \$true"
echo "}"

IFS=$'\r'
LocationY=10
i=0
for b in $(cat Default-v2.30.set | grep -a ";" | grep -a -v "saved on" | awk -vORS= -F";" '{print $2}') ; do
i=$(($i+1))
echo "function Button"$i"([string]\$filePath) {"
echo "    Set-OrAddIniValue -FilePath \$filePath  -keyValueList @{"
echo "        key = \"value\""
echo "    }"
echo "    return \$true"
echo "}"
echo " "
done
IFS=' '


echo "#######################GUI################################################################"
echo "### API Windows Forms ###"
echo "[void] [System.Reflection.Assembly]::LoadWithPartialName(\"System.Windows.Forms\")"
echo "[void] [System.Reflection.Assembly]::LoadWithPartialName(\"System.Drawing\")"
echo " "
echo "### Create form ###"
echo "\$form = New-Object System.Windows.Forms.Form"
echo "\$form.Text = \"Set Default Value - CommunityPower EA\""
echo "\$form.Size = '600,920'"
echo "\$form.StartPosition = \"CenterScreen\""
echo "\$form.MinimumSize = \$form.Size"
echo "\$form.MaximizeBox = \$False"
echo "\$form.Topmost = \$True"
echo " "
echo "### Define controls ###"
echo "\$button = New-Object System.Windows.Forms.Button"
echo "\$button.Location = '5,10'"
echo "\$button.Size = '75,20'"
echo "\$button.Width = 200"
echo "\$button.Text = \"My Defaults\""
echo " "

IFS=$'\r'
LocationY=10
i=0
for b in $(cat Default-v2.30.set | grep -a ";" | grep -a -v "saved on" | awk -vORS= -F";" '{print $2}') ; do
i=$(($i+1))
LocationY=$(($LocationY+20))
echo "\$button"$i" = New-Object System.Windows.Forms.Button"
echo "\$button"$i".Location = '5,"$LocationY"'"
echo "\$button"$i".Size = '75,20'"
echo "\$button"$i".Width = 200"
echo "\$button"$i".Text = \""$b"\""
echo " "
done
IFS=' '
echo "# Checkbox"
echo "\$checkbox = New-Object System.Windows.Forms.Checkbox"
echo "\$checkbox.Location = '220,8'"
echo "\$checkbox.AutoSize = \$True"
echo "\$checkbox.Text = \"Clear afterwards\""
echo " "
echo "# Label"
echo "\$label = New-Object System.Windows.Forms.Label"
echo "\$label.Location = '5,800'"
echo "\$label.AutoSize = \$True"
echo "\$label.Text = \"Drag and Drop files settings here:\""
echo " "
echo "# Listbox"
echo "\$listBox = New-Object System.Windows.Forms.ListBox"
echo "\$listBox.Location = '5,820'"
echo "\$listBox.Height = 50"
echo "\$listBox.Width = 550"
echo "\$listBox.Anchor = ([System.Windows.Forms.AnchorStyles]::Bottom -bor [System.Windows.Forms.AnchorStyles]::Left -bor [System.Windows.Forms.AnchorStyles]::Right -bor [System.Windows.Forms.AnchorStyles]::Top)"
echo "\$listBox.IntegralHeight = \$False"
echo "\$listBox.AllowDrop = \$True"
echo " "
echo "# StatusBar"
echo "\$statusBar = New-Object System.Windows.Forms.StatusBar"
echo "\$statusBar.Text = \"Ready - This script was created by Ulises Cune (\@ulises2k)\""
echo " "

echo "## Add controls to form ###"
echo "\$form.SuspendLayout()"
echo "\$form.Controls.Add(\$button)"
for i in {1..38} ; do
echo "\$form.Controls.Add(\$button"$i")"
done
echo "\$form.Controls.Add(\$checkbox)"
echo "\$form.Controls.Add(\$label)"
echo "\$form.Controls.Add(\$listBox)"
echo "\$form.Controls.Add(\$statusBar)"
echo "\$form.ResumeLayout()"
echo " "

echo "### Write event handlers ###"
echo "\$button_Click = {"
echo "    foreach (\$item in \$listBox.Items) {"
echo "        \$i = Get-Item -LiteralPath \$item"
echo "        if (!(\$i -is [System.IO.DirectoryInfo])) {"
echo "            if (Button -filePath \$item) {"
echo "                [System.Windows.Forms.MessageBox]::Show('Successful - ' + \$button.Text, 'Defaults Values', 0, 64)"
echo "            }"
echo "        }"
echo "    }"
echo " "
echo "    if (\$checkbox.Checked -eq \$True) {"
echo "        \$listBox.Items.Clear()"
echo "    }"
echo " "
echo "    \$statusBar.Text = (\"List contains \$(\$listBox.Items.Count) items\")"
echo "}"
echo " "

for i in {1..38} ; do
echo "\$button"$i"_Click = {"
echo "    foreach (\$item in \$listBox.Items) {"
echo "        \$i = Get-Item -LiteralPath \$item"
echo "        if (!(\$i -is [System.IO.DirectoryInfo])) {"
echo "            if (Button"$i" -filePath \$item) {"
echo "                [System.Windows.Forms.MessageBox]::Show('Successful - ' + \$button"$i".Text, 'Default Values', 0, 64)"
echo "            }"
echo "        }"
echo "    }"
echo "    if (\$checkbox.Checked -eq \$True) {"
echo "        \$listBox.Items.Clear()"
echo "    }"
echo " "
echo "    \$statusBar.Text = (\"List contains \$(\$listBox.Items.Count) items\")"
echo "}"
echo " "
done

echo "### Wire up events ###"
echo "\$button.Add_Click(\$button_Click)"
for i in {1..38} ; do
echo "\$button"$i".Add_Click(\$button"$i"_Click)"
done
echo "\$listBox.Add_DragOver(\$listBox_DragOver)"
echo "\$listBox.Add_DragDrop(\$listBox_DragDrop)"
echo " "
echo "#### Show form ###"
echo "[void] \$form.ShowDialog()"