## Note 

Vault doens't show the token policies directly inside the setting in the UI . 
Instaed you assign the policies using the CLI or API 
* secret/config/*
```bash 
vault login # token ( root token ) 5 keys ( 3 keys -> login root )
vault read auth/approle/role/config-server-role
vault write auth/approle/role/config-server-role policies="config-server-policy"
vault auth list 
vault auth enable approle

vault list auth/approle/role  # If this doens't show it means that it didn't get created correctly. 

# create this by using this commmand ( worked)
vault write auth/approle/role/config-server-role \
    token_policies="config-server-policy" \
    token_ttl=1h \
    token_max_ttl=4h

# this is to verify that you have already created it or not 
vault read auth/approle/role/config-server-role
vault policy list 
vault list auth/   # this is used in order to check if it's in the different  path then the current one. 


# in order to get the role id and the secret 
vault read auth/approle/role/config-server-role/role-id
# this is used in order to generate the secret id 
vault write -f auth/approle/role/config-server-role/secret-id

```

### APP Roles  values 
```bash
id=70492586-ea4c-8383-0c14-43d93f77d73c
secret_id=2dad0ab4-e4ce-9ff7-3444-d7fe0363d5f6
```