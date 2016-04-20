##
# Form to fill info
##

[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") 
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") 

$objForm = New-Object System.Windows.Forms.Form 
$objForm.Text = "ORK Form"
$objForm.Size = New-Object System.Drawing.Size(800,600) 
$objForm.StartPosition = "CenterScreen"

$objForm.KeyPreview = $True
$objForm.Add_KeyDown({if ($_.KeyCode -eq "Enter") 
    {$x=$objTextBox.Text;$objForm.Close()}})
$objForm.Add_KeyDown({if ($_.KeyCode -eq "Escape") 
    {$objForm.Close()}})

$OKButton = New-Object System.Windows.Forms.Button
$OKButton.Location = New-Object System.Drawing.Size(600,520)
$OKButton.Size = New-Object System.Drawing.Size(75,23)
$OKButton.Text = "OK"
$OKButton.Add_Click({$x=$objTextBox.Text;$objForm.Close()})
$objForm.Controls.Add($OKButton)

$CancelButton = New-Object System.Windows.Forms.Button
$CancelButton.Location = New-Object System.Drawing.Size(680,520)
$CancelButton.Size = New-Object System.Drawing.Size(75,23)
$CancelButton.Text = "Cancel"
$CancelButton.Add_Click({$objForm.Close()})
$objForm.Controls.Add($CancelButton)

#Textboxes

$objLabelRegisteredUser = New-Object System.Windows.Forms.Label
$objLabelRegisteredUser.Location = New-Object System.Drawing.Size(10,20) 
$objLabelRegisteredUser.Size = New-Object System.Drawing.Size(100,20) 
$objLabelRegisteredUser.Text = "RegisteredUser:"
$objForm.Controls.Add($objLabelRegisteredUser) 

$objTextBoxRegisteredUser = New-Object System.Windows.Forms.TextBox 
$objTextBoxRegisteredUser.Location = New-Object System.Drawing.Size(120,20) 
$objTextBoxRegisteredUser.Size = New-Object System.Drawing.Size(150,20) 
$objForm.Controls.Add($objTextBoxRegisteredUser) 

$objLabelRegisteredOrg = New-Object System.Windows.Forms.Label
$objLabelRegisteredOrg.Location = New-Object System.Drawing.Size(10,50) 
$objLabelRegisteredOrg.Size = New-Object System.Drawing.Size(100,20) 
$objLabelRegisteredOrg.Text = "Registered Org:"
$objForm.Controls.Add($objLabelRegisteredOrg) 

$objTextBoxRegisteredOrg = New-Object System.Windows.Forms.TextBox 
$objTextBoxRegisteredOrg.Location = New-Object System.Drawing.Size(120,50) 
$objTextBoxRegisteredOrg.Size = New-Object System.Drawing.Size(150,20) 
$objForm.Controls.Add($objTextBoxRegisteredOrg) 

$objForm.Topmost = $True

$objForm.Add_Shown({$objForm.Activate()})
[void] $objForm.ShowDialog()


###########################



$RegisteredUser = $objTextBoxRegisteredUser.Text
$RegisteredOrganization = $objTextBoxRegisteredOrg.Text
