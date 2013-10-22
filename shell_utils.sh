#!/bin/bash




function error()
{
    echo "$0 $@" 1>&2;
    #exit 3;
}

##unzip diff type of files
extract () {
   if [ -f $1 ] ; then
       case $1 in
	*.tar.bz2)	tar xvjf $1 && cd $(basename "$1" .tar.bz2) ;;
	*.tar.gz)	tar xvzf $1 && cd $(basename "$1" .tar.gz) ;;
	*.tar.xz)	tar Jxvf $1 && cd $(basename "$1" .tar.xz) ;;
	*.bz2)		bunzip2 $1 && cd $(basename "$1" /bz2) ;;
	*.rar)		unrar x $1 && cd $(basename "$1" .rar) ;;
	*.gz)		gunzip $1 && cd $(basename "$1" .gz) ;;
	*.tar)		tar xvf $1 && cd $(basename "$1" .tar) ;;
	*.tbz2)		tar xvjf $1 && cd $(basename "$1" .tbz2) ;;
	*.tgz)		tar xvzf $1 && cd $(basename "$1" .tgz) ;;
	*.zip)		unzip $1 && cd $(basename "$1" .zip) ;;
	*.Z)		uncompress $1 && cd $(basename "$1" .Z) ;;
	*.7z)		7z x $1 && cd $(basename "$1" .7z) ;;
	*)		echo "don't know how to extract '$1'..." ;;
       esac
   else
       echo "'$1' is not a valid file!"
   fi
 }



function lsext()
{
    find . type f -name '*.'${1}'' -exec ls -l {} \; ;
}



function batchexec()
{
                                           #${@:2} : leaving out the first input variable which is mainly the extension of the file
    find . -type f -iname '*.'${1}'' -exec ${@:2} {} \; ;
}


function getip()
{
    /sbin/ifconfig ${1:-eth0} | awk '/inet addr/ {print $2}' | awk -F: '{print $2}'
}


function machine()
{

    echo -e "\n Machine Information:"; uname -a
    echo -e "\n Users logged on:"; w -h | wc -l
    echo -e "\n Current Date:" ; date
    echo -e "\n Machine Status:"; uptime
    echo -e "\n Memory Status:"; free
    #echo -e "\n Filesystem status:"; df -h

} 


function ll()
{
    clear;
    tput cup 0 0;
    ls --color=auto -F --color=always -1hFrt;
    tput cup 40 0;
}


function def()
{
    declare -f $1
}



function exportFun(){

    local function=${1:?Need a Function Name};
    shift
    local outfile=${2:-$HOME/dev/shell_scripts/$function.sh}
    
    local arguments='$*'

    touch $outfile
    cat > $outfile<<-EOF
#!/bin/bash
source ~apratap/dev/shell_scripts/bash_auto_called_scripts/qc_functions.sh
source ~apratap/dev/shell_scripts/bash_auto_called_scripts/run_softwares.sh
source ~apratap/dev/shell_scripts/bash_auto_called_scripts/bam_utils.sh
source ~apratap/dev/shell_scripts/bash_auto_called_scripts/uge_functions.sh
source ~apratap/dev/shell_scripts/bash_auto_called_scripts/shell_utils.sh

printf "Running $function with arguments $arguments"
printf "\n\n"

$function  $arguments;
EOF

    chmod +x $outfile || { echo "Something went wrong ..$outfile doesn't exists"; kill -n 2 $$;};
}