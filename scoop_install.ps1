# Install Scoop
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod get.scoop.sh | Invoke-Expression

# Buckets
scoop bucket add extras # https://github.com/ScoopInstaller/Extras
scoop bucket add java # https://github.com/ScoopInstaller/Java/wiki

# App Installs
scoop install git openssh
scoop install docker

# Dev/System Wide Installs
scoop install openjdk # Latest OpenJDK
scoop install adoptopenjdk-hotspot-jre # JDK 8 & Oracle JVM
