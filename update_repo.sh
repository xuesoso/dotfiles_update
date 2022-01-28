SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

readarray -t dirs <$SCRIPT_DIR/config

case $1 in
    "pull")
        cd $HOME
        echo "Pulling all config directories to ${SCRIPT_DIR}"
        for i in "${dirs[@]}"
        do
            dest="${SCRIPT_DIR}"
            src="${i#*/*/*/}"
            echo "${i} -> ${dest}/${i#*/*/*/}"
            if [ -d $i ] || [ -f $i ]
            then
                rsync -aR $src "${dest}/"
            fi
        done
        ;;
    "push")
        cd $SCRIPT_DIR
        echo "Pushing from ${SCRIPT_DIR} to system configs"
        for i in "${dirs[@]}"
        do
            dest="${i#*/*/*/}"
            echo "${dest} -> ${i}"
            if [ -d "${SCRIPT_DIR}/${dest}" ] || [ -f "${SCRIPT_DIR}/${dest}" ]
            then
                rsync -aR ${dest} ${HOME}
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
