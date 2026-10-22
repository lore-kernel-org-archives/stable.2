Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.31
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792658035;
	b=hoPb3NtebmFLCiKqiYK0khr6Mc0RX/DigA+577DF8g8nPTknfRYvYgCN9jSDDRB0vCT9
	 2S/Xscm3Pwg+iJ6X0B96QVuoJenR7IlAmIzA+nqqKBPabOU1CCHXlcBbkw7yQiBYYErch
	 TrfDkCNHSXKk2E3csWPbLuTS72kZAi9yg7GxzFeZEYjS51Yril0r3iqoetAiMnJxhvSmk
	 6pM//oiZHhjHwUvb91bun0NnaM5QagR0FLnnrSoxRZXTPy/WGGuBbTdMl3aft0pVRuV/d
	 RbWIlcBrdQUjVL3gP4kdMlJ9FK2RYGiFwCRLLVBG2HK3oNoGicxRUHWMXsBRqelx9fw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792658035;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=1TWPbr2p5fM3AWnNnJS0EAN17l9S5AMf53Pme49pOJM=;
	b=Hj5MWfGsiF0kq6LP7p6Y4ljxcA6BH4DqtOcI583lFGRuMP4Iz5OEUb96z1/+HcqGRcDc
	 NrG4wqk/8XuNk9ENf4CSqd7xIZuv35IPNZf4nNbl6sJeFluUNwAQkmLowrXq6KJt/WW4U
	 HsMW068jI9htkDmGLtaZ9+nMl+s6pZ5SPXiwLReH/vFEXxbYBvtmEopuqreP35Ut0VI1f
	 M0nCFT5P4VNk3BZPIi0SLD9RD3RzIGJqCKINPoKjbQYTp0CPRThw7eHkirxnUWRjBIYqz
	 qyTlrgIdLVeE6Qy5Dbqo/VHtPvvD19wfuFy/u1GdARwjo3VL+dWVZUFUFv7J9ZUilsg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=XWfoq5+z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.31
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012031.outbound.protection.outlook.com [52.101.48.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973B3606A319;
	Thu, 22 Oct 2026 08:33:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 973B3606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=XWfoq5+z
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=idNDOqkY+V6b8x/ipQKAsvPOh4GUM3u9OzN8OOaagAuMnLZw1pmp8/Tg4kT1uk4emI4ebtLtF6sElow5Las9ZEKDZFvZRzIBIq441XQPPwDbXN3HIUao3xfLLElqnGUxc9YkhzH6YzPLH9dvQynrWcD/937E+InBnvIDl97GHFzn3Xz5xU0VQPoCcEehdHDmQ/Z8OI2cVx8YctDE1Uae61hJyP2QINDyoM0fifkeutQv4x4Dcpvbt8fe6THOEC2SahClkxp/YtyF/EtpAd/BefPFFpvzRY+37M+2GeSvKW8u1rQqT4yhrcQ5i5KL0Zel/EPUlyc28o79Lo5dtAc+iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1TWPbr2p5fM3AWnNnJS0EAN17l9S5AMf53Pme49pOJM=;
 b=JsZhpc5aEaw77/DISmRnj6/DnSZ3koT66gWquPophmooGbo1z3NMw9si1DfwtgW9b12qJPB/n8m+TOiy+gHUxSV10o8FRbvK1hJuEHyAlw+FrDbSN/vY+2ic+gpY+gzPtZJ04ElC5r0BaiZ4Jkxy2XdbzGsa8ledYCUWahzfaNuvbpEszPUKAILbIGhPZkuvIIGxIwkUBRq81KMXYaBkM9iyi+dTakyn674ZVpyBErg/taToxi0tcZUvceCACkuJKkA8jng4Mbm1+fC+L1UfwFszrcNbV9aeLOEUWTcFVXguDv64LYhk3cjBBD2Z4q4EXXgS6efY3zmtMyORvKOh9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1TWPbr2p5fM3AWnNnJS0EAN17l9S5AMf53Pme49pOJM=;
 b=XWfoq5+zn7RHJrEB/SDOWukYFlmCusd1cfeLyBmdg5g16C3UZi9qQPoFSDDAkGCTFAndIhJc+nKow7lSOI1yFQ2qqx9GXahqRlZ0FvxEX+ciCWwiUDKUp9QwbnsKRQVR/Bd/CAQNr3CY6S1MDoQXNbxL1jA2cyk1I2JVb6ttmA+3FMig/f0vvQ2+BxaIYPmCWV/abqGieHN6c4bfi4u+E1HW25PJQJOyw63rtiNcrqrVVUc9DL8RFs4GrKKTZwzLhNpIXyDmegQIVOozD/586ynnBysGXLLJnYV4uM25XWLAQsSdIHQ/4sYbxIK9ccOHbvCqJR/4T9w8+ienyRuxYQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by DS5PPF5C5D42165.namprd12.prod.outlook.com (2603:10b6:f:fc00::64f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 08:33:49 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0546.016; Thu, 22 Oct 2026
 08:33:48 +0000
From: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
	Linus Walleij <linusw@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH] gpiolib: don't report -ENOMEM for a requested line without a label
Date: Thu, 22 Oct 2026 11:33:44 +0300
Message-ID: <20261022083343.3905973-3-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0090.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:65::14) To PH7PR12MB5974.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PH7PR12MB5974:EE_|DS5PPF5C5D42165:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cda377d-5301-4160-abc5-08df30173167
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|11063799006|261021121427099003|56012099006|261009223027099003|10067099003|18002099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	W6oBSKLcOEnsyntbYWNsocXalr2RYFdJdJttCUOojUa7F3ybfKSRMMnq5VtviRd/4+l85UOhK4GVfUB+Tndb8dagcdB/k7DjpbGlWnACYg/e4Ltqqs/OM5r32KDTbmERayeS/X2D2mVP2EbTl5NzWQxpDJIMvR3bPdaS+bXIuTUrr7JtcvZ7E0VEWv9jvkhAkncWX9PXMH8/QSxW0N/LbzDPLF4UtKvgZSFnhYyBc0cQuiF0o9uplRcY3x5bW3IHztMyUjjDUmIQJQU3zGxJlAeJkiM8gF1bCjr/Q/gCNJtRDXk8OmtPnl7sA5a+ATFs7rkx/a4pgS9t83BWNO+wumPa85yYGrLfj7kvgdPg5jswlJs3FvOvHtfELn04vnZ9wXeid2rDmZKERRUGV0MWoR6BDJ13QtjOF501mOekG84EzZcnCKoyKvt4H7RtezCPw61MXy6asIj/O6ibv7T5S7RenJCgEAiYuGHw64fN+AwjagNdka8I8HGcmUcK8GEkd9yDFL8m9IZWqAx1NErT1my/oAqnPcDqkUgIK9tVAzBWvQbzqGBYHT/sujssrhpCKBfJac+GKj9htgrGIZifgC9g9InYG7ra2tp5aLBHVnUQRh1HK5hHTcHXeNh24F+qz3M10zGF91AqVUpB0gjYbIjPHgKNWFnoo6x07Mpt0kc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(11063799006)(261021121427099003)(56012099006)(261009223027099003)(10067099003)(18002099003)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?We3BOpetbjpb6XjnsLVl4zWG2OaH4L6jNJBzApU3RDdQ3zB67xAUwgTyofdN?=
 =?us-ascii?Q?eW55NqFQiYFfxpfxevPo7xNrUV+esIDc2gBAO8cxrH5Y+0LrOJIRzHtB9y26?=
 =?us-ascii?Q?NgurzPZPP3gHEQMIf4UsE+ru71IFFq1a8kZnXTdIHmyZt4Z4ezfFsNbTYR8i?=
 =?us-ascii?Q?Ime60TsaQNPByY/RSOkP3t5/417L2+Vr3n06ahqYIPw7QIEX6APPZ3Pf5cPo?=
 =?us-ascii?Q?anKrXMsOVwAP1rrXGxJZcENPHBIw88DI+IpFCWvxvYZy+uBxWRW/xdQV7ffK?=
 =?us-ascii?Q?3le/0r9IxEkUMDYZo1KZFynHHgVMP2VREjTNgDou48eH2MN6bephS3SBRahf?=
 =?us-ascii?Q?xP5mVbgUfwNqBBYDMqtlwzgh6GicbIXeJL4ALcibQi+izRiU9JoiepOgCFYU?=
 =?us-ascii?Q?E5KCnAg8qOL5cCtoVN9jf7CNLq6GYLhGQb4jRG0NBDWaqwGm2DgaJh0KWM5d?=
 =?us-ascii?Q?UQ8atoO7MU5ryCmuu0naAyblMM7aJYmNb8qiby1nHdnyJn5HVDOuWCTyL9YH?=
 =?us-ascii?Q?rGQtllF8TK56MZ4008slBf0BtIqfmJ2x/bKodyN/MZxMHz8Z+HxkzG4GXkNk?=
 =?us-ascii?Q?XduvQsB9WXUHOHZcUJ10jB73x/VKW4O/8ccJsljwC5JcYAqMffSqPANLDpV0?=
 =?us-ascii?Q?E0AgjzfyqY3WPw45Cs3CQV1kz9a0tiKILTPt56lPT0NjXSNVyWk45EPuDl3V?=
 =?us-ascii?Q?A12RJvh4frjo86KdVY3v54CThBQr30cxcKym0CZ20qQ8/YBSEZzdyuBr8iUQ?=
 =?us-ascii?Q?UUpKq7HS/3TDn7Cf0oDwBOLcsc+dQzs7zrz2Hi1LApg3lKPDBz4ts+MyeWTu?=
 =?us-ascii?Q?w8hIIXooCiSIe8reKulOfNUTKs+aWx1czMumvGTqTyjlMQnjARoJBwMICLxU?=
 =?us-ascii?Q?JPyvKOMBAYOLU73LJjnxy0doEF911qkkHCjzGZBWbpvYUdsakzs8RjAm4IDs?=
 =?us-ascii?Q?LwmCVHxjHmMHONev/uCxwCtKDfPi+q5IWeu5XyVtDo8yxw+LrH9adY0J34AA?=
 =?us-ascii?Q?bSROD7nst1+l2F9bOpIOM1y6bEH5GzvRvoeZPbvmoX8z4arIKMKa+PeJxOAs?=
 =?us-ascii?Q?L4ulgxnuv7qRgmuIPAyl932SNpTnZ4XVy4hU2RBAW7NEAFE0Wb3TafF87/jb?=
 =?us-ascii?Q?6/mjFny+AgHARg2P3I9AQS/UDoa1NRR0Dckk48IUP9Ptvd4hIP5OXiM+8j/r?=
 =?us-ascii?Q?1YOAfouEYf3dDBIb93orh+dOp8lR/N4slKwanWu4loTdnsHOJQQtXKsm5LQ/?=
 =?us-ascii?Q?nQZ9YLxlFFYZKSm/V4dsyqnW0w32a4EqUEPzjTKauFETXny6BQToJqWGTZby?=
 =?us-ascii?Q?smD173/hvnKX9E8qeuEnY48Ka4Lf9VPmQ91vNONABs+902pgXDAgI1TlqbGc?=
 =?us-ascii?Q?pZC0ARgSlvswvSTlPrsNOa9rf7yohTIUGVvMBMva7ObWgq6PfTAJulf6czmy?=
 =?us-ascii?Q?vTrePpn8c4aOBmv7pSEd0m7moGnZSa/7kVtKmD3fFs8++K4IkjVAyHGtJV+l?=
 =?us-ascii?Q?JtLetLdrnCYjBT4LrcPl7hZ9ejJGZEwguIMxiFvA8NFb3mNIsncj/BLW3quH?=
 =?us-ascii?Q?aacmpk67RKmyyuCKA3Wi9dk/hoCgFq2qc5QC+Aax/NXkQb6fjRmRmf8/dhvq?=
 =?us-ascii?Q?ILWe4UG17NnmvUGkZMPzMxGlf5tQBV1XyG1rM/DrXS3CnfR5zVwaCWahg3vh?=
 =?us-ascii?Q?IiwVbZomS8VT8rFea9a+hltzZb/hebgDOfkJvtYQXhkJRcx8fJi0HW9skbIy?=
 =?us-ascii?Q?FSUg2S3YXw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cda377d-5301-4160-abc5-08df30173167
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 08:33:48.3841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Ov3qOXWZDDUQ5qLgqyfqlF8Gh4pt4Y+ml5WXxyfqUSIhVRyignnH2OrWiR7nbFB8QPhUD23GXg3i575u1dJPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF5C5D42165

gpiod_request_commit() sets GPIOD_FLAG_REQUESTED, calls ->request() and
only then sets the label. A line in between has no label, so
gpiochip_dup_line_label() passes NULL to kstrdup() and returns
ERR_PTR(-ENOMEM), which for_each_hwgpio() then passes to kfree():

  BUG: unable to handle page fault for address: ffcc73074355ffc8
  Call Trace:
   gpio_sim_dbg_show
   gpiolib_seq_show
   seq_read_iter

Return NULL for such a line, as for an unrequested one.

Reproduced with gpio-sim: reading /sys/kernel/debug/gpio in a loop while
lines are requested and released oopses within seconds; with this
change, 100000 cycles pass.

Fixes: 35b545332b80 ("gpio: remove gpio_lock")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20261020-gpiolib-chip-removal-v3-0-aambrozewicz@nvidia.com?part=2
Assisted-by: LLM
Signed-off-by: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
---
 drivers/gpio/gpiolib.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 1438f97d0634..9c05d36ccd74 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2721,6 +2721,7 @@ void gpiod_free(struct gpio_desc *desc)
 char *gpiochip_dup_line_label(struct gpio_chip *gc, unsigned int offset)
 {
 	struct gpio_desc *desc;
+	const char *name;
 	char *label;
 
 	desc = gpiochip_get_desc(gc, offset);
@@ -2732,7 +2733,11 @@ char *gpiochip_dup_line_label(struct gpio_chip *gc, unsigned int offset)
 
 	guard(srcu)(&desc->gdev->desc_srcu);
 
-	label = kstrdup(gpiod_get_label(desc), GFP_KERNEL);
+	name = gpiod_get_label(desc);
+	if (!name)
+		return NULL;
+
+	label = kstrdup(name, GFP_KERNEL);
 	if (!label)
 		return ERR_PTR(-ENOMEM);
 

base-commit: a0fe269293509acdd93b9cfb3f46636f7b91b33a
-- 
2.43.0

