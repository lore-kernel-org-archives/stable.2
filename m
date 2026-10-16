Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013014.outbound.protection.outlook.com [40.107.159.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534074E5321;
	Fri, 16 Oct 2026 15:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792165423; cv=fail; b=qBBNH8E2PYYoA6VU4SVv0dWvWKimMKpGDyMH6yUJF6TJlinNjL7kZ+ss0b5rJ7H3bJf2OsQPZCkAkI7c9qVj3QC/pzrTqmyXQf3K7NPlSG2lNCbaIxDCpXUDHQ1UstCSQk6eb+BPLvMlqAdJeVKi0lSPJKX4sIsOeo09vCFJuhA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792165423; c=relaxed/simple;
	bh=Ri0wmJo7Us/tZkURL6xwmdi+Hih7oiSPQL5nr2iInXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=czUqb/83Z/Aekd1wincXn2EbeDaX0pR00G7TSTqDmrG7XM4w9AygU3AeaHeI53x96Y1/k47NKC7S5n/wVu6PZb//Uq8mBkaursl7T7gLIvCBG6B4mUO7Vf/vvzPNA6EoX3pEhkbpitmUTgaUtCC5+qjRwB5CrUv4bmx9DBtiU8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=GkEYc4Nc; arc=fail smtp.client-ip=40.107.159.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="GkEYc4Nc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MRuiX+q5vqNsLAveINfPqovc8TRkuUhrSiC0dKe+Zqcj9343VnbPbPmrz5q7GQq6lbgWiCUqQqT9RJekyPx53mncu9tM++C2NT9mgOO/7eEvTupJ08k08Km86iGhZ1wFgW3ouhO5Fw1PMdxAOfogyvCGzyMoLYI+CiuESwoV4J8MhP9Xe1vt68WezczJTfMN9wyw6h5rfJZfQeE7Jr+BajoJMakz66uOs+ynswRHjyxQqUBL7Ymo98fvHX+kUJZPT+par4SDXFAjCou+IMzXhr1XkT5SREeW93PXCO3OCTxe8zgTgbtob6Ombpq8ddA84QKspMjJzr27IKxvp36Szw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JVYCiekkOyhwUd0nYJup1UAFg8CDLC/MTHexAFCWBug=;
 b=qUOOdWAwbdlzl31Bqy5gfe9EdNs02gPBGP9+tmmRis0jrxYV5QTAit0EKkVfU4meesINgltPuEbNmmUU/xugboqb7Uds9KVKR6kOogUkESSifI4dEiBl36z10I1WdkF1dhYSrGwFwgaCj9YxwWBJmrsy1slVgW89u2CeLAsZQ8tV3HX12rkaHhzvCbP3H4ktLDMFjxZ6un7kcH0GBMso0TWv4JQiBanomwoFqCQliQ07hjTGaPyV+xml8pGcsYz6m/b9c8ipwYP8x+cClLX7j2S1pxPI9Zy2bHMzCeYP/XGw9uJ8AqnK7RNEzMH+lNaLdCgHMF9rctf9PKfzwEjvEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JVYCiekkOyhwUd0nYJup1UAFg8CDLC/MTHexAFCWBug=;
 b=GkEYc4NcWi1YFiUXvh4kwZ1cf9PuYGIonuXh8ygVRanxi6CTPai9Z9YKOXpBcp7KhK2FTNVRlftRlUkjQqSACKsNQBLDOyPI17gY7REMjJq1SRq/3kxHysNGIFAJfvgjQmOoyN4sHVWfwKXV5XMem64fcNW79xYdAEduTlTLD3EWeATc3D7W9hmKD8qmCWZNsfovG1npZ72mPulMLn5ly7NSRIJ2jB+CXQEKeYUtSd23+Jo6MKVLLIuA2T2FfhuSTIPjqyJ2oRICpm0E0M9MwQAhCkzS3Y4Tt6gufS0e5HoRmw8Zjf06mda9+g8BZ6EfaIzvrsYzJ1/ooqW7K68CKg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AS5PR04MB9895.eurprd04.prod.outlook.com (2603:10a6:20b:651::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 15:43:38 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 15:43:38 +0000
Date: Fri, 16 Oct 2026 11:43:31 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Hongling Zeng <zenghongling@kylinos.cn>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, wens@kernel.org,
	jernej.skrabec@gmail.com, samuel@sholland.org,
	dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
	zhongling0719@126.com, stable@vger.kernel.org
Subject: Re: [PATCH] dmaengine: sun6i: Fix physical channel index in
 interrupt handler
Message-ID: <atJGI-JbPGJEPqRD@lizhi-Precision-Tower-5810>
References: <20260706064123.66035-1-zenghongling@kylinos.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706064123.66035-1-zenghongling@kylinos.cn>
X-ClientProxiedBy: DS7PR07CA0023.namprd07.prod.outlook.com
 (2603:10b6:5:3af::28) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AS5PR04MB9895:EE_
X-MS-Office365-Filtering-Correlation-Id: dc5661af-22a4-4f15-cdf7-08df2b9c3f3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|366016|1800799024|19092799006|376014|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	VYjCKUZxn+UBaf3Z0jbXC4dV0piAbx2ihvs6YWO0ylD4971A4jF+rLqT68bI+EeH8B0sKVwyRMpYtTEJI9BnP8JZXN/epgbR99v2FSe9bLBdNr8J14Q4UksB+5AvofnRGnSu+jKUpyWOG9OEQw1np9/F/Pq6IVtwjd5sQ8CReae+//wrN+LsUwyfFz9ZEmgGlpnJewPW4rZ0e+f+xhjWCSs2DAPSJO14cmHtWDspK0bGf0zvMZb/Ezme8zkbLAX7VH6lfHvUIixysxEFcL9IIa2o2eoL+07v00LZN5GYnWk0uow9zq/ZT+wizcCeWPL83AoW/pgvs7Beq9unmhqN6ns/pldnfjE30mzDfVdFfHiatTqmORSEdCDfwIwXe70ZmfogzNLbNOQMBuPrLtmd64aX7m/L2yAY4tOHkHW0MOL+F+1VZwV+jfue59iDrLsfYjnOcjKcy0t8DWEdYKX/zvsisHe6ifZKE6mdm0w6ZxlwS4Op+v8hFQXBFFO0aw5rNF7F8KVnaIncBKcZGaLv3IorQ742mbVgdkx1+uy3LCW6aiVUmMiO5iSA0op/nfjP3/KX+Qvkzphk5Ecy70Sol68ULF/xnH4FTwDp/vvf6d/yOTmV+xv9Tf2972VvlOzO6IlnjynY+ExfQFpIzaiAzk0M82BvJ9reRXu2Wl0g6hI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(366016)(1800799024)(19092799006)(376014)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eDsptKBWpDyvqOU7+lDCPcs8/VcIZkGNnPHOmMV7bub/kr433O+0g9rjOi1G?=
 =?us-ascii?Q?6meC3BsEXK1iVzvBQ7tLYmnV8Ja1snINrSXgilpAuthtiLtKrc6TD0wyJmNo?=
 =?us-ascii?Q?dfiNo6sKF7GcByroynLsPbJnBKeyuFsI9rOhvv1qJ8mzalAG3ihZcut0+DLr?=
 =?us-ascii?Q?BJLBbShPdtJ7a/qn825ev7D9s3l5IktY2Yrn0JGSpE47dgPjRkuPYjCzPaHR?=
 =?us-ascii?Q?yoHtnrEt1YhBie7Urhfr0s5QQqHUUisvZnvsb4RasF3OmBk03HgrwQEko3ro?=
 =?us-ascii?Q?NgEMaj5mSxa6FFNndN+TQH5Gj6evGcR3MAWfamjvcKUpxuAJw0qSWa2I5Kv2?=
 =?us-ascii?Q?H0iflWqqXGNXXOofSETHp4HltOYe4F1iNPvscSnvVSMyyD4EX2BEDHpnbWpe?=
 =?us-ascii?Q?OYbtIzynmElZJR3QmpjwptnrgU11QIm6Ayul/9//fYXYkUxZlny24T1K7Z//?=
 =?us-ascii?Q?4qvXL2bwjgfxT82eKMMRdnwarYH97plyAZX/DNncMbVB6+E9cuLjWEv/zkEY?=
 =?us-ascii?Q?yurJ/HvSyOAT/nuuLAww/x6maHm0IAjBjlugBD8hPymKqxZj8SujM+8OYHxh?=
 =?us-ascii?Q?livlssFIvO49XBGxXiI7CXb4VKfGfwsM0Vc2LfmDznY6jt1HC4eiel+gzFi5?=
 =?us-ascii?Q?YwdGJKFzf+cMXq+kMbnY/1RSZJHuRfcnEW12XG2XDv00D5wTRa3RQPsEGwiv?=
 =?us-ascii?Q?IDzKkuVmkRdcZmuRl9p/V90SyjYj8Q/5JnCbIB4ElmnQrmh/dpZ1+tWSqxu+?=
 =?us-ascii?Q?Mlw4iECUvRZ57u6zUpdqX8AHjavLPLoODLT8oZp4cVLLZK7o3sYOCtEUmo9d?=
 =?us-ascii?Q?8OQ0r+ND31zAONfEST/NKa2OHC67y6HGtivMNcuTIcYR4rN0mKtswNL8Eqof?=
 =?us-ascii?Q?3sC1rdX517PEo6ka6hgkeYJi40GT4iL5oF7JlAhQpfQMR260vxIVYRVZgICI?=
 =?us-ascii?Q?tze73JwD+AZCR0/rdU9eo1tEhP6RS+Tx7m3cz8vD/d+gPNeMIBiV90AS7soH?=
 =?us-ascii?Q?ZQt7CQkobxiqkZztj1bYh7yuilpyRRi1fhnwplvJ7z6lkQygwIq0ScOCoU3d?=
 =?us-ascii?Q?A7q0bhfTc1zRoAHDcQacAofy3ojJTSKGy9P6I/xIlGSRI6kXcI/c6ckXyhho?=
 =?us-ascii?Q?XX4+ugUziWj0V/BI4Bt6yMmmrAmIqWKr6jEV9YmLfr+/WaAbTvtrlr6rivp9?=
 =?us-ascii?Q?tJs5iNJcDoUieeEpyuVOV3nTPRj8R529Jm8FrQQH4BJsqJ3k8ng/afQIp1EJ?=
 =?us-ascii?Q?9HZCBEa5Ydt8COTposBJ7ZYJqIW2axueagZg7oxVkt8uMMrgsMyXRX17tzrx?=
 =?us-ascii?Q?3lyoX6jpbzNc/tkuT0EMB+nU4+04c09d7sQgtcgfqZe3sTtSmQsiV4jA1Ko0?=
 =?us-ascii?Q?RYdBXdwfT1O9Rt6cOgis7SHUvSsRyf3zcmKcwMVzPodXSAofkSBMG/2zyOS1?=
 =?us-ascii?Q?Li2hggVoLtKX0WWVSMJhyQ4LGaLByf2MAfMj7+snVf7mgCCknMqAD9BJ0VQa?=
 =?us-ascii?Q?1yXJara88bdvlMOjDG4UdaxZ29zcacCF0xZ2XX557S3e3xaQS5ER8gBpkTX9?=
 =?us-ascii?Q?c/R1/hnp89D81sBb/GMsIA2HDj9yB3fjdejz4VBdgA/D7fujFUFzsIZMVNE3?=
 =?us-ascii?Q?9qDTqIJ6sBFfPTQ16vHeT+wgpIHrAvfguQqA4/8eARpW37pONr83Dg44w1kX?=
 =?us-ascii?Q?32DIp7v/hY8Q2IlYI+Jl/flvEZT+zKB6sC7MoLuHKTTpYafu/oOEC1VNbO+X?=
 =?us-ascii?Q?jO1qUdDSdeMR9wFX5mXmychhsLpUJfXbToOhuhrp0wkAvnDGoqJy?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc5661af-22a4-4f15-cdf7-08df2b9c3f3b
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 15:43:38.7233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XaWvJ600OlAzB7Tb15vBHQtcE77mPnQxbEMtSnExgnUfpQt6Q4Dg7nAZeP7lsyhNH472RFMzpGmLA2bAWGUeONmF0SpZRpjiFiNx1aaNamSOHJDILMBvLeQdHXNXd4pd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9895

On Mon, Jul 06, 2026 at 02:41:23PM +0800, Hongling Zeng wrote:
> The interrupt handler iterates over register banks in the outer loop
> (i = 0, 1, ...), where each bank covers DMA_IRQ_CHAN_NR (8) channels.
> However, the physical channel lookup uses only the inner loop index j,
> ignoring the bank offset i.
>
> This means for SoCs with more than 8 DMA channels, interrupts from
> physical channels 8 and above are incorrectly routed to physical
> channels 0-7. This can falsely complete descriptors for unrelated
> channels, potentially causing silent memory corruption.
>
> Fix by using the absolute channel index (i * DMA_IRQ_CHAN_NR + j).
>
> Fixes: 555859308723 ("dmaengine: sun6i: Add driver for the Allwinner A31 DMA controller")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/sun6i-dma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> index a6487971ad09..fcc88a74d821 100644
> --- a/drivers/dma/sun6i-dma.c
> +++ b/drivers/dma/sun6i-dma.c
> @@ -559,7 +559,7 @@ static irqreturn_t sun6i_dma_interrupt(int irq, void *dev_id)
>  		writel(status, sdev->base + DMA_IRQ_STAT(i));
>
>  		for (j = 0; (j < DMA_IRQ_CHAN_NR) && status; j++) {
> -			pchan = sdev->pchans + j;
> +			pchan = sdev->pchans + i * DMA_IRQ_CHAN_NR + j;
>  			vchan = pchan->vchan;
>  			if (vchan && (status & vchan->irq_type)) {
>  				if (vchan->cyclic) {
> --
> 2.25.1
>
