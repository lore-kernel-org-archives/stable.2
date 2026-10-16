Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013002.outbound.protection.outlook.com [52.101.83.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7A14E56D8;
	Fri, 16 Oct 2026 15:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792165178; cv=fail; b=iImsVy5NOF9kY85REMCe7E7mnksaWS/xAXvmxIYxl5mpYwI5DbZYHVRP9j4JFOSzNtx3uLohCkQcDb8H2xB2WRTsVK2iUsYSGXDHouQqDZSLwP2rC60h3BM/kcC8EKNuPpJQsKFOkv7xSqqEFdCwEMYRIxL/sa26FueI5T3arMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792165178; c=relaxed/simple;
	bh=4f1kbalXS7Dawilc78m0eDuKQYuJ04ia8YmWjZTYVIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LHsFUfL2/r8HyWa+eLY0/gLa4Hx0bAKbSJAqcuU8aTM9k4QM5U4ydVYQ8SoR2AC55FZBi8+EzPy5pTimLJCB2hyaOP9iDZewr1g/yH0a/RgtM+hkcNDxZrSOYHUo2Y5M/LrpcorHrcA+jAqzklOY31s9yrj3lhiHo779WZCAO/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Oi75RQER; arc=fail smtp.client-ip=52.101.83.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Oi75RQER"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y1mmR9XWEfNo9VROqLYMHbwoOlNkYAF9JGG+DJstR7ObFaHxJjCE3bD72DzPn3qrdqazEYWDf335hlGNXMvXcsZoG5WGo6qr9vaYqbNukDUbJNUvkaKDGAdAbv00+kjqfOoUKs7Sf3DQqgiD4BvUyZT2+WoY6w2T1srXG3NwsXtYAZtxGDSP/5/1F4asOhElwRT5Zr3KSLKCcqeym7I0MRfIHs9XDpJxC8jWdKRbuhwOFabKwGa7kQmIsb7Rbfq8TxJJNRPGnIYiFDPwRvbTB9ni3yRG2R9i6iOyp/LcrqcItEIilmTZKfzm1lgH/CFLiqygAodiiKXvvP56YrSa2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/RlYOYW18NWdq1ZUTnrvC/scmLlgIlSh6V8pxQbHT20=;
 b=CKtcwai/BJR5+qQXYalSK3Wf56/ZJ8pYsuUDBEEfV/3JZxk2IwY0EZaesH6OfJsQPseiJdWvg9NQ7mrhefDX2an4n69+xey4FmQb9pskJeDVYx6bYPUdoPNlxpVhsG9xsyovmYQtmyZr1FWwJ/VYTzMKlaj19DHlPA7SvLgWoRk8eqGrE4goFA6r6hzDonzVHko5rVcUWdbcK61evtkB5WFcoN2lP/EuwFXpkvrjnpMV0h4b9SmFQEYOnPetxb8mPppIoe9F8gkCPfcRcKOL5UYUY1l03J9qLopL33vgFQpHXYkkn3b4c/QmtGShZjZjfCHyM0hoWiOOZDgLG7YMLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/RlYOYW18NWdq1ZUTnrvC/scmLlgIlSh6V8pxQbHT20=;
 b=Oi75RQERsUNm5wBnQUMtf2T8L5OSQkMbF3VjoVpfjO7W1MZedC9m2EoWtcDQtXtZhzSD86copGVElnmx9gDetP03R/Iac8vGeAqUWCLp6xnb2jIKSrVBRp+s0yfi2rgslRvTr2SxN/kVvBFs9UR5Am1ubIPmFs6YJHRgny5BcZmWlZhiJV6rty1RwiQS+YwmdYn4Syybu5MVzWG+QEfa1q2IDu2tSkaqK5oCngZ/wGvkfzZoMW1OHr2GbJjePNL0JPhvmnMJqTk8py429yiIlb6DokCYPyMaGnxz5d120wcHoffmmDPc1ieK64EewQ42eF/FCjT30MWzwo7GtzrJvg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AMDPR04MB11680.eurprd04.prod.outlook.com (2603:10a6:20b:71a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 15:39:31 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 15:39:31 +0000
Date: Fri, 16 Oct 2026 11:39:22 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Hongling Zeng <zenghongling@kylinos.cn>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, wens@kernel.org,
	jernej.skrabec@gmail.com, samuel@sholland.org, mripard@kernel.org,
	arnd@arndb.de, dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org, zhongling0719@126.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] dmaengine: sun6i: Fix potential deadlock on sdev->lock
Message-ID: <atJFKnNXdtFjTsQ9@lizhi-Precision-Tower-5810>
References: <20260706031721.24415-1-zenghongling@kylinos.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706031721.24415-1-zenghongling@kylinos.cn>
X-ClientProxiedBy: PH7PR10CA0015.namprd10.prod.outlook.com
 (2603:10b6:510:23d::17) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AMDPR04MB11680:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bcf4d70-fe53-4db4-ccab-08df2b9babbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|23010399003|1800799024|7416014|366016|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	CnV/QoIS0zn7F8MTfVd5nkP6Lb+N0k1//lAtr2tmnIfC4LivVdrSHQn6UUavgqqIo8tUYSP1o3+Xb5NaJ7vaAngWgScO8N0W0RwQd4gzoWcTn2fpqHcR3ZDr2JK2Ry7O4fXKnA37GchHYSIeS/HcJ6WfDGrM3LPF/KsqcR6n8YxhnsIDCRcCPJFeYpDoBMABOiAtwU/k2y0+9uvE5PRfACHSE+wKMDETickF56wJxX9HS8PddnjbUO6phTODAmkj6yHbITkfu7QtfObDCs+7RuWZqG10xTOo7ZCyQeeJGL4O4OOwuiJjXbaHEoIpqyxylt67dtidnmz+4jajYhHAN9FkDWVmow9E0X70sweV2+Ba7SSouYsIxRNM3eJ8K9LwR3yG+k8QqESAG+uSSodlkgnFy1JCwK4uRRKLWlWCKLVrBY87gHWcKMLtkjLau9192P1nlBSAw6OyJU8MLAvp3l8CBrUlo5ziEd+b86X8NKLL6QVbPulne07AvCmwF7PVGYngmkQ1CUimXEt0FAMa4IsjkJrB3GdT1nGQizUDhFyOBu78INU1dkLL5QKdkqRWr3VPOcOiaBE9pm06MEMu/fG1KTZMnFb+urqGqkoq/v8RJuHbVSXa2jNWxfo3hZatYpKw9t6TjEyInIJvsR9pbqNbKJQNWC2CaqX9q6IHwKA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(23010399003)(1800799024)(7416014)(366016)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5cat6XnIYvL2DHqAhgYSjfQb8tcapH3KbyvrtrcD2CzdpZOTMFMP03QKbboE?=
 =?us-ascii?Q?9LqUI5PTZVat3fqzoh+zpc2JBLcAZvMDELoFT6rmqm41w2lI3osJx1ILX4f6?=
 =?us-ascii?Q?8zmz7meSh9JUhbbSkQ3UEYXGbDj6zkECuwCdTu4iFmC6dqp5BuwfQWz0tUO2?=
 =?us-ascii?Q?yDpkSDEBhMjWvFl0ANERyyZbDmfdnpISpM0JiZvr2ypHa/4NtJhcurbtyWeh?=
 =?us-ascii?Q?NeY57ZxJvUdA7T6taQjwkI9zp87Tz21RPSEqpfoyI3HlRemLasi7FvbGQwrh?=
 =?us-ascii?Q?CM08Od610VJaTnbIQpN+Ax0e5riXgaQtWoKpwY2F4Rc1byiqHLQ2o/pa9467?=
 =?us-ascii?Q?YWM8Wdacjfz3vyVIibq315J/NSzxq3bmoZq2Sj/xoaS6/HwQHTemAa1wg9Zq?=
 =?us-ascii?Q?PfIyS8gxQ6R0gi0jnPE327DBXvZ+JC12mUxw7Cd9UP7AahYocpyLZJn2Yij2?=
 =?us-ascii?Q?R15q2rNevSmx6hRkvaWmTELZv9Szije8UrbwcSWaCN+3v5iBtNNCFLQ22Fhy?=
 =?us-ascii?Q?cBXtqsW5SbPqeSQ03aMcGV43q4yt7B8XzW9kMrUr45NucWf5dVO8AA7kI5PW?=
 =?us-ascii?Q?UE8EyCr0IzaBWZkY42BRTNBWMiN57V/SWUksI70gv6D/kUAJFphAknK120L+?=
 =?us-ascii?Q?rSzVj+7hgNfeJl6CC7Wwfi3DlPPqMgfoppcunR2XFzqh4ts/ixAj8bonQPqE?=
 =?us-ascii?Q?o1ppH3q07sGTLMXHnv/JTH7NrCNYXvlxGolJ7dXoCgN/jdmazcZCSA7CU8Ta?=
 =?us-ascii?Q?j6PcaSbI3RH9zGWDpwefa8iNidG09NxlJFpv4KkiDgnkW4S1JoZZYAq0dmMu?=
 =?us-ascii?Q?svTBE25kjgxbAXaF8v7etraJEnkFqI7gz/bdfy4sZ40bcPokhDS9h5L5BDLH?=
 =?us-ascii?Q?bixxbUfZHAIOYRSZ75svhuTQsyjsbxndClClyy63HmRz2lmkfJ7CDvybIIO4?=
 =?us-ascii?Q?tdWxGULO81sJ8Vr6h7a7xFZrtaen/qI3hjgzvhGt7lxNgEZJffC8OPNHzqv2?=
 =?us-ascii?Q?G9GEGb4eJGUREX8qDdgN1NW9wqcXHCDsMD3cFWgdDA6ekzHtTPSuFGDkOzsT?=
 =?us-ascii?Q?UEgT95xvHfklT08WUwK2fX4vLJge1mEIU8ykY2rA6rZ0rMYqqj397ZMc/UqS?=
 =?us-ascii?Q?25X+ofDolD6sJNx/csx+UvbaCM21OUaSap2yhqMdBaVzy6jnlH3beFCJUSD2?=
 =?us-ascii?Q?bGV7IvictzJR8FvrmT/xcw/7j5AKpggRnIYkUzH3SyjgJOmAxlkSsetZByqs?=
 =?us-ascii?Q?Tfubm3RTQiHxRjoQxoQ3pnmN4wOzxZrp1JxRrFALRii+PW2xoTIJeGIRI5b4?=
 =?us-ascii?Q?vfslkkZD8DW0/M0QO2uTfJJUoVbXb74IjGbudYhte1Iv2Tqm1ir0VZeQI1tP?=
 =?us-ascii?Q?bDag9Pms5L5RpGXJJm115Xz/TB8uKrfwxKRdimrvmvODcKRWdrbHHzRoeA7f?=
 =?us-ascii?Q?ECDyglfzAsMkbUhcK7MhI9x1rEqm8zo+jbOfLreJu5T8666bXjbWZpNoBWys?=
 =?us-ascii?Q?g0r4ltv6yhzDeSD1dcpZvMsLNm8RS3zWHVhFyvMSVfpuKfa0NZ2RsgS+fLTe?=
 =?us-ascii?Q?oii6IyLuE0YcEOozH6vfpcIvybcV8MZDATwHw7WW3SQLnuegVt36aE9karQ0?=
 =?us-ascii?Q?OuBHJ8zeTHefSWVUj9JLZ+8cQ9PkbkrB5z55sJEMgCX/TAHnOY8HIYTpPFoT?=
 =?us-ascii?Q?6WdpYlkWFRrr1EgrO2aFsB9mPBu6MySDQi+vBdiku2q4nP5GiUKVaUhBAb8B?=
 =?us-ascii?Q?7hC1yeZ79n07TAKo5FdUKTMJzRIJgFDTKPAKVZmSSXNWn4XPX+Ja?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bcf4d70-fe53-4db4-ccab-08df2b9babbb
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 15:39:31.2444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: grFJAVnr5wB+i9Gf9ACAu3hS3eXSmc2JJeYoEd0860hTjnTU6i2Uyr5fKExgdPlQwersvDgL0Kpym+GsEBTiOYyKH9KrPMxV8LrgaHfFVrYwn9wWccD4u3EsyCdOf8d1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR04MB11680

On Mon, Jul 06, 2026 at 11:17:21AM +0800, Hongling Zeng wrote:
> sun6i_dma_terminate_all() and sun6i_dma_pause() acquire sdev->lock
> with plain spin_lock() from process context. If a DMA interrupt fires
> on the same CPU while the lock is held, the interrupt handler schedules
> sun6i_dma_tasklet(), which runs in softirq context and attempts to
> acquire the same lock with spin_lock_irq(), causing a deadlock.
>
> Fix by using spin_lock_irq() to disable interrupts while holding
> sdev->lock, consistent with other call sites.
>
> Fixes: ba489fd46ab6 ("dmaengine: sun6i: Add support for Allwinner A31 DMA controller")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
> Change in v2:
>  -Fix by using spin_lock_irqsave() and spin_unlock_irqrestore() to
>   disable interrupts while holding sdev->lock and properly save/restore
>   interrupt state.
> ---
>  drivers/dma/sun6i-dma.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> index a9a254dbf8cb..a6487971ad09 100644
> --- a/drivers/dma/sun6i-dma.c
> +++ b/drivers/dma/sun6i-dma.c
> @@ -891,6 +891,7 @@ static int sun6i_dma_pause(struct dma_chan *chan)
>  	struct sun6i_dma_dev *sdev = to_sun6i_dma_dev(chan->device);
>  	struct sun6i_vchan *vchan = to_sun6i_vchan(chan);
>  	struct sun6i_pchan *pchan = vchan->phy;
> +	unsigned long flags;
>
>  	dev_dbg(chan2dev(chan), "vchan %p: pause\n", &vchan->vc);
>
> @@ -898,9 +899,9 @@ static int sun6i_dma_pause(struct dma_chan *chan)
>  		writel(DMA_CHAN_PAUSE_PAUSE,
>  		       pchan->base + DMA_CHAN_PAUSE);
>  	} else {
> -		spin_lock(&sdev->lock);
> +		spin_lock_irqsave(&sdev->lock, flags);
>  		list_del_init(&vchan->node);
> -		spin_unlock(&sdev->lock);
> +		spin_unlock_irqrestore(&sdev->lock, flags);
>  	}
>
>  	return 0;
> @@ -939,9 +940,9 @@ static int sun6i_dma_terminate_all(struct dma_chan *chan)
>  	unsigned long flags;
>  	LIST_HEAD(head);
>
> -	spin_lock(&sdev->lock);
> +	spin_lock_irqsave(&sdev->lock, flags);
>  	list_del_init(&vchan->node);
> -	spin_unlock(&sdev->lock);
> +	spin_unlock_irqrestore(&sdev->lock, flags);
>
>  	spin_lock_irqsave(&vchan->vc.lock, flags);
>
> --
> 2.25.1
>
