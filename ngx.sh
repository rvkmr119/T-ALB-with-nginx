#!/bin/bash
sudo yum update -y
sudo yum install nginx -y
sed -i "85iline <img src="https://www.pixelstalk.net/wp-content/uploads/images1/Game-Of-Thrones-Season-7-Poster-1.jpg">"  /usr/share/nginx/html/index.html
service nginx start
