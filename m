Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013031.outbound.protection.outlook.com [52.101.72.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D884CCDE9;
	Fri, 16 Oct 2026 16:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792168819; cv=fail; b=Mg4IAwHjEZM3oW67FS1CM/WCQ4NAMKbUvCZVKT/oDFYgA1H54Yw/hfGrtyFe+QhqT9GFyYLI88yZE/bjJTo/reZTxxif3OPhF1eRwu1Y72ApFhUp6oeDcxsnx5dPPHZQwK6/EwTUnoxpKPC7+j0pQb5x9QOc39jnq4RtuOX9CzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792168819; c=relaxed/simple;
	bh=sUEdzZicE56mkgCFULXHo9yRwbfjo8dv36YDvwdomiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PUmU7QwkkI8G+PWkxtdMrdOhZRUzEeK6asm4dIdhIfS8BP9KILA1AXWj1n5W7BlpnotEywM4UoU563Ko2MjUgYDZV7SfnG7vVaM6DDtOW+nnbSnGTvQdJlC+92bn3RPqCsLvC6RskxILGkLBYoEhr38mzMryNbw9rY4lf+A93p4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Kq3He9c1; arc=fail smtp.client-ip=52.101.72.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Kq3He9c1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pI5zIF+A02jdzMbd+nNbi5tZTxABRz/K04K7N1bpnExI9mfPhOZEA+4EaEgRVmx6P6+Fj6SnGBz70ZSAGnwF5Bk8fgVr3M45MhdOJmPwyGqVqcz7ApWd4XbIGhRu2nIPV0YRFyWXdkuhHxRgRLQQpya571oZm161lMz6j/2nipafns9eDa8gRhWG6uy5EIERbnAtmj6uyBHAjM+WKaApQAss36OniTa2mLUhrI1Xw6wtqlNWozd3KC/mNTOBDSag4i46G1yC7r3D1SUzBElC14RtOiV0RqiSHzRwz0w+xmT8ymdLPyFWUEnjInxVd+9dQPpRVfRC4MpShJwrYk8zxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EyQg3rcgxAScndoXbngeZx42mjuOAFxwDXzjo39kL+o=;
 b=mRvQOxvHCtqsaRXPXVd+RS6OJI2BGF9kyAv7mjxGgd1wG9vlsq0vtuPX7/ckK4G7RECEXZbfEibi97PNvkD1y6eqZzc4+XKXKNyEoOriN32Da8j6E2tALsknsrl5kQHeOpdnA/RDv1SOdoC4heZqmhUUTmZrTTVHzul91NsdUh+x759gncOXX+ATusElPtTVmBYP+FVYa2X4qWhCFfiNPTIdE8vhKRi/3I4i8MiQJ5x91+NpVHHbnQi4XWrbNBmHT7D42aiULHJKtG6LUs5MmQDzljxo+ZdYBGr15c1GFzxOKZKnObt+WCmPdn62vuHoOtYqMaTgTugr3i53RGYk4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EyQg3rcgxAScndoXbngeZx42mjuOAFxwDXzjo39kL+o=;
 b=Kq3He9c1atPq4XGFoyenpSmweE7r2Lo2BYubZ8mCyDezC8yfOeqHVTnRpJuDplZ7tLOIaaykShB2JZiHmeCuPG7FdHDKk5NpPrmASP42X5gVmkLyosxoX4RTbSQTUNI7jUzaDoHn9KvyxuMMJucLIhctfrRFSiLQgzWYBNYPdsg3Yi6vUNF9q0yxbIY8ubEHyscNQkDjjvNhZTctAwbb/2LCno72qblg5BassYc4Cq72I4mpZWIcSIKt4nu9dOV6LYIgs7fP6+QkU4lYus/FByVZ/7ylknZvhoMrR7mXZK+KuTp345mMmWq6T2o5ub3DCgElg6SXfJP95G7DgBrE3w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM9PR04MB8337.eurprd04.prod.outlook.com (2603:10a6:20b:3e8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.15; Fri, 16 Oct
 2026 16:40:13 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 16:40:13 +0000
Date: Fri, 16 Oct 2026 12:40:06 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	jianhao.xu@seu.edu.cn
Subject: Re: [PATCH] dmaengine: tegra: initialize channel state before
 requesting IRQ
Message-ID: <atJTZmloabvKGOTD@lizhi-Precision-Tower-5810>
References: <20260830061213.2209331-1-runyu.xiao@seu.edu.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260830061213.2209331-1-runyu.xiao@seu.edu.cn>
X-ClientProxiedBy: PH7PR17CA0061.namprd17.prod.outlook.com
 (2603:10b6:510:325::11) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM9PR04MB8337:EE_
X-MS-Office365-Filtering-Correlation-Id: 16ef28c8-7234-42af-35ee-08df2ba426d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|376014|23010399003|366016|22082099003|18002099003|10067099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	Fo2L212P3kEIGEI+3eY87N2xnhO7jufozMbTmaL5Ybv9q7RRn4AtlrKpGv0vDLrafOwQ3OGQd+HwanJtuAMbE0QeRZ+g7T23ZC+F2iC+1TMIhzewQt0POdt1Sjg6kbywEhG6SuGo6PcdLHdYtTdllG/CfxCuMB7SGT4Y7JriPC+BKx07efCcMp+rsLVGGvCAlElWM5eIa1YSBqaurOVez5qbySqR6BZ3sUfofzsopQwO2E+155fMJe2rHD1m//BTspA237GGaTFNAW6+xlW/BGBeMS37U14pK1rUVDcpcpJIjUpv7iwa9Nlokgvgj/JQdEUpg2aCom3p8YZFXpIjkl29nCYfly86WRqzZV7VSpA+fPkHdZCLeuEBFLD9dSc5TFekWErQhUlXuT3mU9iWw4dVyuZNUV7tNNn4IgIMihQA6nDVDrABZ9scKCEGZbREC7VlOygSNqrkQfWbj48Ow+3Rondo5LSoR2pgwdkKzLFHYdgaD9HkNkyQpso/tPyqIJy2Rh8G26jed4VT653ewpvrpKfpKv5uNZcS85y4gdVpAYmzcH2Hcml76o1SyWXcnkGPtLw2RueuTvZIMip3ZJvc6fKJmzR4it8AHGYxDa+Xo1ihRF/dX2nX0Y3iQuIgCbYZUn6HWZ8Fk5Hubx8HOfu417+HVvb2yAE0UFp8nt8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(23010399003)(366016)(22082099003)(18002099003)(10067099003)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bfZM0t1+pqCG/CO3vMD81QzDxf8kWq+o0Mo+QLeD1Syc/5Rn9MGMFRGivOto?=
 =?us-ascii?Q?8JIhsmbreGFBHValFkOLL2YxVTU34RsPaOTNtxf5iXmSjRrW4HsZzDgJ2g8z?=
 =?us-ascii?Q?BfD1vYd04Aljybl9vQtz2nSZE6x3Y0IcxU1oPxCFAGw4gZZ/ISkAspJHFN4X?=
 =?us-ascii?Q?jb3bFa2FcYosjJ/6cQOS5Wth10b6NY0JwecEWKnKtDTjw5J5DCW4SJaYkHLv?=
 =?us-ascii?Q?CHuysueJztmtNyIdVZypMyFswdMg/Tabu0llytHHZX7nQWYjJDDB45+7MybU?=
 =?us-ascii?Q?Cze9R0EIv253UxxKjI58GIXIhjGMw3cBcXtGxqBaGRBOvKg9YlQGLfYg7Evk?=
 =?us-ascii?Q?ElBtWkdcrr8Jyhd/IAfHeDLq3C7wi9sJgNbiYwbEFJACtyOs8wy2DeJbUl1J?=
 =?us-ascii?Q?tPRHtWbRVlSmojoQlImoBML0J2xbFqoKlCkKRv2QebiQfoITvvVirtF5k60t?=
 =?us-ascii?Q?H97mtaLd/8QjnuJVecWsl1owE2WgrqfjsOSplZLAPyP1f7+Ohmnh4EMLKeUS?=
 =?us-ascii?Q?fK7ujnBPaKsZZKASrI/Z0df6yhwCKCAOZVkN+jUuTkv1VHNUJanBinapUwz7?=
 =?us-ascii?Q?LRUiEqRLbMXrbczBCdoh81sN/s/cCdQeyxtxPDIH1P95pKl3Hq/fHBENcw2p?=
 =?us-ascii?Q?0UT73/J54AC/ByyU10LIgO+KBgSCo43AGl1d4MpVyljuo+9i05oqYd/IIIzn?=
 =?us-ascii?Q?c5KSlzljTZQ3RoD/2pYMg1HJeJS6yw02iZqal1TBbQf4ej6Slkk1JbIVQlf8?=
 =?us-ascii?Q?Myelhig2yG41AtJQTUvqmYl3s6xdo/+X1DQrF4pv193AO/BKE7TLHpcvv17n?=
 =?us-ascii?Q?cHUFO62LHXbYI0sraZa90BtWQQCdQU8vAv3JBJ7V8rBzv+zrRAWxToTHlThK?=
 =?us-ascii?Q?EWU8sTT9A/FUhYtjs7K/rY/T3Fd0ClmKUFNM0ke5HSRR4cLQUUSDQbPnftPq?=
 =?us-ascii?Q?KMeNM9jTIiYbD39Xs6qEvjbSKtaZb+FtJ8Ujn2iWX3SIdvj2+HsEDH8vrjv0?=
 =?us-ascii?Q?0EsJN7JppCI/GkkHREhiU8h3q2oIiBN6vA+OcNRu9sNrfZa3qLkkmXmMZj/7?=
 =?us-ascii?Q?ITQ2xYpctGNFyoRoWcEuc5yLqy45/mZMiD2xEvhmChhaxOr3SX7imh2gMCQS?=
 =?us-ascii?Q?JLcHnxPZLSno0yD61LKulP/oW4XRqYfhsDVtKaqDIzI1eACbFYuH6bgPagSJ?=
 =?us-ascii?Q?gZQFqOtQpjVF3vAspwMgPI6IFIcJMt6VXk1XcHD3XtxmJCw4WiVlcXZZO7wG?=
 =?us-ascii?Q?A7IRo+cO3NLhsIMtMC0w4dYIcRMf/XnEqPvR9EVxOzxCVfJyx7MDjCvuk2aF?=
 =?us-ascii?Q?6s3GX104rqiDelyZ3rdkt0+UaOfVqR51CUX3IsOXvOvxW2p7/FIZYhjYWPEk?=
 =?us-ascii?Q?zaw7Owgh00t/ggiA7f3AfbkdZL+Qi7Bq8eDzvWZ8QpNEIqAMyf/hNOO5ihts?=
 =?us-ascii?Q?OIJNYYUD+hXioebST3Pml8XxocJ7e00i+8sin2T8Fqv2+Vfu5L9K0aIMhOjq?=
 =?us-ascii?Q?Ufs/PTvvBwK+cnEphuQ2c6Up2lXYMYDRaYbY6S8ofmRBqSt6vF/ku385F1zF?=
 =?us-ascii?Q?ZaY8xGOpPRsDyhuPsGDbWhHzs4uZ+6ijUZhkoqHoN1AVwDy8xaUwx4hfMKLR?=
 =?us-ascii?Q?f3MWsR7Pu3ui/7F3DqeRVD+ZK2wjBoulPlWPnUzuIyoPk18SP9Hu9sNq0bYd?=
 =?us-ascii?Q?/V8TkJ/b4KmymAqaxRrGJo5NfBKSR9F9Lx/XebZWXN5rOm/F6kEdVzP4DPZC?=
 =?us-ascii?Q?GmCzbIGEJff1/0rmxeWbXb5BWJbxCaLu7nGzoJ00SbjM9Dp1Fibg?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16ef28c8-7234-42af-35ee-08df2ba426d8
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 16:40:13.7998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: it9E4CxIcbt4HwwRlqZ0Ov3uopYQWtW6T3o0rBaCKmwZ4wpflHyj0F0YM6wiaoSbwAY6DjnwPaHS0EVA1knS09qm/We9Lh1qES4vmmWhkeDYoy6wdV56D/l0UlTo6yeR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8337

On Sun, Aug 30, 2026 at 02:12:13PM +0800, Runyu Xiao wrote:
> tegra_dma_probe() registers a channel IRQ before initializing the
> channel lock, tasklet, waitqueue, and descriptor lists used by the
> interrupt path. A pending interrupt can therefore access uninitialized
> channel state.
>
> Prepare the channel state before requesting its IRQ so the handler and
> tasklet always see initialized synchronization and list objects.
>
> Fixes: ec8a1586780c ("dma: tegra: add dmaengine based dma driver")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:GPT-5
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/tegra20-apb-dma.c | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
> index 640b8a218..23fd294ab 100644
> --- a/drivers/dma/tegra20-apb-dma.c
> +++ b/drivers/dma/tegra20-apb-dma.c
> @@ -1494,6 +1494,19 @@ static int tegra_dma_probe(struct platform_device *pdev)
>  		}
>
>  		snprintf(tdc->name, sizeof(tdc->name), "apbdma.%d", i);
> +		tdc->tdma = tdma;
> +		tdc->id = i;
> +		tdc->slave_id = TEGRA_APBDMA_SLAVE_ID_INVALID;
> +
> +		tasklet_setup(&tdc->tasklet, tegra_dma_tasklet);
> +		spin_lock_init(&tdc->lock);
> +		init_waitqueue_head(&tdc->wq);
> +
> +		INIT_LIST_HEAD(&tdc->pending_sg_req);
> +		INIT_LIST_HEAD(&tdc->free_sg_req);
> +		INIT_LIST_HEAD(&tdc->free_dma_desc);
> +		INIT_LIST_HEAD(&tdc->cb_desc);
> +
>  		ret = devm_request_irq(&pdev->dev, irq, tegra_dma_isr, 0,
>  				       tdc->name, tdc);
>  		if (ret) {
> @@ -1507,18 +1520,6 @@ static int tegra_dma_probe(struct platform_device *pdev)
>  		dma_cookie_init(&tdc->dma_chan);
>  		list_add_tail(&tdc->dma_chan.device_node,
>  			      &tdma->dma_dev.channels);
> -		tdc->tdma = tdma;
> -		tdc->id = i;
> -		tdc->slave_id = TEGRA_APBDMA_SLAVE_ID_INVALID;
> -
> -		tasklet_setup(&tdc->tasklet, tegra_dma_tasklet);
> -		spin_lock_init(&tdc->lock);
> -		init_waitqueue_head(&tdc->wq);
> -
> -		INIT_LIST_HEAD(&tdc->pending_sg_req);
> -		INIT_LIST_HEAD(&tdc->free_sg_req);
> -		INIT_LIST_HEAD(&tdc->free_dma_desc);
> -		INIT_LIST_HEAD(&tdc->cb_desc);
>  	}
>
>  	dma_cap_set(DMA_SLAVE, tdma->dma_dev.cap_mask);
> --
> 2.34.1
