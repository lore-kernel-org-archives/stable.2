Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795023152;
	b=XnJsKdPZvQh7sxXinGaloZev8f5L1fPIG+2Kv3FlR+rV98IxJFgW1YlJK1TzhSpCQKMD
	 F9U5+6VqW8aW7hwzvVmc52foR43/0SJaHemPkuhiMx6KVgkKolFk0hxIXwgZsyXvFssYF
	 GZ3tLrAs1t2l5hU7LjFckHy3vxzPlxWuuZ4/NmGmYik6CHO0aEscuDSsRbC0MWNQFa3+J
	 kMh38GTWFStS3Cnol1DGt5/iGRcSXpvWgBjEMvJSto+Jut4MJOlUe33UDZQHFN73f4POr
	 4dHcTNIfSzNikiYd/8DqwYSFCsAM1hiXgj1IDdIbSKhXfHuWzRiMP83jIN9MWGQno5Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795023152;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=d/ULkVw6ZogNEuM3IO8XrGmrpvDsrusUhHJ7PBDHKuk=;
	b=yJXaEpVc46F5e0bL9Bx7XEwWsnnByQ8m8xWOg8Rqpot8HbFfu3jckJenJ45CWmNVd4IC
	 LiFB7itoEkSfTJivr+s1/evg2nbxVSU5oEXvhNFSSV5vw8FHCdozxHnK+kuPdzktLlRzQ
	 Ka45ItOop6dy8IqE08MFxBOEtCyM9jU4E0mChpt2o+P0U2Zp6JiwS38AOa05VPezWNMh8
	 Vok11iWbMew75KZ+WXMV8ZQFUMVZ7nR0XGbYI7drf/PcJFgKXONnYk74aGVskNkt//v6j
	 3VNtON+3I6bYE/CeQgvf7rOcYP99EWj9k8GIiL7muov+ipHxr99ua6h2yh+FWEizn/w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=KDcOX5cN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.43
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011043.outbound.protection.outlook.com [52.101.70.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55ED3606A320;
	Wed, 18 Nov 2026 17:32:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55ED3606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=KDcOX5cN
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FcafOLk0d7DME62mHUjTPFRC+rcAPt4YwNlugtOceJLqVfRoUs48mvsjTiXlXwVryko6rUSmLCjaWzGSxAYyh5rHgnrRHjGAZQS4HTpWZpjJ3QMV9t6QaGghSs9YqY+QlRCAvBs+/B6wyBgk+UZb27CR8C+iMyui9w1kPymqHaczAN8j7G7qLqaaW1+m4qGs7bAoYmgHJ1ktTIA1YaCgaII2ep+qlHaZEYdBK4zYBRN9BQ63zOw2/+w9vBHdSfCkOxe65VEqGBXBHPv1rTpqVk6tksmgBfdlDNyFMc7hJ+Xgmqu7qZe0RR3gjBi+xZYUxWuuBgQr6WCKjq2NmrAZsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d/ULkVw6ZogNEuM3IO8XrGmrpvDsrusUhHJ7PBDHKuk=;
 b=U5QMnX1FKdzw9JFvJHbALcK/WjJwXNxqCOvThtnokFyzg1M9CYEbhEppZ/yjDcdq0VGiC1LrVIsAWuNtgKrCzXiNdk6vOKI8XSunvJCOn9H4BiGYkpeRh1fz/PxCyPg6TJNciB88Yv/P63LbU98hsEYLWdF/cMo+7gOm4gxT0id1bk2/xhgH4nJ6H8TdUpdQ0ZBFy36i7T4c9cD5zMq60x/4Q7fRM6636tB3oSFlgIkjDPkosrkAXeAkydpJuhWZ24kzALaObGm6/Tfb1PHJ9VK4VPXUSjUiJdxNgd+1rBP9sfy1cr4kzuOf1vGDz3DgRBgawb8kPcVOP6PEc6afVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d/ULkVw6ZogNEuM3IO8XrGmrpvDsrusUhHJ7PBDHKuk=;
 b=KDcOX5cNTPmdkHqeEMgAFMdqbyzeVvJNdlXt6P+VDSHJWFMYxlD/abdxZeKqr8vK4ZgpEcBK2NxMGKcMln+4Xu5zChpUcfUTM8X1XNfuUtFtogwkffMUAwtQ94kW6NLu7U3IlaOj1YrZ5W35P8ZzhB5FIIG1mFZARvaMuPOm+kwvPNmpE/hAB0OOJ61PVyflVF9/YDiUgAHAPZJ/acsSMJ7LjL6BLiYPgS8rhqp8AF73S8DJzUxhOprFUpqKl7WYvsXB6OPRMlor89X0cdvzXyL6uq8ZrY03QTjd2YX6g6QRv/UX6FkUcQKE0jbGXwj1Q8ZJfrumvOFgJtKb3OTLDg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by PA1PR04MB11360.eurprd04.prod.outlook.com (2603:10a6:102:4f2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 17:32:29 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 17:32:29 +0000
Date: Wed, 18 Nov 2026 11:32:20 -0600
From: Frank Li <Frank.li@oss.nxp.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Sergey Khimich <serghox@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sia Jee Heng <jee.heng.sia@intel.com>,
	Mitch Barnett <mitch@accuratesound.ca>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v7 4/8] dmaengine: dw-axi-dmac: use atomic polling for
 suspend acknowledgment
Message-ID: <av3hJPZhRD9t_XOz@SMW015318>
References: <20261117-submit-dw-axi-dma-stop-pause-v1-v7-0-d5f2309afd72@gmail.com>
 <20261117-submit-dw-axi-dma-stop-pause-v1-v7-4-d5f2309afd72@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261117-submit-dw-axi-dma-stop-pause-v1-v7-4-d5f2309afd72@gmail.com>
X-ClientProxiedBy: PH7P222CA0001.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:33a::14) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|PA1PR04MB11360:EE_
X-MS-Office365-Filtering-Correlation-Id: 64a4acc7-ec90-4b8f-41dd-08df4599ebab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|19092799006|366016|1800799024|7416014|376014|18002099003|22082099003|261009223027099003|4143699003|11063799006|261026121527099003|56012099006|261026140227099003|261102123227099003|261028144727099003|261021121427099003|261021123027099003|261022075727099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	uFlBaKwpkgTarvGeWhMS1WTKTDWuZIKNu4midfdfLf2yqgJFQ2zqh+dnom3pmhVFjGb7eiqTJqHSDUMdRQgEAMTfeuVStXR0l75/4C9qzBaYVIZJka0Yg2bc554FwemXbc1ccRyL4F/h706B0pJ84uE4LD+WMwhM1DUrUQYhwf8F/DYSPTtP2KE6kk1WNd1c5Tpy/buxMXDDKQ9pK7pMU7MgQbYlWygClI97XVvbwR3EIx5kO875eylmMsqRizkJqmHOu1oLRv2AlWSA/utVOSOD8kuJcPvSyMtV6DNw+uFh1H+yrX47+LMaSIDIdMWY4PU9DoJ+RwVXFXvpyrQk5mhmVTLPk1aMQiQttjHFWnjgdixexrwxvbiqWK0Jw86FnEUEJNh+LByWfDErq4S1N+MxXQj8rqsfDw2UcTUHntxegUw18uRu9BNw0NFoFNOffI32PgeI9BSBdfkW4hOnoULKo75k3F5XSArJ3W7ppDKj9dzfkmwgLuQCjmrL4iFZj2YnPIWZE+uwvGCb7bPH6vV3oO0MEe+AdVfyMSuOlCMZ28m17iOaxTIAU83Og0AoJrHTQ8/40UNzpIkAySetC3D60q1B+e4cOTITOBKnfkhRO36tBeeWLZYAqy/rxc9er3A0BfAc3V75UsZvty/HYfsMvt+K7NYuGXNbgZGzgc0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(366016)(1800799024)(7416014)(376014)(18002099003)(22082099003)(261009223027099003)(4143699003)(11063799006)(261026121527099003)(56012099006)(261026140227099003)(261102123227099003)(261028144727099003)(261021121427099003)(261021123027099003)(261022075727099003)(261022105027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vjMcBKmPUYkOyBwSWMoA23u9EP3kW6SCD2ZR/AiOGgvXV+J//bwTpWB5hNB+?=
 =?us-ascii?Q?4l7OXQUlfl/1FzdJyUXGzJcIfpOtEV7mJOs2O3OJFg9xr7MCxsRgh8OeRIVU?=
 =?us-ascii?Q?IlHGapejbLGuicD8kQPNiWXnu3S7J6vHcKzaOWwUX0AiRYlTupugysvwWvHh?=
 =?us-ascii?Q?i+e+gSAAGajopCY0tfxwSm03KmwuaRrKsrdTSe4jD6aq0EkyXkXfFFY7XmVS?=
 =?us-ascii?Q?St12b7CVTiApKsv+ou50mCd7q9PYOufIENXnKRA31nRewHwfdHORCs9XJ3KN?=
 =?us-ascii?Q?cFB1Z5MKldDfXm54/adsfqe2X5mMsoB0tOz5ZK2OrW2mIlXeTSbs+eGPKmnA?=
 =?us-ascii?Q?KOBNN4vkaORWryo/Rvru/kSoQPuCh0zYlh2oygvPPSQ3afEYM59kai7W3grm?=
 =?us-ascii?Q?JcFSdtZP6iEhTRRBx0HRia1T6Ku1Ee0Wjp1eETYsEq+lxid1OuYqzTzD7E1u?=
 =?us-ascii?Q?kQZeHc7UEz258ALj92GMN782ausQ0i/i3fUaktZjVFUdJMeUdlH9oRpOalT8?=
 =?us-ascii?Q?di9VchkJOykuO7Yn/dbWmzo/u4FSZhd3bkEbwbBx09bMDT7taIHin5aWuka1?=
 =?us-ascii?Q?7kGaBA3nn/119/vmxkRcAhgfkcfv7iTTfJhVDag12WNhmZ3v4d+WM5ihjLAf?=
 =?us-ascii?Q?1CDBVcpClmVHEe/SCU5Vhv3IzAvo/IHMNjNd7HCGIVinVOepcpUne07llWvN?=
 =?us-ascii?Q?iizh6vQ484AZrps+dkpu63+PHlGlOsySGzA20D3mcRJcdyvjOEF/LyuWysyT?=
 =?us-ascii?Q?hRgZcqqPE5DEAc91Gz87UYtw6hxT254Nt84AYhjndeSazAbM8hH/fVDPPiYY?=
 =?us-ascii?Q?FJvNBTbG1ZEPOU2qDQdGfBY1t8xkI3kl0bzwbNXrAm6alX4h6n89kxLOrWC/?=
 =?us-ascii?Q?mpM4S863IF7R7+h+TnGcJGmbKG2ospavDp25uCTV+I6Px6PR0rpZ8443oX41?=
 =?us-ascii?Q?IPSop7AdBd7F7ycdDWJtGUkVmaLEC+ACUGJz7Ao747+rhP0a3Z5au0WEiBuY?=
 =?us-ascii?Q?6LAj9YcfwlOcLvjQBegVNmPmAIPfcHUk0bEX5Hg/DYSasfLE62FGUMgQvgUw?=
 =?us-ascii?Q?wPN7REtOPx1jr6YP3dJXoxTqiIjaUwZjPEQ8bEO0yrS2WHytcPjsaN/KNWSs?=
 =?us-ascii?Q?r/DcZ0Y4CD3U7XcvG0Ou2fNa0GxqiQZbndozoiNdO6Ot5UYu6hbLFbu2YhQK?=
 =?us-ascii?Q?gNoaP14TGsRbRaCB9zQ6LhH3xlOFv9/GAnlG+Nr58pzG+Upx0SNDdnPptrC7?=
 =?us-ascii?Q?fQhdJl4byvmgJncXXjpYSuBAZAARssnjxGY5eIM7u3H2YWFAVwGeoXBCT84A?=
 =?us-ascii?Q?iW8//KUooNMwuaBN5FD/rb5+J0FaU5iPPb4SwGL2NEqJQXSRBz07GO0RXSUY?=
 =?us-ascii?Q?6GAqEsF/VDnfyF8wKcz6kHoNItBkezAEVZSC6sf3LUnE+vJCf/jAvtpteBPT?=
 =?us-ascii?Q?l3NPsav9sexwwL8KwF8zhYgYH0TnXCy4kaC3k9xGsCM0SUIG6Yyomah6k42V?=
 =?us-ascii?Q?3RTBmANxVFk2c/QWX2W+my4TzfMDSN1a2azjfCbEu707izBKnSdqmo+SCaLh?=
 =?us-ascii?Q?YhVshs/VmWtIJNM8EC/lzYJq+KW18MNEwFa6g8MOTQtz4LuxySkkUdiTT1j2?=
 =?us-ascii?Q?QADKJo451dPCEn0jYhkkajqN1YIilHi1DURcWAG3uwCi7duyOR5EFra+oh1r?=
 =?us-ascii?Q?m0ffFv6FAwmUk3RJOkTZfMEaRTtnKcV5z685bbPjWcZuEmXYdT1dVk8KN7dh?=
 =?us-ascii?Q?22MtHXiz94QfBQxBcfItzF4WZ/DT7mo6e9xSh/GGkp0n8yx0iJtT?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64a4acc7-ec90-4b8f-41dd-08df4599ebab
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 17:32:29.8172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ve1/gAh83CSzz8gLSVV+jnp4LTKgO4FMGYoP96xkBdfy5g9AOLUIFYZ/7c9otmaLajrxsQovETT+t6kTwCuMWWMtZl//Mdc/sUSgMWNDXoINvZTmpo1rsYPpSNAvWnE7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11360

On Tue, Nov 17, 2026 at 05:07:43PM -0700, James Hilliard wrote:
> The pause loop delays after its final status read, so an acknowledgment
> that arrives during that delay is cleared without being observed and
> the caller receives -EAGAIN.
>
> Use readx_poll_timeout_atomic() to check the status after the final delay.
> Keep the two-microsecond polling interval, 40-microsecond timeout and
> -EAGAIN return value when suspension is not acknowledged.
>
> Fixes: 1fe20f1b8454 ("dmaengine: Introduce DW AXI DMAC driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
>  drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> index 040c12d07db2..1a53fbc951a9 100644
> --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> @@ -1219,7 +1219,8 @@ static int dma_chan_pause(struct dma_chan *dchan)
>  {
>  	struct axi_dma_chan *chan = dchan_to_axi_dma_chan(dchan);
>  	unsigned long flags;
> -	unsigned int timeout = 20; /* timeout iterations */
> +	u32 status;
> +	int ret;
>  	u64 val;
>
>  	spin_lock_irqsave(&chan->vc.lock, flags);
> @@ -1250,12 +1251,9 @@ static int dma_chan_pause(struct dma_chan *dchan)
>  		}
>  	}
>
> -	do  {
> -		if (axi_chan_irq_read(chan) & DWAXIDMAC_IRQ_SUSPENDED)
> -			break;
> -
> -		udelay(2);
> -	} while (--timeout);
> +	ret = readx_poll_timeout_atomic(axi_chan_irq_read, chan,
> +					status, status & DWAXIDMAC_IRQ_SUSPENDED,
> +					2, 40);

use read_poll_timeout_atomic()

Frnak
>
>  	axi_chan_irq_clear(chan, DWAXIDMAC_IRQ_SUSPENDED);
>
> @@ -1263,7 +1261,7 @@ static int dma_chan_pause(struct dma_chan *dchan)
>
>  	spin_unlock_irqrestore(&chan->vc.lock, flags);
>
> -	return timeout ? 0 : -EAGAIN;
> +	return ret ? -EAGAIN : 0;
>  }
>
>  /* Called in chan locked context */
>
> --
> 2.53.0
>
