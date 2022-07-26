# 03 Create User of the Domain

1. Crear json con la estructura del proporcionado en el repo ( o copiarlo directamente jeje)
```shell
Start-Service WinRM
```
```shell
Set-Item WSMan:\localhost\Client\TrustedHosts -value 192.168.153.130
```
2. Nos conectamos al dc desde la wk mediante la powershell
```shell
$dc = New-PSSession <IP-DC> -Credential (Get-Credential)
```
3. Podemos comprobar si se ha creado la sesion con este comando:
```shell
echo $dc
```
4. Probamos a copiar un archivo:
```shell
Copy-Item .\ad_schema.json -ToSession $dc C:\Windows\Tasks
```
5. Copiar Script del repo 
6. Bypassear el 'execution policy' de windows
    - Dos formas:
        - *Set-ExecutionPolicy RemoteSigned*
        - *powershell -exec bypass*
7. Copiamos los dos archivos de esta carpeta al DC:
```shell
Copy-Item <ARCHIVO> -ToSession $dc C:\Windows\Tasks
```
8. Si salta un error cuando querais logearos como otro usuario en la wk teneis que:
    - Presionar tecla *windows*
        - Acces work or school
        - Y por ultimo desconectaros del dominio
        - Resetear la maquina
        - Abrir powershell con privilegios de Administrador
            - Add-Computer
            - Os pedira que metais las claves del DC
                - hlx/Administrator:P@ssw0rd123!
                - Teclais el dominio que os quereis unir
                    - hlx.com
        - Reseteais la maquina
