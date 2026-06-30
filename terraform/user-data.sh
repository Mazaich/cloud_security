#!/bin/bash
cd /var/www/html
echo '<html><head><title>Picture</title></head><body><h1>Look</h1><img src="${image_url}"/></body></html>' > index.html
