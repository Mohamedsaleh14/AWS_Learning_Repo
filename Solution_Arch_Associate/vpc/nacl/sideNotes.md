# Side Notes with the launched EC2

By default when connecting via session manager the user is `ssm-user`
To show who is the user
```bash
whoami
```
### To change the user:
```bash
sudo su - ec2-user
```
### Download the HTML page
So html page was installed via apache configured in the `YAML` file, and to download it.
```bash
wget localhost:80
```
That means the Apache server is running
Another way
```bash
ps aux | grep apache
```
Also 
```bash
sudo systemctl status httpd
```
