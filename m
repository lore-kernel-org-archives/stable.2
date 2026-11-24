Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.58
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795512063;
	b=uqBL6q5yk2Bt7quT8Zu7ljD8orsnxVr+lVbG3aJyfPPyqidxeVGcas4VpnKRqsQOgHFB
	 L7/1No3mO9oLV9TBVmwd+papfipSb0yfDNpDjOf3F06wV72f61W0qUSlx1qOsHNHMwlsZ
	 rj6PVGvRkI1PdbLx1bltAPXdfOInTt7n/4JcgjfaVN4vzmyCkxfpivxKpa9Ulr65NtlLS
	 miZWysoDLwjgmYkZah21q6v6n0DMS0tYCFapQ82J11FxxM9bdfcUlVsOr2VEZw/6Y0ipB
	 doccoPlqqAMvmgFmFJSnnutc3LLgHtMR9V5GOzGvfidzqcDPTqR6tBrS2zbgqVvtFsA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795512063;
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
	b=llTs56ZuzKRegJmYHVw0rSap3KkGMYRC7yQouEJ1RSJ1jKVUu4QnyJNdY0OWTL6eAf6o
	 lHMjv1adAcmBa3n+/crsWN18vYSUy+QPf91E/g94wXsQbJ1+5+uO7QpAmjQo7s7TtPJ6g
	 gisJNu/7z0nq0cNjgwYUTtfkxWqsPOawtZEKcBnKeF8fGPs5V6jiA1PIPOlO6bEqJeJ5p
	 DJl0wV/hkJ4KKC5NMOWkwewO2f5sFRA67014fYsVTCGWSJAhN57Zw5NBElVfUiVIxbg3A
	 /kAxo1ZQsH78VQlAeuyhmGpR+LJMBaa8EBJpXa02O/RmQsNF9EEKX0BgjzWC6hJQ5qg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=n9edZ2B5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.58
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011058.outbound.protection.outlook.com [52.101.57.58])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DBA606A687;
	Tue, 24 Nov 2026 09:20:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12DBA606A687
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=n9edZ2B5
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WYhCXYxnq4iGnnuZbyYXeOv+5fhmH1hN1Fp1WGFip/Je6229zZEypTm4Hcz2ihbHeVnGTut1K/FmPZXjB28MK3ueVFZe0chiEG6oJAipBXgQ6Zw6q6ItZyFtvxkTZcrIE9zuLZK4gHYDDj4DgqQXy7n8IYwGP2HDvqMpM0WiCgJxCyMaRVSVzn5JP51ZLUm6h0GlY1AalZ9vU2j34Udvh74/A0y1lys2htg2T5BcKappZEd7UOESmk+vV2hGsbJ9Lpihmgebb9pjH0DTRDTL9Zh9O3Ophhzo4iEyYERCwX34RhjoMcJ6OUOHQVmSPCAEV3PfXmOWaiXlJsMH61GkcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sSz0z635/+RzoTpgywzI8k60WgwEX1x1FtQDzML857s=;
 b=tj8TNIlL5HOr0t59gzzkcPY04wYpIpemOebd5hTeATmP84q8vQP6SgD+EHpLFbaI0B7RYxiRWulO/uEKmLOkKCLOIsH4dZeLgxmofpxR4lKtNG5bDhvTl6FAM12Cuwlhk8l3j1+Mvk/mpQyHk3UL9PlS2Hp9+4VxnOy+x8IUNF8vf5sQZ+LqcHKigfSCuNXc0IlM+h3isdiJLodDu4CN7HhYKen4I1lo9YEet/+OneRHzvR0Xp97+gPXPcoTFtzLFe5RccdgK/ri/XixLMTj5weuzMTwzafc/z4qdy5/fyeiSJhKglynUkFOPkJANlFQUnksU0kMWYndQeqWXburzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sSz0z635/+RzoTpgywzI8k60WgwEX1x1FtQDzML857s=;
 b=n9edZ2B5h+pMNEMLx3mwBpB60E9bPOuUMoM1Wm8jbs866XIgzXwid1vPYwCq0SZRiB8M0JLoOLviFELoTgq71ECvPkKACd3Wn64K7BHtvcO8lffK+NkTQvRrREKYS7jO4Q62NZI0TcfOXo+cqNBwx5SbcDZboFSnbrEc2pqhCHFATUHfXPYK+41dAA67X2PyMEVjRuFn7ol8GiFmrD1nmm0dKWp953cTuEBC+98VdlTnbu4NFuJAHnviYvrx75uTqaEZxPKFgSkjeBbTYCTi7NMlXQoGwb3tQqD6uFx5t13nIPLIKn+zQHAph/SXWQRPLp9Ws+kbsqsvpn6b9JGj+Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by IA3PR12MB870191.namprd12.prod.outlook.com (2603:10b6:208:712::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 09:20:56 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 09:20:56 +0000
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
Subject: [PATCH v8 4/8] gpiolib: cdev: don't sleep in the SRCU read section in read()
Date: Tue, 24 Nov 2026 11:20:35 +0200
Message-ID: <20261124-gpiolib-chip-removal-v8-4-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124-gpiolib-chip-removal-v8-0-aambrozewicz@nvidia.com>
References: <20261124-gpiolib-chip-removal-v8-0-aambrozewicz@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL0P290CA0006.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::9)
 To PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
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
X-MS-TrafficTypeDiagnostic: PH7PR12MB5974:EE_|IA3PR12MB870191:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c83a093-09e8-46e6-32f2-08df4a0c3e69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|261026140227099003|261026121527099003|261022075727099003|261022105027099003|261028144727099003|261021121427099003|261021123027099003|261102123227099003|11063799006|5023799004|56012099006|10067099003|261009223027099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	3SHkE4DnXgKw4ZO2gP8UZoTzKCX1ZPGv4Uo4kpYvCz3vLX/rI/h9ioOZbjpV7pi9n2+/M6I7YwddCpzk2IjpbFX52gErMz8LGMKTC7Ejw7XgYu23dw+XB46owU09l7fdrb4gpYu3n2RlUzlhyKXScHNnElmUqSf2xMTXiYjXTI1rlqBoCqE0TWUsuwebdGGwwHFOS/WQd98K2B/T8LrsSwToiOIhhf2EMr8+hzffO0gqWs/7nXbjVUg3aB8FUo+rQBWfrgKcwRxD5HUmPNr8SGLfGyTLc24BMuIt7Bc92Vdy0Q8IZv+Pil617wZeA+XKIp0k466/NSoOqYsHJ6TFrOZs4YhdtICDeXcWFAtpvAZzK8oHTDciyXaNqz3jSlenP0hOBnx7pBPFgSvNUyKgZ1erBTg6j1C48H8XsPlprWQjog/zl7Glwv+NpM9+C64yBSKvyUc7herDY+MUpbOMo6HiPhCZC8e/c/isFOP+mtt2gRAhpEqVcM3NcLE9TKuslN63x8aZGXLhirwObb0pb2VuiSO0eqaDsU5TkxOW7If5PIO+0BGRHzyTLTZWnAw4zfabMoqMLit1VzQ5Mnq+jtzXbPGg7Ni8pY0V/ij4gig3wJq3T7BzXMTdonoujxTIGC9ZREgLdms0hYvgZKATspJZMNGPVISqTDzjBiLcTjA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(261026140227099003)(261026121527099003)(261022075727099003)(261022105027099003)(261028144727099003)(261021121427099003)(261021123027099003)(261102123227099003)(11063799006)(5023799004)(56012099006)(10067099003)(261009223027099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lbHB9L0Op4WBjfGtV2g4p0n/ANViP/OnEhn9jX5bKgV8V2RHaHOHHnld0eV5?=
 =?us-ascii?Q?Ly/zKVXdSb9RtBHBaTVjGKMGgo/hqTI9JguL7cCeO7hDOTgG0uuBUhkknZV1?=
 =?us-ascii?Q?EEtFT6u0gAucsCiHx6cr6rq5AJJjMFBlS3dLS2lL+o2qx3w3zhXJ47a7xWE1?=
 =?us-ascii?Q?MLV3jMDPxZE+E1vqds389TFhPfaqBRuHMrGmdP+1pmf+MKjrYUiW+UyCQ1Ya?=
 =?us-ascii?Q?7OxtMJGjzXWGm2deipeNG5QAwc53HACiRijorexp/f/SqtWHhZT0haoB1yab?=
 =?us-ascii?Q?ONEfHg8Mx7qsGTfhY/8rHYBjGhAWJbyOoQbB6ETz2DlPdiXJ2muGZU0tYXOn?=
 =?us-ascii?Q?yDEjJNooJOOj6lpArGSuTuUOjNNBnjesf2S3xi4F0bezdjeSDaI6wbEosnkV?=
 =?us-ascii?Q?SRrPri8vygZXclKD8bdOYJWmHn9l5wV9LPOlzMr3F8ArWPrgc331Yb4yJuq1?=
 =?us-ascii?Q?dS79rJcdR7227DG6D8BeTOxwg7qdEbxVwoXPUWkdykdE2d4Mwmego1Vlgr3K?=
 =?us-ascii?Q?zRcORbNiuOb9RI2WIKdrmj0w85jIKkmCamajf6P9PwSHtIXZsJaJajoTUCwk?=
 =?us-ascii?Q?lrx/QOvuwqODnCcSJH2uU2PQA/eGI4+Ga0TC2JsisQZeN8BnxHsdDefH/nKd?=
 =?us-ascii?Q?ObdS7jQM9X0w5PLbrIGq3L9axUi4ubIOdiGy6rGnCJXyXT9/zxAWxnyLFYtd?=
 =?us-ascii?Q?v/SBclOGIJPCvTFeSNp55q6Aek9fMK397lrBQZblkETtpA23pwFaZlkl5g0m?=
 =?us-ascii?Q?AJkrHg4Rz3Ba2Y1ygQKCnFtTWjDxf4Ct2Yj25Ocey8QAVOO1tPK0cMmams5q?=
 =?us-ascii?Q?RnAtj7L9jBTw20zj24CwSUvDmmGvPvg7+LViWPbWQVtyr9bkMV+8Q3o6lkHw?=
 =?us-ascii?Q?EbybRKqmWePiQ+q5G0JDU1cbLq5vTFNkb1kakpZt2JZZvnApLKQyB0freInn?=
 =?us-ascii?Q?As5MAWfpeaKdQb+QEuGNvvmTitfCs7eZ4osI1dA10LbVeEUCoZD4ZXXhBdWz?=
 =?us-ascii?Q?RXaCT96b5jcBUnIDI48QEmverJhW5KZoxUoBn6QIE2EcSxFkZlEtjJLiLE+0?=
 =?us-ascii?Q?exnikVSmGapkbSdaAvVOu3CJ76Xe/hmBuNVjYubLGWGqYhN5IBptlRCZCj3b?=
 =?us-ascii?Q?tJT46KAH0bD3IGdqVs4KRbpTh7oWfr2Rlqcu3p4PfXvCgFV7IqY8TF2l+eSx?=
 =?us-ascii?Q?C9xHf12ZRZahVYU64l37gV2kSKTreLhFaR/9ya9js+w7eh1mrTq3F94YxtjY?=
 =?us-ascii?Q?hhbG04FfsDagxlTvYUlXwEByDUEc+Cdg3hk/z7iLTTzOedVdiGlhzO9jHskT?=
 =?us-ascii?Q?i0pTUiVaNXyUW2QtK/aSIeicFj/etJnKtyjlPm9JlEi7yT2mpTSkhDEx+g3y?=
 =?us-ascii?Q?Vnnfn0CWnZ7mH9S+iBQ7iZoDQORrsQ7xmuNE7PpCG1S9D4IG+9s4vniWD2kX?=
 =?us-ascii?Q?Pg7zgoValthJRNDlrHEOLytnV/TJp6vD8c6vF4tmeJs2xA1FgjVHggYfr0wy?=
 =?us-ascii?Q?3iCRdchBGG8C9eNoAUa5OJSVYmchCZGColv8gmI/Oby1mE8s8qV0DE+efvu6?=
 =?us-ascii?Q?rdLDAbXh0eVV0do9xKFts7OT52ImgtAH3Aj9gEsnSOp0SIuDdy5c/d0je36J?=
 =?us-ascii?Q?NhJAEAJxHPVfbvNVU7PAX4NjZIkyMdqUZWrhUrwSlWHiMyaInrzYWaC99C4B?=
 =?us-ascii?Q?fgL3KARWKAXD55ctB0P9TF8KfcXUhwopfJjcqwc+bZ7eAtPsQbbGPP4wJkd6?=
 =?us-ascii?Q?y6SuO1bsGQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c83a093-09e8-46e6-32f2-08df4a0c3e69
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 09:20:56.0339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /LF14bX+tgxJDcWE4FjZLABPT9+TFyQmmPOyWecsWAxiGywgJ7MhCmGjTIOjxHwfsYbvAkICpx1YoOl4eTNWGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR12MB870191

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

