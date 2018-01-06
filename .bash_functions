# create new directory with name passed as argument, and then cd into it
function mkcd {
  mkdir -p $1 && cd $1
}
