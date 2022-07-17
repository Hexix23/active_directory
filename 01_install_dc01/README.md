# 01 Install the DC

1. Usar `sconfig` para:
    - Cambiar el hostname
    - Cambiar la direccion IP a estatica
    - Cambiar el DNS server a tu direccion IP

2. Install el Active Directory

```shell
Get-Windowsfeature | ? {$_.Name -LIKE “ad*”}
```
```shell
install-windowsfeature AD-Domain-Services -IncludemanagementTools
```