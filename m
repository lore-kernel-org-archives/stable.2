Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.7
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793701971;
	b=b0PshtJFq8RV/h0v06YNslaqsLhb45ruka83FLW0TFLUhQcWKVSpZWvuMAW+K1iPto9r
	 OEqw0P3KAyzEq+W39Zb6JnGtTNQs5BNdzayrscC5KIn3bQ7P3bs+uCM//mtnB2M5v1/Nd
	 N58xsjwtbSniiAdSNhxWLQ/a4hjKan7cKT6wO54cmKD3+ZDwu+xJKfVfO3C3hrW36SYsq
	 fWm2qGBl4EPrFfIlgCZUuzo0sXBe5XvuHf349l+XBLGpEH1U/ykEeIKz5BvZUH4isyKHp
	 a4Mx+7+WIhmDLqv5T6njXk7V+2AhVJ2Py66j6CLCSaaZYD+g7HMHz56HY0S5H44CS/w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701971;
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
	bh=800t1OGlvEfLtVRAqfmW9s9AiAfaXBJju/MHqsg1jEc=;
	b=Sxijbki/0DJCqwtrcytJvfvWHhB/bHSsDSZFIsP01z6Crj+RSIAU76JBPpPqotzqvqVD
	 tYVJm1k4W5yA+7GdNyOYuwVIeOdr4onkHdLTSob5zUILCmZIu4/PlYRd+QSCgsOl1r09m
	 68FZciT8TZJdiWmK54CzTACM0B+nDnXluWMkVHuVBEVaGK25B83ikwj6lh7NxeNQpStMT
	 pY2m7M3zVsFnyRlG1v4u/jjHv7S5tPIB5lMWf0G/VjlWNpuYcx/RPsdL3V+oZ7b/StF6M
	 SyrQ0gianAOknzsCycmm1koaao0SRTfcyQLnILdlklRAnoXg/JIdNmT9qC/t+iux4Ug==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=jxr9BASp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.7
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011007.outbound.protection.outlook.com [52.101.57.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E9E606C573;
	Tue,  3 Nov 2026 10:32:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2E9E606C573
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=jxr9BASp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QOLwOpNKyRvB98RLcFH/zehErZlrjcgWTayA6iBrEm1p3uL5Uy85qS58frFjZbij9tCcNxycFQb/gnkzQFne0stOZgQiWR1eyw6D9xoI8N3Qq1YqK4sRGMrKndILSS+qhG4U7dkO7i3N24MgkGBbRS0Tq/ue5tG/CEWzGep6xOqFf0EuAZEC9mfAiS5u3uV7deaF+JugZ7Z8zrCeoUvVuAQc7U710lTDslas9zchq4beV2Rqr/NtMxlH3mY9nYX/wJg4sL1brTMExDOyyeYgy59Bly+iHJtSDY8YkpJJLqUGiARBSuraMRtZBmJpjDVezjlerr/tHJgpcFsKYtTZAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=800t1OGlvEfLtVRAqfmW9s9AiAfaXBJju/MHqsg1jEc=;
 b=aQd1VVG3qVO4ir6bCPMeCBuiTJIBZ9QFKls9XvUMHYdOgGdNA9ZMEsy9PPg6nuPuoVEKXzyEIWBfWNydRs/G7F6PD8hHVEiIdUQZzAOTMCYVTLeWB8SW88LjdHzXHrr0BcY4GjwZB5m6d5pGTpXwTr37SnBjVZYCt2b5GElbM6rH3e0xA08dFrdWA5RMbYnBL3Yz16l3k9EALwJ7ZfXMIzqMrzPyVcC2tooy1PXeJKlAc9v2FUcQbSzFVohRTu+yaVvOQRKWesm7WFN1YZwx13OAodcOxWKpi80dc830V5hnMNPEIuCYpRljxTohRP+bW4wTvnvNpJduZSA56hEbcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=800t1OGlvEfLtVRAqfmW9s9AiAfaXBJju/MHqsg1jEc=;
 b=jxr9BASpPXzk1tXDwx2+o6kcHpdkx9ZrklPExrZKZ3FQOToMYXV5EdJzLWi594AI35dO0mLYbPFmXLErv4TQxIwY5vz88haGxDrNRlUCm6kvuOnHkCZXdFWStcAGoyZGBFFSpHwlw6Ei8LyTRKZcnjeK/dMNlPtb+/1WV4RwE5BGTbY9ndZn9EktxCgCPqQM52Et24AA3ePlMfZRjfWCc57iJnR01qaz1nAtBu4TIc3hIQABdpGbuMyu/KTFLJhX+crCE1C+eDMr9noAijfcShavHKpSXR/RntJCn+rbFTmQjQQ7YbMRb03zmuYztoA4OZ7Z6GPxqw8QP2WKfN7eJw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by BY5PR12MB4033.namprd12.prod.outlook.com (2603:10b6:a03:213::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 10:32:45 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 10:32:45 +0000
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
Subject: [PATCH v5 2/7] gpiolib: free the label of lines released after their chip was removed
Date: Tue,  3 Nov 2026 12:32:35 +0200
Message-ID: <20261103-gpiolib-chip-removal-v5-2-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261103-gpiolib-chip-removal-v5-0-aambrozewicz@nvidia.com>
References: <20261103-gpiolib-chip-removal-v5-0-aambrozewicz@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MR1P264CA0115.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:50::33) To PH7PR12MB5974.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PH7PR12MB5974:EE_|BY5PR12MB4033:EE_
X-MS-Office365-Filtering-Correlation-Id: 053c9aa8-63b8-4e4b-d895-08df3995ccad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|18002099003|22082099003|261102123227099003|56012099006|11063799006|261022075727099003|261021121427099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	N5UNEV7Z3UQuCHXDx4xnO2QZheRu93gTncfMAZpAbLi3xIhCuDwEY/bYAJmgxVh5j1oLLW9lN/CWVUKkeF2gpDEhCxy5h3MtnzSc4eOIOJ2aCKhYaTUmDwFhiQQ1RWigjidKG8p2FqCTFP50UNpMaLj2vmrBsMyi7GQ42i9coYdfVw6q+vAnKZWEOz8NIIFAqX2dp9CFM/Q7Gpybq2ptzR5q7gjWwof+lHMC/8uYkUkEK5vP6n7y+5PpLzIKjS5Xcydo75P8ewf2iTVtU7mr/yJ00E4gkn1aUgdIfYyZX5H8vhhZgvdxKFpN8qfLlSyLOTTWk1DZtvx1QIIUqpEJakIqS89u6i5kB09eazaWfe6QJfcehEbHn+zuewhr9a5mLlKFGK+cnBKUBEQrTgQ0ay3j0XwbGM0rCPTwUJCinJxeAFSQFwQ+vyKc5VgGCJRQnuUK+WPtPQcF647QiosiDIMzjVZjckpA0oR8OM7sCxJ5suKCSIm7w/9bFQXHS5k4f1bWlxwB0ePmInD+lMx80sRd4LPH8zhF+4svLPtVzdjSz2NfcefrFNlbNEg/cseNwSLj2JdiMk2O/fHxBjI07GgX8jDXM4DSkOPfvDgdBi5DIipdQvmihsQpC0I4UcGa9c7mjk+HjFHUf2uhYUIhzgyN3lTsoDesWWUQ8sPidIA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(18002099003)(22082099003)(261102123227099003)(56012099006)(11063799006)(261022075727099003)(261021121427099003)(261021123027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kej4p+ofsfNsLbQr1ZEHMmVuTw4vZpDN+wXw8x/S+62ZazJKA/VP70RlTVjz?=
 =?us-ascii?Q?J7sQtgNb3/I/Qb7L/TF1OE57PUFyfQkVMOXRyVIwraxzaU70ijJ5puBZkO7Q?=
 =?us-ascii?Q?6pKe2Xnxtn9d4r6i84p9bB1ntB1JhnQFk4NJELRgO0586uw1xm5dRtCJKxvW?=
 =?us-ascii?Q?iDjWOgBw+o2ytpXY/r8S3I+whCzeS/c3sFm8qtb5JLLLO08X0FKdt9yMPQ5U?=
 =?us-ascii?Q?fG0dW0riAxPu6elkU7P2VBiKP3oJ11uffH+QXmXIkVq9L9OCndF4bz703ZtJ?=
 =?us-ascii?Q?e3qsRFOw3oeAGMunTmEvjMhjQuOAvMda5edqkjTU3UPE27KtilUrVZP/y3O+?=
 =?us-ascii?Q?8d70klLjjRadqUxuv5oMNf62WBwzcunJx6j+C27rehrkELlKTTl9O5UX5QaE?=
 =?us-ascii?Q?ceJ58AI7PksFAIZoDJhGQhW5dRMXxjZsfZiQC88o9XcLq8xnVUoEK11WNEDh?=
 =?us-ascii?Q?6CDwsrj5VreGksiNUA4dGmjJ0GD9Dd83UHssF7J0emD8NnOxnb9FUR3wkwFT?=
 =?us-ascii?Q?PyVoAU75+PuAOjsKURBPVR3nkbYe21qiEcsaSFVnnbS7wCdLMa065UsQvXrW?=
 =?us-ascii?Q?KXzzOZX7XDtrsEzbtHVK2cKmH+0pJSSqTjtxnxzKdFqjI/+hYSWSwDxhNAm1?=
 =?us-ascii?Q?//ynhxAwJY5khZ+wL9+7NV8FG7IOtrhb+35vh8F2dRIHdIJdHB8JprCx7AK/?=
 =?us-ascii?Q?o8zolfNN5UJpan6muf5xlqC8bJjdVM6wpxr0iLZK/lBiypN0908F0vP4G0bX?=
 =?us-ascii?Q?c/WHYohtE3V4GoiDGO8cSHVHotXWeCysLEQgORfNVjEI/bn9Tv21bVcXYBPm?=
 =?us-ascii?Q?VrGsRggN6r6cbIbkv0uml4Hzq9X1latAQ4gWcKUTmebgSxZrxrOiNWnnOzI7?=
 =?us-ascii?Q?wCDfXMEKq5t/87Aq35/RFbsYmtX95V0S3ZEOjBTnz+/67ZSCJwj1Ycj1PExC?=
 =?us-ascii?Q?Zx9D1x/0js7Q8Ish7DpJPc4sq8ijrF+KsmG+adr4PFlRxUgDW28ccRyLUMAz?=
 =?us-ascii?Q?T2iR6/Vi8wr/fvoqVdctY671hPLK74akyS85Rts7MIY0oBIDGF21fQfnqCC+?=
 =?us-ascii?Q?72XF/Gc0T1siflAHSJpeJKjNISNlr9OmRoH33fYm8rKhs3mDLPF+IdCWLX5d?=
 =?us-ascii?Q?aeQzTP0PPMsbZNw8scfLbiziNkdTVRLS1lEeWJp9aIFzKlhEAfKub457sxuc?=
 =?us-ascii?Q?AoqQ29dDEHdz8y1D5PVB3mCePJ8fdTshkZ0u9tYwfSfPwfhgHMyENqDlGCiH?=
 =?us-ascii?Q?ozCymKsyfTS1eFt9dgcm/bl1BriPq30DAmtmlu9Z8byK4DbHDnMuwdaD3lMu?=
 =?us-ascii?Q?JO40KU6Gd/gegupfWIWTm/EHHXiBQktKqHQDHlYh21p+DUZ0+d/lFSry/0+Q?=
 =?us-ascii?Q?jnUM6AENh7kTa5EphZ+HjLXlO2rb6jQLC5fvryfm0H/Z02OyhY6iM1xe3r1w?=
 =?us-ascii?Q?8R88A8vp9QNXTEbtgjKJG1BrdYuHFf5tt8ITh2AR7SSCu9WSke3O2lKsTS8F?=
 =?us-ascii?Q?2JgpQzthM15YHbq+5k9mqxLm8Wz5FNMw89zuwNt/IRLhvwIV4Yf7LKn6OP1u?=
 =?us-ascii?Q?dAUx+I1O23e24RYlofGwznLOZ2WeRcMTiZ5VDWufkOJcrLr+aRChSVB7xmjm?=
 =?us-ascii?Q?dK7mJFkkCIS4HtRZ6bchGbGNktEyqqN3Fmk4rBrCWaAz397q9L1cmIqsZRhR?=
 =?us-ascii?Q?paVVNB5oI1EtoD2h9VMOgIhy1HPfyVLvA3L/spuT6+xbRNcOLPtKJwVdPezD?=
 =?us-ascii?Q?TzTfhBmM7w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 053c9aa8-63b8-4e4b-d895-08df3995ccad
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 10:32:45.8940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AhOY9q2pzVrxh8i5GYJyJ8ORaRRoHOZrZDD3ITsq6emXmDE0jST58SXkvHhMYtPT14PqtE7W23YyGwNN3Q++1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4033

gpiod_free_commit() drops the consumer label only while the chip is
still there. A line that user space keeps requested across
gpiochip_remove() is released when gdev->chip is already NULL, and its
label leaks:

  unreferenced object (size 32):
    comm "gpio-hold"
    backtrace (crc 7ff222d9):
      desc_set_label
      gpiod_request_commit
      gpiod_request
      linereq_create
      gpio_ioctl

Clear the label before the chip check. The ->free() callback, the flags
update and the line state notification need the chip and stay under it.

Reproduced with gpio-sim: request a line, set the chip's "live"
attribute to 0, then close the request. kmemleak reports up to 30 such
objects after 30 cycles; with this change, none after 100.

Fixes: 35b545332b80 ("gpio: remove gpio_lock")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
---
 drivers/gpio/gpiolib.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 0439e016f246..ec5f81f4fd9e 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2690,7 +2690,12 @@ void gpiod_free_commit(struct gpio_desc *desc)
 
 	flags = READ_ONCE(desc->flags);
 
-	if (guard.gc && test_bit(GPIOD_FLAG_REQUESTED, &flags)) {
+	if (guard.gc && !test_bit(GPIOD_FLAG_REQUESTED, &flags))
+		return;
+
+	desc_set_label(desc, NULL);
+
+	if (guard.gc) {
 		if (guard.gc->free)
 			guard.gc->free(guard.gc, gpiod_hwgpio(desc));
 
@@ -2709,7 +2714,6 @@ void gpiod_free_commit(struct gpio_desc *desc)
 #ifdef CONFIG_OF_DYNAMIC
 		WRITE_ONCE(desc->hog, NULL);
 #endif
-		desc_set_label(desc, NULL);
 		WRITE_ONCE(desc->flags, flags);
 #ifdef CONFIG_GPIO_CDEV
 		WRITE_ONCE(desc->debounce_period_us, 0);
-- 
2.43.0

