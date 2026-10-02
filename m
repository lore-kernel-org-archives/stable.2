Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013038.outbound.protection.outlook.com [40.107.159.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2BA4D2EFA;
	Fri,  2 Oct 2026 16:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790959800; cv=fail; b=QhKdMyLiepwjXVBYKpFqWV6KCN8F5J5vEgXcStFHUhYc03JXepRzEcBNSpkbFPpll2YFfiMT58VDxQKfqmT6KeQqTWocl0ZnolT0+oPjBpz4osqA7d9Og+wRIB02wnWiD5Zb0AfwFZoZyFQD+G6UmU9tPAia8RTrRkmpMrvjRSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790959800; c=relaxed/simple;
	bh=6nvBMHDJZafzZbu/bZc68WKJzMNCx6T/0ppMADBkZBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=umryHwalrGl+/SHqUUxkUx/NUT9BDa+Ci9HgwDv7ZXvEzeDaGjWFvqNF58grcXudYhhysngn3wi+hcfd/aVPRfL88thJzYKMMqgjvdMcd2rRsEDPCTplEneBkghvY9k6sVKRSv9kAJuthyoBscm487YiABabQ122Y2aIz2gS3aE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Cv/Gaw4f; arc=fail smtp.client-ip=40.107.159.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Cv/Gaw4f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bSLN7I4GtG3ZXvCyIOjt8XLH3ljfTAdBpbRnrhOhj3hqGtu1S1w59tPdqkq3zUYS4TchPYvSn6xBR6QAraewsSyjOQAisCT0F7DF8541yYWdgvmJ5gi3LDwNtcE1S9N/pJyO4qdDC28fHxZw7NYFc37wavf7GZCcG/eVs+0qkiCmzxLAFOX5jVfOjpcIMkDCtQ5+QOP6TV0PtyKnIsnVNSgJnowhP3U/RSCQC+wAdcira/zH3Xgw1g1IoTwB9gEaxQfQ6vZO7LNtli7rCIYYfPFph0U0AL1kPZM0YMVnSjanxkOtOshq5p1ioJW5eFM0YqAGkW92/JrqMho8282bhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sqH1FCttXn5r1cWXiQ0jZqNx22aSJGT6z5kjfWGaAFM=;
 b=AtIkPvOI4U9I0UcKALaormQ+6UTa+m0m8zOqiMq758bwj5I8nMJe4EeGC1EBLnlWd6GPhf8XwVQEvevvJ8eVFdR24XK9AG/8UQGowy7pemfSeZpT2eExqMnpwyFRP2HPBNBfOl0x9278nt2pjA5zc8u7x82iCplNdd4jdz6SgQtdorJnzqGHwQo2Sed4F76UUUdu0PE5o+X2i6fCQRUDxewSVHrUeRr/p2b8EjNzuk/+gTO4hVUey+CU5x6bB4Grwfl44bQKt6gzh/23bkc+LkJ1m7izHZyyVYyg/fZe1rkVVV69N+fII0PAAPKto7An/1JQ1/uD1VfH7/BRdrAcvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sqH1FCttXn5r1cWXiQ0jZqNx22aSJGT6z5kjfWGaAFM=;
 b=Cv/Gaw4fK7l8Jk/JHTLUZ+BXiV2xmOgSCY2nkRjo5J+45ZvKiykf7/w83OmTLJKaaSgkXyukbX0egkNIjfdrxNjCUMfRn8/RGqiJTHrdTdQtIPv32eZJHvFL5cw0KpRCHbe6vgk8bQ9D//KxKUEQcPKf9XTAqHUFq5vCidTbXQBteSynQKv9/u+8w0Flx1J7qrNbWsKG3YE0sEKUoX6rl7zl1NQJJ4QICVwZbYQFkl1KT60tHO5l/bTRtzGA0pwxt4+BtuaEOfcvUdIk/DJ7wsE1T7JPQ+8LI8ugFWdCodogrHgwH+VCjr8gxQ3KOvgc/myDKpJ5BOLjBvKGMida5g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM9PR04MB8454.eurprd04.prod.outlook.com (2603:10a6:20b:412::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.19; Fri, 2 Oct
 2026 16:49:54 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 16:49:54 +0000
Date: Fri, 2 Oct 2026 12:49:46 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Andy Gross <agross@codeaurora.org>, linux-arm-msm@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	brgl@kernel.org, stable@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH v25] dmaengine: qcom: bam_dma: free interrupt before the
 clock in error path
Message-ID: <ar_gqlHElQOGN9KV@lizhi-Precision-Tower-5810>
References: <20261002-bam-dma-free-irq-v25-1-f39e01d19910@oss.qualcomm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002-bam-dma-free-irq-v25-1-f39e01d19910@oss.qualcomm.com>
X-ClientProxiedBy: CY5PR15CA0172.namprd15.prod.outlook.com
 (2603:10b6:930:81::15) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM9PR04MB8454:EE_
X-MS-Office365-Filtering-Correlation-Id: 02f87f10-a73a-466d-9c91-08df20a52f13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|19092799006|23010399003|376014|56012099006|10067099003|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	f+lvDrb/J2Znf4AEmx1fIvyj351jhC1FXYgS60UF+Lvpy4/w5CTWRIClx2AD68nSi9U2aCxmOy5EhtTPtFhXMiBX2O2syMzmQY0eq2dimtJnQyeEE5/1zL4y231C8eqDkbtAmhFeYEy38+CrU8xxbAuTUB1n3s/axIPZVQMaxLyJ5MDyAZGGj2a/KFMKeXVYeUkAvKd6FrGhEMFdnQm2sE3D26z3eKJPstXX8PN1gwqTq/YsI/S5LbgRDsIkJJNki2YP1wed2hHvN57QogLbWNHZWu8c7heO77TlMiG/u8oirpK04HrDmvw8N0NYZ7YDKoRdPZ5GI7NPPho1gzj6m95pWniwCuH6aiTsEYKvScT5GgfAVDpbIjryzI0/foAZLsWIOCtL9gV8Y2DSXyB7FGkEsq0tuhD9IAIkFgfMvpApviQ6RYy4kudjuza2CyBvPGbDOkJ/6YbUkk5J1/CFZ23bMHyhkP3bY6hfg4Z5J0tvyCBHBxVJwvoekUQizOgJ9SrHjEL7kNlmI5kJxpI99eK6lMtB2jpSIG/2+MOjGjtn1OdbyU2CywwylnnpytAurBx6ik9XKficWJ8B8aOuEoVrdp5Jq0n42Qeai1FUxog=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(19092799006)(23010399003)(376014)(56012099006)(10067099003)(11063799006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WAcU+vQoIbyqA1SXY97Z6TjIN6laY+owl9R5L0lY5vfGPOkbiM2idPbM72s2?=
 =?us-ascii?Q?l4YkdKUPDQTjeYibLTWUe6ayHo9YIVAck/g8putLV0Ia8hHGdYjiP2GNhiff?=
 =?us-ascii?Q?dqTZZpmqS7IwZeyIsqY8pIOFwnWBhrBpmGZELQ391zYCUyMlyg9g9DYGxa0Q?=
 =?us-ascii?Q?RRu1ga/40WZHK3kpQSdoWXoy2PazGVaBm3UwhaDcscG5GN6aX/xL0YMQrurC?=
 =?us-ascii?Q?Wa88CopASgp0Jvr0+/CPtiVV9ipNRJXIT3UtzLdyojsdA2XQ9NDr84jXFdBG?=
 =?us-ascii?Q?1lW8dEqZN3Yo7MykOVfQQd8BszwWbhoCQpfWt8E0B8zA2QTAFc3zkqX01zwm?=
 =?us-ascii?Q?qcf05vsGiaBpEVTZFHu/rUqUSrZSygmpyHluMPxUogRZmE0gLnuhV/Hz+3zj?=
 =?us-ascii?Q?1roxJpncijZgTdpFgCrRHFPqepQIiRQSOaglYD1iZVjEVnX1EyHrSnxi1+8w?=
 =?us-ascii?Q?HrgEQSwpw0D1w5//Zc1Y5Qt4WW38YAxgeuHDmjpK8iDZDsZ+iMV2bz++ao2s?=
 =?us-ascii?Q?uQZYcBat033eeZl08VouTDKnZJCzdGWjtmsT4RqIDP4EUu3wnrbYVrcUFpZt?=
 =?us-ascii?Q?+gUWmBpyyBIdrcokVDmeTHzMz38msglucrNSmXgd5DQukQgLw1QsN1pa7WLg?=
 =?us-ascii?Q?YdpCT/PFXgf+WHqAl6z0eZAirmfCbRRHHeWW7sV5Z4Ui5DQ+GAgio7InOoeg?=
 =?us-ascii?Q?M+BumnfDBnZxtxampuUw/o/38vKpvw2yK/moNPiTcMRXb3/Kv+/rdDSIiPab?=
 =?us-ascii?Q?fsEagSEk2ODY2kZ6zQd5cCFq8ytteGO50WtEjgROT6014DzkifcDNzB6TTFx?=
 =?us-ascii?Q?hoE75VocDRAVSQGF5BC/QGswoQGYi8Ase+/h/lOBfBi+ZEOC9XHPfkgmO8S5?=
 =?us-ascii?Q?pRPU+NxbNG43E0U0b+1iXplYds+vLJmAuuljstP3Bh2mD8acYskrKR5uOif/?=
 =?us-ascii?Q?H+CLzs6eyooG2sTGeGQ6ZQGVISHnfE7OpYuPEKOqSteMrlNQ3xH3UJk1CwkF?=
 =?us-ascii?Q?a4W/3K576sSg4Ill1Lppg862iYORNyz0Raxu/OKC/yRV4mILdwpbaJhvX4Ax?=
 =?us-ascii?Q?s6T6QWEiTTgqGIAL26J+NbDSH58kOnw8pGc082d74D3aebIwkAUuQd859nyX?=
 =?us-ascii?Q?1ufGiORfQ+r3fpR0Oq+I6+ouQzx18OMLdwqpKR3se+Bc2N0t/emHss3F9KJy?=
 =?us-ascii?Q?54XQrAR5N/txZxLi+6W60KVvUoOUtAAnmYeyNGCwFzDMWnyOZgLOZzK6cBpy?=
 =?us-ascii?Q?RoJe9go3YKW3BQOjfh0+UvbfpakRudtj9QM7PPnOi+bYWGhqf4Id0JKTrEg/?=
 =?us-ascii?Q?T/y1NsTjZGmeSZUrqel41MjfhEtl133T/NisbYrDZcGcCGXACVjOJB4QazqJ?=
 =?us-ascii?Q?U3iN8V5RJnUl63kzQPlLuW7epXT1fQJNqQU2E6c8l8iMLu7Oqj7uhGFSEBns?=
 =?us-ascii?Q?xJ58zVcThTQow4WFmJ8O4CGDE3JeVgalRJpmuitqI6hRTBTAHvYF1QlmdJ1K?=
 =?us-ascii?Q?yXEm9uSTE6PSh8kh+Dx1DW3++1c97rqycMigf8BU7NaAjllQ4uWdgjfcGz7z?=
 =?us-ascii?Q?IpOn3b5IWAVUK2mV4uF6wyDCJR76GH2zoCcD7kjTWl3M8gb0TuDVpk+1BdkN?=
 =?us-ascii?Q?1KkMO6qMIUV8b6MQ6kK6hzcVGadCoHBO7lvtBrRnAR1JjGb4lxGpc8zEkT5g?=
 =?us-ascii?Q?wJ1Vh48kGUYj/yC23co9xOr5I0J1nttHDjbe7u9jggNdMxK1O0ulLrj9yPyT?=
 =?us-ascii?Q?KU4kr+XKWlI+H2Y5UtRFlkEyfOjkube1/nKcQm+bwztnw/2RUQF5?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02f87f10-a73a-466d-9c91-08df20a52f13
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 16:49:54.2880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kpKEbXwMPiuPQVwvG5q2mFqmJzTuJ02AS/Jcu+vOfugj/VUjyjJHTCSuRIKbMhPZJ6NmvD8kzdB/Zrk7kZh5I6OtzttzEuJrQF4Grx+osZkHhaS3c4Wa5NQs1jusw7bS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8454

On Fri, Oct 02, 2026 at 10:51:47AM +0200, Bartosz Golaszewski wrote:
> The BAM interrupt is requested with a devres helper and so on error it's
> freed after probe() returns. We disable the clock before freeing or
> masking it so it may still fire and we may end up reading BAM registers
> with clock disabled.

It is less possible to happen. I see other methods to fix similar issues

https://lore.kernel.org/all/20260608001128.80090-1-dennylin0707@gmail.com/
https://lore.kernel.org/dmaengine/20260927-dma40-fixes-v7-6-89f595e8851d@kernel.org/

>
> Stop using devres for interrupts as we free it in remove() manually
> anyway. Add an appropriate label and free the interrupt before disabling
> the clock in error path and in remove().

Just want to avoid bounce in future, change back to devm version.

>
> Cc: stable@vger.kernel.org
> Fixes: e7c0fe2a5c84 ("dmaengine: add Qualcomm BAM dma driver")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260427-qcom-qce-cmd-descr-v16-0-945fd1cafbbc%40oss.qualcomm.com?part=2
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---
> This used to be part of the larger BAM DMA pipe locking series and never
> got picked up despite months on the list. I'm resending it separately.
> ---
> Changes in v25:
> - Don't touch remove(), it's not wrong in its current version
> - Link to v24: https://patch.msgid.link/20260723-qcom-qce-cmd-descr-v24-0-4f87bb4d9938@oss.qualcomm.com
> ---
>  drivers/dma/qcom/bam_dma.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
> index 05a3b1f9e0c23dc5f861488fae03494867970523..a626746b5c93496e5c5e885b35a856d38c284448 100644
> --- a/drivers/dma/qcom/bam_dma.c
> +++ b/drivers/dma/qcom/bam_dma.c
> @@ -1332,8 +1332,8 @@ static int bam_dma_probe(struct platform_device *pdev)
>  	for (i = 0; i < bdev->num_channels; i++)
>  		bam_channel_init(bdev, &bdev->channels[i], i);
>
> -	ret = devm_request_irq(bdev->dev, bdev->irq, bam_dma_irq,
> -			IRQF_TRIGGER_HIGH, "bam_dma", bdev);
> +	ret = request_irq(bdev->irq, bam_dma_irq, IRQF_TRIGGER_HIGH,
> +			  "bam_dma", bdev);
>  	if (ret)
>  		goto err_bam_channel_exit;
>
> @@ -1366,7 +1366,7 @@ static int bam_dma_probe(struct platform_device *pdev)
>  	ret = dma_async_device_register(&bdev->common);

Can you update it use dmaenginem_sync_device_register() to update current
base?

>  	if (ret) {
>  		dev_err(bdev->dev, "failed to register dma async device\n");
> -		goto err_bam_channel_exit;
> +		goto err_free_irq;
>  	}
>
>  	ret = of_dma_controller_register(pdev->dev.of_node, bam_dma_xlate,

devm_of_dma_controller_register()

> @@ -1385,6 +1385,8 @@ static int bam_dma_probe(struct platform_device *pdev)
>
>  err_unregister_dma:
>  	dma_async_device_unregister(&bdev->common);
> +err_free_irq:
> +	free_irq(bdev->irq, bdev);
>  err_bam_channel_exit:
>  	for (i = 0; i < bdev->num_channels; i++)
>  		tasklet_kill(&bdev->channels[i].vc.task);
> @@ -1410,7 +1412,7 @@ static void bam_dma_remove(struct platform_device *pdev)
>  	/* mask all interrupts for this execution environment */
>  	writel_relaxed(0, bam_addr(bdev, 0,  BAM_IRQ_SRCS_MSK_EE));

Actually there are problem

pm_runtime_force_suspend(&pdev->dev);  it will call suspend, which disable
clk,

...
writel_relaxed(0, bam_addr(bdev, 0,  BAM_IRQ_SRCS_MSK_EE));
access register

clk_disable_unprepare(bdev->bamclk);

Maybe cause refcount overflow because previous pm_runtime_force_suspend().

Actually DMA driver seldom remove. It has another issue if still have
consumer acquire channel because miss dev link between consumer and
provider.

Anyways, if you resolve above runtime pm problem, irq problem may not
existing.

Frank

>
> -	devm_free_irq(bdev->dev, bdev->irq, bdev);
> +	free_irq(bdev->irq, bdev);
>
>  	for (i = 0; i < bdev->num_channels; i++) {
>  		bam_dma_terminate_all(&bdev->channels[i].vc.chan);
>
> ---
> base-commit: 9f24d789f03b22941b905ded43cb5ff8eea9ce62
> change-id: 20261002-bam-dma-free-irq-cac4b268c465
>
> Best regards,
> --
> Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
>
