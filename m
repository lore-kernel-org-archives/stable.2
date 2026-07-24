Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010019.outbound.protection.outlook.com [52.101.228.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14B74156CC
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 12:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784897975; cv=fail; b=BGEyTwE3vb8WqX7sDM2HA5xxli2y8S9+yAbA7BKbJ9ZPLx2SftDuPUALPRKlgbGHPswhqxccZteoYgsPY4zqB1nl+ffgy3lX2CIQZIPR4Vd2xx1+6MHWUZ2cFFFYwzbePFlmREIQVQ34KupW7ZTSYK41F0REpQw6EtnMM9RVBfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784897975; c=relaxed/simple;
	bh=Q6ZSBuhotj+sTI7EPZUmrHYOHOw4LM8KU6fzssGdnOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qVGcW+sof/+brKXiEWcTVzAgFFCYtytJPhQMSb4IFYAZlkAVIAdS5+6XuwH6jGJUMCNLSE5dVG8SDtTfruOvsBpcGMRB0FDTYvxlr4nOFbxVK5oRYHj3Tsag29dHyNOVWEU+Px9fHKHsPlnK271bJWilpXa8nmK9jwKU7SyzfHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=ayv61sOw; arc=fail smtp.client-ip=52.101.228.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="ayv61sOw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xz4RlmadLC00mwQUybAolJyJ8iM1/2XE9tjEcwCOAakemqhC8NjXnJu7yN1pfiJXmASQOWqUZOHl8Jhb9UnULIU20W2QHuBt2FZ0Qe9AbOloDDn1ZQfypRsOWgRp0ze6Diey8/aURvkbc3jhZBopMRfr+8TquWuOEvGZJhZziwtSm30pfhtRLrb9mMitCUekaaYH1BsJkK3EtkGBOp7YvkoDOzUDBZIuhKx99dsKZ/mfVsEwVUFs8f/k6L1Q0gLkLt9lEJJxJ1F3hzrRaThVZZbZldyIqD/is31IrRv0KCV80+EAKoik1yuZ0b0F6eScAECQzS9M7SLfo56iCoP0Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GBQO7KTwbRB+xtIe/jBbRjfmzMYBf/ORjV4fpvEzdRc=;
 b=T+BT9gcDlEQm+NQjpxS30R635Rw38hvGBGs1Sddce+KtLiXx5JNRiA+Lyf19ucMwuAmITxFu/ylCSS89xHiJONhOXWZ7ICwoeWIUtJHUFU0Kp5ba3oqWAS7ck18XPJ5uyoDmJwrCCJvCyx66pNQYoKs+64igpSzoeEqYe39VL1f4zwRrxOHbKgS1vsBOhjAlOkF6H1VUGkqg9Y0iQ2jnnpafU8Gm73fpkH7HEP+Zb7wH4np6H9MAt6BHBlCt+xqbz3aoZG7XyzF5JyUyaTB+Djb1w5cPt1oaoVnR5L2oS6+ey/DQXUPTuNVe0dgP4uhmWbXH6mCsL0W4dKp1OoJpLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GBQO7KTwbRB+xtIe/jBbRjfmzMYBf/ORjV4fpvEzdRc=;
 b=ayv61sOw2n83PBNy4P6hNz/qkCmkHM8dpCJp4xl9tkJ+OTIZ6l7EDW980Z73YU8ybmrGjxnFKXcb3aj3EbCMdQzOWN4cqewDYDIUyIyg/bU7hcv4MrP1u3yk+iHXDAwMQX3B4+P6TDZpbcnOMA7mSEad1LYR4qdbnMUVoeb1eaY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com (2603:1096:405:18d::7)
 by OS7PR01MB14318.jpnprd01.prod.outlook.com (2603:1096:604:386::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 12:59:31 +0000
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828]) by TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828%4]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 12:59:31 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: stable@vger.kernel.org
Cc: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Frank Li <Frank.Li@nxp.com>,
	John Madieu <john.madieu.xa@bp.renesas.com>,
	Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
	Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 6.18.y] dmaengine: sh: rz-dmac: Move interrupt request after everything is set up
Date: Fri, 24 Jul 2026 14:59:09 +0200
Message-ID: <20260724125909.2967032-1-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <2026072020-swampland-tavern-478c@gregkh>
References: <2026072020-swampland-tavern-478c@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0087.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::12) To TYRPR01MB13588.jpnprd01.prod.outlook.com
 (2603:1096:405:18d::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYRPR01MB13588:EE_|OS7PR01MB14318:EE_
X-MS-Office365-Filtering-Correlation-Id: 3174eef3-2345-4718-aff7-08dee983671e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|23010399003|1800799024|366016|38350700014|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	PXQdoBs7epCcz1riHCvYNB0yxIi8pDCrZ7IgNVq+3wh+pp76VlJr4aiwscyCYi8wY3AvTrmkt4HmaOl5JBvbR8pmj7efOnf7BMGwmFfEI9lH/fc2dirM+op37p7Qy+bOKRx2GMMeM5+5X+Xb3Qu26yyHtni5JpPHdY8z5Q3o8tpFQoRi8odNA1NYj3emJCifK8Qw5Lsl2OJnMOJcuwI5rtDDciA56H2dHReG/6Q3j3C9yUnXQO83emzlZ82WESXUCtUHJZkBrXqykV0yETvYaTXCJqK95Qfee1AFP1PNNCEuZbypndgP+b5Ushqjrlpm2/5t3pgJ6VLEOIb1hC/jDJY0hio7eB7T4ll6tIWcbc7cyZHiAo5WH165vuD5Iec4w6WLUoOZgUXEPWrhgNJRRHow4QxVTGLnGzukeu8TY3q2GWAeL9hYAcxN+mc763Ralk0SDNlLHsDrZ2k7BX0kSpruMwGc+hxXw6IDk2GhyRreneJGDAPRrK5C/j418LARX+SUb6NmMyizMGPAOCFNhXF9geUjRji0P6uG19cLxUNwiSjqu7/FgcczvWaPFp7e7aI+81azXPBtBJgEad0vUC/LRsRqY6PipePJ0Dm241nXyB2iCxSqVkYftV7AUiqzoYTAV8vAwIbG8yHrGRuil8kBKjJ09J0YoLFuZXemqIM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYRPR01MB13588.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(23010399003)(1800799024)(366016)(38350700014)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Qxw+3IyM2o0T28EIG+0KblJhStGByiTPdJewLj2+6v3mANMZqRpcQntOPijx?=
 =?us-ascii?Q?eqFfWl518pprqge/Ns+EzSFoNaMMearTulEzseAG82zgEV+Mkb01bGBi1TGf?=
 =?us-ascii?Q?SugBcjHqzXEs0roy+ePM3hBYRH2wvK+XnaYV13VVx+IYGjWQqBeXbplMTljd?=
 =?us-ascii?Q?Sj1d3YRMSy7Jd0BK7WhYUYXRvLG6eOl91YViOVUamSGOwitqsMGB2YnTsrGs?=
 =?us-ascii?Q?zc/5a5vFBKEADDg5sLywBX1vWTMDA4aj6DHCqYYjD+d4w5qNzGaTOCr+xbwf?=
 =?us-ascii?Q?QAZ4GoBn0xKDduy6Nkl0fnPW98M7/ZBfhENRkippCFILuUBmLXxo+D8chByd?=
 =?us-ascii?Q?b9xeTBY1QQN9976E0zEXDDd3gAwaAogBEs89DoHCrK86KCdjOl8TAYD/lhpX?=
 =?us-ascii?Q?hKnLe1i/Z7jsky4Gjg/7EhGQ2MFlMNTa977mTA5XCniLHhSRPOdHfDIcDRP1?=
 =?us-ascii?Q?A17ke+6NJKRIINUtvANHda0cVBaM234nn44HJxJG216Ec7oc1G6vw6rnWeIj?=
 =?us-ascii?Q?H/cMQccWe207DJ0HifNMAVPvzCKPAcr63y0RNdB8tkc+8kZdJd0ub2GRzynA?=
 =?us-ascii?Q?lm+ByW9zXDipbR4mI8/aU67qQR/yIOA0oqLBxCo8JtIrJRF4Ig7JQXaZYTSH?=
 =?us-ascii?Q?WN0f2P76UvDtKB3TNPouipqivnynMAOBT5pRfAj6LiQxXmpjxbRyhrNfvNej?=
 =?us-ascii?Q?i89/B8lTZfBle35+h6TmhztRdrkQ6uFYpGNhTfpL2B21uPyaHH6x4i9CQUNC?=
 =?us-ascii?Q?d9g7h8ePiGrZWQjSZoHhnwqeiQhOPQbFYELyuRtxcd2NWgeIygA81JcrXTAI?=
 =?us-ascii?Q?Ol5E++4a+Kf6tJPtPVooy756380SIBemGwker5v3Zzy0G9BdkoTWDMrN3kKb?=
 =?us-ascii?Q?mBrG6SmcZ25yrnx3Z8x5p7Fsv+WFCcQkIpr8COq7kZWwLjL+Y7Nq5NqKyNbT?=
 =?us-ascii?Q?K8qSEz3lx1DXntvqvoRAQhTbWc2XZm3E/ttCkH35g5HuEz89PXbn/+JTU5+S?=
 =?us-ascii?Q?Z1dfo6xdtA2hGvz2HkyK3yJeawa7AUHfd5Ihd1LZtlXax7NlIkg3FlQ7Sdx2?=
 =?us-ascii?Q?otPn8o4swZS0EKzGk5dgk+jdBApUBajldWv7nJbdnQY2syNUABgVEOgojYWO?=
 =?us-ascii?Q?EGJcXmIdt7pvFhw2sUYGP5ZLELOL0DIFUAkBc3H4uCcO8o4f8ueiQZWy2KwT?=
 =?us-ascii?Q?nii17kM6Wg1vlwjU7mhJjdPPRpgqDGYUyvAER40TcxFSqLGkA6lFTZ1P4UmT?=
 =?us-ascii?Q?X8CSMhQZVKoNVncw8EqQBUiyfu/GN667AAZEHcbqBUXnyGjNHLv1RTBEDTJ/?=
 =?us-ascii?Q?GLpD5dyzvE8YMX6c1Of0liY3wS8wouQzc4ARNtJZJtv3x5lPl9uVnaMAjXpC?=
 =?us-ascii?Q?Xe3465esY407UbXvAQSsJCuKdrPZFox2p5E9xTf63idZFVgKnx3mkNvsPpyG?=
 =?us-ascii?Q?NpeAozgq6Q9bNt9K/k8Aa2ZX8GFQNEnELpvO/NU7AhTezuK2xvLsEqwMIgTU?=
 =?us-ascii?Q?p3w9YNBH6opiuFbMB1XRBKLlH40sk2Xqd1gpW6e+EOm94cNUhjbA91D3qpFc?=
 =?us-ascii?Q?uYvYz/uRp0xN66/cjKsoq53JBC0N2ftk5UL1gE3t5OyN2ZQ1A0Wu8w9EpD9X?=
 =?us-ascii?Q?fvYXo49vva5q0IlW6V5rna1bHU5SCcn1OxzkkqrfQhcXoM5LtltlSHKCbe5D?=
 =?us-ascii?Q?NIafQ0ovxMpjk8vCJ4NJI5WVoEOmEfGoq27xP7DhFbMjkHV8OoOZlsGUe8AM?=
 =?us-ascii?Q?wgKI2jBUytcv3JhVKpN+WbZvyM45hQPhsh16SnucPrhBDC9dOCrC?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3174eef3-2345-4718-aff7-08dee983671e
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 12:59:31.4418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DYYp2NBbkagZHlhslEUYNQTb3mgD5dAFqkgy2nWsRPBeuN6atKP806LDKugN9mpAROaKcLkezuDbCGSIECe+A6E+Qf8uLrg5xVq9rrKjyx6C8JFGvGAGrHJOGw/eJhGf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB14318

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 731712403ddb39d1a76a11abf339a0615bc85de7 upstream.

Once the interrupt is requested, the interrupt handler may run immediately.
Since the IRQ handler can access channel->ch_base, which is initialized
only after requesting the IRQ, this may lead to invalid memory access.
Likewise, the IRQ thread may access uninitialized data (the ld_free,
ld_queue, and ld_active lists), which may also lead to issues.

Request the interrupts only after everything is set up. To keep the error
path simpler, use dmam_alloc_coherent() instead of dma_alloc_coherent().

Fixes: 5000d37042a6 ("dmaengine: sh: Add DMAC driver for RZ/G2L SoC")
Cc: stable@vger.kernel.org
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Tested-by: John Madieu <john.madieu.xa@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://patch.msgid.link/20260526084710.3491480-2-claudiu.beznea@kernel.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
[tm: Kept the channel->irq field in rz_dmac_chan_probe() instead of
 upstream's local `irq` variable, as commit 04e227718ab8
 ("dmaengine: sh: rz-dmac: Make channel irq local") is not present
 in this tree. Likewise kept platform_get_irq_byname() instead of
 platform_get_irq_byname_optional() for the error IRQ in rz_dmac_probe(),
 as commit 6b3a6b6dc074 ("dmaengine: sh: rz_dmac: make error interrupt
 optional") is not present in this tree either; its early return on
 failure becomes a goto err jump to match the new call order.]
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 96 ++++++++++++++++------------------------
 1 file changed, 38 insertions(+), 58 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 818d1ef6f0bf..4db84b83177a 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -811,27 +811,6 @@ static int rz_dmac_chan_probe(struct rz_dmac *dmac,
 	channel->index = index;
 	channel->mid_rid = -EINVAL;
 
-	/* Request the channel interrupt. */
-	scnprintf(pdev_irqname, sizeof(pdev_irqname), "ch%u", index);
-	channel->irq = platform_get_irq_byname(pdev, pdev_irqname);
-	if (channel->irq < 0)
-		return channel->irq;
-
-	irqname = devm_kasprintf(dmac->dev, GFP_KERNEL, "%s:%u",
-				 dev_name(dmac->dev), index);
-	if (!irqname)
-		return -ENOMEM;
-
-	ret = devm_request_threaded_irq(dmac->dev, channel->irq,
-					rz_dmac_irq_handler,
-					rz_dmac_irq_handler_thread, 0,
-					irqname, channel);
-	if (ret) {
-		dev_err(dmac->dev, "failed to request IRQ %u (%d)\n",
-			channel->irq, ret);
-		return ret;
-	}
-
 	/* Set io base address for each channel */
 	if (index < 8) {
 		channel->ch_base = dmac->base + CHANNEL_0_7_OFFSET +
@@ -844,9 +823,9 @@ static int rz_dmac_chan_probe(struct rz_dmac *dmac,
 	}
 
 	/* Allocate descriptors */
-	lmdesc = dma_alloc_coherent(&pdev->dev,
-				    sizeof(struct rz_lmdesc) * DMAC_NR_LMDESC,
-				    &channel->lmdesc.base_dma, GFP_KERNEL);
+	lmdesc = dmam_alloc_coherent(&pdev->dev,
+				     sizeof(struct rz_lmdesc) * DMAC_NR_LMDESC,
+				     &channel->lmdesc.base_dma, GFP_KERNEL);
 	if (!lmdesc) {
 		dev_err(&pdev->dev, "Can't allocate memory (lmdesc)\n");
 		return -ENOMEM;
@@ -862,7 +841,26 @@ static int rz_dmac_chan_probe(struct rz_dmac *dmac,
 	INIT_LIST_HEAD(&channel->ld_free);
 	INIT_LIST_HEAD(&channel->ld_active);
 
-	return 0;
+	/* Request the channel interrupt. */
+	scnprintf(pdev_irqname, sizeof(pdev_irqname), "ch%u", index);
+	channel->irq = platform_get_irq_byname(pdev, pdev_irqname);
+	if (channel->irq < 0)
+		return channel->irq;
+
+	irqname = devm_kasprintf(dmac->dev, GFP_KERNEL, "%s:%u",
+				 dev_name(dmac->dev), index);
+	if (!irqname)
+		return -ENOMEM;
+
+	ret = devm_request_threaded_irq(dmac->dev, channel->irq,
+					rz_dmac_irq_handler,
+					rz_dmac_irq_handler_thread, 0,
+					irqname, channel);
+	if (ret)
+		dev_err(dmac->dev, "failed to request IRQ %u (%d)\n",
+			channel->irq, ret);
+
+	return ret;
 }
 
 static void rz_dmac_put_device(void *_dev)
@@ -932,7 +930,6 @@ static int rz_dmac_probe(struct platform_device *pdev)
 	const char *irqname = "error";
 	struct dma_device *engine;
 	struct rz_dmac *dmac;
-	int channel_num;
 	int ret;
 	int irq;
 	u8 i;
@@ -964,19 +961,6 @@ static int rz_dmac_probe(struct platform_device *pdev)
 			return PTR_ERR(dmac->ext_base);
 	}
 
-	/* Register interrupt handler for error */
-	irq = platform_get_irq_byname(pdev, irqname);
-	if (irq < 0)
-		return irq;
-
-	ret = devm_request_irq(&pdev->dev, irq, rz_dmac_irq_handler, 0,
-			       irqname, NULL);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to request IRQ %u (%d)\n",
-			irq, ret);
-		return ret;
-	}
-
 	/* Initialize the channels. */
 	INIT_LIST_HEAD(&dmac->engine.channels);
 
@@ -1002,6 +986,21 @@ static int rz_dmac_probe(struct platform_device *pdev)
 			goto err;
 	}
 
+	/* Register interrupt handler for error */
+	irq = platform_get_irq_byname(pdev, irqname);
+	if (irq < 0) {
+		ret = irq;
+		goto err;
+	}
+
+	ret = devm_request_irq(&pdev->dev, irq, rz_dmac_irq_handler, 0,
+			       irqname, NULL);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to request IRQ %u (%d)\n",
+			irq, ret);
+		goto err;
+	}
+
 	/* Register the DMAC as a DMA provider for DT. */
 	ret = of_dma_controller_register(pdev->dev.of_node, rz_dmac_of_xlate,
 					 NULL);
@@ -1040,16 +1039,6 @@ static int rz_dmac_probe(struct platform_device *pdev)
 dma_register_err:
 	of_dma_controller_free(pdev->dev.of_node);
 err:
-	channel_num = i ? i - 1 : 0;
-	for (i = 0; i < channel_num; i++) {
-		struct rz_dmac_chan *channel = &dmac->channels[i];
-
-		dma_free_coherent(&pdev->dev,
-				  sizeof(struct rz_lmdesc) * DMAC_NR_LMDESC,
-				  channel->lmdesc.base,
-				  channel->lmdesc.base_dma);
-	}
-
 	reset_control_assert(dmac->rstc);
 err_pm_runtime_put:
 	pm_runtime_put(&pdev->dev);
@@ -1062,18 +1051,9 @@ static int rz_dmac_probe(struct platform_device *pdev)
 static void rz_dmac_remove(struct platform_device *pdev)
 {
 	struct rz_dmac *dmac = platform_get_drvdata(pdev);
-	unsigned int i;
 
 	dma_async_device_unregister(&dmac->engine);
 	of_dma_controller_free(pdev->dev.of_node);
-	for (i = 0; i < dmac->n_channels; i++) {
-		struct rz_dmac_chan *channel = &dmac->channels[i];
-
-		dma_free_coherent(&pdev->dev,
-				  sizeof(struct rz_lmdesc) * DMAC_NR_LMDESC,
-				  channel->lmdesc.base,
-				  channel->lmdesc.base_dma);
-	}
 	reset_control_assert(dmac->rstc);
 	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-- 
2.54.0

