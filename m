Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010057.outbound.protection.outlook.com [52.101.69.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DFD35AC00;
	Fri, 14 Aug 2026 14:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786718929; cv=fail; b=YTFyVjXpivhNCVS61O+mU8kOpKqj+ghb2mlMadRw5gITROuzo88p9mYkHmj0yLYDaTxHV44eP/pwMjpILxwfzZXVPY15TUS3cuVc6YIwls5s5FCfKp8/SAQk1mMdyfwmtYy0Shjmst3RFVpd7eBQIURU+d3fZ6A30P1ZI3rLvjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786718929; c=relaxed/simple;
	bh=+9vIAMBy+ivP2ugu9r2pBij512z/qo0rKf9vbORVKUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p37wPqYfgjqAnGbLei8CXUZYwNoGqSmtku3LMFgEMiQeqVsieyRSZTPjOMfy7HtlBaOAGMAk9lxoxyd3EVpV7yFbJDcuBezq5k7O2kSUp8/DdM7MPz3PoYB3xVHvNPxKSOB8fg913OiHijzKILOg/Mhgki8y0k1XxZBSdZMfbzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=tTHLGDhF; arc=fail smtp.client-ip=52.101.69.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="tTHLGDhF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QOY4jwUPY9GrudFD+bO7R5MvoWMv9x//gfsL0xzKj30Uv2OTR1fzAXkDlh9uqvIkasbOT29k1nBVYtOVDBsltzfOs2bAmx+6EVHgXEFbO/Pe1hTcByr8Nu6qDBN/S+jxqkp225nNnDtTJtfDMkdG2Jk8XmlXt6YWSIPrMt/4842P+Ib3gE7uDdtS9mwwgdVjvSC2YR78uUaks3FUleBAkDpsyvrR36BxxP6z9eO9H+zfDBM2+tFMQEcayH8f6dXXITm4OwXDOGkrbMa8D91br+vONS6k2BoqX8YfZtU3MOq704zWeL+Xc1AI7J5KBJu7GQE/AY5jPie32dl4eBoUkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hZI7F6uyjrD+VDfh2+PVfI26GweaET/FuBxmu1TP3BE=;
 b=rbJ4DE5yCGE3OVVDhY9E9RuiTyzku388s8W2s/3j/+E3K3XmwlLRK9sEFyBUBsK5BI6OFsazTnr/KRm58HvJZ7/iFiNlMlRXSDINlf+1hpWlWYJBM77W+M5NUyribEieZXCKAYheUYaBstVNQFBKbnc2ZntyQWnE9Gl1OIihIeu9TsJexHGYW0O/HoRFTbOTr+7MyEMGTx99XSjOSvg9e9uFz5hEmYMN4yPk+5+ezmB5svij2p0n4cE838R06xKTJchDB1+Owbb2gJ/Mn2g3K2zDj1A8g56qNt6fPCLWidvaNmQuvLSPiVlRukbxj2i8mPzaBtOIBgVgiDp6frUbMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZI7F6uyjrD+VDfh2+PVfI26GweaET/FuBxmu1TP3BE=;
 b=tTHLGDhFJQEuO7tKx4ACUJiDNhtlzSFlQ7AuLcap1oGAZS+75Ewf+FwUxeV/eitW0RddU0AlbOEHEBJUPSB4JK9rhwcTGiW92CXGzRSJjjVcgAzsVhhWeWRiD3vtoJM9MTNWVDSUVHMothsudwrwIAlRAykp2to6i/3wBUzH2ahSL9CLSoV7uWDIHOmFhGZwrP0KhaBPVAqrRIHhK/lplPXLI+P5prh/BjhnVFX89GJ9b4tp+4q4WTqjp/UKxdYlAbpre7hrRXNITRk+ChIoI3CUvXUamudfvgTFwmqU8wPIk87qMpHEocwTdp3kKgroStmwlHUHWMw2B1PvJ3dJLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DB9PR04MB8364.eurprd04.prod.outlook.com (2603:10a6:10:24c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 14:48:44 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 14:48:44 +0000
Date: Fri, 14 Aug 2026 09:48:35 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Christian Lugnberg <christian.lugnberg@soundtrack.io>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, wens@kernel.org,
	jernej.skrabec@gmail.com, samuel@sholland.org,
	dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dmaengine: sun6i: fix undefined behaviour in
 sun6i_dma_tx_status
Message-ID: <an8qwzz8rYHRDwWr@SMW015318>
References: <20260814142708.79120-1-christian.lugnberg@soundtrack.io>
 <20260814142708.79120-3-christian.lugnberg@soundtrack.io>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814142708.79120-3-christian.lugnberg@soundtrack.io>
X-ClientProxiedBy: SA9PR13CA0019.namprd13.prod.outlook.com
 (2603:10b6:806:21::24) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DB9PR04MB8364:EE_
X-MS-Office365-Filtering-Correlation-Id: 87a3af1b-b58b-4068-7fad-08defa13235a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|19092799006|1800799024|376014|7416014|56012099006|10067099003|18002099003|11063799006|4143699003|22082099003;
X-Microsoft-Antispam-Message-Info:
	XGuvYB00U+LQ2/HuACCyXhMhJWmwaolB0ftQHfj8unUew1VOOTZ8zQwreEOZNjYv22GZ2GEyQi/OdEnmt3eHWqEphkJ2C9vFfA8wxRmbMJujHeJUio2VYgo4sOwxP17MY59QEvvhXVyp4YRmOlVWuI0tCoyHwNUmDlzw2KHyDY1rMSZpyC+/QxPn1ARnzEbn5ImSBCXYgk7JmKUqKPclfpKxMzs/RtnX+4D1RD4QxiRpaFAcb7no3YyBHx27yDnLWdGVgHcczkbpPp2T0ai/U7gT+hQX4pYYZYFPNEckq7yOzHpMidDj29IO4I1dJRkMIyCvRV2XSVyfft6vymB1jFteF7HSGvh6EoRkuqDIzeVy3EkvNGDq2HlqyGYCEJ5EBfb5YQF+MMFba8RVkm1pnwzl4TQSDux/CDUnWAL44KT9LW0YuLf5FnwG620NIhObxDaxlRuMsWJVKD2PkisZEd1cx2q7jIqHrZqaug8s7ZMOoT3de7xsK4fjoGAlFF4WWuvmMv3aqfHZeAQx9ChimkpVHl2E/xJA58gRx5rP8iZoqFZScM1PrKoH9xqSJvwKW2B4fNg3QedsEAZsPXar2hhg2T+/EJp1E/vJzLdf3s6bwnTG0czUerC0Pc8FjyaK1nQkhbMmAZ1cZtpe1udgHriZyVWHqRMjrSGGdJl6Na8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(19092799006)(1800799024)(376014)(7416014)(56012099006)(10067099003)(18002099003)(11063799006)(4143699003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tqP/LJpFnlIj6P3rv6Ft3JeI/BvOCdiPUlkUocVUbtps9ij/3AMfAVf/aERc?=
 =?us-ascii?Q?Wp08x5+3Ny14r452OKgHSKIJRb/1sfxwCy/DkcRXljJRURKfVNIUEx31AgFz?=
 =?us-ascii?Q?74VrphmCbZG2OOcOtxDtMQNBUj4qCblZPRDMpLOvlL443qjR2iAgPzNaVgA1?=
 =?us-ascii?Q?sr6OZbMujprQDEG62F0wwJ434imDnfR1LdHyii2vzrCCDlDEzFCQr1j2bRFv?=
 =?us-ascii?Q?9j7buKDlmNMO+D2ZXTRUbuPEFhG+UnasjIHwKifaNlggMnyKY+ozg0DEerur?=
 =?us-ascii?Q?vFHmgaiSfq3Ubjs31o2TtNsglnmjSu3WswXN8CwDaDXfPCKQgy1FP2nJXxZ1?=
 =?us-ascii?Q?aoZPw1K2gumF3zmy9QZyxIreRcdf0E7yG1aE8Hh/aIr8mMHQUjlt4s+no99F?=
 =?us-ascii?Q?V9mp4PTNF3HpANR8Gj5heyrs87tAH6aMvo43OnY+YigaQHNQznNv6mnqCQLQ?=
 =?us-ascii?Q?N1w83XJVKc4FXZpU/aW9yNGg9lYM/p+v387PYAUFw9rr9HwY/RrKArgOTfm4?=
 =?us-ascii?Q?3I9q9G7vod+XpcUJO0kVwDgRPSJHfNIHMjxX74tYFniGWyjWWtIycMoR9Yj8?=
 =?us-ascii?Q?ZxXSdvDzSIWBu55BEoda/BYnx7bqymU8LOvgmWhHHj8A/Gj+y+XavZ6G6c3x?=
 =?us-ascii?Q?KBDjHEb8efGSOKN4oZi48ZProy8yP5NhJbQlp6Kp/3n2vIhtWoxJQuBC23iB?=
 =?us-ascii?Q?ws1THKmOfdtfdCP8CVJ1vhox38A2Cb7SYriT2jnxnCQa0QGer5pdmzvyMLUr?=
 =?us-ascii?Q?fJCA4fcY8Vlf92igzlaRQi2UotA2E7RMAgRAuVBu4r99ZaEny/E9DIHMehjR?=
 =?us-ascii?Q?w5WL5HXj/AnhO+yldgSzSUEk/13YO4GfCyKwRpoujYLPBVM4a872NgIY/5gx?=
 =?us-ascii?Q?FfH3ZIGHk/APaYlpE+6WIEGaINlgJ4nfBevGDhj3ICdeuz0b0iWSNn4f+Qfv?=
 =?us-ascii?Q?O3uZ4pivnEPpT6arjQ1ilEiV0amjvRGVRCKsVrZM0+qP8Crl0bYghd0M4f52?=
 =?us-ascii?Q?Ux+KwXxfSGgzOaBc/fj5JcCaXXB+cEJBsAyrOXOrBUPY77KQf8WS79yRaNu2?=
 =?us-ascii?Q?LHMwRFPvpf+Fm4CaVzasnHLfMpYpLJnX83UnpAVLukvdViL0c0uh8XkDWQo1?=
 =?us-ascii?Q?WbeYClM6SsyRs5XOP9STY+xndrkfL1zpMw5zyTeVfg6p8jP+xyOoQUe+Hutx?=
 =?us-ascii?Q?ZHsC5TLOGHQHuKzvmrRHplQ/AuH3Wq+mcY2rbmgESmBY6MR6oQeR+0uAaIR9?=
 =?us-ascii?Q?WokVf9D5bz6aOa60Fh9HGL4ydNLalIiCoEx9kqQuJzKoPqKvJSvBNj51RRBA?=
 =?us-ascii?Q?XsP4edHc7ZKvRBq/kRawX0sc1JMqY8+mt+ZZafBWpXEeyJ7ZIkCR4qy/syOr?=
 =?us-ascii?Q?1Rtm94lmV1Grp7WDMjxMsJLwsm0svDMoQ1kYndI0a4L4KmwaeP4jROJ/954m?=
 =?us-ascii?Q?CdErNu6vPXUBL0lIg4kK+dXF/+MQpREvaVvOCrdCFEYp3FJn9CE3fEz18TVQ?=
 =?us-ascii?Q?kjENWWH2E0V52EZ3vrTUIfAGLOGjzP+YPU/gIY6ZcmLpKYWCSL6ZtKb1XD2b?=
 =?us-ascii?Q?kdr8x546r+3ruZnWKoh5jJKWkG2BXTwSmFNPG7uEUc1FFQgL58kU4Y3Trxc2?=
 =?us-ascii?Q?2x2lmii3YE1MvED1IlBp/XpEL05N/rx1ut2JL1TNjuS0uuaA7Dnlq0E0xWa+?=
 =?us-ascii?Q?DVPSIuSizfZ+D29BqBFcXncy8ZuU5MpxeQoxDW+/IQiNPfOIA1z0fbQeJdyg?=
 =?us-ascii?Q?ejdxU1mMLrM8rdS+w/EFbbnCqI/mq6X976rY+LOdwkNrpYOS6XyM?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87a3af1b-b58b-4068-7fad-08defa13235a
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 14:48:44.0173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i9SsWsmWzAs267JB/U9snT0RgpKmLdLQhZgT0ZlPJpvY1lDuVoO2WK7UpdYZsw3x+QYPIYq36apsMKVxV7Ul+IiFiHiIIEnXqzP1JTbo5C+CRP8nZPRvwbLU3pYxDyo7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8364

On Fri, Aug 14, 2026 at 04:21:11PM +0200, Christian Lugnberg wrote:
> [You don't often get email from christian.lugnberg@soundtrack.io. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> sun6i_dma_tx_status() calls vchan_find_desc() to look up the virtual
> descriptor for a given cookie, before checking whether the pointer
> vd is NULL:
>
>     vd = vchan_find_desc(&vchan->vc, cookie);
>     txd = to_sun6i_desc(&vd->tx);   /* vd may be NULL here */
>
>     if (vd) {
>         for (lli = txd->v_lli; ...)
>
> vchan_find_desc() returns NULL when the descriptor has already been
> completed or is in-flight on a physical channel and no longer present
> in the virtual channel's descriptor list. When vd is NULL,
> to_sun6i_desc() is called unconditionally on &vd->tx before the NULL
> check, which is undefined behaviour. Move the call inside the if (vd)
> guard to ensure it is only reached with a valid pointer.
>
>     vd = vchan_find_desc(&vchan->vc, cookie);
>     if (vd) {
>         struct sun6i_desc *txd = to_sun6i_desc(&vd->tx);
>         for (lli = txd->v_lli; ...)
>
> Fixes: 555859308723 ("dmaengine: sun6i: Add driver for the Allwinner A31 DMA controller")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-sonnet-4-6
> Signed-off-by: Christian Lugnberg <christian.lugnberg@soundtrack.io>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/sun6i-dma.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> index 04fe1f5042e9..7704b016aed8 100644
> --- a/drivers/dma/sun6i-dma.c
> +++ b/drivers/dma/sun6i-dma.c
> @@ -981,7 +981,6 @@ static enum dma_status sun6i_dma_tx_status(struct dma_chan *chan,
>         struct sun6i_pchan *pchan = vchan->phy;
>         struct sun6i_dma_lli *lli;
>         struct virt_dma_desc *vd;
> -       struct sun6i_desc *txd;
>         enum dma_status ret;
>         unsigned long flags;
>         size_t bytes = 0;
> @@ -993,9 +992,9 @@ static enum dma_status sun6i_dma_tx_status(struct dma_chan *chan,
>         spin_lock_irqsave(&vchan->vc.lock, flags);
>
>         vd = vchan_find_desc(&vchan->vc, cookie);
> -       txd = to_sun6i_desc(&vd->tx);
>
>         if (vd) {
> +               struct sun6i_desc *txd = to_sun6i_desc(&vd->tx);
>                 for (lli = txd->v_lli; lli != NULL; lli = lli->v_lli_next)
>                         bytes += lli->len;
>         } else if (!pchan || !pchan->desc) {
> --
> 2.54.0 (Apple Git-156)
>
