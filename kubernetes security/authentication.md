Configuring Authentication
1.2.1 Configuring Certificates

Generate and distribute certificates and keys using tools like openssl or Kubernetes API server flags:

sh
Copy code
kubectl config set-credentials <user> --client-certificate=<cert-file> --client-key=<key-file>
1.2.2 Configuring Bearer Tokens

For service accounts:

sh
Copy code
kubectl create serviceaccount <name>
kubectl describe serviceaccount <name>
1.2.3 Configuring OIDC

Set up OIDC in the Kubernetes API server with flags:

sh
Copy code
--oidc-issuer-url=https://accounts.google.com
--oidc-client-id=<client-id>
--oidc-username-claim=email