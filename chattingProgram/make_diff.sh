echo "$1"
svn log --diff -r $1 > diff_$1
