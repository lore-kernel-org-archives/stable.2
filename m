Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012064.outbound.protection.outlook.com [40.107.209.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B753A453F;
	Mon, 12 Oct 2026 13:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791813044; cv=fail; b=m8aUc/MvQs9EXe19cOiyMRYfaiXK81T7UeiAIxnIleI7aQ68vGgUTKACtefLVYi7EHwXhxwgFxq80RqsMoKh+5bgKf10NetZOM0NGfHTNRHwLD0v3jq0boMluuZmFayFVCWX3VsgD7DI1jjI3vRYP7R1+Qv+5kMm8aE8dfxf9TU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791813044; c=relaxed/simple;
	bh=pcMEy1FrmjfH3gex76VtHjL7wQDmoLCxtCWAqun6IDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mfI1oiWBlkxC6EbobzJlFSOafWTo1FMjnHxLB7Cb0Msdv5+D4Ky2rMtXmlUzRu0RnxoJAmTCA2wvfizXydV5dWqarJevYbG628+HqRZlC6evo0GTzMBPn2XumdPjY+obdeYolEL27Cyu+WKygVQBcIVOh8H7H6GCDBaqPLAfKNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aTb4Gqmz; arc=fail smtp.client-ip=40.107.209.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aTb4Gqmz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xPkDEKguiDxAiL0t2oIZQHJJp1SH4t7aEIK1bzrieiXrZ5uqqJeB0krgnWRvqnvm0lLHab0FepUXT4EsN3d9pY95VbKMbHyEi9Tt80xzCTAZUwPWVs9ctKelnokXVL5LEtQeprUJfHzALsh4ibMrdcDxg5QHpeT1rgt70UnIEUrfwMSRgriwkkrkVTtECnctHzn8P91k1uGVNQ/Xip9aJ6/iQxU/Aq8Gy1kZ632gMx7wssjYt+9lKptQDEZmXiQTBv2mQLElbScs8NaDANywdTyoQt+FZ0D/OPDoZaNoKZYDQGHOYKx/F62YMeyXZMidopkqENuLCS6RXf9ukgzQ5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E8DWcDeUqa88dZTHFbEUWsFFIXYHIWOkCpUnFBpKO7I=;
 b=sw0HdgQzPhkdlAGCEvLVBOHLKfD+/rKnp3qemVSlvj8zl2iSWi38+9pZbZTdGQvLITObo79/QVzDVBZnBDr1nUvGqjJ91GWNXma8lV7/Fg4GURJo0ocPxZH4nO5uFEiXHnPb4CIAaj4SyP0QGw9nSBo6HYOd8RJ6vHotiNIkPT/rovY0s+cuULIQ2EGcsehmfJeeWM96w0/VCCWpcBVYcvlkMIGCN8yAYOwJkE6MfofU67SsEmmsSdhST9Iw1+N7D6OcJnTVPzyjITCY2LiRNQINbHVDBk9JXELRF8XrUg2JThk02e9ebsjOEGhygRE4pG3soGjqFTIWAjCiVc9ZwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E8DWcDeUqa88dZTHFbEUWsFFIXYHIWOkCpUnFBpKO7I=;
 b=aTb4GqmzpjX5lROWizJUYSwnlh5r084lME5AcZvQ7KhfQmHersUX2xAOeXy3FixiQpTH9MpvYC9fZ1fPc0O70ftUg0KITJWFV3XHOj7fXuDwLbVXE3eInSgETiCKgeaCBBu9E43DK1GlGUKf6wGv7QaN5CFnSYfFZIchGwZ5kJAtMYrTApHEAD2paaTgA+b1Wey+uqQpBfDfbTXCN2zOZupgHlkLRk7GAoSOsoFYksTiMMaoeXL13KulNwnWvWNi/hkG43deYeJCTqu0tHK4loeTkRzmuA0DryPlFplLav03urQm+Zjga74V02DBM9BH8Ny8lwKPXaioDSrTTEPZYQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by CYXPR12MB9442.namprd12.prod.outlook.com (2603:10b6:930:e3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Mon, 12 Oct
 2026 13:50:34 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0496.010; Mon, 12 Oct 2026
 13:50:34 +0000
From: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
	Linus Walleij <linusw@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Kent Gibson <warthog618@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Jia Jia <physicalmtea@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 4/6] gpiolib: cdev: don't sleep in the SRCU read section in read()
Date: Mon, 12 Oct 2026 16:49:58 +0300
Message-ID: <20261012-gpiolib-chip-removal-v1-4-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261012-gpiolib-chip-removal-v1-0-aambrozewicz@nvidia.com>
References: <20261012-gpiolib-chip-removal-v1-0-aambrozewicz@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0030.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::17) To PH7PR12MB5974.namprd12.prod.outlook.com
 (2603:10b6:510:1d9::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5974:EE_|CYXPR12MB9442:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d75f7f9-01bf-4ed9-5648-08df2867c9c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|56012099006|5023799004|11063799006|6133799003|10067099003|22082099003|18002099003|261009223027099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	ZU8x9XAhom0cjgjb5r2PJ1Uj1i0m6vuO69dNd12ICgFTk34VgL26BALlhi6toV7wLvyCNDJERgVenjgiJjVgC3mhMYpHSpTFX5XhA2IQRQdT29fiCjIcmWT8WS28egc48xOIFnhAXC3kdvgRTpTJkLzBg69CgJ9CJcRcsOMAuUJTP4aOq7PHZBUujOlL1ZtkSKmR/QjntGa/+Kqegsf37L/Zc0s3qFrKy92r6aTqP2ZTlUJHkEWaBjjmjpYi5/IKDs+VLBI/szJE9q/6te+T7zhNZxWvwuKM9HqMk5ap8xS8b3jg1YoiTA8KCt/dwV0Duq18v6XZzv9ah4C3wLYZsNU2n5Tns4HUo0NF6WdzlBiMc2uIlTBEb5aGPaSo0Vrz8TMXrTkX8cAOtB9Wz834ukye2mIBfS0GoBGIGgK7/jizW9gFXwt17RrKjCF4MAcsMrIJ9x7joeZrD1czBt9zEonruhb2DeKUeidxmMfYLArvsdVMJ7bOQ4YbVN//Ewkzcyq2kCCDUSYCnoGcckDlTp+ft3TehVl/Qgbz6llEdlg68Y937kttg5iGRHkZyp8MVtvBgPGe7MqV8LvXXWvXYPQ2u/gq7u//ttWWQAX2AmW6IEraCrW81W0TiDqqOfKnZNiR6ONlyJ9/C4QX9svDBzB2JjwAtqaVh3miaQWOz4E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(56012099006)(5023799004)(11063799006)(6133799003)(10067099003)(22082099003)(18002099003)(261009223027099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k3dsFo98XV2qha6bRZ32L8YdgcYv0WFKl6P5NdUfedrdPgVFOMrKSOuh05et?=
 =?us-ascii?Q?jqrRqq0f5uYsUviGfPmdTWF9WW7qGakaMSsynNPQ5r9VIxLVDfy66uHdJ2YP?=
 =?us-ascii?Q?m8luJ9khZlkQWcEtwGWMu6Dtzgz1h8pS04aFKPzrBqQtKZeBgvkNmss8P0jO?=
 =?us-ascii?Q?Fgacj8PGErYyZSNtHndOOlBPy9fSxYjnYTJE2dY2AJceLJLeHXIlTlD+TC8e?=
 =?us-ascii?Q?YRz4hHgu6bO1KEggnJcQ0fd6e6IiwVsD5wou+Hz+16AF6E531vgmbvftULQR?=
 =?us-ascii?Q?l/lIjAUgVGsliPXiMFsH1JJq7EREXU9ISl+EplpaKswN1hNSv6TSGKn9YaRD?=
 =?us-ascii?Q?9lKwLcrKLbIZ3JsEKK9750d5Zclno+swC6VlsGiMLvIOEVJ+rxBxO8U49U9c?=
 =?us-ascii?Q?FbvnTILdmpuIqI3utrhXC3nzuhmqdhZ29zZ+RCYmwybnjUPt43TJOi2LV3oB?=
 =?us-ascii?Q?pfxKu6yv40ff2TNJcWMy4ND0uNdyyuvjQ9r4DzR4QUFLv8WOFQmEXhE24etE?=
 =?us-ascii?Q?A9IP24+gGHaliW9wlNLl9mCjeorRKLIZ4mBM3ilzgQRoylj8QuETm0LfjeNW?=
 =?us-ascii?Q?VeHpLCfMt42JZW7tw2EXS0o/rJjlMx6dnJj7/QDH+vaHa149XljAQMKjq7qT?=
 =?us-ascii?Q?pzu5Bf2sshm79F+2dOXc0EvzqwL7beXfI4yUdiP2aTfqQVn1hkzLamto5VDS?=
 =?us-ascii?Q?qVhSiIAxOE/y751o5Lcz0LWmG46aiYdC+SzvJ+7tOGAxDOQh2ST0GaXS5Azz?=
 =?us-ascii?Q?/D7OMN7XcFDFHoOo+XlsWqwhMcw9H7NLOJk6p2d2ZWPCiFRdkr3b3T1bVA8u?=
 =?us-ascii?Q?SN/iAT9MANJsE5H48gJRn4PLX+zm1HcmNRPAAfjJ0z1H1COmMDTUwgtc61LE?=
 =?us-ascii?Q?3BSvR6D1g/pC711QnZUcHXR9gt2oz97RyrQo8e+HcaF07qgfQ9J2HQdzM3BD?=
 =?us-ascii?Q?aat8ZxTZ99gPaALtC+0rULo2aEBGQebDN/yrcCe464FKx1ruFJGFb5HjIp07?=
 =?us-ascii?Q?S78DIkpI1rASwZWldIihUx/ls/dQevQmeMCQdW/vFJS5ciuuKJtLyHuI4vEz?=
 =?us-ascii?Q?zisSsL9Di4xIGnY0UzPpxSg4uNbGiCokXF5h81K2REl9UyqZ4VlLwY6ROmUp?=
 =?us-ascii?Q?rWZUCgA617HTmFnO3b8Fz9RW6q51qJHrIjj+o9fJpXKAcxFEjv/roBm+fQnV?=
 =?us-ascii?Q?aVEussd9GdkCaCf/xJe3okB+HfR0bTVPRSFY7GTEmegJ1XU+D6ahSnR2TYUl?=
 =?us-ascii?Q?X9FkjA+0Sn/YsbSd/MNlZ+lvNSXtsSYrQewDArTEqu8Pk6hOgsirXtL2PDaX?=
 =?us-ascii?Q?jn0GQUC6AZCF751tBTiouyM9tqBrmmZXRVvgEcxae/L8LHcC1nG7z0C4uny9?=
 =?us-ascii?Q?tJt02cyRvm+HGoJCZE/NoETRHQQNNM0MnXesistl6gto2UIWy/23F6VERuc0?=
 =?us-ascii?Q?2KUQ86410b0sdqMbUKgfpOmUAv0A6xivF97PgTkpY4geXuTWE1rYCfbinegd?=
 =?us-ascii?Q?azDFPjUp6YPhf4aQ7sOC9QFVJZ0+FcCUtTMM3RRb5eOBkh1YOIXAqfzh4FEm?=
 =?us-ascii?Q?nZQCZVCbDWMzmQZIOVoBZkB8eNbMtTmbf0Um5Xn8YgNB777h18aWgB74eRBw?=
 =?us-ascii?Q?nFsq0DjDKVVXAA/+Htc2vrdy+mOn7rPnWBVyg4BYjpSyMxCmOHPOyG79n+5h?=
 =?us-ascii?Q?2T5TFqhBU2P6mjv0JVmbHOy16QbGfaO25hfh5Jeem1fV6O0tUfNMf62LaF3S?=
 =?us-ascii?Q?3xc/vQ6xtA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d75f7f9-01bf-4ed9-5648-08df2867c9c8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 13:50:34.4792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MmJr6lR7nvxuPOlrKP55SuRNfbAinhF0hlLgfRrXEQdPNXVbhTUOhHXQuNhFDDhWGkWpNPedJzOElAT15HN1VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9442

linereq_read(), lineevent_read() and lineinfo_watch_read() enter the
gdev->srcu read section to check that the chip is still there and stay
in it while they sleep waiting for an event. gpiochip_remove() clears
the chip pointer and then calls synchronize_srcu() on gdev->srcu, which
cannot return while a reader sleeps there. The wake-up meant for that
reader is sent by the device notifier, which runs later in
gpiochip_remove() and would not end the wait anyway, as the wait
condition only looks at the event FIFO. Unless an event arrives, a
process blocked in read() on a line request, a v1 line event or a chip
file with watched lines holds up the removal of the chip until it is
signalled:

  task:init state:D stack:0 pid:1 tgid:1 ppid:0
  Call Trace:
   __synchronize_srcu
   gpiochip_remove
   release_nodes
   devres_release_all
   device_unbind_cleanup
   device_release_driver_internal
   bus_remove_device
   device_del
   platform_device_unregister
   gpio_sim_device_deactivate
   gpio_sim_device_config_live_store
   configfs_write_iter
   vfs_write

and since the device lock is held meanwhile, so does device_shutdown()
on power-off.

Check the chip pointer in a scoped SRCU section only. Nothing after the
check dereferences the chip, the request and its FIFO belong to the
file. Also end the wait once the chip is gone, which the notifiers'
wake-ups now see, and return -ENODEV if there is no event to report.

This dates back to the RW semaphore that the SRCU section replaced,
which these functions also held while sleeping and gpiochip_remove()
took for writing.

Reproduced with gpio-sim: one thread blocked in read() on a line
request while another sets the chip's configfs "live" attribute to 0.
The write does not return until the reader is killed; with this change
it returns at once and read() fails with -ENODEV.

Fixes: bdbbae241a04 ("gpiolib: protect the GPIO device against being dropped while in use by user-space")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
---
 drivers/gpio/gpiolib-cdev.c | 43 ++++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 2c9ec524d38e..11d5b112886c 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -1520,10 +1520,14 @@ static ssize_t linereq_read(struct file *file, char __user *buf,
 	ssize_t bytes_read = 0;
 	int ret;
 
-	guard(srcu)(&lr->gdev->srcu);
-
-	if (!rcu_access_pointer(lr->gdev->chip))
-		return -ENODEV;
+	/*
+	 * Don't stay in the SRCU read section while sleeping: that would stall
+	 * gpiochip_remove() until an event arrives.
+	 */
+	scoped_guard(srcu, &lr->gdev->srcu) {
+		if (!rcu_access_pointer(lr->gdev->chip))
+			return -ENODEV;
+	}
 
 	if (count < sizeof(le))
 		return -EINVAL;
@@ -1538,9 +1542,12 @@ static ssize_t linereq_read(struct file *file, char __user *buf,
 					return -EAGAIN;
 
 				ret = wait_event_interruptible_locked(lr->wait,
-						!kfifo_is_empty(&lr->events));
+						!kfifo_is_empty(&lr->events) ||
+						!rcu_access_pointer(lr->gdev->chip));
 				if (ret)
 					return ret;
+				if (kfifo_is_empty(&lr->events))
+					return -ENODEV;
 			}
 
 			if (kfifo_out(&lr->events, &le, 1) != 1) {
@@ -1837,10 +1844,10 @@ static ssize_t lineevent_read(struct file *file, char __user *buf,
 	ssize_t ge_size;
 	int ret;
 
-	guard(srcu)(&le->gdev->srcu);
-
-	if (!rcu_access_pointer(le->gdev->chip))
-		return -ENODEV;
+	scoped_guard(srcu, &le->gdev->srcu) {
+		if (!rcu_access_pointer(le->gdev->chip))
+			return -ENODEV;
+	}
 
 	/*
 	 * When compatible system call is being used the struct gpioevent_data,
@@ -1868,9 +1875,12 @@ static ssize_t lineevent_read(struct file *file, char __user *buf,
 					return -EAGAIN;
 
 				ret = wait_event_interruptible_locked(le->wait,
-						!kfifo_is_empty(&le->events));
+						!kfifo_is_empty(&le->events) ||
+						!rcu_access_pointer(le->gdev->chip));
 				if (ret)
 					return ret;
+				if (kfifo_is_empty(&le->events))
+					return -ENODEV;
 			}
 
 			if (kfifo_out(&le->events, &ge, 1) != 1) {
@@ -2615,10 +2625,10 @@ static ssize_t lineinfo_watch_read(struct file *file, char __user *buf,
 	int ret;
 	size_t event_size;
 
-	guard(srcu)(&cdev->gdev->srcu);
-
-	if (!rcu_access_pointer(cdev->gdev->chip))
-		return -ENODEV;
+	scoped_guard(srcu, &cdev->gdev->srcu) {
+		if (!rcu_access_pointer(cdev->gdev->chip))
+			return -ENODEV;
+	}
 
 #ifndef CONFIG_GPIO_CDEV_V1
 	event_size = sizeof(struct gpio_v2_line_info_changed);
@@ -2636,9 +2646,12 @@ static ssize_t lineinfo_watch_read(struct file *file, char __user *buf,
 					return -EAGAIN;
 
 				ret = wait_event_interruptible_locked(cdev->wait,
-						!kfifo_is_empty(&cdev->events));
+						!kfifo_is_empty(&cdev->events) ||
+						!rcu_access_pointer(cdev->gdev->chip));
 				if (ret)
 					return ret;
+				if (kfifo_is_empty(&cdev->events))
+					return -ENODEV;
 			}
 #ifdef CONFIG_GPIO_CDEV_V1
 			/* must be after kfifo check so watch_abi_version is set */
-- 
2.43.0

