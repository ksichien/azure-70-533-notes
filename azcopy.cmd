:: upload file from desktop:
azcopy /Source:C:\Users\DougV\Downloads /Dest:https://lastoragedemo.blob.core.windows.net/photos /Destkey:<storage account key> /Pattern:"picture1.jpg"

:: azcopy does not infer correct content type, there is a command line option for it:
azcopy /Source:C:\Users\DougV\Downloads /Dest:https://lastoragedemo.blob.core.windows.net/photos /Destkey:<storage account key> /Pattern:"picture.2jpg" /SetContentType:image/jpeg

:: download file to desktop:
azcopy /Source:https://lastoragedemo.blob.core.windows.net/photos /Dest:C:\Users\DougV\Downloads /Destkey:<storage account key> /Pattern:"picture1.jpg"

:: upload multiple files from desktop:
azcopy /Source:C:\Users\DougV\Downloads /Dest:https://lastoragedemo.blob.core.windows.net/photos /Destkey:<storage account key> /S

:: asynchronous copy from one storage container to another (can also be across different storage accounts):
azcopy /Dest:https://lastoragedemo.blob.core.windows.net/photos /Dest:https://lastoragedemo.blob.core.windows.net/photos/copy /Destkey:<storage account key> /S
