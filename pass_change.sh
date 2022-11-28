
#!/bin/bash

#black passwords output
cat /dev/null > password_given.txt




for user in `more user_list.txt`
do
    if id -u "$user" >/dev/null 2>&1; then  # use the function, save the code
        echo '$user exists! changing password...'
        newpassword=$(openssl rand -base64 6)
        #echo $newpassword
        #echo "$user@pam"
        #echo "$user:$newpassword" | chpasswd
        echo "$user\t\t$newpassword" >> password_given.txt
    else
        echo '$user does not exist. Creating user...' >&2  # error messages should go to stderr
        useradd $user
        echo 'User created. Addin to proxmox...'
        pveum user add $user@pam
        pveum acl modify / --roles PVEAdmin --users $user@pam
        echo 'Setting new password...'
        newpassword=$(openssl rand -base64 6)
        echo "$user\t\t$newpassword" >> password_given.txt
    fi

done

exit 1  # set the exit code, ultimately the same set by `id`
# Declare an array of string with type
#StringArray=("julen" "felipe")
# Iterate the string array using for loop
#for val in ${StringArray[@]}; do
#   echo $val
#done




#echo "$user:$newpassword" | chpasswd

