SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

readarray -t dirs <$SCRIPT_DIR/config

case $1 in
    "pull")
	echo "Pulling all config directories to ${SCRIPT_DIR}"
	for i in "${dirs[@]}"
	do
	    dest="${SCRIPT_DIR}/${i#*/*/*/}"
	    echo ${i}
	    if [ -d $i ] || [ -f $i ]
	    then
		mkdir -p $(dirname "$dest")
		rsync -ar ${i} ${dest}
	    fi
	done
	;;
    "push")
	echo "Pushing from ${SCRIPT_DIR} to system configs"
	for i in "${dirs[@]}"
	do
	    dest="${SCRIPT_DIR}/${i#*/*/*/}"
	    echo ${i}
	    if [ -d $dest ] || [ -f $dest ]
	    then
		mkdir -p $(dirname "$i")
		rsync -ar ${dest} ${i}
	    fi
	done
	;;
    "clear")
	echo "Clearing files from ${SCRIPT_DIR}"
	for i in "${dirs[@]}"
	do
	    dest="${SCRIPT_DIR}/${i#*/*/*/}"
	    echo ${i}
	    if [ -d $dest ] || [ -f $dest ]
	    then
		rm -rf $dest
	    fi
	done
	;;
    *)
	echo "Wrong arguments supplied. Needs to be either 'push' or 'pull'"
	;;
esac
