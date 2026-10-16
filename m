Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011055.outbound.protection.outlook.com [52.101.52.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178063BC69E;
	Fri, 16 Oct 2026 09:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792142639; cv=fail; b=kixv7WPS1YivkoNdXed4HGen0CHWq3MqtagQXoRE4cGLkaDfDBCNWyHIWD91Qx8JHjUa6lKu82sEUBRV6EH/PCm2H5+YPy1wYzqFG6HR4UDaqQJgRdpAiqgItwlxq6/slm7HdUPSodwwkHBsQCUelNzS8srFZzE6zfDW2KvjdTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792142639; c=relaxed/simple;
	bh=4ILiUXHz0Clg53XiLfMArGkP0pPdYPnPDYSC2WDq69Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MX7TPcUcrKVQIA2dxZiw4tfUVZNBJUk0IP1nZrtdrT3zLh2AburUHpVk6F0y301D1zA+HfiHts89gREhIxVoY9qeW/fktJIE7Qpr/pgBFZnc6sYMvqBeWvBMsrtV5iF8yV0m9f1WK5gqEbjbkvQZIlesq3BWf8buoqEjewjJSJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qeQYFN5v; arc=fail smtp.client-ip=52.101.52.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qeQYFN5v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w0vZi1PPsKMTwJgkZyGhCxH0JAUDkpbraSl4Acho6mPYRVXXwNP9xqXo/6vfm+VpzSDnDbWgOG3U0U0lZ8rsyp8mIx5GRTZ0X8Sbv16OH4fSqbVfIy12HYo0uNzmGgzBhg0Sh0ZlZp7fAPJzZujXMPwf1jpOoUDbolnP8B+eVZELM7m9EnMTuRyt4/MWXEYJO0jdTLCquFX6eEDXdS1Sk1lxQwmIAVF1V+in34H5VP/flIjm2hPE2jUfavkMYvwLtSiCKBPV6UP9zb5KRS2pYxwMe55a0/5nVsSReLT+QvutNEBekd7F9vKFd6Y8GZ1MD/nsZpQSqf1BseZriWHIUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bsmKAXKN9IjdgaxbpB9FZimlMoN10BoeToy3xHVmeo0=;
 b=w2B7MQBSTWNkOcYRvP1RP26V7/3QmVLuxhWqYiPoBAN9quSMsszwsr8LbBYUZF8xH/SSWPJa9zX8pnsfcly+ssrYtltJjODCSS6Inb3A5YCbkDToTh2SXrhdih1nJp3MgM7mKI20rVLabF0l+z/4sFI8XK4KJstFBTdBs6ta1zk31hf6Abkf9ckpd0qiLAMF7PCAdoaRoeczesFtKAfr7uGEWKDMBfw3hzZKW6gQirG919ZQpQ2Vy0/JV1+8IOyeQBgzsLcGZYkr8gBimDu2bZQxa8v/3H+P6TSJSbOvhUyC1TJ5Vc2aehTbCjkWHLAUVLcQh8AkY6pKPkb993dDFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bsmKAXKN9IjdgaxbpB9FZimlMoN10BoeToy3xHVmeo0=;
 b=qeQYFN5vE+DeECkpjE81qj/V3+iK/D3KGzKr5gI0FLJAXEjV4iRC7R6FtBIoqvU5TdsiY64hePDsWDDbFjqKt4tlb6jBoxaARf3Xx5dmIAbXtnXJppkUttcAqVsNKgRWyByBLFV9sjIiUzCzsG9CmVXYIIOr+Qa36WicX1afnSRIYyPZrah/NhRT5OFxrEfJVNb9wzccEIXE9Raqg0K7aiwc+qat+8mI/MVzfDlbsjutpFZP8ro/kYhRQ6PV8jEUFZvPeK4Z1hzDjnHWRRHYsRrbUM2Y6DgdkVX6f2nOeTSRcYI1LzA7KWgX6mhSigYNakVUOW1YGAdJPgttAqGLyw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by BN5PR12MB9539.namprd12.prod.outlook.com (2603:10b6:408:2aa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 09:23:54 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0522.012; Fri, 16 Oct 2026
 09:23:54 +0000
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
Subject: [PATCH v2 4/6] gpiolib: cdev: don't sleep in the SRCU read section in read()
Date: Fri, 16 Oct 2026 12:23:36 +0300
Message-ID: <20261016-gpiolib-chip-removal-v2-4-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016-gpiolib-chip-removal-v2-0-aambrozewicz@nvidia.com>
References: <20261016-gpiolib-chip-removal-v2-0-aambrozewicz@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MR1P264CA0129.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:51::17) To PH7PR12MB5974.namprd12.prod.outlook.com
 (2603:10b6:510:1d9::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5974:EE_|BN5PR12MB9539:EE_
X-MS-Office365-Filtering-Correlation-Id: 638e1a83-5285-4e57-e1a6-08df2b6732de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|23010399003|1800799024|6133799003|18002099003|22082099003|10067099003|3023799007|56012099006|261009223027099003|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	WlFJQNQd0kghubOs5AKkh5dgB1hvkJTh+wnizfIHBq1OH38jZnDsE11Bg2GB7fRXreJj4ZsFE2iBrBVB9sIKxHp0WreUB9E78FPQYpmvQ3oQIFf3gw34YHjJaaSTbuI+bL4hC3Itw8bbkUBrsEHelSIn6KxRx7lWDXellXto8gzGJmlaZLRa/j/p6JPY00zwydC2H9/y3TAn2SIWI355dyBQLScnYqDtyvDfOMYw3LxTxG9VKlWPGYk3JxqYYwkpWbByoJv3NAQRCEtIADXEtnuFnQkJ1TEPR7MpBpDHnzk7LaGvtLygczm93VZgqgI5XEyUhvK/j2V+junjp/N7YgiwL1d03VZ4v4JYgub84wkRKxVHDU+r90coZHmXA/n6bOqoS4p+pOgTdxfKU5NZpRotdOltgn4cGPG507CYKUSUsT2vCAI8iGi4KV6dligKpmb28xWYFgH3cIAd9npUAsq6x071FaUQAINJ50hT70FFfndidwTEEM600tBkqk2Qo9tXODJ/T89W4feS8M7tGesGf0vgU3e6EcbRG19up5VcoqzKVlBECkuSadl2+TVzP8JFKR2Q6xNjNdvePtVM3/bmclVeDS9RiBirL4i9UaMvte+WgfUJKgCb6qBIz/90ZixYgP+UzK4zU3ma7oLFLd7jo6zjs+azPOApO8VTNM8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(6133799003)(18002099003)(22082099003)(10067099003)(3023799007)(56012099006)(261009223027099003)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WsmMQHpS/USDXzUUYzaQ2J+lfa1paJao5XqJY+tanwWRej25ObYxffvPcMy+?=
 =?us-ascii?Q?fZIVQJ25wi3KNDCH5wAF9YdgNVc6GNnvR90lpA8XrzFUmELRezAq6EkigsUJ?=
 =?us-ascii?Q?f2dxTXVox5m7EXHc2GplJy1paBBDkZN1ZpEKlG45RKghQYlGBCLT5EadS4tt?=
 =?us-ascii?Q?7BSWbLb667qMj9tYuNHJ2TY/Y0qrgpyTC0llCfbeM0JvTjzQQdSiQwtfqvtx?=
 =?us-ascii?Q?SM41UGhcOQ16u9y7jh6ZTbAHO2aI3MrYMVGDJJTJEIzkjmUbDfCbZliG370g?=
 =?us-ascii?Q?CuaJ8Yzs48Ivv7ypHK2XRZfRPy2gx8ItALdV09aJL6XCOXGKC15JZ7DBc/Qr?=
 =?us-ascii?Q?ZpmviDXBpdkgYT5RFNbFsbxJghdHZYADQLOWG96TYEBcB5d4TE9Zl8pY0NiL?=
 =?us-ascii?Q?qEhfTbywYbDo7fQs31N368LL777HAgpuv9ndjS6LFvTXNJpWSh70L+WOB7WA?=
 =?us-ascii?Q?E+/yc/M1gumGVceVCGOiRfVxJfpYDxsOsQkjrAHrzrctdZ/jF3WXNepbrQQq?=
 =?us-ascii?Q?dqOeIqAR7WHqKou2DALlv0LtUYaiQ/uoCUPHGoYC9pZSLFIo94dJetIXJ76i?=
 =?us-ascii?Q?kCWCW0e0UwYjvln3uV/SRdP3VnyOYRRDI5h2B8bxfs/ZQnUjrVh6dWNH6EHg?=
 =?us-ascii?Q?DRqGbndCRFU4tem6slomNtZOli8U6Tr8JlaoMdVR49hQa36Ntz8yVDEKwbSY?=
 =?us-ascii?Q?83ZlqInhqghgvxy+NKRuIK03IgaB/sDE/DdMZ2rt9KCgJmfrvWl5ygziwM6w?=
 =?us-ascii?Q?3CEQMxWFU0QizwLPYpBgVWQTu2K+whfazYiqz8aixXLB2JNlwo2J6FTcNzuL?=
 =?us-ascii?Q?33w9V7zZSbdNmLZPM+JScpDtKny43Ymo0QCFFii5NfO3eN+zio/NKGC9mYIS?=
 =?us-ascii?Q?VgvlOqKnRMID2iGq2J+LzFv1+XrJhQrBWk6sxPjKBHAlRIMwrej/6nP4aUmi?=
 =?us-ascii?Q?aQ/lAIiuiP/VRTzyUZrFUThYYvnOE6d0+rknSTMn/2D1aiI2i+AHHRM/tVa+?=
 =?us-ascii?Q?C8sLk7vr6V21j5rvtcWePQ346BlmqlYtDWlgxsauRLmWtWqvFDfw8BrBm1/J?=
 =?us-ascii?Q?lZ3hCN/M/X0AyuOoAz6MwDGTwrIcu33WuKPQZG/jWUxmvCWymRr/5Gz/rEI/?=
 =?us-ascii?Q?KrL6dGULe8kD7IXfI4wHq0Zd0x0YjglML1ZsS02ntlqeDA1KXRAdoFqzBq5U?=
 =?us-ascii?Q?IYLE7miCaBpnTQRP7xM5Q+cCoeGAH+ES2l7XTjas/XQIodWoNAXziFsaIDAv?=
 =?us-ascii?Q?fDSecZm+dQGpXHqneyeS2G8J6JKuMNL6ZRK/yu/4mBsV32698UE0hOM3QjU+?=
 =?us-ascii?Q?BI8ak039lUDo9ML7mrFcnjcSi5r2LIFSEYGxG5t0o+VPevratUw2X6uzcn1b?=
 =?us-ascii?Q?wvyZprPkWQHnYaPCytxKjejh2PDP8AZd0i8FGVEnhKVHRR2yFtgrll4W+P8V?=
 =?us-ascii?Q?3VGeaS2xn8Uc85Rs0ksGQSroG6xBA2PT/krITesdTlaPD0Pw+mmdrYbbCSg+?=
 =?us-ascii?Q?z6nT85SVauEq8u/1NFQAD9M0TF3em8h4xtqfny1Tsfytl+S7rLcqwSYAbnJR?=
 =?us-ascii?Q?xLKe9z2jl8r5Ah0g7fSx5DN8Q+9Hvlbjo4PgeQ/jOrRvy6BC5YR3Tjjz9/1T?=
 =?us-ascii?Q?hgs0roxmuGT/fyV6MYFrPesJ7xstTwtLuQK7cAStuOWCV9ghfo7AMhjV5r9q?=
 =?us-ascii?Q?CKJIRZn8tGkiiLzv2EVMGCqdJRumye5QrHuV/2DET/eEXzJCv9159NgsJxxt?=
 =?us-ascii?Q?NRUvm2ol6A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 638e1a83-5285-4e57-e1a6-08df2b6732de
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 09:23:54.6851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F9AwvEX/+yWrN4W19fGvEerg+B4pqtyLVX3SPD6+FW2g5Jm/i5nWB5DtqxmHVNYq04KYgfJCPO3+ZO760zN8cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9539

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
Assisted-by: LLM
Signed-off-by: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
---
Changes in v2:
- The three chip checks factored into gpiodev_check_chip() (Andy).
- Assisted-by tag.

 drivers/gpio/gpiolib-cdev.c | 50 ++++++++++++++++++++++++++-----------
 1 file changed, 35 insertions(+), 15 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 3792ccee4da0..6f84aaa95033 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -1512,6 +1512,20 @@ static __poll_t linereq_poll(struct file *file,
 	return events;
 }
 
+/*
+ * For the read() paths, which must not stay in the SRCU read section while
+ * sleeping: that would stall gpiochip_remove() until an event arrives.
+ */
+static int gpiodev_check_chip(struct gpio_device *gdev)
+{
+	guard(srcu)(&gdev->srcu);
+
+	if (!rcu_access_pointer(gdev->chip))
+		return -ENODEV;
+
+	return 0;
+}
+
 static ssize_t linereq_read(struct file *file, char __user *buf,
 			    size_t count, loff_t *f_ps)
 {
@@ -1520,10 +1534,9 @@ static ssize_t linereq_read(struct file *file, char __user *buf,
 	ssize_t bytes_read = 0;
 	int ret;
 
-	guard(srcu)(&lr->gdev->srcu);
-
-	if (!rcu_access_pointer(lr->gdev->chip))
-		return -ENODEV;
+	ret = gpiodev_check_chip(lr->gdev);
+	if (ret)
+		return ret;
 
 	if (count < sizeof(le))
 		return -EINVAL;
@@ -1538,9 +1551,12 @@ static ssize_t linereq_read(struct file *file, char __user *buf,
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
@@ -1835,10 +1851,9 @@ static ssize_t lineevent_read(struct file *file, char __user *buf,
 	ssize_t ge_size;
 	int ret;
 
-	guard(srcu)(&le->gdev->srcu);
-
-	if (!rcu_access_pointer(le->gdev->chip))
-		return -ENODEV;
+	ret = gpiodev_check_chip(le->gdev);
+	if (ret)
+		return ret;
 
 	/*
 	 * When compatible system call is being used the struct gpioevent_data,
@@ -1866,9 +1881,12 @@ static ssize_t lineevent_read(struct file *file, char __user *buf,
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
@@ -2612,10 +2630,9 @@ static ssize_t lineinfo_watch_read(struct file *file, char __user *buf,
 	int ret;
 	size_t event_size;
 
-	guard(srcu)(&cdev->gdev->srcu);
-
-	if (!rcu_access_pointer(cdev->gdev->chip))
-		return -ENODEV;
+	ret = gpiodev_check_chip(cdev->gdev);
+	if (ret)
+		return ret;
 
 #ifndef CONFIG_GPIO_CDEV_V1
 	event_size = sizeof(struct gpio_v2_line_info_changed);
@@ -2633,9 +2650,12 @@ static ssize_t lineinfo_watch_read(struct file *file, char __user *buf,
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

