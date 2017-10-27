cd C:\Program Files (x86)\Microsoft SQL Server\140\DAC\bin
sqlpackage.exe /Action:Import /tsn:tcp:lasqldemo.database.windows.net,1433 /tdn:packageimport /tu:pinehead /tp:LinuxAcademy1 /sf:C:\Users\DougV\Downloads\sqlexport.bacpac /p:DatabaseEdition=Premium /p:DatabaseServiceObjective=P1 /p:Storage=File
