Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010012.outbound.protection.outlook.com [52.101.84.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC163C0A01;
	Wed, 30 Sep 2026 19:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790797469; cv=fail; b=UkKlr755wl+T8FKwq+hgjkPcS9P7TilraV/YWbTcAeG83mUibRmCcmgd0OQYasbWWUpf0+ph7FLH6lfFNp8rrwZcQMiNs49TKQ7iuZOxnDzluziLDS5tLAWvKn7JwQXLyHJUwGFsE811tZgCxkmy0iVCFcZvDtOrxWOhjziaaks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790797469; c=relaxed/simple;
	bh=luVAYgLaith92uvPj+opTmHcuPs664SFblkKqNbmBUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rgjM7r3ImovInZL78DCaqCqdiH4y1UON7ahjtM/H9/7UhMSLCB31LzUHyNsyXEFvv7zlrFcxOScLt0Gumsxjfm4GIKAwp80hmTD2cT4yM3E7hvOcZusOYXnRP2fLjpGTDWX1Xp9QuDmqCjooOLmR6ONTMov1yawsuHTYTPKNRVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=wwiK3Plg; arc=fail smtp.client-ip=52.101.84.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="wwiK3Plg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mJfGZ68TwPxG6YcWgoeMkLkN3Tfc5cCz/1zdlLuQmRLTalMEDXfnJkRaoC5FPw4nUrp6TFO+UobPWPXeP5mkn14VOf+5z3ZyJw4YDQXsETlIwKVsC2lqbjDtXux0AXkq+YZqCQosPhJDD4dsf5kAcYZW6nKMLnHp1922AhTNAk9ncSYvUksFW7hEd7uaSFYqkvbja+/O/oHlOgH8Lwu5YonjApx47juKgwzexgTrCbVjFFSH38xXn5CSJILIBWfTMim2gQFm5nEEbdFezPBqQKcdIiv9vlmdny8kiRcLZJxOYGl5lu5ZrytDL+gKdwhbZA7Yux0okVWA8Z71Wz4fVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1mBPns9QVCjZ1pYoCUZnyFEXtgUY9389quXTBb5Ysfk=;
 b=Eru24WxYvKoZrbxt4/UTwVQ2ht2FnwKNi27Hp4kq95SwEfW5yByZPbHspu+Zt4BnUEhcL8yaDE4kErxkpM4sBFqrHpOEpnH0sKy0LuKjlf1zi4fnNHMmw6CgSBJAa/KQqg32p09qy5NEp0yhK4x5vPSGcBcORZ+2yNp06XViL5Vcz6ElUOwWYqdCiO878yBN7DzPjz/JjxvoTVroOKQ54esM0qZr1I3KOScdk0aA13ydUv7QRjeJ9kgg+SwHJtNJ7W5jjbVtZl7ebHSFbtkr11tmCdz98uU4/sphnDFc9EmHwqTr0JwTFmIDNzhXwg0oNFY90jZxKm+IM7RW0mw0nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1mBPns9QVCjZ1pYoCUZnyFEXtgUY9389quXTBb5Ysfk=;
 b=wwiK3PlgLsOcyMXVvX7+giXTP1tWjOIas6Ba+4B6fPfttEQ8rFXOTru0iK8OSBs17xOPOOvOYjRTSZA5PLxgQhGwjbs3NgDu6+eMbg3NGINpCxWGoZm0VwyEhSMJPW7xVjPsMsZDAMomNgrjB/3vhkfO8kJJ5h5H4qclb6hOC3Fbt/4x72XagHdXwJ+u9Dh9OtCiuNI8lonCAEJhuLUFRVFTL2Yc8mC2tz8oNlnC8SDbB3DhvlI6e9evn7/VmL/h0kW3jArsxYt1D7cwilna6B+1bK6zC+JBhYO6ohBkBlDyzj66AI+fXgE0S9NS0CwbcryMywvO1OIVytLxRwUjTw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PAWPR04MB11571.eurprd04.prod.outlook.com (2603:10a6:102:50f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 30 Sep
 2026 19:44:24 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 19:44:23 +0000
Date: Wed, 30 Sep 2026 15:44:15 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Nguyen Minh Tien <tien.nguyenminh@embeddedlinux.blog>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Chengfeng Ye <dg573847474@gmail.com>, dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] dmaengine: sun6i: Fix potential deadlock on
 &sdev->lock
Message-ID: <ar1mj6HFSCNGM95c@lizhi-Precision-Tower-5810>
References: <20260926171049.841335-1-tien.nguyenminh@embeddedlinux.blog>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260926171049.841335-1-tien.nguyenminh@embeddedlinux.blog>
X-ClientProxiedBy: PH8PR20CA0024.namprd20.prod.outlook.com
 (2603:10b6:510:23c::19) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PAWPR04MB11571:EE_
X-MS-Office365-Filtering-Correlation-Id: 091ebbf7-476c-41c2-0f47-08df1f2b3a8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|19092799006|23010399003|376014|1800799024|366016|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	qW5ouYvHY6Uz22mR0AFEdFjj2AYo/C2JF728yQ7mO3NtkdHS+5pd2NOdfX3hA08FZZT4jEProqnPll7dFYICfoDR/uQHzmoDbaQyLZRUCdqc+wDCROChTEwBhfhwaQMDqTsjqLVuc6GkBH4nNyrTrkACpkjVae6e238WT4enyPOtUIc5ttfEggRPOyJP0yDXu896yHA661rG1X0F67UHLaJzJksUNkMtakHoEqVtiH7D7ziWUZfcsLVChgNm5DwGN8PGwC9g48UgnIReqIUenZN23xithoxt2udysPVbTrGXOllHrY0yu3FwsYFGcWIg/tdcm9+2deDH1I3nrdi2yrYA1Evot5ioKrboJ5vTd7DbgPHNHBL9B5+dSc+pmGD0y4UHBGc2i6m9wCpt283VDma8zorSXI8Unsgzy6e33+Tj0qP+hZG1erhsLkjkvU93LkP+AD/uAPH/H93bPFoWR5nFC9ElQBpIh1GfvpiuAteXDJ7y4HaoLyElUvQdQ3zyqrcqSVawkwx8FGTFcQueYCW2iLUstCimP2ouF2rmDqL6VlIPKZ8vBApa7Ym0kxJY+CAAJE47KldFHweoz5t0rqnFY4n8d38gXe/6wPK5j9BFPZ0mZAYQT7+qyB3fbBFJ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(19092799006)(23010399003)(376014)(1800799024)(366016)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p7t1JbRRoyY3jeF3NyAAFUpmNmMlceXbSb7EQKE8ixBPYwlDNguSDS8fU/cw?=
 =?us-ascii?Q?8yXhprzlBT3MxlDieTo8FmhcXUoRfeZM0WkvqO5IUzpvteBxYPMJ8xbCFuLn?=
 =?us-ascii?Q?nVXTtNn8pgQHl/9/0mjd+9qM9sb1WoT5OxaIkhbijUMP+RghQ3Xi54dUZXiH?=
 =?us-ascii?Q?1dqAfiVgMCdN6kMqLgELck62pEF5pT1jvdNDEfW3rDglS9gkUwzMPjdnOxSC?=
 =?us-ascii?Q?cPj+Mffd+JU+ErXIMAtp6fRVXvQyA6zOZ1A8E4Vu7ARO5EAoNmxbhve4x/v+?=
 =?us-ascii?Q?6tk8cEHeFStqV9TX1VpoLyqgsjQutwJLFmKzPfGO5lz9jUJvvEyzYzK0GsRO?=
 =?us-ascii?Q?6BXu2V4h+gW5WvMtIaoRI2owpRMRX4omxrB+UjcqV2tRTSOezmnW6KxPXGPK?=
 =?us-ascii?Q?3tgLN8pwDhmFXxBQWj50Sww5DqsEJjda7V9sKIUYeJwCMNHmWHc8B+geS11f?=
 =?us-ascii?Q?uO7uQUl4CAxp00LHpI0XnA2sCtdnsCaInbpiU2lv4hctBF2MnaAcLvwGi1hd?=
 =?us-ascii?Q?l/x1FI795/97T5YhoEY+Kw9LUykr3XqOV3A7apypvuF0Ip0wBT21ndv75S/D?=
 =?us-ascii?Q?rRe35F+hklHKtxactom0Fk3pmvEuI5Khl10qAW+Wk/9JZ7Xk395gA1ANhUYC?=
 =?us-ascii?Q?/U2rf6dETSK7NSij3dvQIBtYNiCk9pPD+s1S6I3kRxC78B2Sm2PbgE664inl?=
 =?us-ascii?Q?zNs8X5VSw4TOLYpVG9RLPVCWgG7cXJpjnyl4VNUvTlwcgftpGFb4IIsRPiY0?=
 =?us-ascii?Q?MhQTvWOwdFL9moxh7g/GqKLVkbBOz5iv4X/gb8XOiFD47hcTXvx8SRnWBFIE?=
 =?us-ascii?Q?cLDOZe8jviLJuC8KJLgIXeCF8UTX+O4atufHfEedLXP2N0ynH1h3V2h9yF92?=
 =?us-ascii?Q?s3uZ85nkp1AjZdyUvDHCBHOCFO6sEkSWC3jGZTciNcWbJpXykr7bSGDncc7U?=
 =?us-ascii?Q?3UkvNuyeUmflkDK2F0wsSyZH/1dLtv/3z+ucw6QwWYdE1z8wxnAN6cZzfFTE?=
 =?us-ascii?Q?tO4nlskI0srvATrRUvh5mOwZNyoDqzx4gbimCJzYXxSn5LKqagPEoFZ07BFG?=
 =?us-ascii?Q?UH8lXV9FC9pGJXEeVxNlytAxZUElFV5lyiWKdzXpOWE347M07aqmjRSlF2L+?=
 =?us-ascii?Q?AWzulfveRyTyou9bqdOtA1uPg2G4ZqTOTdYWcrImF1t+koq4s0lhmuPT5HT7?=
 =?us-ascii?Q?S2sFC3bEyCRNmJT1yRkzYOJbdnZjEgpB46olbwl3Z6jZkSljFSu94wL+FKkH?=
 =?us-ascii?Q?YbRuikcZK9XbqtgwGgf+j307fbHdwczOWHCSvUdmVHxERgUu33qlxD0JQZ+A?=
 =?us-ascii?Q?uCnF/XGuAOTWig4oSLhWeT0g9wywHU6pRs77awWO1ZaTiZ135vlon7OfH6pa?=
 =?us-ascii?Q?41jw6u6OtxO11RECI/ibbBbTzA2FscHWZdXbxVImmpyZ/+UWeRnx41sjHwrx?=
 =?us-ascii?Q?+IzkaooGt65Qd4f6wXxsCBG1hr9nesArUu8bl68KPmqFJhdUm15hk1ddiMcQ?=
 =?us-ascii?Q?kppx1eeLC6oo/5aYqjZMafkNG5BwShb9X/4BgLnhGsKLFoE497BXpmscOMxB?=
 =?us-ascii?Q?LHjeo77F6NCJ5srk2N5hi2gWxhbBNLcCg18wSmpUaK8GFZPk02ankch5OJN5?=
 =?us-ascii?Q?Hp/KYk5M2nBUPa3Tn/G/IFR6h6li0hJASuQX0xvEFeJC1TCowjM/qVrdBlX/?=
 =?us-ascii?Q?tGg4Alf6s4hlwFS2N7Od4p9ZqVEfQZJhWYYnHjxsijTUeQ/dJwMgkel2yZAd?=
 =?us-ascii?Q?2F9b9XVW1dfo2Vxn3xnQVKSPjav22s3oiYH5JMjXLU/qGBTzjRC7?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 091ebbf7-476c-41c2-0f47-08df1f2b3a8f
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 19:44:23.7726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /46ARKGfmswTrXibOQJwwb97vyOcJbLD/+pIqgB2xOLpyoYcY+UB4cXAxnE7DRuU8GxOTNJo9tVbkoGArFSU4gRCbKVb5T7/mDdHxCqoLBsZ0kfWKKFymCGisgKGO0T6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB11571

On Sun, Sep 27, 2026 at 12:10:49AM +0700, Nguyen Minh Tien wrote:
> From: Chengfeng Ye <dg573847474@gmail.com>
>
> As &sdev->lock is taken by the tasklet sun6i_dma_tasklet() in softirq
> context, other users of the lock in process context should disable
> interrupts, otherwise the tasklet can preempt a holder of the lock on
> the same CPU and deadlock. sun6i_dma_terminate_all() and
> sun6i_dma_pause() take it without disabling interrupts.
>
> This was found by an experimental static analysis tool for irq-related
> deadlocks. Lockdep reports it too on an Allwinner T113, where the lock
> is also taken inside the HARDIRQ-safe vc->lock:
>
>   [  299.389380] WARNING: possible irq lock inversion dependency detected
>   [  299.411196] c7109568 (&sdc->lock){+.-.}-{3:3}, at: sun6i_dma_terminate_all+0x40/0x2c4
>   [  299.419137] but this lock was taken by another, HARDIRQ-safe lock in the past:
>   [  299.426398]  (&vc->lock){-.-.}-{3:3}
>
> Use spin_lock_irqsave() in both places, as
> sun6i_dma_free_chan_resources() already does.
>
> Fixes: 555859308723 ("dmaengine: sun6i: Add driver for the Allwinner A31 DMA controller")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
> [tien: rebased, added the lockdep report from a T113, Fixes and Cc stable]
> Signed-off-by: Nguyen Minh Tien <tien.nguyenminh@embeddedlinux.blog>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> I ran into this on a MangoPi MQ-Dual (Allwinner T113-S3): with lockdep
> on, stopping dmatest set off the report above in
> sun6i_dma_terminate_all(), and a small test module set it off in
> sun6i_dma_pause(). While looking for a fix I found Chengfeng's v2 from
> 2023. It never got a review and no longer applies, so I rebased it on
> dmaengine next and added the lockdep report, a Fixes tag and Cc stable.
> Chengfeng, I hope you don't mind me picking it up.
>
> With it, lockdep stays quiet on both paths on 7.3-rc4, and dmatest on
> four channels passes while another channel is paused, resumed and
> terminated in a loop.
>
> v2: https://lore.kernel.org/20230726051727.64088-1-dg573847474@gmail.com
>
>  drivers/dma/sun6i-dma.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> index 5ad9d01cf..aee32363c 100644
> --- a/drivers/dma/sun6i-dma.c
> +++ b/drivers/dma/sun6i-dma.c
> @@ -887,6 +887,7 @@ static int sun6i_dma_pause(struct dma_chan *chan)
>  	struct sun6i_dma_dev *sdev = to_sun6i_dma_dev(chan->device);
>  	struct sun6i_vchan *vchan = to_sun6i_vchan(chan);
>  	struct sun6i_pchan *pchan = vchan->phy;
> +	unsigned long flags;
>
>  	dev_dbg(dmaengine_chan_dev(chan), "vchan %p: pause\n", &vchan->vc);
>
> @@ -894,9 +895,9 @@ static int sun6i_dma_pause(struct dma_chan *chan)
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
> @@ -935,9 +936,9 @@ static int sun6i_dma_terminate_all(struct dma_chan *chan)
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
>
> base-commit: 0a8dda0a15d3926422d286567f945a05328a4ac6
> --
> 2.34.1
>
