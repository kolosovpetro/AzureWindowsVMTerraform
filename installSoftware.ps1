# Install IIS
import-module servermanager
add-windowsfeature web-server -includeallsubfeature
add-windowsfeature Web-Asp-Net45
add-windowsfeature NET-Framework-Features

# Install Chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Install Software
choco install microsoft-edge -y
choco install visualstudio2022community -y
choco install git.install -y
choco install netfx-4.8-devpack -y
choco install dotnet-6.0-sdk -y
choco install openssl -y
choco install powershell-core -y
choco install winrar -y
choco install notepadplusplus -y
choco install nvm -y

exit 0