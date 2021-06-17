wget https://www.sqlite.org/2021/sqlite-autoconf-3350500.tar.gz
tar -zxvf sqlite-autoconf-3350500.tar.gz

#compile install sqlite3.35
./configure --prefix=/usr/local/sqlite3.35
make -j 2
make install

mv /usr/bin/sqlite3 /usr/bin/sqlite3_old
ln -s /usr/local/sqlite3.35/bin/sqlite3 /usr/bin/sqlite3

#again compile python3
cd /usr/local/python3
./configure --prefix=/opt/local/python3 && make -j 2 && make install
