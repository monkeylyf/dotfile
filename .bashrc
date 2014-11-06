
# .bashrc
# yifenliu

# Install homebrew if not

if test ! $(which brew); then
    echo "Installing homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew update
fi


## Source global definitions
#if [ -f /etc/bashrc ]; then
#    . /etc/bashrc
#fi


#
# Alias
#

# echo wrapper
myecho () {
    echo $0 `date "+%Y-%m-%d %H:%M:%S"` "$@"
}

# Dir tree display
tree () {
    if [ $# -eq 0 ]; then
    	curDir=`pwd`
    else
    	curDir=$1
    fi
    # ls -R | grep ":$" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/   /' -e 's/-/|/'
    echo $curDir
    ls -R $curDir | grep ':$' | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/   /' -e 's/-/|/'
}

# Python helper
pyclean () {
    directory=$1
    find $directory -name "*.pyc" -exec rm -f {} \;
}

# Java helper
jrun () {
    if [ "$#" == 1 ]; then
    	filename=$1
    	name=`echo ${filename} | sed 's/.\{5\}$//'`
    	myecho 'Compling '${filename}
    	javac ${filename} && java $name
    else
        echo 'This command takes one args' && return
    fi
}

jclean () {
    directory=$1
    find $directory -name "*.class" -exec rm -f {} \;
}

unsetPaths () {
   unset PRODROOT
   unset CONFROOT
   unset PYSRCROOT
   unset PYTHONPATH
}

setPathsTo () {
    unsetPaths
    PRODROOT=$1
    CONFROOT=${PRODROOT}/etc
    PYSRCROOT=${PRODROOT}/src/python
    PYTHONPATH=${PYTHONPATH}:${PYSRCROOT}
    echo PRODROOT=${PRODROOT}
    echo CONFROOT=${CONFROOT}
    echo PYSRCROOT=${PYSRCROOT}
    echo PYTHONPATH=${PYTHONPATH}
    export PRODROOT PYSRCROOT CONFROOT PYTHONPATH
}

setPaths () {
    if test ! $DEV_ROOT; then
        echo "Please set up DEV_ROOT env variable first."
        return 1
    fi

    setPathsTo $DEV_ROOT/$1
}

setPathsPkg () {
    setPathsTo /usr/local/ironport/$1
}

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
