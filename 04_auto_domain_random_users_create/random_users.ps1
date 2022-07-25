param( 
    [Parameter(Mandatory=$true)] $OutputJSONFile,
    [int]$UserCount,
    [int]$GroupCount,
    [int]$LocalAdminCount
)

$groups = @()
$users = @()

$groups_names = [System.Collections.ArrayList](Get-Content "data/groups_names.txt")
$first_names= [System.Collections.ArrayList](Get-Content "data/first_names.txt")
$last_names = [System.Collections.ArrayList](Get-Content "data/last_names.txt")
$passwords = [System.Collections.ArrayList](Get-Content "data/passwords.txt")

# Default UserCount set to 5 (if not set)
if ( $UserCount -eq 0 ){
    $UserCount = 5
}

# Default GroupCount set to 5 (if not set)
if ( $GroupCount -eq 0 ){
    $GroupCount = 1
}

if ( $LocalAdminCount -ne 0){
    $local_admin_indexes = @()
    while (($local_admin_indexes | Measure-Object ).Count -lt $LocalAdminCount){
        
        $random_index = (Get-Random -InputObject (1..($UserCount)) | Where-Object { $local_admin_indexes -notcontains $_ } )
        $local_admin_indexes += @( $random_index )
        echo "adding $random_index to local_admin_indexes $local_admin_indexes"
    }
}

for ( $i = 0; $i -lt $num_groups; $i++){
    $new_group = (Get-Random -InputObject $groups_names)
    $groups += @{ "name" = "$new_group" }
    $groups_names.Remove($new_group)
}

for ( $i = 0; $i -lt $num_users; $i++){
    $first_name = (Get-Random -InputObject $first_names)
    $last_name = (Get-Random -InputObject $last_names)
    $password = (Get-Random -InputObject $passwords)
    $new_user = @{ `
        "name"="$first_name $last_name"
        "password"="$password"
        "groups"= @( (Get-Random -InputObject $groups).name ) `
    }
    $users += $new_user
    $first_names.Remove($first_name)
    $last_names.Remove($last_name)
    $passwords.Remove($password)
}

ConvertTo-Json -InputObject @{
    "domain"= "hlx.com"
    "groups"=$groups
    "users"=$users
} | Out-File $OutputJSONFile