Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010029.outbound.protection.outlook.com [52.101.229.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EC02C0F7F
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 13:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784898032; cv=fail; b=kSodk5TLqMFUusClGVIvvVGu+jbQ6z/8VUaNiFyWCIFiXLqTmUo87f0FgWlYoSI2xdaYOCbj7pxxCol8DsgbI26NazOCDCMNThqabB4jUjAxzJKJ32kxScHqP64LDLWVkxbH8XGQsTxvHHcAU4Z2D2B+I151BouhJWGVFAYHdI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784898032; c=relaxed/simple;
	bh=s/XGfeRKjfVyobaWgBRkJP2jCyAAIGgbq81gkuFZY/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sLYvrVjXWptrDoHIPRDkuHdOp0+kt+AbnLY1RPsrBV0OEiRa50G+ZjQgpAP8/2YFp5MeeWh4Wn3Oe6DRrZCkRPtNVgAE4hJX8jnSy0z18ebK1rFajmf1KCYC5xxe7FNXl8em647/t85+lqoaw+ejbk/h/l6XHMxpZnsSIJFHaQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=ff1R2XEc; arc=fail smtp.client-ip=52.101.229.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="ff1R2XEc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LMe/gXxMbEMt4KbU1JX2zRk8RAwszf426AB23A2Mx5PCos4W7iCHD1Z12QHBjR8DFb8nmjPepXc2xEIvwlQ8vs5OjNgqIH6mgLsZ0ZuTIyZFI/IfoGKanOSiwj0VKU7OAnXZCBPYu69tbloFyWYaXaLvD5taknCGEt+2M2iXghMO5R5kKhMoUC3qlarMoNncEpqgKkgC8GmckgA8TPiv/ghX68WNTfoUwUMeTxuYTLzLGoxRrV8m2Hm0bXv9O7RMrN+0XBSAOcmi9+7Vjkx7t3oIzFaSuqTYF4yuofpwLo0B3PgYRslEPg+stBO+ZKAVzfi5tBCxGYmNIga3e2yFMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eUkHwZICM4Psi7f7UqpoSj7/U8NUOGHcYUDFvtj4UK8=;
 b=HKF1iWTTIesAgUj67JW/l7K65jjDzDTFMr5RiyYG24avZ2IAJ+jYCn6EzlXOEgwL5udl67uY55i8uHwVDNnOKUaCTk1NQoebz58+sWl8Z6toWb+7a1FPfaQzzkh8nIb1+F/VRtBq3wXf0/2uPHhoPlUUDU+bMh9ek6dD0t9nvfNMwcNVLjXo9pCwZLElwLUw/EbNJoBCj0BXg5iejwdjiB9ycJ+d2I9A3G0q07hIJsYTACyiqHX54Hvvs3nVAw/4AMCPwrssKHK1wOnh7pHPEFNYDXWflRaDper6PO4IOvco6lNE/H8RJZ7e9t6tGzP7m6wfmCFVdF9EJ3pnujevAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eUkHwZICM4Psi7f7UqpoSj7/U8NUOGHcYUDFvtj4UK8=;
 b=ff1R2XEcRTlxLHtx0QUw5KAksmGDEu39YIg9YNcnWfytiwR5bPqsWkDaisfRNDKm0wG2CrCAvta4EIaUTV9Q/rzNfC8hwEHUb52u35YTZZZN0FgWqiFaXyCHYzDbLijANOrafON/7JQBQCvwKuZQBSEGGmDPwxAm2nwb/e9Zf3c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com (2603:1096:405:18d::7)
 by OS7PR01MB14318.jpnprd01.prod.outlook.com (2603:1096:604:386::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 13:00:28 +0000
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828]) by TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828%4]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 13:00:28 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: stable@vger.kernel.org
Cc: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Frank Li <Frank.Li@nxp.com>,
	John Madieu <john.madieu.xa@bp.renesas.com>,
	Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
	Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 6.12.y] dmaengine: sh: rz-dmac: Move interrupt request after everything is set up
Date: Fri, 24 Jul 2026 15:00:06 +0200
Message-ID: <20260724130006.2967163-1-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <2026072020-preheated-papyrus-50fd@gregkh>
References: <2026072020-preheated-papyrus-50fd@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0143.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::6) To TYRPR01MB13588.jpnprd01.prod.outlook.com
 (2603:1096:405:18d::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYRPR01MB13588:EE_|OS7PR01MB14318:EE_
X-MS-Office365-Filtering-Correlation-Id: ac5b62e0-0bc1-46a8-ecd3-08dee98388c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|23010399003|1800799024|366016|38350700014|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	2CvAzW1mJLcbS3F9u1R+AtIx7WpHSWrPNWnBTNb/ipOuT9idUjEXJ4CrihUrRxix6PqjBCRenV5mPZq55lkxbF41xdxTJhFCIrFPV0Z+QTKUHV54YmkK6CrULlED2ExTsY5/mhMfRYCY9mMyOdxko1nh5ZOiAnfhF4xSF+a+2N8ovZEQdUvtca704eLlyy7FXLvhrwh/D6hHvcPw40nU3enLS9lDcu5VwRV1pFZvLOKho89Do2+Iw4WvyXED4cVeOFRaCCFAZLcBS+rxnqKVAit/+xlYoyBB1OAhOCCCIwtPmLeptAOFuufpKPxkJzxECDeCxGjTMFurTzVo5ptDYJY74zwNkQtFmUQvseTvpbFYh0cEnsdQIVnjoj+7+4t+QByxy6Ya4R8h2l/s4oLytRUU76f0cz321LLc5yuAEPsED6ugj/zurCObopA5cc6npYz/hIXHYvN3OBtO18A+07cyC293gz8PT5Tl27MEgH1WBjJ16gPnkD46O8mGt8UGtACMHfrBeZHx+pdKzvi/6UVHflc1gNmXl9iK6A96NXrd0zEusZncDlV4Or1gGH8pCmITFAIfB7u4U/mRIzEoH869I7hAfnJzBN8vpLiXQuhs6Djla4yPzVRu0HQUJxt8pMRYgbrx6V8kb9H1sm/NScBaKYtGj3sFfJ3l2/02jFk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYRPR01MB13588.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(23010399003)(1800799024)(366016)(38350700014)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CGTxFt504dW58cb6D74JoF1knB5IC/d2BqPAX9imCdwT8mJtv9Di3bsT7Iqa?=
 =?us-ascii?Q?9q7akrVkOSEuWTcp8yosoUv3ryHFAuZ+HXUhkc6CB8TwxibjtX7b3YAXSUNA?=
 =?us-ascii?Q?8JNBNlCEb6m4KJEchnnMRF/p3CyQYfk0OKZeNL58y9NOOvBrT4JaBfDEM+M4?=
 =?us-ascii?Q?ioSS5lOTFJCTFBq/9q/MamllhysuTF1Prnr2zm+Hxun8eDEYVGnA3daxSjTo?=
 =?us-ascii?Q?AJUn53HUSJ0Q6pesVBwI9G31ClXad9CYX/QQXRzPbtEyTxEn4RqtF+gOeAXX?=
 =?us-ascii?Q?kUJMhQTD1WvwVNnKdQHuvMNXlVowpWawKMOsxIa8mZtQvCvlG39sXBz8MDng?=
 =?us-ascii?Q?DxlCq+4ptsrTx34oRTXp7UPvjWeLCQHsiueKi5R8G0us1CPh2GYezG0DhSYT?=
 =?us-ascii?Q?/QY7TPNO9jksXLpLzlizAYaSPi69dQwaa7a7ghON8+k74tvVUnX9TT6MYJQD?=
 =?us-ascii?Q?aYA3O0nDxnlF5gZCDtJwaqWhqj+rdtkExyCVTG3rUc2TLyD3Y2HKsTy3le6Q?=
 =?us-ascii?Q?cw07lrQo/jdZej502eH1iXDNX5ntV/sV1k7lporTGCdi6ZaC5MDnt0CU1fMv?=
 =?us-ascii?Q?V4U7uNNOcUf0JXok/XKIrvURTy4prXWYz4yY9DDs+PIjxuGKeDHtDxpIjsY5?=
 =?us-ascii?Q?lXI3VbyMOp87c9voFGtEj5bcqqh5yId5MnBG7AaFpz2HrGyw7/t926U8ft+v?=
 =?us-ascii?Q?zJKm8LkWLHNLzu/1hSBSDyaNk9KBWBcx8my7gKnwpeeJySt1iPLzQOTtF/1g?=
 =?us-ascii?Q?Ay9ooLKrda+xNgCRntxi3sqLQAmDpsIoNeXnBLDFAyrjS48Bh2VYhF+/OyhP?=
 =?us-ascii?Q?2K+frq477qk1vnNUqJl1g/sEYR6E/W4iceXFTeOJ07DPY6axr7F+D8xLv9hb?=
 =?us-ascii?Q?JC7JBkFU/J4pxZ9Cz8nygvLpTKdVlqCZVAgXjja44P2A81HLmj65NeZlZ4k+?=
 =?us-ascii?Q?l44NbslhbKvlzHpWrVK4utdlWCIpfUoC7/Qs+B+goInAFw10YthdV8AOAXO8?=
 =?us-ascii?Q?eLYkabvNNI+nf1agVok0DCJbIrCfHaL/3mJRMO/oK9lBacPsIz65TknRE2Sh?=
 =?us-ascii?Q?31ts8K4KIwJKLY2Nr4rUH3ptn0lSpU0hIJd2XWHY+0M7+u8QG19cLtV58Ksf?=
 =?us-ascii?Q?bw1UfBc1KatLfO5yQ/J6nQjYx3CEl2rO6IzIQPf6xADVe+Awynm9u/vv5t8S?=
 =?us-ascii?Q?9Y5nwR5rPEcqSZgYlxKXDmqC9OfPkqqMLyB9zL/+21brnIxXnWyfPEB7WX+c?=
 =?us-ascii?Q?TuYLxdaRLWzHhAUvXwdmjJy/6FUQrEuC9Id6mintxO0UU8tbJ2KeqXe5VzeN?=
 =?us-ascii?Q?JUWF/Gq/DcMydEenK9LxaMBMEQ/EbD0LgzZ8wF/LizGKBxEhBg9RsX8EBMRS?=
 =?us-ascii?Q?uKl9KiInQ6+puvzRrWDcz2hBCekLzwQIJ1ebouTYY2pcU6kJbUg97g3XvVnL?=
 =?us-ascii?Q?x4y77Q0W//noWGQvbcfE6ylC7OtnhkAvHT5V1gqE9O6QuuG390TsSSnDsatu?=
 =?us-ascii?Q?FgzRAkIffVEqf01aW3QaT8f4Ttc3nuBDv3ZbnlDRiki5TR68Fv7ct1t7h8C3?=
 =?us-ascii?Q?kBiG6fDk7WAon0NQEOsqaIPoKrzFE3P+Y4oYunA85+9/xvElt0CeoDEn025f?=
 =?us-ascii?Q?8HqlFu+LDlTi0XaJwEMTNOhWcwDCpnZpnvoHGhf9mLAzzejq6DEmGGaE3YE2?=
 =?us-ascii?Q?BE1igxodtRXEcGt8Rh41i6/6xGviX86hIru6aw1tuThjiQ5dZu/zYptUHHkH?=
 =?us-ascii?Q?jboLpnE6co97CGNZjuaYVbnqipxcZV+4nMyCCmZ3A16lb+vl1Ghi?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac5b62e0-0bc1-46a8-ecd3-08dee98388c6
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 13:00:28.1291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5PjYcXUJ8qXPlKCoY7Vn5qbVx3Fhj1LfhMqbmgsLH2/gAR6Qyq5eAsX0gZgvXkHJvD8PQGEZV9iWiuH1hjj0WvNVJazKd2ruhU8V0IlUq/p8i2cqH+6Ndrc8JGqjq07a
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
 in this tree. Likewise kept platform_get_irq_byname() (mandatory)
 instead of platform_get_irq_byname_optional() for the error IRQ in
 rz_dmac_probe(), as commit 6b3a6b6dc074 ("dmaengine: sh: rz_dmac:
 make error interrupt optional") is not present in this tree either;
 its early return on failure becomes a goto err jump to match the
 new call order.]
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 96 ++++++++++++++++------------------------
 1 file changed, 38 insertions(+), 58 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 06952519f509..fece2cfec1cc 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -780,27 +780,6 @@ static int rz_dmac_chan_probe(struct rz_dmac *dmac,
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
@@ -813,9 +792,9 @@ static int rz_dmac_chan_probe(struct rz_dmac *dmac,
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
@@ -831,7 +810,26 @@ static int rz_dmac_chan_probe(struct rz_dmac *dmac,
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
 
 static int rz_dmac_parse_of(struct device *dev, struct rz_dmac *dmac)
@@ -858,7 +856,6 @@ static int rz_dmac_probe(struct platform_device *pdev)
 	const char *irqname = "error";
 	struct dma_device *engine;
 	struct rz_dmac *dmac;
-	int channel_num;
 	int ret;
 	int irq;
 	u8 i;
@@ -888,19 +885,6 @@ static int rz_dmac_probe(struct platform_device *pdev)
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
 
@@ -926,6 +910,21 @@ static int rz_dmac_probe(struct platform_device *pdev)
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
@@ -964,16 +963,6 @@ static int rz_dmac_probe(struct platform_device *pdev)
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
@@ -986,18 +975,9 @@ static int rz_dmac_probe(struct platform_device *pdev)
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

