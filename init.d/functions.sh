
getfile() {
    etcdctl get $prefix/$1 > $2 2>/dev/null
    return $?
}
