# MetaMoodSln

In order to get this web application up and running, an NGINX web server is first needed.

First, do sudo vi /etc/nginx/sites-available/default after downloading NGINX and setting it up.

In this file, copy paste the following code:

server {

        # SSL configuration
        listen 443 ssl http2 default_server;
        listen [::]:443 ssl http2 default_server;
        include snippets/self-signed.conf;
        include snippets/ssl-params.conf;

        root /var/www/webapp/wwwroot;
        try_files $uri $uri/ /index.html =404;
        index index.html;

        server_name <INSERT FQDN HERE>;

}

<code>
server {
        listen 80 default_server;
        listen [::]:80 default_server;
        server_name <INSERT FQDN HERE>;
        return 302 https://$server_name$request_uri;
}
</code>
  
Also, type sudo mkdir /var/www/html/webapp. This is where the static files will be stored that will be served to the client.
  
Make sure to restart the nginx service with sudo service nginx reload. 
  
From there, create another folder at /var/www/html/MetaMood. Pull this git repo into that folder. Type dotnet publish -c Release -o /var/www/webapp to publish the files into the proper folder.

Now, the static files should be served correctly and the web application should be functioning. However, this application depends on both an API and a MySQL database, so those also have to be set up for the application to function. 
  
# MetaMoodAWSAPI
This is a Web API that retrieves both raw data and the results of sentiment analysis from a MySQL DB and sends it to a Blazor WASM instance hosted on an 
EC2 instance with NGINX. This API uses AWS API Gateway and AWS Lambda.

This project was done in Visual Studio with AWS Toolkit and AWS credentials set up, so all of that is necessary before making this API work.

From there, download this GitHub repository. To make any changes to the function, change the code then republish to AWS using the proper credentials, permissions, etc. 

To integrate a function into AWS API Gateway, create a route with the appropriate HTTP verb (GET, PUT, POST, DELETE, etc.) and attach an AWS Lambda function integration.
Whenever the appropriate HTTP verb is sent to that route, it will trigger the lambda function and return the results. 

# AWS Lambda Analysis

There are also AWS Lambda functions that need to be created. Dependencies can be added with AWS Lambda Support Layers, but the modules need to be in the path: python/lib/python3.8/site-packages/. 

# Data Collection

By Jiaxing Li

This repo contains code for collecting data from the web, as well as downloaded data.

There are 3 platform that we are collecting data from:

1. Twitter
2. Reddit
3. Spotify

All implementations are in Python.

# Large Scale Database Management Data Analytics

This repo has scripts which can be used for conducting analysis on data that would be found from text and from Spotify track information.

The scripts have code which can be used for connecting to a database.

## Authors
Bryce Hinkley
- [@Ouroborosrex](https://www.github.com/Ouroborosrex)


## Installation

The file provided is a Jupyter file that can be ran in Google Colab or any other software that will accept Jupyter files.

Both files have varying dependencies and will not require too much modification beyond changing the database connection information in order to connect to your database.
    
