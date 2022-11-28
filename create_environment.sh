
#!/bin/bash

pveum group delete ikasleak
pveum group add ikasleak



pveum user add julen@pam
pveum acl modify / --roles PVEAdmin --users julen@pam


pveum  user modify julen@pam --groups ikasleak

pveum acl delete /pool/Irakasle -group ikasleak -role PVEAdmin
pveum acl modify /pool/azterketa -group ikasleak -role PVEAdmin

#Delete VM from pool
pvesh set /pools/Irakasle -vms 100 -delete true
#Add VM to pool
pvesh set /pools/azterketa -vms 100
