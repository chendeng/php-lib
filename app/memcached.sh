cd ~
set -o errexit;
args=("$@");
while test $# -gt 0; do
        case "$1" in
                -no-check) nohttps="--no-check-certificate";;
                *) ext="$1";
        esac;
        shift
done

wget $nohttps https://pecl.php.net/get/memcached-2.2.0.tgz -O - | tar xzvf -
cd memcached*;
phpize
./configure && make && sudo make install

cat <<-'MM' | sudo tee -a $phpini

[memcached]
extension=memcached.so
MM
