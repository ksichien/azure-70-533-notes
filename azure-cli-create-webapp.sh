#!/bin/bash
azure login
azure config mode arm
azure account set <azure subscription> # optional
azure group create --name <resource group name> --location "South Central US"
azure appserviceplan create --name <app service plan name> --location "South Central US" --resource-group <resource group name> --sku S1 --instances 1
azure webapp create --name <webapp name> -resource-group <resource group name> --pln <app service plan name> --location "South Central US"
