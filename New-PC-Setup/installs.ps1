# Base
choco install -y googlechrome
choco install -y firefox-dev --pre #I personally enjoy Dev Ed
choco install -y notepadplusplus
choco install -y 7zip
choco install -y paint.net
choco install -y spotify
choco install -y discord
choco install -y steam-client
choco install -y pnggauntlet
choco install -y slack
choco install -y notion

# Dev
choco install -y git
choco install -y git-lfs
choco install -y putty
choco install -y python
choco install -y vcredist140
choco install -y gitkraken

choco install -y visualstudio2017community
choco install -y visualstudio2017buildtools
choco install -y visualstudiocode

# Jetbrains Products
choco install -y jetbrainstoolbox
choco install -y pycharm # Professional edition
choco install -y clion-ide
choco install -y intellijidea-ultimate

# cli utilities + linux-like environment on windows
choco install -y nano
choco install -y sudo
choco install -y vim
choco install -y pip

# configure windows display settings
displayswitch/extend Extend screen

# set ExecutionPolicy back to Restricted once script is complete
Set-ExecutionPolicy Restricted