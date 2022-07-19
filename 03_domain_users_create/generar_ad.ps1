param( [Parameter(Mandatory=$true)] $jsonFile) #esto obliga al usuario a meterle por parametro un argumento

function CreateNewADGroup(){

}

function CreateNewADUser(){
    param( [Parameter(Mandatory=$true)] $userObject)
    
    # Parsear nombres del JSON para el AD
    $name = $userObject.name
    $password = $userObject.password

    #Generar nombres "inicial + apellido" structure
    $firstname, $lastname = $name.Split(" ")
    $userName = ($name[0] + $name.Split(" ")[1]).ToLower() #coge el nombre del json, junta la primera letra+apellido y lo pasa a miniscula
    $samAccountName = $userName
    $principalName = $userName

    #Crea un nuevo usuario (objeto) del AD
    New-ADUser -Name "$firstname $lastname" -GivenName $firstname -Surname $lastname -SamAccountName $SamAccountName -UserPrincipalName $principalname@$Global:Domain -AccountPassword (ConvertTo-SecureString $password -AsPlainText -Force) -PassThru | Enable-ADAccount

    #Add usuaruo al grupo que le pertenece
    foreach ($group in $userObject.groups){
        
        #comprobar el gropo
        try {
            Get-ADGroup -Identity “$group”
            Add-ADGroupMember -Identity $group -Members $userName
        }
        catch [Microsoft.ActiveDirectory.Management.ADIdentityNotFoundException] {
            Write-Warning “El usuario $name no se ha podido add al grupo $grupo ya que no existe en el AD”
        }
        catch {}
    }
}
$json = ( Get-Content $jsonFile | ConvertFrom-JSON) #procesa el json

$Global:Domain = $json.domain


foreach ( $group in $json.groups ){
    CreateNewADGroup $group
}

foreach ( $user in $json.users ){
    CreateNewADUser $user
}

#echo $json.users