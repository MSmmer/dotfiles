B
export CLICOLOR=1
export LSCOLORS=gxfxaxdxcxegedabagacad
#LSCOLORS是设置目录颜色的
export PATH=/usr/local/bin:$PATH
alias vi='vim'
alias ls='ls -al'
alias cl='clear'
alias hisg='history |grep'
alias ..='cd ..'
alias ...='cd ../..'
alias mountc='mount | column -t'
alias grep='grep --color=auto'
#查看你还有剩下多少内存
alias meminfo='free -m -l -t'
alias psg='ps aux| grep'
alias df='df -h'
alias du='du -h|grep G|sort -rn'

#----NetWork---
#显示出哪个应用程序连接到网络
alias listen="lsof -P -i -n"
#下载整个网站：websiteget [URL]
alias websiteget="wget --random-wait -r -p -e robots=off -U mozilla"
#显示出活动的端口
alias port='netstat -tulanp'
#获得你的公网IP地址和主机名
alias ipinfo="curl ifconfig.me && curl ifconfig.me/host"
#返回你的当前IP地址的地理位置
#getlocation() { lynx -dump http://www.ip-adress.com/ip_tracer/?QRY=$1|grep address|egrep 'city|state|country'|awk '{print $3,$4,$5,$6,$7,$8}'|sed 's\ip address flag \\'|sed 's\My\\';}
#-------------
export GREP_OPTIONS="--exclude-dir=./tag --exclude-dir=./svn" 
alias gitcl='git clone'
alias gitci='git commit'
alias gitst='git status'
alias gitco='git checkout *'
alias gitpull='git p'
#alias pptree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"
PS1='[\u@$PWD]'
if [[ ${EUID} == 0 ]] ; then
    PS1='\[\033[01;31m\]\h\[\033[01;34m\] \W \$\[\033[00m\] '
else
    PS1='\[\033[01;32m\]\u \033[01;34m\]\w \$\[\033[00m\] '
   #PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] '
fi
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.7.0_80.jdk/Contents/Home
MAVEN_HOME=/Users/MSummer/Work/BSA_JAVA/apache-maven-3.2.5
PATH=$PATH:$MAVEN_HOME/bin  
  
export MAVEN_HOME  
export PATH  

#创建一个目录并进入该目录里： mcd [目录名]
mcd() { mkdir -p "$1"; cd "$1";}
#进入一个目录并列出它的的内容：cls[目录名]
cls() { cd "$1"; ls;}
#简单的给文件创建一个备份: backup [文件] 将会在同一个目录下创建 [文件].bak
bak() { cp "$1"{,.bak};}
#解压任何的文档类型：extract: [压缩文件]
extract() { 
    if [ -f $1 ] ; then 
      case $1 in 
        *.tar.bz2)   tar xjf $1     ;; 
        *.tar.gz)    tar xzf $1     ;; 
        *.bz2)       bunzip2 $1     ;; 
        *.rar)       unrar e $1     ;; 
        *.gz)        gunzip $1      ;; 
        *.tar)       tar xf $1      ;; 
        *.tbz2)      tar xjf $1     ;; 
        *.tgz)       tar xzf $1     ;; 
        *.zip)       unzip $1       ;; 
        *.Z)         uncompress $1  ;; 
        *.7z)        7z x $1        ;; 
        *)     echo "'$1' cannot be extracted via extract()" ;; 
         esac 
     else 
         echo "'$1' is not a valid file" 
     fi 
}
































