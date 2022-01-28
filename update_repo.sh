SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

readarray -t dirs <$SCRIPT_DIR/config

case $1 in
    "pull")
	echo "Pulling all config directories to ${SCRIPT_DIR}"
	for i in "${dirs[@]}"
	do
	    dest="${SCRIPT_DIR}/${i#*/*/*/}"
	    echo "${i} -> ${dest}"
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
	    echo "${dest} -> ${i}"
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
	    directory=${i#*/*/*/}
	    split=(${directory//// })
	    rootdir=${split[0]}
	    dest="${SCRIPT_DIR}/$rootdir"
	    if [ -d $dest ] || [ -f $dest ]
	    then
		echo ${dest}
		rm -rf $dest
	    fi
	done
	;;
    *)
	echo "Wrong arguments supplied. Needs to be either 'push' or 'pull'"
	;;
esac
