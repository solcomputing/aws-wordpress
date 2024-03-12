#README

INSTALLATION STEPS

Set up MySQL secret. Create a new file called password.txt and add your desired MySQL password in this file. Make sure that there is no newline (\n) at the end of the password. Use kubectl command to generate the MySQL secret.
Deploy MySQL and WordPress containers using the YAML files from the previous section.

kubectl create secret generic mysql-pass --from-file=password.txt
kubectl create -f mysql-deployment.yaml
kubectl create -f wordpress-deployment.yaml
