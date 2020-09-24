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
# Topic XX: Install AWS PHP SDK
1. Download composer: https://getcomposer.org/download/
1. ```yum install -y php-simplexml```
1. https://docs.aws.amazon.com/sdk-for-php/v3/developer-guide/getting-started_installation.html

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
    'UserArn' => 'arn:aws:quicksight:us-east-1:'.$awsAccountId.':user/'.$namespace.'/' . $quickSightUserId,
    #'UserArn' => 'arn:aws:quicksight:us-east-1:956288449190:user/default/QuickSightDemoRole/yongkue+reader@amazon.com',
  ]);

  return $result['EmbedUrl'];
}
```

```html
<script src="https://unpkg.com/amazon-quicksight-embedding-sdk@1.0.3/dist/quicksight-embedding-js-sdk.min.js"></script>
Homepage: Current User: <b><?php echo $_GET['userid']?? 'FULLUSER'; ?></b> <br>
Change User (test):
<select onchange="window.location.href = '?userid='+this.value">
  <option selected value='-'> - </option>
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
