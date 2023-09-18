# Configure `letsencrypt` with jenkins

SSL certificates allow a website to run on HTTPS protocol which makes sure that data transfer between user and server cannot be intercepted between them. When using HTTPS protocol the data transfer is encrypted between user and server being used.  

_**NOTE:** Keep the fact in mind that letsencrypt does not generate certificates for bare IP. It needs a domain name._

## Installing SSL certificates with `letsencrypt`

In unix, letsencrypt package is called `certbot`. This can be installed using following command:  

```shell
sudo apt install certbot
```

Here standalone mode will be used for generating certificates which authenticates the machine's ownership by hosting a temporary server on port 80. This is because ports less than 1024 are privileged and require root/sudo access. So make sure that port 80 is open in firewall and there is no application already running on it. Also if this process is being done on container, make sure port 80 is forwarded properly. One can also use webroot mode to generate certificates. See this [link](https://eff-certbot.readthedocs.io/en/stable/using.html) for more information.

Use following command to generate certificate files and keys in `/etc/letsencrypt/live/your.domain.name/`  

```shell
certbot certonly --standalone -d your.domain.name
```

This will produce `cert.pem`, `fullchain.pem` and `privkey.pem`.  

Copy these files to location where `.war` of jenkins is located. Make sure to change the permission from root to jenkins' user. After that, use following command to convert certificate files to `pkcs12` format.  

```shell
openssl pkcs12 -inkey privkey.pem -in fullchain.pem -export -out keys.pkcs12
keytool -importkeystore -srckeystore keys.pkcs12 -srcstoretype pkcs12 -destkeystore keystore

```  

This will ask for a password. Here it will be denoted as `<password>`.  
Use following command to start jenkins server with generated SSL certificates.  

```shell
java -jar jenkins.war --httpPort=-1 --httpsPort=<your_port> --httpsKeyStore=keystore --httpsKeyStorePassword=<password>
```  

After this, go to browser and type `your.domain.name:<your_port>` to start jenkins with https protocol.
