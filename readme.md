# TRIGGER SNORT UNTUK TELEGRAM bot

## INSTALL MYSQL UDF FROM [Github](https://github.com/mysqludf/lib_mysqludf_sys)
- Clone atau download library dari [lib_mysqludf_sys](https://github.com/mysqludf/lib_mysqludf_sys.git) menggunakan perintah
```
git clone https://github.com/mysqludf/lib_mysqludf_sys
```
- Setelah berhasil, Masuk ke folder lib_mysqludf_sys dengan perintah `cd lib_mysqludf_sys`
- Lalu eksekusi perintah `./install.sh`

## MENGEDIT TRIGGER SCRIPT
- Jika sudah berhasil ubah line ke 12 dari trigger.sql dengan path anda sekarang
- Misal jika sekarang berada di path `/var/www/bot/` 
- Maka ubah `E:\xampp\htdocs\message.php` menjadi `/var/www/bot/message.php`

## MENGUBAH TELEGRAM TOKEN
- Masukan telegram token dan chat_id anda di file message.php

## IMPORT TRIGGER SQL
- Untuk mengimport bisa menggunakan fitur dari 3rdparty seperti phpmyadmin
- Atau dengan perintah 
```
mysql -u root -p snort < trigger.sql
```
- ganti `root` dan `snort` dengan username database dan nama database anda

## TEST
untuk test eksekusi perintah dibawah pada sql
```sql
INSERT INTO `acid_event` (`sid`, `cid`, `signature`, `sig_name`, `sig_class_id`, `sig_priority`, `timestamp`, `ip_src`, `ip_dst`, `ip_proto`, `layer4_sport`, `layer4_dport`) VALUES ('1', '217', '511', 'Snort Alert [1:10000001:1]', '31', '3', '2019-08-04 00:00:00', '3232239493', '3232239614', '1', NULL, NULL);
```