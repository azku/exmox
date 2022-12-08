
#!/bin/bash



USAGE="script usage: $(basename \$0) -u [username] -o [PasswordFile]"
OUTPUT="The script,  creates a specified user in linux and proxmox, asigns a random password and attaches de password to a given file."
while getopts ':u::o:' flag;do
    case $flag in
        u) U=$OPTARG ;;
        o) OUTPUTFILE=$OPTARG ;;
    esac
done
      if [ "$U" = "" ]; then
          echo "no user"
fi
if id -u "$U" >/dev/null 2>&1; then  # use the function, save the code
        echo "$U exists! changing password..."
        newpassword=$(openssl rand -base64 6)
        echo -e "$U\t\t$newpassword" >> "$OUTPUTFILE"
    else
        echo "$U does not exist. Creating user..." >&2  # error messages should go to stderr
        useradd $U
        echo 'User created. Addin to proxmox...'
        pveum user add $U@pam
        pveum acl modify / --roles PVEAdmin --users $U@pam
        echo 'Setting new password...'
        newpassword=$(openssl rand -base64 6)
        echo -e "$U\t\t$newpassword" >> "$OUTPUTFILE"
fi


      

# #black passwords output
# cat /dev/null > password_given.txt




# for user in `more user_list.txt`
# do
#     if id -u "$user" >/dev/null 2>&1; then  # use the function, save the code
#         echo '$user exists! changing password...'
#         newpassword=$(openssl rand -base64 6)
#         #echo $newpassword
#         #echo "$user@pam"
#         #echo "$user:$newpassword" | chpasswd
#         echo "$user\t\t$newpassword" >> password_given.txt
#     else
#         echo '$user does not exist. Creating user...' >&2  # error messages should go to stderr
#         useradd $user
#         echo 'User created. Addin to proxmox...'
#         pveum user add $user@pam
#         pveum acl modify / --roles PVEAdmin --users $user@pam
#         echo 'Setting new password...'
#         newpassword=$(openssl rand -base64 6)
#         echo "$user\t\t$newpassword" >> password_given.txt
#     fi

# done

# exit 1  # set the exit code, ultimately the same set by `id`
# # Declare an array of string with type
# #StringArray=("julen" "felipe")
# # Iterate the string array using for loop
# #for val in ${StringArray[@]}; do
# #   echo $val
# #done




#echo "$user:$newpassword" | chpasswd

