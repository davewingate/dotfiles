Blue='\033[0;34m'
Purple='\033[0;35m'
Red='\033[0;31m'
Gray='\033[0;37m'
Reset='\033[00m'

_info () {
	echo -e "$Gray$1$Reset"	
} 

_error () {
	echo -e "$Red$1$Reset"	
} 