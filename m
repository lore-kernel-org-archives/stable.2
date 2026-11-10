Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794291201;
	b=M4XRpIqekSISXMhA71RS4WrgzLA4QUZUJaWeV1w07tLrLIVcv5985cjXqqeAHwdtzXG2
	 mvCsAzPxFfCG1u4gHTcPuQIftx9H3FSopv3N4HuZbfRytphB4iY0O0hcCLxq9wXe+iaAU
	 28i5hOOXWtFM3DQLoZqEEfWwEsqznD2TwDFtdilCaa7lhWiZC0ZhrssSb8GfVRZFPuH78
	 PqAfjxqK5yIGAp04gzDKBztntecp7iWLcXcfA3SFp7WaAeVp39/+bkFNky9ldrNVfPWZq
	 jgBlrM2Hol7YJYXzgym0KYE2Dcxw67XT2Ul5XR/T+H+b/ImAjkUj6mTucLjkYQu4BTQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794291201;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
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
	bh=uC2O0if5aVvrQyaB7WZXojwMOYPDZ6A/75P1cR/Dfzs=;
	b=L5L9VrKJnWmMR8aREoLxUSi+wHaQJ5wn/lR4lEjjjcZryhqtNoSdq6+a60pPR60rGftM
	 vvSOGE75cBItLkVqz5yT9XHWyk3YJdnNDEfIEwSepwUiuKQuvMBHP2CJnwNFGDErhlF/m
	 NdLPFN0X+MbFye3UE63MlTxDlM6Z0Qv0nb4PeAWBuI6YmJuoCwZTrh5LH+ijTVUqdCnjV
	 yAk0455cXM3jMikdvNyW1lDofjQroIokbYOU7VJiXf25dqHWPQXMBptc0C7KSNGyur9ad
	 1gevs8UfIlWNFwBwfvV1Bm8tZ+zgQFsal3yyICNbX8AJk9SbwNqPVG4FgoJXz0Ov02g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=altera.com;
	spf=pass smtp.mailfrom=altera.com;
	dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=Y9UGuA9w;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.41
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012041.outbound.protection.outlook.com [52.101.48.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2C4606A32A;
	Tue, 10 Nov 2026 06:13:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B2C4606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=Y9UGuA9w
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NYNLY2M7ok8njUG3ns9kplfc2U2dTSrdjIKWkJAceibLHK7YJAsaAwfAFZwh+n9MLrmnTcpEhRM1He9zG1MRkJPCsY1QvJxCNiN2pYfFl2SHZdP9azjb57yHFAVXgMBGVb434LdLwCuDf1PM+xQp9qL0mxIJEO2lBXM0LqrXO38/VcL0LqeDi+fl5/qEn9AWhBChla9sGkSFs35AI7aDPBGdbQ68pZa9fjInrhjxpSkW0QgJT+DI+jWeAPrIAVbTOJpC0OQJK05SKfSDSrcrdCGjR2y/A4YATbSE/LRG21u9w/EAS/IZ1hfj1aU5mO5rqOZIYIB64wX7DlkIxNi79Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uC2O0if5aVvrQyaB7WZXojwMOYPDZ6A/75P1cR/Dfzs=;
 b=i0wkqRzn5hAA4/A8R0i9g7cHuPPuRg5kiDFXql5lr+1fFu46NoVUNdLDblV/KUxDNyGWv6MbAZwWKLPsaTNrvNEj9LZCwUEo9xmSONnvXXdovgYKu+B6Xh/X84ZE121CZJ0ItTjyPMP91Ecs/7QJFWI4bQFvVGsGeHYxBks+rguUPmoImZpbQK1QHAlM/L3PMrgnTCkXM7qDdMAkq3emBatdNUUvJtq/aUsqeHC2hmc1IshiFFbZMizPoo7XdxQfsldYbd0DqeRFwZXDhjMokLx6BAOzhDio7Q/cy41af2I+yCLrQsnj8mYVa+CfPQKL+Y/zX34UiCYw44P4xjdnTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uC2O0if5aVvrQyaB7WZXojwMOYPDZ6A/75P1cR/Dfzs=;
 b=Y9UGuA9wPD/SJzQOF+Bg+MznmpwqBUx/yGx/pk17fCxtyiORr58ihseKmJSQkH9/sQP8/ktIKW80v6r6PwbEuc4PV7vk0i5ZS0WR9oKjObuehmYqNvYhW0RkDYZgUmqVjT+B7+DUM8Szc7tTxc89/BHmeFcwc00B+VkqQHR+aPh/1EJdwvMdPbEFvY3hIbX29TXKV73Z+J9azipfYox0Y+1U7G5Bj/LUaIQe/X1zqq6Tby/yS4PTeep19e23RIhPI3KboQqimNvzFEPRQcUpYJMyJkwa7DwpKj2BN6/N4i1XDCW2yAIwq5pCRpkHwApG/isr3xRzjIvzNnLN8nxuPA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB6581.namprd03.prod.outlook.com (2603:10b6:a03:393::12)
 by PH8PR03MB989187.namprd03.prod.outlook.com (2603:10b6:510:3b3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 06:13:19 +0000
Received: from SJ0PR03MB6581.namprd03.prod.outlook.com
 ([fe80::e335:b86:cf59:8b80]) by SJ0PR03MB6581.namprd03.prod.outlook.com
 ([fe80::e335:b86:cf59:8b80%5]) with mapi id 15.21.0592.010; Tue, 10 Nov 2026
 06:13:19 +0000
From: Adrian Ng Ho Yin <adrian.ho.yin.ng@altera.com>
To: Dinh Nguyen <dinguyen@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Adrian Ng Ho Yin <adrian.ho.yin.ng@altera.com>,
	stable@vger.kernel.org
Subject: [PATCH v4 2/3] clk: socfpga: agilex5: register the SP timer clocks early
Date: Tue, 10 Nov 2026 14:12:39 +0800
Message-ID: <5ec9233ec12b09fc2bb23bb093769d818609c7fb.1794287244.git.adrian.ho.yin.ng@altera.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <cover.1794287244.git.adrian.ho.yin.ng@altera.com>
References: <cover.1794287244.git.adrian.ho.yin.ng@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2P220CA0012.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5da::9) To SJ0PR03MB6581.namprd03.prod.outlook.com
 (2603:10b6:a03:393::12)
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6581:EE_|PH8PR03MB989187:EE_
X-MS-Office365-Filtering-Correlation-Id: 45207c80-8487-499f-894d-08df3ef1b751
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|22082099003|18002099003|55112099003|10067099003|11063799006|261102123227099003|261028144727099003|261022105027099003|261009223027099003|261021121427099003|261021123027099003|56012099006|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	fBsCrO/0FBUv2u9gpk07Ux3+5MqMLddaVHMCJPy5Y1zxoB0HPkQBoSD3ZzwAn4182OP2l8ZV3KpKQC78Mc2+9M+SQmpobwEgyrf/UOWK8amScJP+Nd7CH+rsO4X7jH1nLIHRA9JtA8Qgpz1C/Hd7BQN+1JbPRNxLw7dXJanRRTxBFXeAzoEZsnA9g/6wE877ZFpKGwM1ha0c+RUDeW341h+l7jYTZF22cAA0tVq6faGujuPrSli0NCgwR2L2fEnAeDs+QNkC4osnAgav9XodyblgipVM0PONQIdZUoTiqQggiCUuZxkG0d+YqtMMZsKiorPaLXdt2eYLgC0Izkn+SgdztmW5ikVgcinXlmqNsYQ3bs0id56AnTNdDsLs7XbmjhiSimxb09BIrP+MLcbGxj87QHffk7qo92OTNS6shqR0zsvHPT8ALaVXhW+MxJ2IgnP4nMpJtsrlnxucMpGfkUfwkKv0gl+95uVR947zHfK/XdLXWGJzvDl7SgwqASorN7uS3lTQ/ROy3caHfltCWZdH5BAy7l3GKRlSLNVivc00OKY3zXqloMG9cTPUbcIqCFvzxZI5O2jsItxGUti3jPtoaDN6ykp9bgctir19CXeJM2JJ1ME3acKXDm3s+zBYoRpexpDv4otCuMIp2euWYsvCI/wJsMJigNIt/DbnWew=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6581.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(22082099003)(18002099003)(55112099003)(10067099003)(11063799006)(261102123227099003)(261028144727099003)(261022105027099003)(261009223027099003)(261021121427099003)(261021123027099003)(56012099006)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2RuClfmSsIwarnYHvi39jzgy3mbDiRxQ4xSZDvi0mk/gAyC0fU7ge3XZVxEM?=
 =?us-ascii?Q?8vVRbBxJPJ8thzxpSwIgJz0C1Jkb6G3zgZvxZ5vUlQIODNFIX5VIdz1+BtPo?=
 =?us-ascii?Q?LMWtQEGp/sq8anMifx4CEdUiaI6hlDCB2v+pIhPZGb00lNHnKc0bmKMpzYUq?=
 =?us-ascii?Q?MaRzSSvBCJOvcsvEhYBPvqJE189IuSyKQ2a/3MC4ESQFB6AItTO9xNi5Y8Ty?=
 =?us-ascii?Q?J40PWQprbO5dE9fLzSyZnobQ8bxMiwyGLE3hG+g5526NNzteJTTh48pvB3w6?=
 =?us-ascii?Q?zm6mLa0i8AuZyllzRsQ1rKOcpsnkQxclcaHFFGKXR8slKx3raxjTaWTwyWuG?=
 =?us-ascii?Q?zv7JCa5dAD+5HfY3qkBInngqx3M/zgjXxDnMGKei0F+cpgR+e4/SOWYSbXux?=
 =?us-ascii?Q?X4S3YCAVkx0ABOuUziUePtPvizDzt2tebTabCFGMJX2v+PzUjId8JvYoWDuV?=
 =?us-ascii?Q?TfbgphpRyPGS4kWEDT2jcl06vHwoyPaBZBlqw+lLSV/d6TBCZB2AHyjUGXpB?=
 =?us-ascii?Q?k6TXi2tP0wEkrQMk1prfb7cRN0ja76nVopnAEVd7ufg3mcy0Dg2CrQithVi2?=
 =?us-ascii?Q?1pBYjTpxT+q4SQY1wyAHwYzl+y50MnDA8IPkiO0TyZ/BAaop+KD+uMKC/rdy?=
 =?us-ascii?Q?G4MxtGO7p6luMIicRqrM56CC3VMymo7pQnQjvBU9oHM7ThIeOVF+QhiaySvM?=
 =?us-ascii?Q?2EPMu7qEGsfhDprNcfsXFOPBVUptY8MmSkn+DpullrTqE5bZIZoen3Ufn8Ss?=
 =?us-ascii?Q?NeT7cMh8Ags7VSUx5qyD/Wr+cuKcU2OYBN5vYm/cw1gIWJDWguTBXu+sIYV9?=
 =?us-ascii?Q?KVkXWAYnZA9YZ9LPpWbuTc7dZGpLMjJcuuQcCq2XQ+txA2f/KaVNj+6+WvLS?=
 =?us-ascii?Q?ijDdgWUePif00Omiyqu9U1rmFnn3trHaIJSd3x3Ns7CPpa4n2MmvDCVeix8T?=
 =?us-ascii?Q?xj+VrzKGI5WrmPyi6JtQU8YY1MsMkCoS18adtU6WG2CRNoYGlDEaI1fWf7a3?=
 =?us-ascii?Q?+xcX/z7LeQymZoHuNVG0FAkDWXR6fi7R0g1anINpHlK2dxGcJnmhGn1hxdso?=
 =?us-ascii?Q?/l/rKTtf+5bt/2ebq2SQGyxXPfjD7aRTRZFs36SC3jp7HayIThDuy2HWFSwx?=
 =?us-ascii?Q?rkpzBbECMaLdPx+AfCC6zBSaxbW1ELhSrjgurSJ2DIvs5mse2N2yTKIGCicX?=
 =?us-ascii?Q?vKXeb5pl8H0g/xir4X2wSXopMg+a35hd6+v1iM8we+sGYfrmYfXgZOd34kx4?=
 =?us-ascii?Q?2xSB5RCzl578l74U1IinSd0/U7SGk3xHeqi4iUNQbVIvIT0zjTL6lYR1uKAB?=
 =?us-ascii?Q?znCS0RgBH/CSsTKnpJSI0fRipmMY6BUTiy+RiT/DfH9PuS0YkPI2Ev/kQxRB?=
 =?us-ascii?Q?cW2n6Np/XvDTodzAD9jIQsdntahYhrTd2ffRhvmdcuPkoVOfipEcFKIWn0LP?=
 =?us-ascii?Q?uxVY8lL0JAX0BzIMYmHbjp9HzwB2bE56YHjyPQtarfs5TJPV7D0u7JENKtfs?=
 =?us-ascii?Q?tLBpJR0W0I1mKEDjC1VkW+SViQKRVK6K+u7FdxE6J4L+gg3f1d3VPl+PsBF5?=
 =?us-ascii?Q?H25LZirLsnmirTmkKTEDGk1brWirWdf35oazyo+rqUQhQ2TQrLBxC44+PRhC?=
 =?us-ascii?Q?bF9qDpzgp/siPgsqWDs0Xo3+Oo9H6srvbGCHhXL2wjdhVLoRCELpxLM96oBT?=
 =?us-ascii?Q?vBS/9zDmN4AVJ15CupfXfpIRjpV6SVg8lwEjCCDBRPwvwYSPreJWhICCXJjp?=
 =?us-ascii?Q?3HlgDOFHJXT0NmtHW31s+zqwhsXYwS0=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45207c80-8487-499f-894d-08df3ef1b751
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6581.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 06:13:19.5971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P+hZvo838cZd26WPS69Uc9kmpvtp/JxYhQZm4eK72pnlxHYP+xyqLscFxyJ1kmOU265JO7PQM0xSC6cnUIgtuyzKN11PehD0EHNwmv7ucr8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR03MB989187

The DW APB timers are probed through TIMER_OF_DECLARE() from time_init()
and cannot defer, but the clock manager is a platform driver registered
at core_initcall(). The timer's clk_get() therefore fails and the timer
is never brought up.

Register only l4_sp_clk and its parents (boot_clk, main_pll, periph_pll,
main_pll_c3, peri_pll_c1 and noc_free_clk) from of_clk_init() using
CLK_OF_DECLARE_DRIVER(), with every other clock left as -EPROBE_DEFER.
The remaining clocks are still registered when the platform driver
probes, which reuses the early provider.

Fixes: 2050b57ecda0 ("clk: socfpga: agilex5: add clock driver for Agilex5")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Ng Ho Yin <adrian.ho.yin.ng@altera.com>
---
 drivers/clk/socfpga/clk-agilex5.c | 155 ++++++++++++++++++++++++------
 1 file changed, 126 insertions(+), 29 deletions(-)

diff --git a/drivers/clk/socfpga/clk-agilex5.c b/drivers/clk/socfpga/clk-agilex5.c
index f7f0ad884f64..50dba11ab45e 100644
--- a/drivers/clk/socfpga/clk-agilex5.c
+++ b/drivers/clk/socfpga/clk-agilex5.c
@@ -6,6 +6,7 @@
 #include <linux/slab.h>
 #include <linux/clk-provider.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include  <dt-bindings/clock/intel,agilex5-clkmgr.h>
 #include "stratix10-clk.h"
@@ -233,7 +234,29 @@ static const struct agilex5_pll_clock agilex5_pll_clks[] = {
 	},
 };
 
-/* Main PLL C0, C1, C2, C3 and Peri PLL C0, C1, C2, C3. With ping-pong counter. */
+/*
+ * The SP timers are probed from time_init() and cannot defer, so their
+ * l4_sp_clk and its parents are registered from of_clk_init(). Everything
+ * else is registered when the platform driver probes.
+ */
+static const struct stratix10_perip_c_clock agilex5_early_perip_c_clks[] = {
+	{ AGILEX5_MAIN_PLL_C3_CLK, "main_pll_c3", "main_pll", NULL, 1, 0,
+	  0x68 },
+	{ AGILEX5_PERIPH_PLL_C1_CLK, "peri_pll_c1", "periph_pll", NULL, 1, 0,
+	  0xB4 },
+};
+
+static const struct agilex5_perip_cnt_clock agilex5_early_perip_cnt_clks[] = {
+	{ AGILEX5_NOC_FREE_CLK, "noc_free_clk", noc_free_mux,
+	ARRAY_SIZE(noc_free_mux), 0, 0x40, 0, 0, 0 },
+};
+
+static const struct agilex5_gate_clock agilex5_early_gate_clks[] = {
+	{ AGILEX5_L4_SP_CLK, "l4_sp_clk", noc_mux, ARRAY_SIZE(noc_mux),
+	  CLK_IS_CRITICAL, 0x24, 3, 0x44, 6, 2, 0x30, 1, 0 },
+};
+
+/* Main PLL C0, C1, C2 and Peri PLL C0, C2, C3. With ping-pong counter. */
 static const struct stratix10_perip_c_clock agilex5_main_perip_c_clks[] = {
 	{ AGILEX5_MAIN_PLL_C0_CLK, "main_pll_c0", "main_pll", NULL, 1, 0,
 	  0x5C },
@@ -241,12 +264,8 @@ static const struct stratix10_perip_c_clock agilex5_main_perip_c_clks[] = {
 	  0x60 },
 	{ AGILEX5_MAIN_PLL_C2_CLK, "main_pll_c2", "main_pll", NULL, 1, 0,
 	  0x64 },
-	{ AGILEX5_MAIN_PLL_C3_CLK, "main_pll_c3", "main_pll", NULL, 1, 0,
-	  0x68 },
 	{ AGILEX5_PERIPH_PLL_C0_CLK, "peri_pll_c0", "periph_pll", NULL, 1, 0,
 	  0xB0 },
-	{ AGILEX5_PERIPH_PLL_C1_CLK, "peri_pll_c1", "periph_pll", NULL, 1, 0,
-	  0xB4 },
 	{ AGILEX5_PERIPH_PLL_C2_CLK, "peri_pll_c2", "periph_pll", NULL, 1, 0,
 	  0xB8 },
 	{ AGILEX5_PERIPH_PLL_C3_CLK, "peri_pll_c3", "periph_pll", NULL, 1, 0,
@@ -265,8 +284,6 @@ static const struct agilex5_perip_cnt_clock agilex5_main_perip_cnt_clks[] = {
 	ARRAY_SIZE(core3_free_mux), 0, 0x0110, 0, 0, 0},
 	{ AGILEX5_DSU_FREE_CLK, "dsu_free_clk", dsu_free_mux,
 	ARRAY_SIZE(dsu_free_mux), 0, 0xfc, 0, 0, 0},
-	{ AGILEX5_NOC_FREE_CLK, "noc_free_clk", noc_free_mux,
-	ARRAY_SIZE(noc_free_mux), 0, 0x40, 0, 0, 0 },
 	{ AGILEX5_EMAC_A_FREE_CLK, "emaca_free_clk", emaca_free_mux,
 	ARRAY_SIZE(emaca_free_mux), 0, 0xD4, 0, 0x88, 0 },
 	{ AGILEX5_EMAC_B_FREE_CLK, "emacb_free_clk", emacb_free_mux,
@@ -313,8 +330,6 @@ static const struct agilex5_gate_clock agilex5_gate_clks[] = {
 	  0x24, 2, 0x44, 4, 2, 0x30, 1, 0 },
 	{ AGILEX5_L4_SYS_FREE_CLK, "l4_sys_free_clk", noc_mux,
 	  ARRAY_SIZE(noc_mux), 0, 0, 0, 0x44, 2, 2, 0x30, 1, 0 },
-	{ AGILEX5_L4_SP_CLK, "l4_sp_clk", noc_mux, ARRAY_SIZE(noc_mux),
-	  CLK_IS_CRITICAL, 0x24, 3, 0x44, 6, 2, 0x30, 1, 0 },
 
 	/* Core sight clocks*/
 	{ AGILEX5_CS_AT_CLK, "cs_at_clk", noc_mux, ARRAY_SIZE(noc_mux), 0,
@@ -486,35 +501,114 @@ static int agilex5_clk_register_pll(const struct agilex5_pll_clock *clks,
 	return 0;
 }
 
-static int agilex5_clkmgr_init(struct platform_device *pdev)
+static struct stratix10_clock_data *agilex5_clk_data;
+
+static struct stratix10_clock_data *agilex5_clk_data_alloc(void __iomem *base)
 {
-	struct device_node *np = pdev->dev.of_node;
-	struct device *dev = &pdev->dev;
 	struct stratix10_clock_data *clk_data;
-	void __iomem *base;
-	int i, num_clks;
-
-	base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
-
-	num_clks = AGILEX5_NUM_CLKS;
+	int i;
 
-	clk_data = devm_kzalloc(dev, struct_size(clk_data, clk_data.hws,
-				num_clks), GFP_KERNEL);
+	clk_data = kzalloc(struct_size(clk_data, clk_data.hws, AGILEX5_NUM_CLKS),
+			   GFP_KERNEL);
 	if (!clk_data)
-		return -ENOMEM;
+		return NULL;
 
 	clk_data->base = base;
-	clk_data->clk_data.num = num_clks;
+	clk_data->clk_data.num = AGILEX5_NUM_CLKS;
+
+	for (i = 0; i < AGILEX5_NUM_CLKS; i++)
+		clk_data->clk_data.hws[i] = ERR_PTR(-EPROBE_DEFER);
 
-	for (i = 0; i < num_clks; i++)
-		clk_data->clk_data.hws[i] = ERR_PTR(-ENOENT);
+	return clk_data;
+}
 
+static void agilex5_clk_register_early(struct stratix10_clock_data *clk_data)
+{
 	agilex5_clk_register_pll(agilex5_pll_clks, ARRAY_SIZE(agilex5_pll_clks),
 				 clk_data);
 
-	/* mainPLL C0, C1, C2, C3 and periph PLL C0, C1, C2, C3*/
+	agilex5_clk_register_c_perip(agilex5_early_perip_c_clks,
+				     ARRAY_SIZE(agilex5_early_perip_c_clks),
+				     clk_data);
+
+	agilex5_clk_register_cnt_perip(agilex5_early_perip_cnt_clks,
+				       ARRAY_SIZE(agilex5_early_perip_cnt_clks),
+				       clk_data);
+
+	agilex5_clk_register_gate(agilex5_early_gate_clks,
+				  ARRAY_SIZE(agilex5_early_gate_clks), clk_data);
+}
+
+/*
+ * The registered clocks keep using the mapping and clk_data, so neither is
+ * released once the early clocks have been registered.
+ */
+static int agilex5_clkmgr_setup(struct device_node *np)
+{
+	struct stratix10_clock_data *clk_data;
+	void __iomem *base;
+
+	base = of_iomap(np, 0);
+	if (!base) {
+		pr_err("%s: failed to map clock registers\n", __func__);
+		return -ENOMEM;
+	}
+
+	clk_data = agilex5_clk_data_alloc(base);
+	if (!clk_data) {
+		iounmap(base);
+		return -ENOMEM;
+	}
+
+	agilex5_clk_register_early(clk_data);
+	agilex5_clk_data = clk_data;
+
+	return 0;
+}
+
+static int agilex5_clkmgr_add_provider(struct device_node *np)
+{
+	static bool added;
+	int ret;
+
+	if (added)
+		return 0;
+
+	ret = of_clk_add_hw_provider(np, of_clk_hw_onecell_get,
+				     &agilex5_clk_data->clk_data);
+	if (ret)
+		return ret;
+
+	added = true;
+
+	return 0;
+}
+
+static void __init agilex5_clkmgr_early_init(struct device_node *np)
+{
+	if (agilex5_clkmgr_setup(np))
+		return;
+
+	if (agilex5_clkmgr_add_provider(np))
+		pr_err("%s: failed to add clock provider\n", __func__);
+}
+
+CLK_OF_DECLARE_DRIVER(agilex5_clkmgr, "intel,agilex5-clkmgr",
+		      agilex5_clkmgr_early_init);
+
+static int agilex5_clkmgr_init(struct platform_device *pdev)
+{
+	struct stratix10_clock_data *clk_data;
+	int i, ret;
+
+	if (!agilex5_clk_data) {
+		ret = agilex5_clkmgr_setup(pdev->dev.of_node);
+		if (ret)
+			return ret;
+	}
+
+	clk_data = agilex5_clk_data;
+
 	agilex5_clk_register_c_perip(agilex5_main_perip_c_clks,
 				     ARRAY_SIZE(agilex5_main_perip_c_clks),
 				     clk_data);
@@ -526,8 +620,11 @@ static int agilex5_clkmgr_init(struct platform_device *pdev)
 	agilex5_clk_register_gate(agilex5_gate_clks,
 				  ARRAY_SIZE(agilex5_gate_clks), clk_data);
 
-	of_clk_add_hw_provider(np, of_clk_hw_onecell_get, &clk_data->clk_data);
-	return 0;
+	for (i = 0; i < AGILEX5_NUM_CLKS; i++)
+		if (clk_data->clk_data.hws[i] == ERR_PTR(-EPROBE_DEFER))
+			clk_data->clk_data.hws[i] = ERR_PTR(-ENOENT);
+
+	return agilex5_clkmgr_add_provider(pdev->dev.of_node);
 }
 
 static int agilex5_clkmgr_probe(struct platform_device *pdev)
-- 
2.49.GIT

