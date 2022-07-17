# 01 Install the DC

1. Usar `sconfig` para:
    - Cambiar el hostname
    - Cambiar la direccion IP a estatica
    - Cambiar el DNS server a tu direccion IP

2. Instalalar el Active Directory

```shell
Get-Windowsfeature | ? {$_.Name -LIKE “ad*”}
```
```shell
install-windowsfeature AD-Domain-Services -IncludemanagementTools
```
```shell
Get-NetIPAddress
```
```shell
Get-NetIPAddress -IPAddress <DC_IP>
```
```shell
Hay que cambiar la direccion DNS localhost a la del DC
Get-DNSClientServerAddress
```
```shell
Set-DNSClientServerAddress -InterfaceIndex <interfaz_wk> -ServerAddresses <DC_IP>
```
