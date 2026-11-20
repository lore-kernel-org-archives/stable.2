Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795162461;
	b=nklN30BBwgBcpOvtTZldLtvbKfY+gKlCflO+aUmowm+sSXXsju+fxMDbZGbXC90FFNs1
	 BJ/vFeS3jwdRXBi36B3AHZwCROkmJnaIopPpp0cMW4wKtFgdZFzUIjjcxNTSk1pjm5rXZ
	 s4XVzOdXNEcNhc0b25TW4vXrzQtcUsNdHM/O5yeDoHpFSrJcoiy3S0gsoTE9o+ttEwccK
	 5FU5pvxS7p4MVXzwYGtxKFi3//jB+BJAVLbT2tlhMIgCXhtcE7QZNaBq/y+VNnHFS/rPk
	 VKUV29XgkUAOcJe5dWG35DcGMDZIXBtVCLIJ7IvkHhXaavKo71X8XPXXnAWihfrO0iQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795162461;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=sSz0z635/+RzoTpgywzI8k60WgwEX1x1FtQDzML857s=;
	b=pNt1h1Jpxa0vXFK30PdsSxX2MBy+XoyZ5PPYil7k2SCnXxLQF9bG4huKqKJZJ6dd3QHq
	 5QYzeSAGK94QOIEaeZFgNXK7Oukkho1SSjVSjYPQPO4tzvuIo4usWFE6mZ0luNVyYqxWi
	 BX0czHBvZpXEjX7XdeGPtQusGxmg5FLnhHe3hgME55cstCx4rjqhaIzeG5ib710ZUwFvf
	 bMtMRMxS4QZRRdwd9vhe2HYZWN9qWRoLI5NfP9hWH4B+7wJko26Ki4jkhJ+pBpwbzGhs1
	 qDzwurMteGoJf6LtyOFcA9QahHUQAsjt2ff+YuvurOThJ69F1GodLD7h9qaLZkpJUjA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=JsLOJcw7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.50
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012050.outbound.protection.outlook.com [40.93.195.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22C360A261F;
	Fri, 20 Nov 2026 08:14:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C22C360A261F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=JsLOJcw7
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uaa2XD+POi0iWYOTyNVZKWsbR1gDWdNXf3pX2ST7K/hv+GqgkPD8vESBdFNS7Zuv/UlQ3BxcA9okmOtqUUyPvqpagAiazJS5mHGbmAP+4L7ZLKE3Heg5aH/DAIVf81aIS0paj/QJOwrwvseWn2iIMXuw6pD6D1YJMLRqZMXWKhuY8yEp2D3MvkPS3JTqYfNzBLunKsSRSyr+GJyaLFvUvL2oKADzOZNDE6RjVJDkZ6IXXni1DlvcsLaofoovKuZZoY4emHIu+AzMlw4du4yYVCvhDj3KKjyV6tpUDB6asPolPO1O9j/WP2atTWE/bFk8uEv+rI7WRMhCRDfGFDDdZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sSz0z635/+RzoTpgywzI8k60WgwEX1x1FtQDzML857s=;
 b=YmtkC2rdYcOA8+lXbZ23alz5k9kfoamdSq6BmXq1wgqw73LTfPwXvkCbk2BB8JBiXIuUMWcXq/zpE+bVVA4ef+u3D1SRYdXS92Oz1hDK08zps5WMyLeI2YF3BTZCdfNel2HI4Q6DAzPoRR/o+p9cpxJpRzZbXvfeZ9X0zFy4h1NjGLpOLYK0oLtjljDbeNq7yxhv7hw4EZiWMfpDF5157Hav+MNZReaqVH0pgU6JiZtR6PRbNgeuflJMscuugVperWn01OUXJvVfO8I94qpTtHgfHmVJhfAXaXmFU0+ZbQM5lbhyMDBWoOq+xagLkH3u3G3LZNZGx3j5LFb6Zohh8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sSz0z635/+RzoTpgywzI8k60WgwEX1x1FtQDzML857s=;
 b=JsLOJcw7DA/dg0TMmbX+irVB8h5nFQ2SHBPnEJiOW3MNF57f/W+BvLI+sWLtakULmdRscmIooIXTSEKH8N/XZAeL4ZGzKWIVO/j575Dh519EJP1CCMWfcm6at7tAsHh/1fkKQqEBYkW5ouQRFkJUlke6hf1Z7brJ9MZHutm/deHUemUk2jj0g6ex0Lw9YA+i9fdFavkAcAiu+rMYS5GQ3eXEDuSfFEdiWP986kvaGtbCLH2jbNYqcDbRgI6K5wlwuxYv3HqmsWAnr4WuFZEP7XruhG6DDA9WauWpkBABAUKmYuUjOFzUwvvyLAL1zCYsPEdK2RI86cJAC+R9+5tlOw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by PH7PR12MB7818.namprd12.prod.outlook.com (2603:10b6:510:269::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 08:14:17 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 08:14:17 +0000
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
Subject: [PATCH v7 4/8] gpiolib: cdev: don't sleep in the SRCU read section in read()
Date: Fri, 20 Nov 2026 10:13:56 +0200
Message-ID: <20261120-gpiolib-chip-removal-v7-4-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261120-gpiolib-chip-removal-v7-0-aambrozewicz@nvidia.com>
References: <20261120-gpiolib-chip-removal-v7-0-aambrozewicz@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TLZP290CA0003.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::17) To PH7PR12MB5974.namprd12.prod.outlook.com
 (2603:10b6:510:1d9::19)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5974:EE_|PH7PR12MB7818:EE_
X-MS-Office365-Filtering-Correlation-Id: 8698e8c0-3d74-40d5-5211-08df46de4593
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|261022075727099003|11063799006|5023799004|261026140227099003|261021123027099003|261009223027099003|261021121427099003|261102123227099003|10067099003|261026121527099003|261022105027099003|56012099006|261028144727099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	wk8l+Z454eIg/m+DW0xvbk8j2mU+oRt/ziCT8iV53+MXRKRtMeVGuWe9UnvKQ/f5wysSAIwCpW5l17geJXWyL4dDM5WgSeeXvlIseWxeKD+nDBkvMv9gj8QmPS6HJY6LtOgAR61pmX1ZJ8gXYoD0WD9MbEThC9vfRL4c4Xl+dbYchkK+KXk4Bx/I8A2LNAVRcwtaNITjTIL0U5lgdjmJxSqSyGCmBtSkp+61atKd9AP4OxLI8L/pMbYQBhhJbI/conr2b2Cq3hiXCjMn7+mnPe1Y1EUXfw7jhGv5fUhVWS6rBhkc45jGUxg2+RlOJimH6ClNcOgtfD9Kc0bFbIWnNvfBjv1jSVXzSBwOQUdaIp1g2Vg9DZKIw6q35iES291utOsKdaAdoDF9zNkNc2bRujl6lSTYnq2LzODQuJxS2SBgl78G+2L06CnKLIjfbFYDajGBnkp5DqrEBgPTHBb26DU7wx7xJrfROfp7xLugACq8SZeFrWV52YpY5cLcf0dOFmR1Ar5uMKZlWQpL/keli8BDIAqyQWbUMqt3TCpenCdwDd56lqagHCjCYXvGAQVF9C7z30zh7Nh0NTWEIBIgxiAC1OoShunOdmy2e4EKp+z2xEYEPB12Uyxov+of0P+D7ZRpOZT3+FCrVZ/GQMMimTYGol01ijgOGIEzGXgMmQQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(261022075727099003)(11063799006)(5023799004)(261026140227099003)(261021123027099003)(261009223027099003)(261021121427099003)(261102123227099003)(10067099003)(261026121527099003)(261022105027099003)(56012099006)(261028144727099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Kca0NTI99WWQo3wC+QatqrQUkOTkpibnUgu2gY6O/jbXahfKTXFAcTienxz8?=
 =?us-ascii?Q?fI1UCpTpWj/7XemIm2GiFenICYjiNNt/COza5uqATb4EYQGAeb52kSoktR3n?=
 =?us-ascii?Q?AImkBgOMhomcD4xbtrA2uL2zPj98D3qSQwObLTwzwJ86YAIcIs8stYtGeWQ2?=
 =?us-ascii?Q?a4zN/VjtBFGtEZ8RDt5alHmGNKSn3Yvq+0w9cDuFHZAO9kjLs5siYyF8RCtg?=
 =?us-ascii?Q?s3XMGztMvXoB2gFcVZfAsKHkbrQ5P9WHypfTpwFWoFAjEpClmOy8UMOxV8C9?=
 =?us-ascii?Q?/lVnZvlaiL4wESBD2OQZhgHluqXf94zOwHlVtPy09ClHD249CE+LuUnK2z6c?=
 =?us-ascii?Q?violXTdmwBuVGDQGHEu6eCbghFIiaZJeyaz+ahHqcQvro0QB62IRocY5C0Hk?=
 =?us-ascii?Q?Keh0Z3/rwogJeONS8mfB7MNap0xx4B+qMAG5yLBny8ITKRxS0f9B7obx/NjL?=
 =?us-ascii?Q?qis0jut7oZCgxDnvTbGygyx+HVubGFbyxFCdBRCealIrHM1an5yg+bbU3W/U?=
 =?us-ascii?Q?KE4+LtLrZ9yrPMCGSAS2t1kbzdjaL2OCyk1R028894vGvmJYncUwXcvO1BSo?=
 =?us-ascii?Q?5iyO0LPKVzipxt56FK0KgRd3RIrgwpIyWsqLgIy8YnYzalzpK58rSIDF0Dat?=
 =?us-ascii?Q?5SixqmZiA7ERxpyqK4aPjU9qi9GEZEFwtDoNssg5yC+2UPI5S0Pn5hdeEDXs?=
 =?us-ascii?Q?GQS5LQmREt6wNMnJ1FZvViD08Y833Vzdky0K2EdNKkUW7TjOlzEn3xgpipWr?=
 =?us-ascii?Q?Slpm4MvmF110F/D70EU9PRmyM+J2R/KmndbUwHS6vdmQnnVL1CIt9yAuna7p?=
 =?us-ascii?Q?p6bQxBL3bpTiEXn2aJ1CO0yLheYWmomw701ow4jWFUzDCMvqRR4McYu9K80q?=
 =?us-ascii?Q?LtG1qeT+gXKlgO9yTMEwrXb+vd50q85waORoDh/v6K17m4xWdDBvTF8+FA8c?=
 =?us-ascii?Q?SqQ6AhW9V04Pkx7Y3DfP7WDQcvBlLYUkDxOsu0dDPxrvMN8lSKodJgM+F6CQ?=
 =?us-ascii?Q?Wfh/HxzesHOy2/igtRJctobfhQc4vTIKaWLSleYCgJN65L8fwmF//gCSr1fH?=
 =?us-ascii?Q?58SGAXwt70DE+gx5Gm6IPXbA2Uqlg9ZAlu8JsL6EwhBm+rhNGuKu65DvRQj9?=
 =?us-ascii?Q?PzfY8XcxucvqMxWAVRZcm1HvZSIbGTEiIl/mGfl+IGwgQjkGElDoz5IMURgN?=
 =?us-ascii?Q?Bsc5rbakwvSiQrPZxSpBPF1LMqvSgNRW1kdHoW6dw6z0uoEANGBRp4K2VOYM?=
 =?us-ascii?Q?zigQeiWHc4/fWwyRi6HulmBZfSF4nu2dFliKgFCzrGWPaPjjyaG3gxMvu34z?=
 =?us-ascii?Q?gyLBr26vpIZULhuPuIYnds/bjIg61XQYhYg86/dDxNSiCnDlCovhKuPy2MMj?=
 =?us-ascii?Q?TUVGNrvpATXrU8dVdCmLC1VPoPzMJ/jxs4o87HVwUCW+QLP8Ho4H15QPfGli?=
 =?us-ascii?Q?e4H0jx8JoWp2lnrrEhb55S3ruCyqATd9hfaEfcb4XXGjIfCTMjubjZxFt2PJ?=
 =?us-ascii?Q?sb408CXIQ2aqAioDuo02p0K2UDi8ACo6Zqla03Dw3XFaJ9vz+LS+VhcgmuVC?=
 =?us-ascii?Q?8u8obvXACEhr55RNMCsRDDl4zT0tZ7bF3N66MvDlYmLVCAJr+pMjFZ5B67ES?=
 =?us-ascii?Q?a89kvawGx2mzWiAPRt6af8RK7rk4KBFyHBbxsc0uES9PP9OgtYmO0zN2VpjU?=
 =?us-ascii?Q?ZqnIzmhbGn5TERVP9sLsVXbDV52iD8MsZ5HRoCY+TppHWhUoh3eZp7Ro3koX?=
 =?us-ascii?Q?ZbS0XaRV7Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8698e8c0-3d74-40d5-5211-08df46de4593
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 08:14:17.6223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bBZrFA2Ts6LvdV3eintPkLJQ7q8TJznVa8xPG3e7ENT7FhCdR4nRr7diI686NduvX5I/DU7t3UHzDKdZCyYelQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7818

linereq_read(), lineevent_read() and lineinfo_watch_read() stay in the
gdev->srcu read section while they sleep waiting for an event, so
gpiochip_remove() blocks in synchronize_srcu() until an event arrives
or the reader is signalled. The device lock is held meanwhile, which
also blocks device_shutdown():

  task:init state:D stack:0 pid:1 tgid:1 ppid:0
  Call Trace:
   __synchronize_srcu
   gpiochip_remove
   devres_release_all
   device_release_driver_internal
   platform_device_unregister
   gpio_sim_device_deactivate

Check the chip in a scoped SRCU section only; nothing after the check
dereferences it. End the wait once the chip is gone, and return -ENODEV
if there is no event to report.

Reproduced with gpio-sim: setting "live" to 0 hangs while a reader is
blocked in read() on a line request; with this change, the write
returns at once and read() fails with -ENODEV.

Fixes: bdbbae241a04 ("gpiolib: protect the GPIO device against being dropped while in use by user-space")
Cc: stable@vger.kernel.org
Reviewed-by: Kent Gibson <warthog618@gmail.com>
Signed-off-by: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
---
 drivers/gpio/gpiolib-cdev.c | 50 ++++++++++++++++++++++++++-----------
 1 file changed, 35 insertions(+), 15 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index e6d41a8aba70..f2da4f2646bc 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -1508,6 +1508,20 @@ static __poll_t linereq_poll(struct file *file,
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
@@ -1516,10 +1530,9 @@ static ssize_t linereq_read(struct file *file, char __user *buf,
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
@@ -1534,9 +1547,12 @@ static ssize_t linereq_read(struct file *file, char __user *buf,
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
@@ -1831,10 +1847,9 @@ static ssize_t lineevent_read(struct file *file, char __user *buf,
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
@@ -1862,9 +1877,12 @@ static ssize_t lineevent_read(struct file *file, char __user *buf,
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
@@ -2608,10 +2626,9 @@ static ssize_t lineinfo_watch_read(struct file *file, char __user *buf,
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
@@ -2629,9 +2646,12 @@ static ssize_t lineinfo_watch_read(struct file *file, char __user *buf,
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

