Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.34
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794836855;
	b=yOvn/lL+xDUi9crtDqc8IAhNz9oZd5m9sS9Mtfp7kX6+0QrmwuDMDzJP+w+q0nm6bxI+
	 HCKILsCdc+zi9y/lV7GgMlOROXGmwsSXVYyxx6LlSmghukmfY1K1oMmGfoEg3JDmBCDnl
	 33n/DAujS4yVmsJ3S7x8Kf+P/MqgI1JFYUYwFMdVO6D6VKJHfBjuqOBWY5Z3aNmWwFU9j
	 sNBD2CiE62aFJE+tIjae7/Cs/YNAb1eaCz/R2gULtkiW61rk0LBpGt2vsGoQmXvzNj0KH
	 dI+zu0b8yPaMr306sgFxfSd+s4GYv0pI2dJ2yAWqSpPb/lYvqwyE9SIemwN+rB1OmPg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794836855;
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
	bh=E/GI1mBtBCShMy94ZQ//R88T7rQmUgwz68YKhCH2Eko=;
	b=4zqL+4hvxXLOet+nkG97osg/4w9KKS6l79oweL4Tp0Hxewl36xEockJE9080XQc0cVHW
	 J+P5JIx3f1JexhYwHj2l2PY1xn6DrrBkvq5A5QKwbG1XwrxdnPafO9VXZUv8ZXoNxNOVh
	 4SNzKq8L0PuvSemrD4yLzDAkfbA2hCHzlyuniDE5EeFpob+dQ8EMbzkSGgEN9swDuxXlO
	 KgzWAYiR9/Y/OA8wQAXOs9H44Hg86IA+xVLIV03gEF36KAwOe3fXZOZHTjbKmmqDTJJB0
	 q54KJqPOLQg94skigrhm00kihG0uOmzP9753Fe3qRrO+pfDYQQ6F9LnLkEGTeKI8pSQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=AHs0doH7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.34
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010034.outbound.protection.outlook.com [52.101.201.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA24606A335;
	Mon, 16 Nov 2026 13:47:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4EA24606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=AHs0doH7
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YspunmWLIi1s6JBxEckYvn0E73v/MCk2yC2QtrYZWX+PAec8NnnVcJ2XDaFYTWOLApFJARUlo0VXdQuYace6/xcqvW3UNhDXK1Ds8s4jV8uHp9c5XpJG9xsETZurQ/v6qCGXr0Yh2J6d6mtALiN8QpZj3icfvYWNNN4tt2j039vMFdMU9R2VdDMLIJsURELOoIKtYatN7YmnXhgnK3ct/QiYaKMKFKLMYZKeIEAu76AJgytIdIHwCnb/xeh4ka2cBtKih3FjpJXd1ENWjCTQbUvW/Eoe/1EYzyX4lWoE4VW5Xwr5g3b3IxHB3a/dhKNCDoxmryxtj8gSVUKkOXNxtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E/GI1mBtBCShMy94ZQ//R88T7rQmUgwz68YKhCH2Eko=;
 b=y2UA6pSrltWkMNoJpfEBWmUypQxyCH6neSWEaXZcNGQwOX77Uq37FN6pEXXXqPxjjYU4d7s3+5EVde28gcarIR2qm3VSfVTaXYuNBZ29OmfLes6UaRCBMrCAKX2XpJXsmcKn69Y1D7ktq7p3fsYzkTS+0cAad6+tqPtqSM0bVOA/5EooTsZMTI+eqJTBwCFCXSCzytVRhFnWbPfYFlWxPhHEKqbXjrXfBnhB0F+wxj4OBPc6FFcP13/BAb/FgtH1C1kkq92qFNEoTrrfRasFETPWHLaXs0o+nVe2kvYl2Md21B9sjQjhGv1al9lodfx9gPMoL02+3c8e3ckR7Ypm3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/GI1mBtBCShMy94ZQ//R88T7rQmUgwz68YKhCH2Eko=;
 b=AHs0doH7ejY4M7c+6zJOP9CrkEIVVAtHcRwQnYdTjV8XFD+nu12bMeztthh98mh6mSeTrsghl4ZKPBnzh3f4mdRFvhufuSnnJZPoliusZqiPA9aDMCkWDkCf/duJOTqT5e3rIwWxCZir1BdAnNO62uLSrFtlpUuocZvuMnFVCFVw32mUOadfpLSxX3ZfRitU5ZjRotxgv1zwFoCqTAMTXy23RH6BkpONM65z9fIOxc/LkhfAJMdoQjwINn4pSMLHAZ2i0Rg8KgUjpdLpeSv61r15ObqbqoaEH0clSjXM9D0WQeoS3ZZfR8f42UecZww2zKy8Aht4p0vfO403Vod8MA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by LV3PR12MB9117.namprd12.prod.outlook.com (2603:10b6:408:195::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 16 Nov
 2026 13:47:27 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 13:47:27 +0000
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
Subject: [PATCH v6 4/8] gpiolib: cdev: don't sleep in the SRCU read section in read()
Date: Mon, 16 Nov 2026 15:47:07 +0200
Message-ID: <20261116-gpiolib-chip-removal-v6-4-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116-gpiolib-chip-removal-v6-0-aambrozewicz@nvidia.com>
References: <20261116-gpiolib-chip-removal-v6-0-aambrozewicz@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0028.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::10) To PH7PR12MB5974.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PH7PR12MB5974:EE_|LV3PR12MB9117:EE_
X-MS-Office365-Filtering-Correlation-Id: 63bb8720-31ac-4f6d-a7c5-08df43e8271b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|366016|376014|1800799024|56012099006|261021123027099003|11063799006|5023799004|261026121527099003|261009223027099003|261022105027099003|261022075727099003|261021121427099003|261028144727099003|261026140227099003|261102123227099003|18002099003|22082099003|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	3f+vCykjK08IGbEg6K8/f301XYRFraqFtqRFLayYbaUtX8qcLlV/j+DmzR2ODV3NEUEGb9n6M+470U0B30CXOWMRbHtWH8qInPtv0u6cICRgpU8ipNsZGxAEzDp1NdsMCuXqqp/2XxE4KtSI3lSYlnnc2Y5EFjC/g73x7WLKjsoS93Vh8fhI47iCY001iQcvV4AMNW3pFA3cQzg4Idue4OKvo52VGITQEY0pkFQIDtoC/HU6IJmcd3FNjYigWo4ZSfQfdLOxouBHEV4u3MNJgG2VH0xiheY+N4ScJyb8LQsTg3rwVjeBq6a6GrUAGWEwZ4+Un66aEVsTmeyBDCqqdD1hXCIu0y4zB6A6KI14y2SOMYJmOh3tL8DmOwUYAaxaAhlWKBWLQFR5l77EUoAspXd+QLorzZYe4bwyt0VSVxGe/G9JkJLTEcVVm7HDzCB10luPYq0f5GqD1KIjOfD6kzxtIPcn7T9qlbQkidGA6diHiRLTJnM+MVnDdtCk2ip4Yfahdtuz7HE5w49qpa+l4CczXnVgRU04WrY26BlFipM8BZjXMhcMTGx5uVSIZ7cdSqPNrYpsZArK1vny4EeM+3b9waWYkJlaFztx8fuSkxGRDsYhTrzJ3SfgQ4lkKtNzzHs7r8lvApaU1y6R1LJ+ZVW15p4ABlSp4VKjlo2ljxI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(376014)(1800799024)(56012099006)(261021123027099003)(11063799006)(5023799004)(261026121527099003)(261009223027099003)(261022105027099003)(261022075727099003)(261021121427099003)(261028144727099003)(261026140227099003)(261102123227099003)(18002099003)(22082099003)(10067099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k17ElPEeNlyRPwnzbUhsFCsk1hyLqogIKlSeRZ7pDwqN2IMFo2ySUj2z0VKF?=
 =?us-ascii?Q?fPS32qGOjcWnryhsrx2VRE6J6mSXHVNlCaUjCuKA2aMDrzdhEJ0Lm5YQg/Qx?=
 =?us-ascii?Q?SC3/y4f3bd1Uz/wur+fp30CJUSeTE57feeEW4DlKQ6/1IAkkdEVnvxf8lSLI?=
 =?us-ascii?Q?j10JcrC+VDg+V0RG7zcSrd0Yif6HElzSnpSukj5nFMG5yNnWd0e/WmLLi796?=
 =?us-ascii?Q?6tKqmMSsUQioWt/bXe/TVepycLFtKnGyS8B+bMetOfZUMNAuBAyrEkBLSo75?=
 =?us-ascii?Q?8Cl1qzf0m+ZfJl/vpy4UGuHYADzqAgFGxmG1mYH6BQJJbPwipdjHyBjZwgfc?=
 =?us-ascii?Q?2ebkiOy+Hzubp/vMkFeoB7OYeEKTdlXhhJT9g4Z0Sw6vp9ms+JFKxPXXV7FF?=
 =?us-ascii?Q?bXiVQlihEfmm9lhPkU+atpkMCt5RLOB9GM0EVXmQ7SUZq7J33MTGBXWzjAzH?=
 =?us-ascii?Q?QQrtTuc5eQsz7+RdTAlar6nI3rB3VjNlaEE205Vc4kKvWbNw4kYGpauhGX+x?=
 =?us-ascii?Q?VBlFUUeuQRGDQ/e+fdtyjqwS9I/KWypanau5yKequn9nHQa+WlwJ57/PYHyr?=
 =?us-ascii?Q?wHx05WogvmmSkzFyaY6rgF2oUpeOPFjfm+6GP1CSjLh4p3H5eD4/S5AATP5/?=
 =?us-ascii?Q?8Q5AR8IqFypKF881kIdQBcqjhrZqUnhKKtsFRHqkSEkuCcUaxEcmyAj3sNKk?=
 =?us-ascii?Q?g6AAP0X2PgoMbANTaK24XfxY/VDs6awRhWILjClIRSFYBFrgjaY9D7tDIMBK?=
 =?us-ascii?Q?iqJGn8VhQhHod3OttOrZ02MgCgdXhqK7ijwCjWsn2a9xtDkQ7qPlvUUKHkDA?=
 =?us-ascii?Q?trssEo3eH12YkbRM2IXXCyt6WzfA01l3IRIk3O9dk4u58XICqXZhf+VG1xnR?=
 =?us-ascii?Q?XoUONFCCS2EGOTIp4wOK6H6AzdjgReJ/z6jgUVE8qu5x+ouaoUe/12VcjLOW?=
 =?us-ascii?Q?dCpMBfj57XrYRA+3G+V9hJaFDMw96rLQdIln+nAP6tPn1NzrjDkxhfl5dhG2?=
 =?us-ascii?Q?3l1OtW8A6BrtkvYyLeKz6/0ovIiJCAI13eNTS+fm8R4vXDCDF1FwPYZdYbEf?=
 =?us-ascii?Q?mmb1ofceD75lrxVViYqFTWMIkv+YYsmSJZrxBCI1QV8syeLobk/yO55QAlda?=
 =?us-ascii?Q?ZB1lgHoNJxaZ9gdOaeBU85qIHscD8MPBNGCi/ExioW1bIV8UCxVGdmtgXPzz?=
 =?us-ascii?Q?qWc56YREsJzkqzLHHJNIEZy7hEemIS4Dq5mQWeP/yaJetb2oI4iGVxk2jejB?=
 =?us-ascii?Q?QKc/Q05gbwzHDWpOCidYi62ve5q8Kidvpr7hu+vJb4r8pvayNZ8Y9/dIqWFt?=
 =?us-ascii?Q?KFBWDRoj11bzT0566t9nh2sOhM3KYto8x0zx5yswPe0AjfR1FWtn8nyKFj87?=
 =?us-ascii?Q?gnPrFOZKwmfgrTr0rfynKfevFfmfIAAbEMh5B5w4hEXEdz+8D1kWaSPs1j2E?=
 =?us-ascii?Q?kYtc2Xw+d7PBC3AnbDPbARfB6QEBuUzJAw3WeTZs+bb44G3kBz+DbwM6SeU5?=
 =?us-ascii?Q?d0uxzpObZQOH8N4IkZkC5dk0a2rH9V/SlPOXTIFX6jmkr5yFkEcgDtsRuaAA?=
 =?us-ascii?Q?Vf77Ll/uWDpHyFdJYflHciJRKs8S8V1fdH3usi86+kC7RyvlIpf7VC8T/DAB?=
 =?us-ascii?Q?ltfQkT2J6tgL6JhL4lgAsAuUpFeMJNFLK4xc0Gko7/+y13ou1ufyljQ1A49K?=
 =?us-ascii?Q?DYvie5TVdxoKx38XwuAgdNx7eqUMIq9ivDTZ4wKxL9/bLX7lWpBhJ7rfK9tC?=
 =?us-ascii?Q?ECsc6foPMQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63bb8720-31ac-4f6d-a7c5-08df43e8271b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 13:47:27.8567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TbyW7zFTxqqvzlIIRFFtn0lHf0mJABTuWq5+iMWRNVefK2DGJT2EkqQgoHkJYvtBLWay2M5UWh2gRbYK8x1xHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9117

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
Signed-off-by: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
---
 drivers/gpio/gpiolib-cdev.c | 50 ++++++++++++++++++++++++++-----------
 1 file changed, 35 insertions(+), 15 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 58e9da9a0662..9c7b820248ab 100644
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

