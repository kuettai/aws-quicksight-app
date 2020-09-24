Topic 1 - Whitelist domain
1. At QuickSight console, go to **Manage QuickSight**, top right corner
1. Click **Domains and Embedding**
1. Under Domain, put in your application domain, such as "https://weisintheraisin.com". Enable **Include subdomains** if it supports subdomains.
1. *Note: Currently QuickSight supports only https*

[Preparation of EC2]
```bash
yum update -y
systemctl start httpd && sudo systemctl enable httpd
yum install -y mod_ssl

cd /etc/pki/tls/certs
./make-dummy-cert localhost.crt

## Comment out SSLCertificateKeyFile in /etc/httpd/conf.d/ssl.conf
## After that restart Apache
systemctl restart httpd
```

[NEW SCRIPT]
```php
<?php ##Filename: qs.php
require __DIR__ . '/vendor/autoload.php';

use Aws\QuickSight\QuickSightClient;
use Aws\Exception\AwsException;

##Configuration
$awsAccountId = '956288449190';
$dashboardId = 'c91ac6a0-787e-4e1e-b90d-81dae8dea45a';
$namespace = 'default';
$defaultQuickSightId = 'cedric';
##End of Configuration

global $sdk;
$sdk = new Aws\Sdk([
  'version' => 'latest',
  'region' => 'us-east-1'
]);

function generateQuickSightUrl(){
  global $sdk;
  global $awsAccountId, $dashboardId, $namespace, $defaultQuickSightId;

  $quickSightUserId = isset($_GET['userid']) ? $_GET['userid'] : $defaultQuickSightId;
  $client = $sdk->createQuickSight();

  $result = $client->getDashboardEmbedUrl([
    'AwsAccountId' => $awsAccountId, // REQUIRED
    'DashboardId' => $dashboardId, // REQUIRED
    'IdentityType' => 'QUICKSIGHT', // REQUIRED
    'ResetDisabled' => true,
    'SessionLifetimeInMinutes' => 15,
    'UndoRedoDisabled' => true,
    'UserArn' => 'arn:aws:quicksight:us-east-1:'.$awsAccountId.':user/'.$namespace.'/' . $defaultQuickSightId,
    #'UserArn' => 'arn:aws:quicksight:us-east-1:956288449190:user/default/QuickSightDemoRole/yongkue+reader@amazon.com',
  ]);

  return $result['EmbedUrl'];
}
```

```html
<script src="https://unpkg.com/amazon-quicksight-embedding-sdk@1.0.3/dist/quicksight-embedding-js-sdk.min.js"></script>
Homepage<br>
Change User (test):
<select>
  <option value='APACUSER'>APACUSER</option>
  <option value='NONAPACUSER'>NONAPACUSER</option>
  <option value='FULLUSER'>FULLUSER</option>
</select>

    <div id="dashboardContainer"></div>
    <script>
        function onDashboardLoad(payload) {
            console.log("Do something when the dashboard is fully loaded.");
        }

        function onError(payload) {
            console.log("Do something when the dashboard fails loading");
        }

        function embedDashboard() {
            var containerDiv = document.getElementById("dashboardContainer");
            <?php
              include_once(__DIR__ . "/qs.php");
              $url = generateQuickSightUrl();
            ?>
            var options = {
                url: "<?php echo $url ?>",
                container: containerDiv,
                parameters: {
                    country: "United States"
                },
                scrolling: "no",
                height: "700px",
                width: "1000px"
            };
            dashboard = QuickSightEmbedding.embedDashboard(options);
            dashboard.on("error", onError);
            dashboard.on("load", onDashboardLoad);
        }
        embedDashboard();
    </script>
```




[OLD SCRIPT]
Topic 2 - Create IAM Role to generate QuickSight roles
1. Create IAM Policy
```
## Remember to change us-east-1 to the region of yours
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "quicksight:RegisterUser",
            "Resource": "*",
            "Effect": "Allow"
        },
        {
            "Action": "quicksight:GetDashboardEmbedUrl",
            "Resource": "arn:aws:quicksight:us-east-1:*:dashboard/*",
            "Effect": "Allow"
        }
    ]
}
```

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
