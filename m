Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011002.outbound.protection.outlook.com [52.101.125.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBB63AE18D
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 12:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784897681; cv=fail; b=jsx9NXElcjoBNRZcxCaoWHDMQaJUsMN7lzmUD6L6o9WERX9OcBJBUAFA5r5VPkN6YYnP6qyynu4W7X5GLd4o2sSR0m3H5Zs11DXV/KFHvGiJYoQyC3HpXGsu6EzwRRPmcOeEaP2GMSbM3NSU/R8Sq2/TLr1UJG1mkqNhaWFGK2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784897681; c=relaxed/simple;
	bh=P+8H6/D/Jk5lwDDUoaFeQ0JY/k8gbCfSZsPik6xh7t4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NzIweEHb+w2C3SwQoRQIA5RULIMNiOPuAWK7E/FLeZ6S0R9pmq+CH13n7WrIbHpu+KlKNLaNHUIIOg0C11s2RRRhShWMnBKdqJpBrvt+eUdjhXA8CRewFMXhGIZd19abH47Zqk14W4I8PsFwuKppw2NF8EE/IJuDP5+dKMyBGFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=oZcLs5Su; arc=fail smtp.client-ip=52.101.125.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="oZcLs5Su"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lWQf0NDYH65M+9n6UsVeXFSnP2NEalUl4JSt+l9yi+paZCKN2wnUsN4czW9W6YP6TsRlymtAa0s4bC8M3Shrt0our+OTHaFlyzM4BHYHejUmfDUuhC0noOZq5OGqRS8DhrDnKoUxS3AMoWUY6kkl6euvdCbzEG9a35ccz0IcLGVWqwR1vIYjSg1NioF0lTj9y0JL2BgisdX6Ao/JO6qRC30XTbWq+QnnanHRD8+cmFIr7+CLzH9YwDpJKjUWXbI4KfQThJlSFBaraC8+rFtnt0MvMiknhItVUh3sifnwpzQFHMib6dZDsqxcVqiydv+reR4KcdZYf2eqp6n0Cl/f/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Td2dMqQvTlrVeOWFBGFpJ/DrELjgypw3sQk5QGf4wKo=;
 b=oIoNujyvxee5p/L3eBoD3etWznMFN1C4jeZzEcEi7HE2Ln6zCKNrYSKrxYjp82KuOnWzOAFnrOFdVpxyj2ML4SUZvInVZzmhyg77MNNBHevjLFT7kMO7cNzKmEKUf0IBWkRZlzrW8Ycxhb22jeczXWAEq4pmkWvpFw7l90drZMsZrCGi+aYh+PXLTNRHP6yQRKA38hnppiwhrvHq4z8k85eHxZK239QOw57ot1jgbK+8U8Gw9YItPWyP8xJfm1Odg+F3vyckU9mGiH4MC4YI75v4//G/yE0KKbvwmUbwXR5pdyoQmewW/OwlOdyQVLtN57Ft4dG/OIjN3NPDP7OSiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Td2dMqQvTlrVeOWFBGFpJ/DrELjgypw3sQk5QGf4wKo=;
 b=oZcLs5SuZ9t3yMlGOSd1i3jCa8dbZO410P/ZHYhwJJDL+CR74PWsgv7/tITqxFzsYW61hkjtICBvSDu9DVTmnXceWSqFwOIjbwRlR7Kt+tk7qm7skgJpJjDQXufIS2HuDrwXzaLYb608PrWHKJsjV0ZRc0IHVuVDsoJa3niTX0w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com (2603:1096:405:18d::7)
 by OS7PR01MB14318.jpnprd01.prod.outlook.com (2603:1096:604:386::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 12:54:36 +0000
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828]) by TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828%4]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 12:54:36 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: stable@vger.kernel.org
Cc: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Frank Li <Frank.Li@nxp.com>,
	John Madieu <john.madieu.xa@bp.renesas.com>,
	Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
	Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 6.6.y] dmaengine: sh: rz-dmac: Move interrupt request after everything is set up
Date: Fri, 24 Jul 2026 14:54:01 +0200
Message-ID: <20260724125401.2966391-1-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <2026072020-shoptalk-chair-cfda@gregkh>
References: <2026072020-shoptalk-chair-cfda@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0055.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::15) To TYRPR01MB13588.jpnprd01.prod.outlook.com
 (2603:1096:405:18d::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYRPR01MB13588:EE_|OS7PR01MB14318:EE_
X-MS-Office365-Filtering-Correlation-Id: ea40adde-c28b-4d11-d546-08dee982b766
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|23010399003|1800799024|366016|38350700014|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	d6RKRw72UeJZdTPdzGkWkCv2voozRSFHH3QSIpADK3YKovedHDCC0v+fMi4kKmLbH0ILvwXJuAI/wzXVT9mcWU6/1ptbsm/21rsUpiO4shMPNJeHlD9VypxMUkxZ3HjVnUJyX96EBemkS3I92QJiL7SOpReZ3m5rc1TcbN/pEVRzVF/rICEbOkMtYqj2ziKrxaA3RTK61g5Upi1Wh+5qeg2m8cQWnRgmBObs9QYIaT/QPQfCRAEqkF4RH3Q8waPCQJIwb6wPjuSa6Huth8Q8kQJyvRYB2snuMGXnTDKBN9TRpGE8NHa2VprW+VF40gCtcWVBrUNMIcFafxDZuWE1CEE0KBLVmaJ4nIOTQMOUnOZiVdaL613Ie2JYa0RuOUpwW+PA5ts0iyHhtkpXTFc6Q17iX5T8EP4gM4U2giEizPQPaigHPLKGpVm88dX6y2BDSn2HeNjyxGz21/NQCsZHo+lIn+ClHNv6iHnkaseJ4PIqpBjPgxdliOqYOnnb7lyws8uNuZZJzuRyx7ngoqJrKR7y0kNYW7IpZoL/9H3uj7TxVux5LMGVUHgrFRNtgzT/s5z65nqQGrDsT7BX2n6B/ZxWFSMsSUYHBqIgGJdmA3JiW11yn3lynoMB1798tSsb9QLxsBSMlBWNd3y1EotMySaf4lSNhX/DhJRCprTnp/4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYRPR01MB13588.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(23010399003)(1800799024)(366016)(38350700014)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zLsnnxW9bs708M11oc3KHnyzNdfzPVaTt9m7jesqE/fJQma+HwPHre3n+Z/Y?=
 =?us-ascii?Q?A5Dmzpgf5FtrqWqDA7TWD02/3RMisNEeXapv0wU7m1eDOncH4/ouFdmtcb+6?=
 =?us-ascii?Q?ImeQDeTCxkGl7vgHKtP2Rvi1gNCgu3wRFLMTxZdKV9fC8EnHKCWztTH7F3wy?=
 =?us-ascii?Q?RZXHYfQAqx/Fb77Q06tOtmyU6bn+SlDvxDGRO9ASJTjFlRj2EPskihpl4Kn5?=
 =?us-ascii?Q?0uAiCsTIQzcL8mfPLdw/nBvHI0QcZnMeP8D+s1fgbu+ak6LrlYPX5e3ZYZSF?=
 =?us-ascii?Q?MNEoHmka+w5qzM/Ob4wxtEo4mVjIVQxrnLGrCi/Sg1WeZbp1D72Mr9HyfgMW?=
 =?us-ascii?Q?ezhSJg0WZ8ny5QwLBMgEvJmTpGwogGOwdzzR0IrITzHaz0zkEfrzBF+oxVac?=
 =?us-ascii?Q?MhxC8hBBxCeKXPAQPlUPCuDu96PoResbhCT2GYRsffWUrAgoWFaTuVLIEbQn?=
 =?us-ascii?Q?I4aB5y789mf1atl7QqEEG5H8vY4ehvan+uq26wYDqFnbjpGl/n2gUw8k0PoE?=
 =?us-ascii?Q?9SoiiwATwcGK9IPr7JIivMExNfc/obcDmP5GzpcacNExMYU6Jj9s8cmAn7aa?=
 =?us-ascii?Q?tS6CEEsGJwcCUHcVl7vBsXKNVZ+HKIBcPhw11CSRs7lLsphHnKyUHjchd/pI?=
 =?us-ascii?Q?Nd+0RCmWIFTDwpsgK/Alblc9HQL6iYneN16B1JbFpcgYcNKJcQKCA1T1PUmw?=
 =?us-ascii?Q?tyVaIAwxjsumO5dsbygWlf6HGbDbZXlunT7XDeMvB3g1HwBOcmSYh5Gkf0Rb?=
 =?us-ascii?Q?hoZHGXm9rjHJmHHnm71415XSsEDecq+G59INY9KEVE3cI2VRJiOrBqobnuty?=
 =?us-ascii?Q?4dVrl5AQCxoiFWb6dWUAlvuaSJw0FiW325hioXYCmBMTciJPofiwbnZqifgY?=
 =?us-ascii?Q?5x3PjC20RxY1wWq/7D//GbZ6IamNbtxpicScYC5NMSfp6XpzulNeHs6sJMnx?=
 =?us-ascii?Q?jPAOK10fxPUqQT3gPe1EaORq9VF2qzslfXY2V/OTotlcgmubCq0b1KHuoPN4?=
 =?us-ascii?Q?qQnp3gdyuVrRnz3g2UkqcxetqXvQKny3wgb5fMQDdIHlQoPvnuuGLGyXsRNc?=
 =?us-ascii?Q?JBSLWUW+3jQNuvMWJmZmbiSSx8KLFjU/oCE9rID/1vPrdLLTpS7YDh1JDlLb?=
 =?us-ascii?Q?Xyjx2rnDPk2rMadmgmtwxrvvXlYDTSMpMqPSZU3MAox1iF15cXdTYQQ+K7kC?=
 =?us-ascii?Q?RcOskFgVLBQh2XsU5TmkrxUglNodeoIJYDYUYleWxnGYbfNNkOUKj90de5I/?=
 =?us-ascii?Q?4swnvEPh6N6IDOZ5e2GCATqTmnQUomwS22gTE1XmlrZVw1WsdIadCZ9aLYhH?=
 =?us-ascii?Q?SF4BtsVx9n7dFm/xpuDFBKL1u8LjGZtfDlMqfx0HPWwjeqxXGl4sfhnz9l72?=
 =?us-ascii?Q?B8l6adI4SI/izYTAMn5rsmfHqk/XODdSi+YQCNdPMRNYr8Cn+WY74+0S4Kqi?=
 =?us-ascii?Q?8VW5NRWFpzfEy8OJEDo6gY5i+RmkASLKKe7AxhUrhfq3MR2GPcOBR1wjq40l?=
 =?us-ascii?Q?LiQ/2HXibJJJycVypIz6bzzozb5aP1cc1KxOnejzY23MuyKdaJVoWFykijZD?=
 =?us-ascii?Q?b9Cu9WeQK+ORC0BpYEWoOFM+kgUBPGSZ5GT/+IXAuHxtyf1QtyGq8r3dgO+V?=
 =?us-ascii?Q?hnCyY8e+nVoJYPSI/pdvcWFnIDabTZ7McMfsrjuizVjFHP3v6ZZWu31gKpEx?=
 =?us-ascii?Q?VC1W8rGkF5YN5lUUtcom7rOe1ma6b38r1cv89C2AhpgjGqm/pS6BZAVrnsLL?=
 =?us-ascii?Q?I3IY5kVbty/2KuYxcQiYZAjOjQsIvvMszEc7vs06HEpe2NUXx1KE?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea40adde-c28b-4d11-d546-08dee982b766
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 12:54:36.6473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 23C30JdMeei+wXsAhKSJMwk1rwhPF8U7wp+9gOftDNyWBbpy12N9s6kgO+54pE7Mlj4bimb4+Ljd096Qwvz620YMtrt9FTtV6TKYx/PK8OuHhaEGbFLVSse9fuMmN3Wy
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
index e5d89bc1bb83..63bcec46b01d 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -777,27 +777,6 @@ static int rz_dmac_chan_probe(struct rz_dmac *dmac,
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
@@ -810,9 +789,9 @@ static int rz_dmac_chan_probe(struct rz_dmac *dmac,
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
@@ -828,7 +807,26 @@ static int rz_dmac_chan_probe(struct rz_dmac *dmac,
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
@@ -855,7 +853,6 @@ static int rz_dmac_probe(struct platform_device *pdev)
 	const char *irqname = "error";
 	struct dma_device *engine;
 	struct rz_dmac *dmac;
-	int channel_num;
 	unsigned int i;
 	int ret;
 	int irq;
@@ -885,19 +882,6 @@ static int rz_dmac_probe(struct platform_device *pdev)
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
 
@@ -923,6 +907,21 @@ static int rz_dmac_probe(struct platform_device *pdev)
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
@@ -961,16 +960,6 @@ static int rz_dmac_probe(struct platform_device *pdev)
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
@@ -983,18 +972,9 @@ static int rz_dmac_probe(struct platform_device *pdev)
 static int rz_dmac_remove(struct platform_device *pdev)
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

