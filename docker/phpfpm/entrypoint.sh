#!/bin/sh
echo "Initializing setup..."

cd /var/www/magento2

if [ -f ./app/etc/config.php ] || [ -f ./app/etc/env.php ]; then
  php bin/magento setup:store-config:set --base-url=${MAGENTO_BASE_URL}
  echo "Magento2 is already installed!"
else

  count="$( find . -mindepth 1 -maxdepth 1 | wc -l )"

  if [ $count -ne 0 ] ; then
    yes | rm -rf ./*
    find . -maxdepth 1 -name \* -type f -delete
  fi

  composer create-project --repository-url=https://repo.magento.com/ magento/project-community-edition .

  find . -type f -exec chmod 644 {} \;
  find . -type d -exec chmod 755 {} \;
  find ./var -type d -exec chmod 777 {} \;
  find ./pub/media -type d -exec chmod 777 {} \;
  find ./pub/static -type d -exec chmod 777 {} \;

  php bin/magento setup:install \
  --base-url=${MAGENTO_BASE_URL} \
  --db-host="mysql" \
  --db-name="magento" \
  --db-user="root" \
  --db-password="root" \
  --admin-firstname="admin" \
  --admin-lastname="admin" \
  --admin-email="admin@example.com" \
  --admin-user="admin" \
  --admin-password="magento12" \
  --language="en_US" \
  --currency="USD" \
  --timezone="America/Chicago" \
  --use-rewrites="1" \
  --backend-frontname="admin"

  chown -R www-data:www-data .
  echo "Magento install process done !"
fi

pkill php-fpm
php-fpm
