Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012051.outbound.protection.outlook.com [52.101.66.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D81153BE9;
	Mon, 17 Aug 2026 14:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786976702; cv=fail; b=oIt1PrSKa2DpPqDSAKD/s5dr2r/OF+KyrqylZyoSCbaQP/sK4IWp6YUFYDsvqNPMuCppOgREVmoOu8A3pJMD3UMVn/0mB5SqUbaVLeHQNRBW2ieVARAmk7jb5cPh1cS3M+5/smrlUh7uFUmBpJ4ZrP2X5N/fwZV/47KCyk/m9bU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786976702; c=relaxed/simple;
	bh=XKkmJOprNrW372/wYpGqHUXaNdvg6PnEyyJ+a1SQFDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=is0X6mgjTi5G3g0ccjMbum3XYuwkNps/3Oqw1Fu50BS6AK7HF8/pUdvEsZA1s1cHORjInSDFovyf6kfKH2EIne89dtYxPmlafIw5zfgK1fzEPt92zsDALMuijOmwkvi5NOKnn16I1fu44rEwlZ1Q5LL6O3tQXnXyEUoQJLeASPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=VHRKc5eS; arc=fail smtp.client-ip=52.101.66.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="VHRKc5eS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PHf4ASeqINHrxjTLDQjD1GTJig7yS9yOkgqVdVPyFRx5E+KiPujRBl3HyqLt8dRedh1E8p66oeW5EGinnbQn5/tpwbYkRzeAtRCHKqNkPfGutOwh1g/CsEZxF1gc81gGbkKupo7EBdniSd7ENMGkAkWYFbROm2RGT2nh5DJG3Ih4oEOmQ3UtwklMttPwEx5P4KT9dbbk+Hr66XXHIIW/biOyrgw5Gx3O42yGRLBnHkI8AX3Ptrrj3VZHCAOBm5a0rJq6Lo36Xq8P6Q7uB2ixtWH479drF1Y4JtiFg+c/el6mZLqrAIi8g97MkbXdp5J3brCXyNFDV+NGz2h8hNEq1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BqJKY2fcHQYW5uwEWzK0Lb9Trd2wBQbYl75Q+Nq6XTA=;
 b=pb+sZIy3ZQY1mSKVgXG0q+lL4aQdgv7U/TRsVoCh26wrM9LxlbLv6p7kJBvKIFS62LHKwiOacoBR5+eEqFyjh0MejPPBv8QLXcISozhtJqz8tZEeM4omJ2+khd5WDJmvHGw3RqA7whFnl4tUZjV9zwgtms6DjGgjzov5yX1hb8tAThjmZ3XvaVgPvpG1bFpXsegAD5aKWar5j6a46OjpOpZMy1d00ncOi451ZkuJSGGWU73DwjRqaWr8VKF35db7qZOgIQcUY8Mz3KiY15X6YPo97V19kxpJJLxjdOz9VRzOm7rIgCXAphL6V+3vNSRXxkHIir4m96I7F/p/reTMtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BqJKY2fcHQYW5uwEWzK0Lb9Trd2wBQbYl75Q+Nq6XTA=;
 b=VHRKc5eSSzVdJsTk3hhAnnPzAFgt6RFwpSRl5RWosUl4hGQgjMjQ7vqqNr15tmp3PTJSip8Ovwy4ABDtNKe+gyVn7JiO3fCa4Ga8OUDKyz3ezlz6pmDbkWukrAhJ8oTy5ztwLL9RAbxu+yaWfpVIzrFqiR6d4XbBq07BvfQfimw52LtuEXvWxrPN3WCOaFDnztNV6Qtav+Zk4jJgC82hJYZNut8kRJeEOo4a9R0ucE1bi3Fzn7pDpAhaTgUG8l+SsLohoYcpEBGDuTiRVhFWFMgWlulpb4H+WZokrv8eLLhfgjPG3e9Y+IEsxNmz76bo1pXHd9QvpE9w7zWRGueBAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM8PR04MB7329.eurprd04.prod.outlook.com (2603:10a6:20b:1d0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 14:24:56 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 14:24:56 +0000
Date: Mon, 17 Aug 2026 09:24:46 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Shivank Garg <shivankg@amd.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Logan Gunthorpe <logang@deltatee.com>,
	Andrew Morton <akpm@linux-foundation.org>, stable@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v3 2/3] dmaengine: fix use-after-free in dma_chan_put()
 and dma_release_channel()
Message-ID: <aoMZrvEp4aNgaE46@SMW015318>
References: <20260816-dmaengine-kref-fix-v3-0-7e76187145df@amd.com>
 <20260816-dmaengine-kref-fix-v3-2-7e76187145df@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260816-dmaengine-kref-fix-v3-2-7e76187145df@amd.com>
X-ClientProxiedBy: PH7PR10CA0001.namprd10.prod.outlook.com
 (2603:10b6:510:23d::23) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM8PR04MB7329:EE_
X-MS-Office365-Filtering-Correlation-Id: dabfe46a-9172-454b-1db8-08defc6b4f77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|19092799006|376014|366016|1800799024|10067099003|11063799006|4143699003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	5k5AkVuhHS4A2463S250V1fILE8Hi01VB+Px1WMa4H60YSGMrStciZMTsowDUjHTOs/kwyd0avI/lPA/vKc7bqmlxjbxS2byO/mAmqp+MMHBqJNvcnw+6wtSxeHHgJs5epNEJ7sf9r0YE15Z+xOTtsmco7vQhQ012gBdfmgXgrhHcwjV/O0vNbOHm8cHwRGIjZruRKAEkaT/YeDA08JMeUtpKZ/SWoSAh6USTZ4ZrbZWNPE2xP5l9dbDEC1V1OhY2KyjutD7Mp3jlE8lEGr96yoyAdO5IL1VuC6FwjM9TShbBZtnoaVcp4OKnthQK18AmDu//v+SMyDr+4+WZbB8qFUXk3y3UWJ/WdTQsgX0OeYTWODhSw5M+MsR2AuoEcIUjVw6RPj/sAJtjbI3DxVQq5HBNsl5xnMlffyn5kGjmTb3Pp0uJNDSCl8XV1mjICk+N/DaH1ZAGEx3lTQP6XMCr7weUeIXfk3907s+lnw2CUoAxPXaiMiBk7eElAn3KcYS6mAa4i1C9S+bC8E5Ubq8IC8gWQP3a4Qtp3lY2VFkNC+KLFllQeFKA+Y85TSL4XwG8Xac7RyFJRNHxUAXotVThKFc6VsIB1YiegN5y7CoIio=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(376014)(366016)(1800799024)(10067099003)(11063799006)(4143699003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PI647Jkk/IwF4UHZ3lJfWk58ZA+VRWfOotUSUWeN2QzWr5F23XEBO67IV37F?=
 =?us-ascii?Q?uwTIDR+He8QqxskjdS/owNIM6iF3rcLUj2oBRXOH27NXGs4C4ZuHemPNj0F9?=
 =?us-ascii?Q?D/kBK5eIVKeXwTlqH8rJ7h+xihXYXmgm7a+/hkoqCOcla6FhG345eUvOHb7s?=
 =?us-ascii?Q?a0RUoHCsbPu31QJloObUxaawFFlFVQj8AP1WXAR6g825vevEdXNdhS+BAXh6?=
 =?us-ascii?Q?hnq2EzCG5kFSX8r2cWOUT1MR/j8pwr1w1v3M3kym8NLzUJFh9iTSDHj8xZWc?=
 =?us-ascii?Q?H9MNEBsxWSK53/uzQkSuwagbTIyLYuGHIkBQzKSMkGIJd5QZztWl0JqobIXJ?=
 =?us-ascii?Q?uZ+zKbuLxQoQdxSdd61aGi+SSlwA06+51v8NcKWc9RH7w7kjUg1RKCd1kcFf?=
 =?us-ascii?Q?9j7bNoELo0osaKD5Hl6+6YHdSrMAJvEY1dlOZZGNgE1bFbFhg/iRy3UDCYjT?=
 =?us-ascii?Q?TDZNucaZl5vB1LzxKBVRN10stK7JbmtJyknT/uQ22pAdyjXeU5jKpAYGbma6?=
 =?us-ascii?Q?LP+XEP725+tAdQfzwbcTkmp3TXM6CkPwoZF0oCCizcnM6qlXbGLfjdJp/m5y?=
 =?us-ascii?Q?4PeAAvMl5s15wkIOBigJSMbPIQcyXZ7ExGs9lceP7+e6gpCLisw7bp8cUcaF?=
 =?us-ascii?Q?ac4jHyufHg1/8Zbp0tI6Z0P3G5N9BEaOJGU7dCIKPuujWOHgBU5V2NXYiZS3?=
 =?us-ascii?Q?Y/ox9WLzakemYq8RMKCgdI+2v/MKvBevonmQ1Lh7KvRQFXFdh4i03q/ICXWY?=
 =?us-ascii?Q?APBy0XRriGE3MBAtGJvHs2u5HMQhuS0SSx003xpbt0F+NkN6LGuUpt1f7rjU?=
 =?us-ascii?Q?k2rBDEj2++KPbBSo1JiIH5uCkJ33PHYExm0e/Y3KDohETrSoxl4ruIlhJnDs?=
 =?us-ascii?Q?hzTY8RBaf8XX+1LAsK/VNuvGVnCnXLrxJiPp5N6JCSZvsQISs40zKOpU1DPO?=
 =?us-ascii?Q?neMjiAmVr4mlSEOJuHIqC7Kayo3MCyjZRN7J1VyGgJXg/NUFf4zOceH1ya8x?=
 =?us-ascii?Q?jwWPr1d1lWGwU24SjslAkuLzZeQ7eR8JLnd7/zY6YVloQQNY4sTy90oTbagU?=
 =?us-ascii?Q?9Dq3rc0msXxdlt/5TYluKdsnuO2n2qR8/hgxISNPcvhmwTbYw/JYGuHo+VM6?=
 =?us-ascii?Q?OBzUSKZmqMPLC1xW3V5xicYLz+Y6ROjHDVYjahbVdLZU9Sz2bgaJisqWgqh7?=
 =?us-ascii?Q?8gTfqMuBo/DaEhJVDg+OTwM/FAucDdD+4nVgvS9qVVTm52ucN4+ZwK7bo3cP?=
 =?us-ascii?Q?4s5HE2ME6ygztSPWwSa0Sm9xyn7qp2csKT+fAtv13E70Kvf0MiMqL3JEWshg?=
 =?us-ascii?Q?7PlYLF/KS8IDXxq0W+uu+9EufLifh/lo+/wxGBfxDOMgJ54VB8PmGgdLo6bB?=
 =?us-ascii?Q?xh3llB+mFYbYkIcuH6TXtT18PvVWYOx3m32oyxR/gB70CcOEso/1dA15ooZ4?=
 =?us-ascii?Q?HQYcJ8hbQvp8dpAprVHk/absx9BYiBftUKvbzKfxc70tvCmu7VOEMP0XQGLs?=
 =?us-ascii?Q?PbyupzR5A6fpAXAwpfoMQw0MvT8J0MtfNXCW4G/HcgZb5SN/QIxgO6WfgvW1?=
 =?us-ascii?Q?JG9rmNX4K1w2BYAvtQbp9h2vAXVXXSTr9+Q7HOGUe5G8rlqzEmhdxIDSkKtE?=
 =?us-ascii?Q?89kdnojQncwhDQnPrAOV5FVdST5q+6HDCMFrbLYHcZqTYeuRI7HriqJGCSIs?=
 =?us-ascii?Q?Gv/41GIkyC/+BQu/aRRacRpkDUsHw+po/hbyBMzZN4WTEGBo8ZXdSmIt9ZcN?=
 =?us-ascii?Q?8YM4Jx7ybI/w0/ATCUtWTRx1hvk4saDYtTFkR+wwSbd5/kfJSBuW?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dabfe46a-9172-454b-1db8-08defc6b4f77
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 14:24:56.1191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WNAM5YmKDvXBX4DlJfYlMuHkaHl1joWmuzFs2ShwBaqJj9cIaYEUmXzGKPU1p6sWuwDMm59gQ+CVYoh+CnTMtsxWbnLHDC5TzwzRuONgn0Do/S7F/wrGjdlnd0e9KLFu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7329

On Sun, Aug 16, 2026 at 03:49:26PM +0000, Shivank Garg wrote:
> [You don't often get email from shivankg@amd.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> When dma_device_put() drops the last reference on chan->device->ref,
> dma_device_release() runs and may free the dma_device along with its
> channels.
>
> Two paths still read that memory after the put:
>  - dma_chan_put() reads chan->device->owner via dma_chan_to_owner()
>    for the trailing module_put().
>  - dma_release_channel() calls dma_chan_put() before reading chan->slave,
>    chan->name, chan->dev and chan->dbg_client_name.
>
> KASAN catches the first one:
>
>         slab-use-after-free in dma_chan_put+0x3e6/0x4c0
>         Read of size 8 by task insmod/6319
>         Freed by task 6319:
>           kfree+0x225/0x470
>           dma_chan_put+0x395/0x4c0
>           dmaengine_put+0xf8/0x160
>
> Cache the module owner in dma_chan_put() before the put so the trailing
> module_put() does not need chan->device. In dma_release_channel(), move
> dma_chan_put() to the end, after every chan/device read.
>
> Fixes: 8ad342a86359 ("dmaengine: Add reference counting to dma_device struct")
> Suggested-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://sashiko.dev/#/patchset/20260518-dmaengine-kref-fix-v1-1-4d6125048fb7@amd.com
> Signed-off-by: Shivank Garg <shivankg@amd.com>
> ---


Reviewed-by: Frank Li <Frank.Li@nxp.com>


>  drivers/dma/dmaengine.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index 516d6d933208..bf491eb10596 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -495,10 +495,13 @@ static int dma_chan_get(struct dma_chan *chan)
>   */
>  static void dma_chan_put(struct dma_chan *chan)
>  {
> +       struct module *owner;
> +
>         /* This channel is not in use, bail out */
>         if (!chan->client_count)
>                 return;
>
> +       owner = dma_chan_to_owner(chan);
>         chan->client_count--;
>
>         /* This channel is not in use anymore, free it */
> @@ -518,7 +521,7 @@ static void dma_chan_put(struct dma_chan *chan)
>         /* This channel is not in use anymore, drop the device ref */
>         if (!chan->client_count)
>                 dma_device_put(chan->device);
> -       module_put(dma_chan_to_owner(chan));
> +       module_put(owner);
>  }
>
>  enum dma_status dma_sync_wait(struct dma_chan *chan, dma_cookie_t cookie)
> @@ -916,8 +919,6 @@ void dma_release_channel(struct dma_chan *chan)
>         if (--chan->device->privatecnt == 0)
>                 dma_cap_clear(DMA_PRIVATE, chan->device->cap_mask);
>
> -       dma_chan_put(chan);
> -
>         if (chan->slave) {
>                 sysfs_remove_link(&chan->dev->device.kobj, DMA_SLAVE_NAME);
>                 sysfs_remove_link(&chan->slave->kobj, chan->name);
> @@ -930,6 +931,7 @@ void dma_release_channel(struct dma_chan *chan)
>         kfree(chan->dbg_client_name);
>         chan->dbg_client_name = NULL;
>  #endif
> +       dma_chan_put(chan);
>         mutex_unlock(&dma_list_mutex);
>  }
>  EXPORT_SYMBOL_GPL(dma_release_channel);
>
> --
> 2.43.0
>
