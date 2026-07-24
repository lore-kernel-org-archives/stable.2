Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010019.outbound.protection.outlook.com [52.101.228.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4042D3515C3
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 12:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784897921; cv=fail; b=uLUw9V8RvF+6ZxoTytsWtLHNE6ZeuSoyb5YwzNdWdP6JuKiO7hFR9Nl+QxzhyahqRdWnEJnNqyC15IGu+bziJOzebrE7UeT0II0V37XWc2xJRSSLU2cpDi450avg24SL06uofhcnDvOd3x7aSpNrlNFKCW7nhrbOaZgBt6OxHRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784897921; c=relaxed/simple;
	bh=exaZxfeXH6cUfn7Epwm7PQmrrxbSJZ0A1hEAZRrWHsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nVT4DUsvdE7A6SySTcITQCNrBCcYpWRT/7lwgOPZW3M7EijC+SxLT1Bc6Wtvr1fAQR/z1NpBw288gvn4m1sf2KhZgji3cjqigkK/53wgonAn4gvQxotVZ9D3tX+d/4/iC8uVX3PV+scOw+gzsAwpTUNfyMonCNKzBG3B/roSg78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=vnNwYhPn; arc=fail smtp.client-ip=52.101.228.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="vnNwYhPn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CAXG944d5wyFHWOy+J1UvcT8kX5RWMzNneeRpNT1pmBwUvCC8IugSQv4RtTYea79BW36PVF2o1NvX7xSO1qbb0MprxA/WSAI0Kp5RhZrcLPOtMKUkZr4C+vzPYKtLbYLfLUZJb8YSJn5fun8lnynUJJuWlyYpd7Eec/mzVc3RX3l5CMWzxuvsBmxZlJDYEZmrHea/dJMN4bM5mGuoudqx7t0/5WUNXYPbhjXqxUZoHRd+EB9vlcQIThyn3xKu4ZuY1TIJ5PKY5WtjeCwNutYOw9DZSo/utOhds2rzq5qGG80LBV+uBMfAgLUFMhrNL5E56X+4kgXwYjLWqNEJyH/2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a2GqmhdxFPDO51wn9vlpEV7OyIFMsJmPZnQ3CugIsmU=;
 b=QALliaRJlqmrcueCDAZNvDibkOfeXpEnfMsTeMvYnAehwJrGkvuvdB0H0ez617SGDlvtyYvKZxy4MitK6xE7vXvPtn8umUXwIxbpsi6MyFXFQFXLVei40MelZovL4Fmt2ol/0hmvTOmNAdi0w9sF8uJCBwR/V+faodToegx/d/zf+iIBmM8XEQTmNN3O0ZcTci2p3mrfafnKYOMesJ1pt/TcZq/bgaw8wRKuHTvPxxSmJkkah5//BzgLoYaB7e1sS4SqDpsE97KI9Jb4hhrmuXjsk+Co19bwA+cpY5JQKbPAApPrm9wsqrALjbr8FNe1lJIAWfrIFwxbT85OAdydqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2GqmhdxFPDO51wn9vlpEV7OyIFMsJmPZnQ3CugIsmU=;
 b=vnNwYhPnUZO5LnFQPkokNrJCzF9RWVbz52cqmmX2oN7ulYXoH8garRPcYUSlGS3a6G4DjdhXEgDrfoA7bXNwAI0thFRfL73LkQ9bC0CMqNjqLKLDw4hDz2jf78HplqjUXLfVPcmWyKRCvnj1cDGTGmgcTG1euLIhVwUrp83GcXU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com (2603:1096:405:18d::7)
 by OS7PR01MB14318.jpnprd01.prod.outlook.com (2603:1096:604:386::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 12:58:37 +0000
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828]) by TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828%4]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 12:58:37 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: stable@vger.kernel.org
Cc: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Frank Li <Frank.Li@nxp.com>,
	John Madieu <john.madieu.xa@bp.renesas.com>,
	Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
	Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 6.1.y] dmaengine: sh: rz-dmac: Move interrupt request after everything is set up
Date: Fri, 24 Jul 2026 14:58:13 +0200
Message-ID: <20260724125813.2966928-1-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <2026072021-glue-compare-1d9f@gregkh>
References: <2026072021-glue-compare-1d9f@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0129.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::17) To TYRPR01MB13588.jpnprd01.prod.outlook.com
 (2603:1096:405:18d::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYRPR01MB13588:EE_|OS7PR01MB14318:EE_
X-MS-Office365-Filtering-Correlation-Id: 195542ab-0e8b-46e2-4e6d-08dee98346ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|23010399003|1800799024|366016|38350700014|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	ODJL0BDN5921z6+TWLRJKzye0TsSykVHg2U2QXGGjBCNMw1fuJTKsG8fRTPTz+RTdvxhFRANp0Y13T9dmfUeLpyblsvMFqC+z4+fmPtWBhVOvJiDIJBY6Y2tL3IiAMHgoVnQB63xG/UsGnDJC3R9o2TX23lhPMVnrX1vB4El0+A4jTPbK8qTAAUZulQRjMQ0uMRKB1YbuZhG7/727kl44EyF0z2dBoWeowtxbITGssV/pdinSJPoodHLVfhF0tSpkpZe6BA/KBjZORUbhIuCRMdfO8x1OGVRtMniyRlc4Ke14fMRpqilayJwusJUMUH17LgnS0OflqQXA2w/FMvdvn+bfKzZZQ7CwcBbYdeeKiOa1tj+1jEp24qP7rv8zmJ54A4FSDsdPTsOS3l9SO5MV1u+JWfPJRlXO+2gzDVKNDTIJEi2TiRit/kw496uRV8xPfSxzX9KYP5P+1VjhVhTItmkQNHwsu+vozTXHpyvyCthuLrtOsH2CkB9Mp8VKCQmS0hV+/yDCJFoNN1nzMYuhCk3J+07zjXEKRk82Vnqso5za1bznmq0wHQwZ48Uj8bzTBSGQU96p9ZnUnRRbgh5xloh/fRHdR40pNGrSqCGZFv9btcWe3Jwd8GHYCWtKFHXyBVLO+eI5/R2/XNVm/moHvuuw7//oMXkJTFL/4G49EM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYRPR01MB13588.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(23010399003)(1800799024)(366016)(38350700014)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j+qJi1aNPbnld5sLHGWavP5oCEPfdEvGT5czhXtI77P+OkZjlJmmBEJR8j9e?=
 =?us-ascii?Q?Bb//edknJppfgI9qmj8xMbwYfwKPTCiY1Oxn7/sOCSdjOdL4aRt388r2+sqe?=
 =?us-ascii?Q?EMcSfEC8KeP6kF4pj6WFL1XHUJzKqYLc08e6MPRhkVlg8hNmfttzS8H1qUz9?=
 =?us-ascii?Q?pjIH+uUU118TSmlngnfMikzkZzdVCeFsp5qfY+Od7NoVMAO7tCNk2UWs37pu?=
 =?us-ascii?Q?kBey16h9C5hwiTP4cMvCgYPVgZ6dqBFS7M1p7g8z9xy0WN5kuJhmE4Kc3Jm/?=
 =?us-ascii?Q?ljnntdzQrCo1wtnZdFAT00k0PztZ704jzp7LdZgmBQeXmUBS5mEIcuoQUBVn?=
 =?us-ascii?Q?duLwsqUALA2+vIWzNWkOs+qXgqSp7s1cHjxwN3pbUB4PgS16r0h4+gbIWPbO?=
 =?us-ascii?Q?z29i7W6FED9q7tD9X53rXw2U5hHLGbn9ia2ORyRxuqELimsGikKcgwYtUIBh?=
 =?us-ascii?Q?wPDguTQhFF+ewO5V8lEytb7QzeE84HI53vG8FMu487iWtDdF8f5KME/iuevH?=
 =?us-ascii?Q?3NrVoAG4HM4BxXgbAfx8ZgSLn+RHhJ5saqDFqRme/MWiqCGvG1/H4KfJ/9lQ?=
 =?us-ascii?Q?7cxGxzk5ydxRJx7oQgakHUBSELc3wS6+kWh8c4UlxQ5DElWMSxHy8i6mYPua?=
 =?us-ascii?Q?IrGOuwBOI6GlMBtow7OjgILLOzOmssBs7fTISkupzf5OLyKLJrrkFAlp+8Xg?=
 =?us-ascii?Q?L9S8V4GDTnvWigWsCw6vSkuMCtXCtJCPwDOjTmWcDpA/vEumfp3qfOOaZ0l5?=
 =?us-ascii?Q?sw3zweRnU4DPSOu3z59LXCjYGjhtM2W2AluKyEAIJ7RLxxomolublZxsPR2k?=
 =?us-ascii?Q?YhY0ZGFm/v+g8Dseqt907UgyVyW+ZGssp8+MWpKjEHb1diKE1uRo4ubJrwM4?=
 =?us-ascii?Q?G+XtlF6P/utw9E4K2gFGLKZiPNWQZOcmjN9vXdJiK5udApgCi8s127CRPovJ?=
 =?us-ascii?Q?A626M/J95vsfD/uL5y51ovXjsCggcjWypeV1Y4US/izxyVTmObvXPPZG4rfS?=
 =?us-ascii?Q?9jUM7V8CqmDgN3kP0ori8sDNvRCWAo+w0XbPUvK/qSxCWa7OPZlls1yj7AEv?=
 =?us-ascii?Q?hvjTheGKCc8bUnofK4aP/aWpdJJnd8OSRTqwa1ppHuAyTAr1U/uTVo3Nniyk?=
 =?us-ascii?Q?OvmujUsduyleiH67v4d9ucMZdqU7JXteum6oFimcnPrGOdK9twQjbZZzyoe+?=
 =?us-ascii?Q?UMtLX6VxmlMrzOrgaqLqGFOs3TQSOSASnP9m647ViWzkxMyi+2QcqY0+NYoV?=
 =?us-ascii?Q?LzPukam1zPwXUCiVlIJ0YvOGyO80WWz6454tJVu9kAUJcEkIu5Urv+Y2AI0B?=
 =?us-ascii?Q?TGSLa82stjZs1RBtCjryiwWU4eDSGs5Lxt2ZT7D3/Dd97vaI4pZDO1e7RC5H?=
 =?us-ascii?Q?riZt/DaFk/Y/Q9Q6TYq/i6mDX4ytL2bODRLUgdeleq81uO1lJjmQ1ALhmnf3?=
 =?us-ascii?Q?DXsGFFcljtTJDOnxvod7uOdWKrnTmP/Mez4DQdjxPxEOeXARrjdB4kjhaEY0?=
 =?us-ascii?Q?wvsR9LY9tiva7d0cEkhHhNpSW4YC8VADNCktAkesqmp8h2Swti2aP/pfThI3?=
 =?us-ascii?Q?J13s7mLwpEcnKM5Dntwegtk5sp3Eb5Tb5zUJNKo2IE3uB20JtDIHALxZxD94?=
 =?us-ascii?Q?oL+ipfLJ/vkKcbT4iPSX/Eb7KdrFV0bOkKeeQkgDbv2o4u6uDHZkU2QZkR/w?=
 =?us-ascii?Q?UGDsDNLHRRcNxH+Dik/hZzrMOtdpskzu5ao7iB7CS6DHW7ALXUBoc4Z96+Af?=
 =?us-ascii?Q?x2/50Y9Wtlpoj1dbl/Hfd1cJcXwnWLMFfvb5ax7xgddmkPt7QyCU?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 195542ab-0e8b-46e2-4e6d-08dee98346ed
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 12:58:37.6432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n2M1g+NHEySincFVH0AwNgstj2vZwgq5LHRbzavvQfQ1MoQbj/YKCBpXijMFDSjM1AT1dvQn5OBfFefN9nGeX3yHSVvvvmeRO6O/f0x4/4H2Ji5+esTw4wZZOABM63h1
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
[tm: Kept the channel->irq field in rz_dmac_chan_probe() instead of
 upstream's local `irq` variable, as commit 04e227718ab8
 ("dmaengine: sh: rz-dmac: Make channel irq local") is not present
 in this tree. Likewise kept platform_get_irq_byname() instead of
 platform_get_irq_byname_optional() for the error IRQ in rz_dmac_probe(),
 as commit 6b3a6b6dc074 ("dmaengine: sh: rz_dmac: make error interrupt
 optional") is not present in this tree either; its early return on
 failure becomes a goto err jump to match the new call order.]
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 96 ++++++++++++++++------------------------
 1 file changed, 38 insertions(+), 58 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 498e6e24ab0a..b956292e8619 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -779,27 +779,6 @@ static int rz_dmac_chan_probe(struct rz_dmac *dmac,
 	channel->index = index;
 	channel->mid_rid = -EINVAL;
 
-	/* Request the channel interrupt. */
-	sprintf(pdev_irqname, "ch%u", index);
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
@@ -812,9 +791,9 @@ static int rz_dmac_chan_probe(struct rz_dmac *dmac,
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
@@ -830,7 +809,26 @@ static int rz_dmac_chan_probe(struct rz_dmac *dmac,
 	INIT_LIST_HEAD(&channel->ld_free);
 	INIT_LIST_HEAD(&channel->ld_active);
 
-	return 0;
+	/* Request the channel interrupt. */
+	sprintf(pdev_irqname, "ch%u", index);
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
 
 static int rz_dmac_parse_of(struct device *dev, struct rz_dmac *dmac)
@@ -857,7 +855,6 @@ static int rz_dmac_probe(struct platform_device *pdev)
 	const char *irqname = "error";
 	struct dma_device *engine;
 	struct rz_dmac *dmac;
-	int channel_num;
 	unsigned int i;
 	int ret;
 	int irq;
@@ -887,19 +884,6 @@ static int rz_dmac_probe(struct platform_device *pdev)
 	if (IS_ERR(dmac->ext_base))
 		return PTR_ERR(dmac->ext_base);
 
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
 
@@ -916,6 +900,21 @@ static int rz_dmac_probe(struct platform_device *pdev)
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
@@ -954,16 +953,6 @@ static int rz_dmac_probe(struct platform_device *pdev)
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
 	pm_runtime_put(&pdev->dev);
 err_pm_disable:
 	pm_runtime_disable(&pdev->dev);
@@ -974,16 +963,7 @@ static int rz_dmac_probe(struct platform_device *pdev)
 static int rz_dmac_remove(struct platform_device *pdev)
 {
 	struct rz_dmac *dmac = platform_get_drvdata(pdev);
-	unsigned int i;
-
-	for (i = 0; i < dmac->n_channels; i++) {
-		struct rz_dmac_chan *channel = &dmac->channels[i];
 
-		dma_free_coherent(&pdev->dev,
-				  sizeof(struct rz_lmdesc) * DMAC_NR_LMDESC,
-				  channel->lmdesc.base,
-				  channel->lmdesc.base_dma);
-	}
 	of_dma_controller_free(pdev->dev.of_node);
 	dma_async_device_unregister(&dmac->engine);
 	pm_runtime_put(&pdev->dev);
-- 
2.54.0

