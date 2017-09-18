# /home/site/deployments/tools/PostDeploymentActions/post-deployment-actions.ps1 in kudu's debug console 
# all scripts inside must have exit code 0 after execution
# kudu > tools > diagnostic dump can show the script was executed post deployment
Unpublish-AzureRmCdnEndpointContent -ProfileName la53cdn -ResourceGroupName la533scripts -EndpointName la533cdn -PurgeContent "/*"