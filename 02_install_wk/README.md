# 02 Install the WK

1. Pasos Previos *no necesarios*
    - Instalar chocolat
    - Instalar git
    - Intalar code (cualquier editor de texto/codigo)

2. Unir la WK al dominio
```shell
Set-DNSClientServerAddress -InterfaceIndex <interfaz_wk> -ServerAddresses <DC_IP>
```
```shell
add-computer -DomainName <dominioFDQN> -Credential <dominio>\<usuario_Admin_Del_DC> -Force -Restart
```