Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795162474;
	b=sKyzAPZqyCQ7lv5eCl+AfohZDLYli3i+44suiyyu2KQkgNV/vctNgRZYWGHSW3nfbn2e
	 KQqG7Q6TupUYJ3k50a1TqfxpqRKp6lfKhfnothbQsBtd88YbQV0JZvgekj6Bh98cDoX1e
	 jJEJnEBhq7Gs0vOuO1wIe3je6i5KCVOVA6/RM54g/NKNUScxVAOsB3RwvBHlRuMZKz0er
	 aJuhDNoQ3La+X3I2bN2GIrNgQtd2dhKVs/wLETnp/O1QYxNrrNCLg9PqI/erIfZkQbf4U
	 BMZoyue4KpafuiAXROESMWyXutfa98UbD3yIABgkyyomGbFU8pWo31cK1Ha3Tcd6y/w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795162474;
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
	bh=qkBrPmFCprGgxvY5g/eOr+XGGjR7A66exCKX5wtywwo=;
	b=PGOptY8jOZsnOtCsiwdCPRyASDucvzXlnLEE0svnFrj/Q+5ic1oJ7IIYciKSUO6RNZ2m
	 8yAq13a8900XFwmssy6pjo8AeVmUenzK/rTYx68bWORIchs85v1P4NSonN+6daEdekUCK
	 oq4rcJ+V74bxFTJG5ari/F0qd5COv/iL1J50LaP3TvuOQ38XDlcUKubl3Cz4cpii20R0r
	 2SIQCX/xQNQSAkKtIvi58anYu15VrQ1q2wmW3OK0sK2x/WewFUGDK+W6WIS8aL1ra44lr
	 u4StTG8lCInftv+1quNVXoO4X6u0pCro8bJMS+RycW2EP86vpLUnLppRutq47hXIYNg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Lxjsz1qg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.17
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010017.outbound.protection.outlook.com [52.101.85.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A4260A2603;
	Fri, 20 Nov 2026 08:14:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07A4260A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Lxjsz1qg
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gWEIL3bfcgEgFQGyuUnloWFiYAuvAknZ01BgCQTCwmSTbfGr1+7xc2jNgs+Rvemtd2y3o9Tg94xUZTmQh/nF7JF6y8xmokL0VyXmmn00GDTDdFwDuivBtsSSVJ6Mwq425ARM/0VvUnZZ7PciOjUxOfMgsZNQCyZzobgYeInZjM3ZcOb+U6wTXwu6UuzZPINtK6vPHFDcYCcMxB205LTVfuF6p2QSTO4f5FnFG3+ZwnxZeZuQJyP4ots1QseK06R0iuK0ZJsrBJaSqII5CJlutOZw27X5n4OCCZSDGmamwKaDzf5Xo3dNlKUfde+WC+wD9ff7XzSFeCMBiLSf6D1kyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qkBrPmFCprGgxvY5g/eOr+XGGjR7A66exCKX5wtywwo=;
 b=nCQ9CZAzF54rxXzsOzO53KGE9a1ysgTSP5sXp0EobmDrmJDuQYUowvAvFpwrUj83WI5LMo+6jgqsxuFebxbdGKC6qV5o8dZ4SbOSH1wEXLWWdnkwYBVV6dJ3kj7h8qIJ46/Nez4zG22CfPkUse6IyF+e9cnFLQoVVMJqFjVxfCEz4A90LuI9V9gL+ajmIqvgH0Gvw2SEkZREcwygSeWurpDYd3BeSRWiSkqSHhsn83ntRw0PWSYLh0lsawfAUGe3b6BzUzxe7ltSLZ6yZp1cdQbTtMnpEXY4hL1gdIzeMNjGBLFCkWHx63RTCv0jM1h17xQEk2jnOzv9gFYhOBFN8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qkBrPmFCprGgxvY5g/eOr+XGGjR7A66exCKX5wtywwo=;
 b=Lxjsz1qgVcE9s2EtYrBDApKPQp9rf0JpQp+wSS5eUl8ANnJD6+/stkPzSeEYNXApg7fJDGiIh7XBVwLupJy82+rDUUdeyjIhIa4G8v7cCj4PrzNmYihubv2XrCw0jSGjvbCkGArlwDwnJAlKyybhucUomZLv11RPUugSnTJbAu67+8qVTIBP45qX5F54R3BZXQoq3CvpSkI8D3CASFxMV4K/WPU2S+6tmaDchS0756H8oXmlMH+KsOd0JnYo2GIyqC8m5/llDLNO1FnPspj6LUDJjTa/vtlLALOO5rDzMGhTgbuHyyhRZyIvVF+MIlLJq/9aCnuAhhOLCwtJ96NOrQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by PH7PR12MB7818.namprd12.prod.outlook.com (2603:10b6:510:269::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 08:14:26 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 08:14:26 +0000
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
	stable@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v7 6/8] gpiolib: cdev: don't report a failed line read as an edge
Date: Fri, 20 Nov 2026 10:13:58 +0200
Message-ID: <20261120-gpiolib-chip-removal-v7-6-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261120-gpiolib-chip-removal-v7-0-aambrozewicz@nvidia.com>
References: <20261120-gpiolib-chip-removal-v7-0-aambrozewicz@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0021.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::15) To PH7PR12MB5974.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 35734d53-b445-49ae-61c0-08df46de4b15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|11063799006|261026140227099003|261021123027099003|261009223027099003|261021121427099003|261102123227099003|10067099003|261026121527099003|261022105027099003|56012099006|261028144727099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	gHG548XjM5iG+lkWSOhnbvNEz8Fkekirv/qXUs/eLUU1uPQ8Fm5sF2lbn6NLbYZeD/Ar7c//sZW1EncoNOORzLXREdq5cOyn0w61yPnLkYn+/i9XctxTj+z2ypnZQKqKZJijVHGBh7M0I/YEKFbnLlPt6ROhvwfFGAm6jZERY9PSKZyqRvvPL/Z7TTnsRiHwZtx1n2UaKt3QwfBtcOgVTansHwPqQe3EQIZRuK/ROOlytWrDBsY4q0hGuHjFSq2pEYlEfpjHE3Tb7m+0ZSO3FhJJVNF7jQU6MBa9RsStKFqBdeuwPVyWuMvISoBsLPIvneEYMJyR4RKbcyRcZVACpPCGDoVDJMBs6pBirD/FsyypedcvCt1lM6c9FBzl9XbNGyTYUmGG7cOpQivVVd88nxBOGYqwLT4Bx2+mEZAorWOEu8DNRzHfCjob86w4it0sCi8pE9JdklyKAc64u9KScG5aD+FF1xqxXU69zNMBsIvkQz63TSjfSgnHHRaFze66ii0s1o8RXN1UDZpuL4Au2EBPRTLoZhJxFihDvUceXgTE0zbCkdExO7tZn2jCKLxsCuGR31fY9crQBxdhi94NCVcPxKwRtGKcMgbwKsuUTz1UYbs04u4krTpQu7mVyLzwoJGQjMUWyd5MN11ob29aMX4VSJp1wfXN+x7qTvkFWys=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(11063799006)(261026140227099003)(261021123027099003)(261009223027099003)(261021121427099003)(261102123227099003)(10067099003)(261026121527099003)(261022105027099003)(56012099006)(261028144727099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dpbl0Drehvtjc5yWs5VexZ1q5igq1Y8NWTHnCTmYPznSV7adqgqKw3sEsZnw?=
 =?us-ascii?Q?BPg8VWbKuXD36IWZSgIU+SKgAwnuZ2R+ZBrGUKFtQWFUnbhAVT/tDGbqHM0M?=
 =?us-ascii?Q?jfIq48qVS1fsbrKXt4+EBBiVY8tO4u+sImLG8C0D2l4tZvKGbzdIedDSZJqX?=
 =?us-ascii?Q?q5TDLxlsUCOMYukjB9XN3QswDOO7vF+mJSiIyldGcjZUg5EFBFtj8Di50xzQ?=
 =?us-ascii?Q?lbX5QV8JMZLf/ovkn6/UCtFGKLFsDP407gd2/SabzF9pEdQarUUY50oB+Vs6?=
 =?us-ascii?Q?cT4EZGIEXR/6DcrJrtFAfqXw4jsTf7D8MPw4b3JFam9Fw+84/EcEXIV0hOwT?=
 =?us-ascii?Q?vUsZzbIUJ8XiJjp42oiqlVRMgDvHQ4Tuzhc0l6ZUbGLDQTJxqeXOdtIz+LK5?=
 =?us-ascii?Q?YEgX5YRU8k6oYn7mPKkBwvIo2CjDyWHVvhpH2FDm1NMte7uS4RAjUKMhrt2f?=
 =?us-ascii?Q?Xf8gDCHrO9sHZd638FpMW6c+VXSd9vEHELhxYotSCEXNx7lbJ4IejktbJ0oR?=
 =?us-ascii?Q?pv+ZhVJWhYW4j19/WgFg/ZpwqpwD9gK7OKV3Km6Bt1QogbHmQ+v3wEf9j0+V?=
 =?us-ascii?Q?2IuCtY9coYe8FdWmg5AFfOjKFhvWcMU8yI+zXAydoU24em0HyslCUcrPq65S?=
 =?us-ascii?Q?YUxaLDh9f9wYKzJj6XJb/nd1+UUi4X6ehd0peLt4utonDOs7lXAoRe9LSy0z?=
 =?us-ascii?Q?uyKCPKoYQnKS0OPPMpeSvz/+5XhFG7om0GDJUxOOD5fqRyvemit/ALG0MPHP?=
 =?us-ascii?Q?ApkqviiRARTltfiTM5pAgyaFPu/6qgfJPk6rcy2YaEwenZAexA/TgNRfdtUO?=
 =?us-ascii?Q?pzorN4tSND7yWse3BTCA8yIU9mBOW6KFNYZlJS0CwOmBLVag/JDCKplnQg1b?=
 =?us-ascii?Q?Cp29WrcHPeNafAvTkjE/UFznJvsCWxK4Xdfj/rxlBlHo5ohUovvYRaACgP2N?=
 =?us-ascii?Q?HZzGy/dxdczggrzU/UTCPGOEOhEvSt2a1rLBqkMZHce1ieWnA36BmnTjJePQ?=
 =?us-ascii?Q?8oFqVCnIVLK2kl2kc+jyl31PHsD9mP2rDe2usJgu/bKNBrOQ7IqLplkfKBUu?=
 =?us-ascii?Q?hQ8hUeTI+VK57LlThxB+dbjyCTzqAyvrLxntkmg6jrx+G1alr6MbVuxVHWa+?=
 =?us-ascii?Q?wT2TRCM7D+GCNQY9tnNBXpE5bpDOzqSa/ZvOEr1cBbzffc8e/bTYD3/2TtPh?=
 =?us-ascii?Q?Z77YBfzQNmMOE5q4r0NqZZFFdTuBwb5AFKzt6LEBy5+I3/mRW1ZkLuq4Llmh?=
 =?us-ascii?Q?0rlQ7HP5v9ZQGxnMfLipOuGO5EB1UPLNZRaVJwnE85voBGBanytvauKYPcOU?=
 =?us-ascii?Q?ee26Ix4Io0szJY673YqMDgNy2V2X6WYFb9SHUq9dHXrArkBl89usyQaj8EFJ?=
 =?us-ascii?Q?JGelWrV0i5VQ5PxJqxbNQJbWeG2+/HDFGvdGlKU4HnlD6cuu8fU58Mpfp9jM?=
 =?us-ascii?Q?ezL7QVWhgx//Ak8co5DRCMc0P9cqnywR3xxAXymkJPKqGyuuY61zZh0bQ2QC?=
 =?us-ascii?Q?Q6+foy32ctIraToZseitqh12MIDJXMZam7Xbo8qs39GvwL4mhteffiq+G+Ox?=
 =?us-ascii?Q?R17pc2TTLBiNxZoVIlivlKZlUvg3Z6lk0HAcVPHzKM2m58dKOQDYdjG8gbVv?=
 =?us-ascii?Q?gU2J6LiS+Hi/41UsUUJ6cbxevvxXDDhHnoz7db2c/6i7n/UzzYl55/QCAesf?=
 =?us-ascii?Q?UeEQMP1rHVYYUXfemKEIDcD16bLR2QXnK+MculkZDaYSEjB67omVtwxinMQ4?=
 =?us-ascii?Q?JJIaOF7Yag=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35734d53-b445-49ae-61c0-08df46de4b15
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 08:14:26.7140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0bgfoqxm40axTVrZrzJG7T8FrTuqGOL5AuAu46Us2ViSWzEreskZ+/syKq4ULm8DxM1xkQkox4MwAmOzEzkFuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7818

With both edges requested, the IRQ threads read the line to tell a
rising edge from a falling one, and treat an error as a high level.

The read fails when the chip is gone. A driver's ->get() returns an
error once its device stops answering: pcf857x when the I2C transfer
fails, dln2 when the USB adapter is unplugged. Since gdev->chip became
SRCU-protected, the read also returns -ENODEV between gpiochip_remove()
and the IRQ being freed.

Drop the event when the read fails, as debounce_work_func() does.

Tested with gpio-sim removal (test delay in the IRQ threads) and a
test chip whose ->get() returns -EIO: both reported a rising edge, none
with this change. The HTE path was compile-tested.

Fixes: 61f922db7221 ("gpio: userspace ABI for reading GPIO line events")
Fixes: d83cee3d2bb1 ("gpio: protect the pointer to gpio_chip in gpio_device with SRCU")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20261020-gpiolib-chip-removal-v3-0-aambrozewicz@nvidia.com?part=6
Reviewed-by: Kent Gibson <warthog618@gmail.com>
Signed-off-by: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
---
 drivers/gpio/gpiolib-cdev.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index fdcd315e776b..d829f7d00b5e 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -644,6 +644,8 @@ static enum hte_return process_hw_ts_thread(void *p)
 		level = (line->raw_level >= 0) ?
 				line->raw_level :
 				gpiod_get_raw_value_cansleep(line->desc);
+		if (level < 0)
+			return HTE_CB_HANDLED;
 
 		if (edflags & GPIO_V2_LINE_FLAG_ACTIVE_LOW)
 			level = !level;
@@ -746,6 +748,7 @@ static irqreturn_t edge_irq_thread(int irq, void *p)
 	struct line *line = p;
 	struct linereq *lr = line->req;
 	struct gpio_v2_line_event le;
+	int level;
 
 	/* Do not leak kernel stack to userspace */
 	memset(&le, 0, sizeof(le));
@@ -766,7 +769,10 @@ static irqreturn_t edge_irq_thread(int irq, void *p)
 
 	switch (READ_ONCE(line->edflags) & GPIO_V2_LINE_EDGE_FLAGS) {
 	case GPIO_V2_LINE_FLAG_EDGE_BOTH:
-		le.id = line_event_id(gpiod_get_value_cansleep(line->desc));
+		level = gpiod_get_value_cansleep(line->desc);
+		if (level < 0)
+			return IRQ_HANDLED;
+		le.id = line_event_id(level);
 		break;
 	case GPIO_V2_LINE_FLAG_EDGE_RISING:
 		le.id = GPIO_V2_LINE_EVENT_RISING_EDGE;
@@ -2007,6 +2013,8 @@ static irqreturn_t lineevent_irq_thread(int irq, void *p)
 	    && le->eflags & GPIOEVENT_REQUEST_FALLING_EDGE) {
 		int level = gpiod_get_value_cansleep(le->desc);
 
+		if (level < 0)
+			return IRQ_HANDLED;
 		if (level)
 			/* Emit low-to-high event */
 			ge.id = GPIOEVENT_EVENT_RISING_EDGE;
-- 
2.43.0

