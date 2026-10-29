Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793273392;
	b=W+4h0is8wjsWc47bEyLQ7BbNkK9UXBArgQvkcsbSw53TlxaHEQ1sh4iYwoASt7JwuymS
	 UOlqg8Yy188Q/muE03aB60iSVde62b2vYSc0MNHD9alt9ZaYfhWPR3LMdk0dPsDaJQAgS
	 V+s67xYRKxzKqvqEuX8PRX2nToy4PfNi7XbIJsuKZaWoiILdAT8Ck59omWJ4cctXddcz0
	 Pq3xfUNfBOhfceNGtZSJdhDixbuxjSK3S8hUxStkSIiy8mya6viFq8whwqd6kRG9KOud/
	 z5cAkjjmmFJ+LTTVlj8bkebrYM6WCt+A8DZp68nbP/QipSjejdnfG1TuD4g8SgzU7lw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793273392;
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
	bh=BneBbXpWsXnLUtxejHbUoH5uGlNDwCyP/I3lldVzha0=;
	b=A/kKPKuXF4VG3ZTEXGuTGP6UlZ2Wzs6Wa8dRYtdNEmj5D/uXWIvw/a8ZnMrR99y1HcIE
	 9nCmBtNUw3KeHCJsfmWN/GGdpQkz+c3plDYp4YQsQXpHKv5Laz9n6ExbmOUX84/nktEqo
	 GH37O4Xbyl0/96VpJT4600xcle40+OUNlI6izQbcOXYrWRAIgQ+kMGX6GAltRbTDaetcW
	 98UYHM4stsaYu7TwCzamNDAwN1FF7XeAg/bhdw55GvX+RTx8HIxFx6yU5J2Q4fO2T9kh5
	 HViP61BrP9JfDEkIaLK4FbJ+fhZH215olY6DteKSLiF/ggOFnuK+hew8rJTDt2UM0FQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=kGTkj0fs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.10
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010010.outbound.protection.outlook.com [52.101.61.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A76A606A330;
	Thu, 29 Oct 2026 11:29:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A76A606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=kGTkj0fs
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GoIqJH9QS7TBCIJkraeKJKnhhv3EmTk7+Y8dzYnm2cMekSlCzz7fytninx4i3S7FN5qo+ka/Zc9abwqkvuST1ryhKnve7iL+VVZ170qahfXwHP2HU6pT0/QkmyYYhGv5xTYoIUqXcAZ+XLyx+IxMDgwMNeVVXJHWYT+wdguypeckeY4uoW2Qx5ixQBFWCEb+RVs6uT1KYvidTa60K8XniFNUA3w+FgF5+D7M3W0Z29sygvL+ArzTc79Z9Q4y/F3H3z2lw5giJKdpYrqKt2NG5VGH8MWte6ZAHR/aLl9c5ZWTVJ6HTT4iTDh8Ad9XdfNSXWjGGTrgq/E/rCY/52XRfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BneBbXpWsXnLUtxejHbUoH5uGlNDwCyP/I3lldVzha0=;
 b=DzENQ5H/G27AQUG297/Dz7LKrjdDVoaLrtTiNi3TG2H//SRNAzPBRupNPLrX5uYC0PWDJo3GFXtiuhuezdLhzr05Uu0QjXpwxU6Q7Rg5/sHUNs32ll3eXkEF/yriSJXBjCXF9tVxMADI+wRViBGlBgLX+HPGu/YJYWcgCHI3XHJaPh54zW8UBO6rps0ZHkUOxc4KeNprdQT/bVrUEN9+ZWaGtJJnprkAQPTfoO6K63duDKlZjfsVqCOyII/vRnDIvUoWZLVV/9+IoukRsamXUJoly/OY4YBMkBJBkaJsfq4puvgCdJkcg/X46N50r75N5Gaw2Ksd5AArNfOFo73Wyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BneBbXpWsXnLUtxejHbUoH5uGlNDwCyP/I3lldVzha0=;
 b=kGTkj0fsFv/7/sBSRhDdVi0fDGEt9duKazXl/UNC3eVBIEKSSwUMMYhSBOaHPbjtg1rfB03Hm3Csy7160bNZz4YDCU9Jk7iVpmCxgjhVh7Fz2weFSZmcQS6IwvoSmfpFaKVp+HC2UnRPqy7S1ZOGkjxAwIjOtEl6U32J8xa33zmxhJcxnSMv+jf3hgHaEq5Q8aAgsSCpt2mCJvEEaEebeIUxFa01nbC0VAGZgW9C2aFDVHmM4nu10PdClEwoXwYv71/ZDEYRW4pGYYO564YJhXFna/S7+P/sBjEvS+y2Qnm9lJYmrOGzy4JRrjkjzrc4ZrvfpKmjMGYNn0MYg9DnTw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by DM4PR12MB6134.namprd12.prod.outlook.com (2603:10b6:8:ad::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 11:29:40 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0569.008; Thu, 29 Oct 2026
 11:29:40 +0000
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
Subject: [PATCH v4 4/7] gpiolib: cdev: don't sleep in the SRCU read section in read()
Date: Thu, 29 Oct 2026 13:29:19 +0200
Message-ID: <20261029-gpiolib-chip-removal-v4-4-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261029-gpiolib-chip-removal-v4-0-aambrozewicz@nvidia.com>
References: <20261029-gpiolib-chip-removal-v4-0-aambrozewicz@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::16) To PH7PR12MB5974.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PH7PR12MB5974:EE_|DM4PR12MB6134:EE_
X-MS-Office365-Filtering-Correlation-Id: eb3b696d-870c-4d80-cc8e-08df35afebd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|261028144727099003|11063799006|56012099006|5023799004|261009223027099003|261021123027099003|261026140227099003|261026121527099003|261021121427099003|261022105027099003|10067099003|261022075727099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	P3E0W+lr8LfeDKRlG5bVnON3vOK6OLvKpfx15LB6O5sdbznX0FzOoonoPPwcb6ew2DlmPtgmjJ//eQmmK+OuOZWjStbYzjjwmHNavlm4g/E6McupSEyUhtKDd6Gbg4lFB9WE3cOCq/A/2ylMW/1XYv1t/Cm32f5Zo8FUezjEAs7lAo88+ifYRadC3Jv1PW4tSE7TVm/WRWJkIWJwKVG+6wMmZwjN4RAUgUIKaEuD7+smLJZBWbX8W9haS7sv3IA5tnKEfBiT5Tf25+cy9fuApW/C5hxb3dPksddzK+a6QqtpyJ7/KwUKjPtLzCLnHpvIzm7TneLaQ4En2588awXZ3Mr116WVwgENw60azuLvjvPs9DhkGfyIHdSCGA6/8hYkaGXDTF6+CNKgamGOnzLCVTR1qUiW5Ve1hXLWlyxw+pz7pKqCg2DJhfrUXkxA1k0hgMsXfi3yI6jSwe1Mu1j/I7U9q2T5WxloCKxBKdpBFx30lmzO8LGNYowJu0e1/art78R/RX7+jsSJvUmaygfUiigkQyT50LTwnbhPs23HXDIQ/6bGAF7z2FmWeyKAyrHVoX9vtXa4MjoWta2C5hu9PeJEXDchwj7r0NlUnO715nGjlkJgnXryMPn8crMJ9SlKX8QXmq4aKWe2ITfwk/QlvHJrG2ufH/A1tu5jVtj2bQI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(261028144727099003)(11063799006)(56012099006)(5023799004)(261009223027099003)(261021123027099003)(261026140227099003)(261026121527099003)(261021121427099003)(261022105027099003)(10067099003)(261022075727099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ckiZQ+k42FLsv7eOxBuB7HgxQqMteW4qhZ5hTsq93GjomRHVsf9zmQcMPwtz?=
 =?us-ascii?Q?1vyyY2NcD6SHcWxbT94pIoRIhL7PiElbKYLfRwp+2Eq4leEtbR2/Vri8uBH9?=
 =?us-ascii?Q?jdkzJ6FmaUH9laC6wWfbMQ6rpY8vNNOJbTL8x0VZoNelWg8oEODuCKpt6G7e?=
 =?us-ascii?Q?sWnduv7M2yC2Vhkio2P/r1dndL2uhs0tCKpG1el63yQJOF9Lkn8piPrQcMPl?=
 =?us-ascii?Q?gJb5gzMaBL6qZ3NOKhHIqsSh8NEbMFY9VYo9mpjREsqU5cqu+BT92sZ8CniY?=
 =?us-ascii?Q?6X07euRVIOs8+hC8T3+to6LHBI/znEqg2/dVb79NAu0OqmBlhZxqIoOWeNwZ?=
 =?us-ascii?Q?5QXnSrhLWbkQYsNPcM+smxmVjFIG+vyyWy6lUQZD78dGV/HfbSoyY1ewBEGt?=
 =?us-ascii?Q?C4sSyMqdC1BHlBEin5WNPicbo6U6I8ZvU1DMhAgZpuY4yK45ai57cJswaWUs?=
 =?us-ascii?Q?1ptA84hWf+ehaMVAZ5/4gs1meyHwa9SJgNysSyVt5uTWPzMlNWl5czhYIXvc?=
 =?us-ascii?Q?5zd1eHXnSu3XHC7VenUZmYq1OvmPE9ziw+NmQwNpT/Ly8OWPpghS5w8IQmpB?=
 =?us-ascii?Q?1TUAX1ZbEhL08TSr61aLghpDuEbe2yyIbHaMgyXEujUNba0LLx1Z/gf9p3wH?=
 =?us-ascii?Q?2XNC5WfLSpJrHurkl2D1M/tLdme9+A0gZi5d7jwQrVWdGEuuPqiwxD1BxwKy?=
 =?us-ascii?Q?dkCafBitpuxqlj3unZXlmmJfNKsVjeFGx7NnTj1j+8X8exCH3SqfggiuIIoQ?=
 =?us-ascii?Q?6FadMyjXClfbHlMLp/iYVwCJ4sDWQAdD5ne7+jEqJ92NOfMLbijKohILzEiz?=
 =?us-ascii?Q?+Yx4n489vzpwWoGKpHjJLsCN/zrqvsdS7M7LjFREc53lougmD0ilHwOY2+k/?=
 =?us-ascii?Q?q972zSDnN22eKZWrAPdemSi/dP9SFNWVWYNn5uAPb6nDwOp9FoXdzZBbtkA6?=
 =?us-ascii?Q?Eu6P6u1RAIfPBVrbiXRZpk+h0Zyi/OaaVD4KOVXJ7LThbZisl/gJq9xxyrG8?=
 =?us-ascii?Q?Uyrzhb4GfzdbMRSy3FiO6FbRDDPuETkOJR7K+tS38UXCk6b8A9Qc3NJIXemv?=
 =?us-ascii?Q?bbakb2gKYXFS5jsIww4V5UET7EVKwB2oCQ3bzt9d52QZlugkeAhX5kkbrMkh?=
 =?us-ascii?Q?Iqwg5wQo5t7UmmS64x40yTVWkaF6Yk4vxSs2qt/ym2pmPo6Vfi3i9Lp18Zl6?=
 =?us-ascii?Q?ALZI/k6oQ++dHBubLHgb1e8uIPxZ90QorRw+TFVU3PDHrKutwjNPWhLDHkCr?=
 =?us-ascii?Q?/cb3CnHbRjIdq7wZimYGEPvqN0bHXheulc1ZkJ3TjSujQ6pT90MIC6cGmJO9?=
 =?us-ascii?Q?FHreDXVgMcaY+UMTOza4lw+qph6Ur1E9YI4+iJQIAZFWL7Z5n5/VWXDl4VYt?=
 =?us-ascii?Q?m/o+qzhMfl/UYteaEVrgp34rm3Fi/34Zf98NWXYIhfO17+/Yo6jmBHCt8T6Z?=
 =?us-ascii?Q?7czpaNbpDMBgIDjUSp1zgevueE2JCEjStHA3E4vvuITCVyMiHVfvOU1eeC4T?=
 =?us-ascii?Q?ww3LF6Rishyi91pUhAzBJhS2QBjJYZyTsGKvKIa0rUfJXK6AaOR2Bg+1MMXF?=
 =?us-ascii?Q?C9w+7KZn113jVNg17EG7Za3wR9UjlFsrEx75A8G+A7f3lx3uxlJGRet81nGF?=
 =?us-ascii?Q?m72imwBAKDw/qvdetfpVd90h/F38RjVjFVbBzr01ZTEtgB63/XWPe89RAFik?=
 =?us-ascii?Q?NWTbeKYasXeFjhRLKcLba/mScYL5/XNVXdlCWy096dfQ+3l0dwZR9tkr2ovt?=
 =?us-ascii?Q?9eqL90GzUw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb3b696d-870c-4d80-cc8e-08df35afebd7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 11:29:40.2941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wDpeJTmpMvMywjK/KcXGG86Zm7EpbvAj3Lx6y3exiVzJFoC+1sfQl6FxOW81F+2J2WPM7K2cZc0t8V3UpgVRBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6134

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
Assisted-by: LLM
Signed-off-by: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
---
 drivers/gpio/gpiolib-cdev.c | 50 ++++++++++++++++++++++++++-----------
 1 file changed, 35 insertions(+), 15 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 6350b2fca8a7..c5869e3f7767 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -1507,6 +1507,20 @@ static __poll_t linereq_poll(struct file *file,
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
@@ -1515,10 +1529,9 @@ static ssize_t linereq_read(struct file *file, char __user *buf,
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
@@ -1533,9 +1546,12 @@ static ssize_t linereq_read(struct file *file, char __user *buf,
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
@@ -1830,10 +1846,9 @@ static ssize_t lineevent_read(struct file *file, char __user *buf,
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
@@ -1861,9 +1876,12 @@ static ssize_t lineevent_read(struct file *file, char __user *buf,
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
@@ -2607,10 +2625,9 @@ static ssize_t lineinfo_watch_read(struct file *file, char __user *buf,
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
@@ -2628,9 +2645,12 @@ static ssize_t lineinfo_watch_read(struct file *file, char __user *buf,
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

