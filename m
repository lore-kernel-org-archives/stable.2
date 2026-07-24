Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010048.outbound.protection.outlook.com [52.101.228.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17AF3BED66
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 12:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784897764; cv=fail; b=Myccfdu4aXHvs03Vy/cIEBVbxhAampJhMIEmt5pQQT29V+VbzwN6eK6ynVLmlGc4PKuxb4YugXoTKBQqJoMpIPeUstMJ4dIz4tlioxA+7rQJL1NpM/G894yZ1CiF7X7+nrrNFFCGMWqzWA9XqLkV11tPjhZUAoCO4l9STbcvuRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784897764; c=relaxed/simple;
	bh=zxPTotkceddsvq2XLt6cq2ZNOyAQoXLzQw2bkqaLHZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oRJ59xvLGExgeXswmhGpgAd298tGCrBx6h/iHft5O0lqoHfd30Vfa5VDSDBXlthi6k0bk2+P/CGmlbAgFH00N1axjKzN396z5OargYq+cWA8gir7ad/e48DWFuUXf34FA0Pp2NL0DKjcj03FsNrwj5a7moIpi84NJ/zAJD/jsls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=Yg1su6cl; arc=fail smtp.client-ip=52.101.228.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="Yg1su6cl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Phl12px9AJU/h91eUveT1P5Hy/en2hiKlQoBYoSraeY8LedH+9qJ5ZY6UHzu78L1VrQTzWnlD+tB7E3TZy8/al8TDctnxh1igJRs4+6IYTKjVUYUkGXqFJjYEINt7vOhCQLJWUDhIhNLFTw7S/fX/UtZnONngMVzTtJe3oy4PKvi1ilUXE5jvg/e0Mrv6MAJ+C+puU2pnSWmolnmo7K3HsEVREHGhePJ7jAJYYHFMRg/tIRkKa8b4VMdCsmyzTZ0/iwTwXxPiF0lRQ3R5LVSarOvegLoO97AJX76x+GiLSsLZG2Dl5RA54qzt1sYpqV5IicIZ7E8xkbWe445VC/KbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pUJ+rq7x3PQlv2UPYuEQU9NrlAm8BE12TgetrRDiPcI=;
 b=ZO7X4OV8HjgIl7JONoNn2dv5sg8lWJQp8MiEbGAz/2FkKoxri+G7/r0cgu8KsrEcT/isqkTsTPyZ5mQxn0kfkA6KHeiq3/udxAg2JrkIgiYBb3fJfnn7A1mtFZqUJjr5pXMia7g712T5Pavy3+eE3m1V3ZYQDXWZ/UUK0Wi1Wodn6HGmbyyAdbE5oiWwnfdQQSZXcVQ+b4uTo1G8wtjUNo7hAMK5IQn31NJiHz4kuratb3p+Y8egvBOLoPqXr+2JVRDEY0AIC0lL/XG+a8TNPVN3BypdJ9fxR4Dcnz10wEjXB4hdlhPPN7aT9wBl8friUNqPBbulokdTzSZF3vB9rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pUJ+rq7x3PQlv2UPYuEQU9NrlAm8BE12TgetrRDiPcI=;
 b=Yg1su6clxlSyk8/ocSywWXfTOmDK05Vy+glZoSdgvDe3kQcACZwPEs7ENjZyRO37+q4zeCjFDHP5UeQt0v2OI+Dn3M24LrTxHunn2YG2NVIEMRdBdihX4bxBWEt+iZ1TPULbGIePPBdBU7bYhc1Z1El4DZxqcuHK79sQtZYkbYU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com (2603:1096:405:18d::7)
 by OS7PR01MB14318.jpnprd01.prod.outlook.com (2603:1096:604:386::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 12:55:59 +0000
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828]) by TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828%4]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 12:55:59 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: stable@vger.kernel.org
Cc: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Frank Li <Frank.Li@nxp.com>,
	John Madieu <john.madieu.xa@bp.renesas.com>,
	Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
	Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 5.15.y] dmaengine: sh: rz-dmac: Move interrupt request after everything is set up
Date: Fri, 24 Jul 2026 14:55:37 +0200
Message-ID: <20260724125537.2966627-1-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <2026072021-depravity-reheat-dd28@gregkh>
References: <2026072021-depravity-reheat-dd28@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0084.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::20) To TYRPR01MB13588.jpnprd01.prod.outlook.com
 (2603:1096:405:18d::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYRPR01MB13588:EE_|OS7PR01MB14318:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dab667e-abe3-435f-afb7-08dee982e87e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|23010399003|1800799024|366016|38350700014|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	gspzldz8xjRl1NyDebLV+d4DBUrnp5zLPh0vZD8ewyZUi1GWu4bap6hE7eh1KekOMarxDJ+cfjzpuOPhk42+ITrnuk3c0ll3gMDGiCTRZXb8d/8YcGYi4bHtT5geBzdtyMn80ffiEeygbZlwq+wiNXRKkNYt0GJEe2Qk/t2il8DkLjcuKGxYPj/klUTSB2Pf/6rKvy3cRejoOsFmw3hpYvdKRbOleM3BuUWYPB0BQJxZI6baRUZAOov6qCtiF/rMhuLJaIE5Tj3m2vwB8I0nxl/5EE2HbMwr3nj6Ol3wuyTDcHvqST0t/tpaWvoW0cCmV42o3j1eALWiAk0muE3mu155M9CZwb5dGU0c00rDI+7/KWEU5NOIBjtk/Kxka0X6hdj49d9qfBJx1vEIwI/geRNWhtjkSjjkl8PItdA5KCwMdsPy41PSiWOHc/1c8C3Mz1ZBdzcLaob64F2vuHLSLVFwzbiIHSogqaHHm2nHgFVdjOyCAaxfSweFq72dsOLYG17VZbeIAcYP/Vn8HAcXLnv0JQtj4BWVprECq0oZ0nnaQtqJkXKWBbKJkbqg4VgHarzAyDNL7kjq7kq5D7U0KthxqBgpPeMuLLIasofz/8mdAR0znWgROy4zYJ5yRTyexrukv/NRECkOXIKo3ORV7ZuP8cyO54GxCwboQZ9e7w8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYRPR01MB13588.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(23010399003)(1800799024)(366016)(38350700014)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wf415IpHpK1yuRYERAzPpxbSeCOOGYCw+o1fvDbjygPsSFOXzSmm3/npenPe?=
 =?us-ascii?Q?fs+dGzTWkhlfFAbU7eIWI5LdP77VJnDL0O3rOA0aFg1y5EyGT1CEBSaoXSLs?=
 =?us-ascii?Q?Akm8YEjrXDpWLtHVvGwEIEONf9Zwv7dLOTBUXlCquOcBCf9p9sQEUihg9dFO?=
 =?us-ascii?Q?pMISq/JqWXWyhJcC8Yv5k00eKFAepOgQoI4GhsX3uGuKVfMe0FThOKLzgvWi?=
 =?us-ascii?Q?ucHGRXQ8oKw+UGuarhMHv1AMOjIS9crRK8tbm7Psv55h2x2HE6cvFcpHSz7A?=
 =?us-ascii?Q?2LlG/37aCs7YRtmeW4wizNP7s+tyY2V667i8i+0hCCV4XhoQk/MAtgK+omA3?=
 =?us-ascii?Q?2o+fSBKfhSEPZETfrd7nTwCGOOWNlr0QPMcEVIyFlfLjDNWJFPlh2avyGvSZ?=
 =?us-ascii?Q?Vu/i3wzu7b1fc5wdgYBmUFdlX+qAQu4vX8kqd/RJfb9JGzQccjpugAIdBcmg?=
 =?us-ascii?Q?GIZTG2CXmyKOjAx5PEPTqyczFuE/bU1IOIZ+MZTSQZnwquQRrFDec7WGSBON?=
 =?us-ascii?Q?MrW7UKZOzc3OzcptqN+owBk5ElM8/pQmV5uYQ3/cx5zz6zpL3t3U7l5J2jmo?=
 =?us-ascii?Q?FIYpOovTYNpxIUuzlP+ne96PfsUoeNs7AWdIjrtrZ3/Uv1tI/Huoms8aGGqw?=
 =?us-ascii?Q?AzM5mzghImcKVfr4q54UvyVqy4gKdIOGqEnY0oSAKbRPUX3t9Fi0q6avOdCf?=
 =?us-ascii?Q?fq9FzMa8PlBfP3evzAXdsVgcnoNIe1x6A80uh2n2CGX6ni4WjSmfBkWoDNf6?=
 =?us-ascii?Q?XGI69s34GWll2M4NNpAsGe53DNdYQYkJMRb5NL6Fz4pOcs84YLj6IRU4XiI7?=
 =?us-ascii?Q?6nt9jRVyxP7ONsw+dIsL35yUisRrOzO5z1fXmUS3Ka//tA6BCwHybcgdLovg?=
 =?us-ascii?Q?0jStiWulBzO0IRhsRPR8pTwyoExZhULZzSeCIAvDjief+gpLYzxHJ2hjLwEF?=
 =?us-ascii?Q?oIHgusj+pB2Vo+sXeQ0fAtpsH013g8hTTT86sLNJpLzbZEObS2GNi9VBgjQV?=
 =?us-ascii?Q?hUGe9SwaS7TT6XGU+QZYAus6r1zNSRF0kAIeRKUBng0GOwquqw7T4VJuY4Ue?=
 =?us-ascii?Q?d8mr/SVHconMqmINCV2AU2gvzIpIXkORJtPCjG2c7bsdmA4XGFavT+nF7Gb7?=
 =?us-ascii?Q?fk5xUqIJ5Ag0xLZtGOoN2LwlHYA+rfpvV+SRfzj1Z+oTCVz5ESbFlsPQ+0yO?=
 =?us-ascii?Q?jlbTPVBQB5eqg4ql2WSEqVQl4In5MdW7ZuJxg0E+IqzX8/y6mgb2oF6EHVpn?=
 =?us-ascii?Q?2A+qoXow2yt1XaHnDZHc5aO/Zz15ZHXWjNTSRlXC9jYXxPrRuGixsjPSTt+f?=
 =?us-ascii?Q?CyZ5gswuC1Lz60wqayYF+hR2ail/9v5AfZ4Lx1sy6E5kMEsNcNUG63r2yuqq?=
 =?us-ascii?Q?jzDerIbBEM/91LZ1zDYsFkCMA7zRH9H4uCqd9Qo0B8EUpW1z8p/l7O3i0NIK?=
 =?us-ascii?Q?KYhY9VcKFJcGUhTZV/n6u0VAUuyiP4DAoD/V68wBtAQaxwQm6mOfQhoWrrRO?=
 =?us-ascii?Q?nUjTQFglCUKJX2QUZcpOJHWit+/WEkr/US2Ap1j4OsI9aTXFUS731/xOTbi0?=
 =?us-ascii?Q?DRRCUmZG26I0l9Qs48Jth+JHuES8S/VOzAgMndAIUVA3BNuSP971uSUBj5Qc?=
 =?us-ascii?Q?fUwFHR4gmls3E90Af7qtiLqldiMHzwEZqfgIaVX492FvYa+aBW1gTcm+Li8b?=
 =?us-ascii?Q?+6yCgJc5ladDCOpIhQ6gu8Oq2FL9Bh9VgyG24Fx2WwqrG1AyMzNzmzgAuRCk?=
 =?us-ascii?Q?gljWnrFaOuB6TKdlxwiH5i/q3Dbjf9vja4idEPTdrNNB+0BZTnsr?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dab667e-abe3-435f-afb7-08dee982e87e
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 12:55:59.2387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xW0qscsUxOBpWQQkEPN8MRwiJXrYDPNR666UHEXA5A2jUSus2jJiHQltCNB48fED/IMSYlKnws8oH31sgLX/QwzJ4QU3s5IfMY9FE+ATgJJg9xd5/P8V9aEGQQp/gqtm
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
[tm: kept channel->irq (a struct field, not a local irq variable) and
 the sprintf()/pdev_irqname[5] pair in rz_dmac_chan_probe(), and the
 mandatory platform_get_irq_byname() call for the error IRQ in
 rz_dmac_probe(), since e0c51fd02f9c ("Make channel irq local"),
 c4d6dcb3b625 ("Avoid format-overflow warning") and b34f3fcae72a
 ("make error interrupt optional") are not yet backported to this
 tree]
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 94 ++++++++++++++++------------------------
 1 file changed, 37 insertions(+), 57 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index c22743e41640..cec94db38c55 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -773,27 +773,6 @@ static int rz_dmac_chan_probe(struct rz_dmac *dmac,
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
@@ -806,9 +785,9 @@ static int rz_dmac_chan_probe(struct rz_dmac *dmac,
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
@@ -824,7 +803,26 @@ static int rz_dmac_chan_probe(struct rz_dmac *dmac,
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
@@ -851,7 +849,6 @@ static int rz_dmac_probe(struct platform_device *pdev)
 	const char *irqname = "error";
 	struct dma_device *engine;
 	struct rz_dmac *dmac;
-	int channel_num;
 	unsigned int i;
 	int ret;
 	int irq;
@@ -881,26 +878,28 @@ static int rz_dmac_probe(struct platform_device *pdev)
 	if (IS_ERR(dmac->ext_base))
 		return PTR_ERR(dmac->ext_base);
 
+	/* Initialize the channels. */
+	INIT_LIST_HEAD(&dmac->engine.channels);
+
+	for (i = 0; i < dmac->n_channels; i++) {
+		ret = rz_dmac_chan_probe(dmac, &dmac->channels[i], i);
+		if (ret < 0)
+			goto err;
+	}
+
 	/* Register interrupt handler for error */
 	irq = platform_get_irq_byname(pdev, irqname);
-	if (irq < 0)
-		return irq;
+	if (irq < 0) {
+		ret = irq;
+		goto err;
+	}
 
 	ret = devm_request_irq(&pdev->dev, irq, rz_dmac_irq_handler, 0,
 			       irqname, NULL);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to request IRQ %u (%d)\n",
 			irq, ret);
-		return ret;
-	}
-
-	/* Initialize the channels. */
-	INIT_LIST_HEAD(&dmac->engine.channels);
-
-	for (i = 0; i < dmac->n_channels; i++) {
-		ret = rz_dmac_chan_probe(dmac, &dmac->channels[i], i);
-		if (ret < 0)
-			goto err;
+		goto err;
 	}
 
 	/* Register the DMAC as a DMA provider for DT. */
@@ -940,32 +939,13 @@ static int rz_dmac_probe(struct platform_device *pdev)
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
 	return ret;
 }
 
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
 
-- 
2.54.0

