echo "$1"


if [[ $1 == '' ]]; then
echo "wrong command or invalid parameter"
elif [[ $1 == 'svn' ]]; then
svn > /dev/null && svn log --diff -r $1 > diff_$1
elif [[ $1 == 'git' ]]; then
git > /dev/null && git diff > diff_$1
elif [[ $1 == 'clean' ]]; then
rm -rf diff_*
else
echo "$1 is not supported or is wrong command."
fi
