Topic 1 - Whitelist domain
1. At QuickSight console, go to **Manage QuickSight**, top right corner
1. Click **Domains and Embedding**
1. Under Domain, put in your application domain, such as "https://weisintheraisin.com". Enable **Include subdomains** if it supports subdomains.
1. *Note: Currently QuickSight supports only https*

Topic 2 - Create IAM Role to generate QuickSight roles
1. Create IAM Policy
1. Create IAM Roles
1. Edit EC2 IAM Roles / Identity to able to assume this role
```
{
    "Effect": "Allow",
    "Action": "sts:AssumeRole",
    "Resource": "arn:aws:iam::956288449190:role/QuickSightDemoRole"
}
```


1. Login to EC2 with AdminIAM Roles
```
aws sts assume-role \
     --role-arn "arn:aws:iam::956288449190:role/QuickSightDemoRole" \
     --role-session-name yongkue+reader@amazon.com
```

```
aws quicksight register-user \
  --aws-account-id 956288449190 \
  --identity-type IAM \
  --iam-arn "arn:aws:iam::956288449190:role/QuickSightDemoRole" \
  --user-role READER \
  --namespace default \
  --session-name "yongkue+reader@amazon.com" \
  --email "yongkue+reader@amazon.com" \
  --region us-east-1
```


```
aws quicksight get-dashboard-embed-url \
     --aws-account-id 956288449190 \
     --dashboard-id c91ac6a0-787e-4e1e-b90d-81dae8dea45a \
     --identity-type QUICKSIGHT \
     --region us-east-1 \
     --user-arn arn:aws:quicksight:us-east-1:956288449190:user/default/QuickSightDemoRole/yongkue+reader@amazon.com
```
