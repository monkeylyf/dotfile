# .bashrc
# yifenliu

# gcc
#export CC=/usr/local/bin/gcc-4.2
#alias gcc='/usr/local/bin/gcc-4.2'
# shortcuts
alias line_count="find . -name '*.java' | xargs wc -l"
alias acm='cd ~/ironport/interviewjam/'
alias bastion='ssh yifenliu@ops-dev1.sco.cisco.com -o serveraliveinterval=150'
alias anna='ssh yifenliu@10.128.29.46 -o serveraliveinterval=150'
alias annar='ssh root@10.128.29.46 -o serveraliveinterval=150'
alias annah='ssh hadoop@10.128.29.46 -o serveraliveinterval=150'
alias couresa='cd ~/ironport/scala/'
alias obd='cd ~/ironport/obd/obdweb/'
alias weibo='cd ~/ironport/WeiboObservatory/weiboobservatory'
alias ec2='ssh -i ~/ironport/yifenliu-ironport.pem ubuntu@ec2-54-218-71-144.us-west-2.compute.amazonaws.com'
alias fuck='ps auxww'
alias douban='cd ~/ironport/douban_fm'
# Python
#alias python='/usr/local/bin/python2.7'
alias python26='/usr/bin/python2.6'
alias python33='/usr/local/bin/python3.3'
alias pypy='/usr/local/pypy-1.9/bin/pypy'

export PYTHONSTARTUP=~/.pythonrc
# Hadoop
export HADOOP_PREFIX='/Users/yifengliu/ironport/hadoop/hadoop-1.0.4'
export HADOOP_CONF_DIR='/Users/yifengliu/ironport/hadoop/hadoop-1.0.4/conf'
#export JAVA_HOME='/usr/libexec/java_home -v 1.6'
#export JAVA_HOME='/usr'

# Bash shell color theme
export CLICOLOR=1
export LSCOLORS=exfxcxdxCxegedabagacad

# Source global definitions
#if [ -f /etc/bashrc ]; then
#    . /etc/bashrc
#fi

# User specific aliases and functions

# Source aprc file
if [ -f ~/.aprc ]; then
    . ~/.aprc
fi

# echo wrapper
function myecho {
    echo $0 `date "+%Y-%m-%d %H:%M:%S"` "$@"
}

# Dir tree display
function tree {
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
function pyclean {
    directory=$1
    find $directory -name "*.pyc" -exec rm -f {} \;
}


# Java helper
function jrun {
    if [ "$#" == 1 ]; then
    	filename=$1
    	name=`echo ${filename} | sed 's/.\{5\}$//'`
    	myecho 'Compling '${filename}
    	javac ${filename} && java $name
    else
        echo 'This command takes one args' && return
    fi
}


function jclean {
    directory=$1
    find $directory -name "*.class" -exec rm -f {} \;
}


function unsetPaths {
   unset PRODROOT
   unset CONFROOT
   unset PYSRCROOT
   unset PYTHONPATH
}


function setPathsTo {
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


function setPaths {
    setPathsTo $DEV_ROOT/$1
}


function setPathsPkg {
    setPathsTo /usr/local/ironport/$1
}

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
