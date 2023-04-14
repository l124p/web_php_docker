
FROM php:7.4-apache

# Копируем файлы нашего сайта в директорию /var/www/html на контейнере
COPY index.php /var/www/html/
