# oauthed_ingress

Essentially just following the documentation here:

> https://github.com/kubernetes/ingress-nginx/tree/master/docs/examples/auth/oauth-external-auth

though not with a dashboard and instead of a normal nginx image. Due to my dashboard requiring TLS which ingress-nginx doesn't appears to currently like for a backend.

**Note:** Please read the manifests as they will require some alterations for personal data to get working.
