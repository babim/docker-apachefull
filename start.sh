#!/bin/sh
export TERM=xterm

# Prepare
if [ -z "`ls /etc/apache2`" ]; then cp -R /etc-start/apache2/* /etc/apache2; fi
if [ -z "`ls /etc/php7`" ]; then cp -R /etc-start/php7/* /etc/php7; fi
if [ -z "`ls /var/www`" ]; then cp -R /etc-start/www/* /var/www; fi

   # Set environments
    TIMEZONE1=${TIMEZONE:-Asia/Ho_Chi_Minh}
    PHP_MEMORY_LIMIT1=${PHP_MEMORY_LIMIT:-512M}
    MAX_UPLOAD1=${MAX_UPLOAD:-520M}
    PHP_MAX_FILE_UPLOAD1=${PHP_MAX_FILE_UPLOAD:-200}
    PHP_MAX_POST1=${PHP_MAX_POST:-520M}
    MAX_INPUT_TIME1=${MAX_INPUT_TIME:-3600}
    MAX_EXECUTION_TIME1=${MAX_EXECUTION_TIME:-3600}
	
	sed -i "s|;*date.timezone =.*|date.timezone = ${TIMEZONE}|i" /etc/php7/php.ini && \
	sed -i "s|;*memory_limit =.*|memory_limit = ${PHP_MEMORY_LIMIT}|i" /etc/php7/php.ini && \
 	sed -i "s|;*upload_max_filesize =.*|upload_max_filesize = ${MAX_UPLOAD}|i" /etc/php7/php.ini && \
    	sed -i "s|;*max_file_uploads =.*|max_file_uploads = ${PHP_MAX_FILE_UPLOAD}|i" /etc/php7/php.ini && \
    	sed -i "s|;*post_max_size =.*|post_max_size = ${PHP_MAX_POST}|i" /etc/php7/php.ini && \
    	sed -i "s/max_input_time = 60/max_input_time = 3600/" /etc/php7/php.ini && \
	sed -i "s/max_execution_time = 30/max_execution_time = 3600/" /etc/php7/php.ini

# Start apache
exec httpd -D FOREGROUND
