wget https://pecl.php.net/get/memcached-2.2.0.tgz -O - | tar xzvf -
cd memcached*;
phpize
./configure && make && sudo make install

cat <<-MM | sudo tee -a $phpini

    [memcached]
    extension=memcached.so
MM
