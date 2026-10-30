Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.63
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793374176;
	b=u39oKoKHw8Plhnp6lT5t7v9c7vrpnxmd2YWk4ptVxJTVTpvCKssVUqdQPK6RWGq9BnL1
	 tKLFaF1Q5sR2sM76yA9AkvnoxoiYXyPeTpy2fHUnSyi/Lpq8JOELv0FdDC9mZ1mae4o4/
	 BIzB6f9gyTqmbG4Ab7sBuQ68IV0wenwjv7JPGMvzovIaDnFWZreTjNESLZjHTZQzefeP5
	 8c19CvrWij3n1/gCDoEcpp1OIOCEHeaulkxsQrLg9klefFRmTkg4Y3UHwAsu1Vbxtml1I
	 lk4OwJvUqK2u2mFnrbVaneDCV6IdxZWE9YQfRIgN5Ruwt/6IJWBTo6aYu+l2pkjL+wQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793374176;
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
	bh=6/ElVyg9EUGewVW4fkz0VAIT/oQ5hMmnVjikSlU+wdM=;
	b=YSjlO0IDRZfkDGMIxAcl07HcwOPjQaMub/5fIE008g3+DjnaoBuDz3W9jZVEFy0bMs73
	 AOQtUJACdCPkyxtRzYX/snenJlcRj7nU9TczN4g7iZikCvdfRQHj8MH/WhUVtPA0gyuF1
	 xKp3TgrO3HnXwu3G01RYyoQPSjp98crLWAq905RHdZjQ7y7lOfZzy6DBufNrO4/p2LRY5
	 jmurl+yC3aytszyVq50eLcIjfGjig2GQtQiG28cLfz9WCq98Pk+mmLqJ7iPmHBZOm0bpu
	 SFLrcqJ1BGRq/FMvO/HwuS1enf+p3sv78BaP3P3wUtjXC+KAlT9T6WHz8dsVsCnoR+g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=TVjcDTBo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.63
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013063.outbound.protection.outlook.com [52.101.83.63])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E9D606A31D;
	Fri, 30 Oct 2026 15:29:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80E9D606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=TVjcDTBo
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TN0dwwGL8HLhnYhFZMhc2088govg6zEP1VtFXtPEcKeDGhUpcrHSSz+GCHTQQJ4IgLW/yqtg+G4TK3rzGiyU1zDLPVWHrgnYoDP6O1qSVuff5vPtJM2UASyUqP9eRcAuX6uGOy6csWtTJXYQyBCW21/mtLTsqVxEDThhI0Ye0CaOBNQb0L25nX3iVarX1l3lV09c8q6+WdjsszR80LE4HKEFHbkPthrP737rJMVMy3TUj88/p8hhzg+HShRFvOaQs80mD7ZRbqGuCZB2NiaE1BpboU1pLIk7L7ktKyHF13OfIqgsvoEFK8WwRjwYMXos1TkKaHzWBLffuCuJFKZBLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6/ElVyg9EUGewVW4fkz0VAIT/oQ5hMmnVjikSlU+wdM=;
 b=WxLZLKbVrp5U7Oo8x/siDovDh1VF3FI5kAM+iB+QQNFwJ9/91v8rWT6LgbtImb+D09Ejvhb+JU+TotNMuMhhRunmAltK6/MOHb8fBYA98Cc+skinJhx3WvLsaquCSBcBt5FDeY9jddXH3fxAIBon+wFKFPi6k92juuJjJdrPmW4QxvtQ/r/GLsbzJKobG2GXJ65vhY1FPoh0omDaVev9yrgFOQM7hFnAd8RWG4adgOsdL9VYDpWk40Fy3EpYPp03UZOI2+D/RaEdCzCoe0NqRRaIFZuLNTBUvOMKSw3x0pgY7gjty41xpuPYKZSBlGIg1bm3SXWPWNjnwchfGH2xGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/ElVyg9EUGewVW4fkz0VAIT/oQ5hMmnVjikSlU+wdM=;
 b=TVjcDTBoMaCi9e3nf/VbOpK/Br/oaQI9clPi8uhL5xU9XaQnaH0MEgliTAOkg1z1cNvnp8X/OvXlDBi6qjte4XSRMPhAVbxn2AnmhwsieRPwe+esyS2MCaZSsoOScXgHLoTjF8Nethulp46l2dHcXz8EvqzT/AgDXn4gr5qIm3u2dYaW0cx0Uyi70dZBOfff6eZTwPcsl0LTeoyQn895Bf+DovaCn2TpWa0gFpSViVtN2b+qSpErkJKFVKqycA0SBS2ny7UqaYycO7BraZnp1oyMiIWAKhEfqnjXfTIbduuGbcJk402s8QgHTai++qVgSK2iCzcmjqiSE/omhu/A6A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AMBPR04MB12445.eurprd04.prod.outlook.com
 (2603:10a6:20b:75e::21) by PR3PR04MB7372.eurprd04.prod.outlook.com
 (2603:10a6:102:80::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 15:29:32 +0000
Received: from AMBPR04MB12445.eurprd04.prod.outlook.com
 ([fe80::ba23:1fa4:ce58:ff06]) by AMBPR04MB12445.eurprd04.prod.outlook.com
 ([fe80::ba23:1fa4:ce58:ff06%3]) with mapi id 15.21.0569.008; Fri, 30 Oct 2026
 15:29:32 +0000
Date: Fri, 30 Oct 2026 10:29:21 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Viresh Kumar <vireshk@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Dan Williams <djbw@kernel.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	dmaengine@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, stable@vger.kernel.org
Subject: Re: [PATCH v4 5/7] dmaengine: dw: drain the tasklet before releasing
 channel resources
Message-ID: <auS30W3Sf7OKQX-0@SMW015318>
References: <20261029-submit-dw-dma-synchronize-v1-v4-0-fea447d9f285@gmail.com>
 <20261029-submit-dw-dma-synchronize-v1-v4-5-fea447d9f285@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029-submit-dw-dma-synchronize-v1-v4-5-fea447d9f285@gmail.com>
X-ClientProxiedBy: DS7PR05CA0070.namprd05.prod.outlook.com
 (2603:10b6:8:57::28) To AMBPR04MB12445.eurprd04.prod.outlook.com
 (2603:10a6:20b:75e::21)
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
X-MS-TrafficTypeDiagnostic: AMBPR04MB12445:EE_|PR3PR04MB7372:EE_
X-MS-Office365-Filtering-Correlation-Id: b676a872-b5fe-475e-5860-08df369a9853
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|7416014|376014|23010399003|1800799024|22082099003|18002099003|6133799003|56012099006|4143699003|5023799004|11063799006|261022075727099003|10067099003|261028144727099003|261021121427099003|261022105027099003|261026121527099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	66o1AK+jyRFJD+2GRQ+JM98Wgewmbx854aZOUgmXYBFB2rMStMr6AGoNot/519nIy/0mEup1sgcUUpZTIbTD1kEAo3MC0oGrSblAzt5J7xGPZxd59wEWds6iHOlvMC80A9j4JJKr3FDu+EDUxRA9pptSLoPGJt0Jl67BWFYpthAsuQLnQ4D6HxMes9nCarGfjI1Pmfi1I7fqVkWT+hrMwNSFhCB6OAp2sdNfR8MzzFcYxiqdLebkDIpYUy8FuTWsQzBuKcnDCQA49vC/AvQKpYBPxyJ4GicDkjaGtVzt9hNBOUClXhOMya0Xjy63mQv8Sbi4JwgT2qAGl0bArAH2nm0cXr0AeQ6zgTlpJQuvMAtAzD+iqrbtjPnrRWHelyffqOi6+rCDa53xr+xB5queJqzswlAtSFUK4Sk+twx7gi49+QB5w2PsDEKbs5IX+Q7Kkq6C0R8df2PmzEPjA1m4YaFfHfYmk1XHteFsvYV9DVoE4KjlBsY/vk1Vdr8XEHZ42Ig4K7Eh5GKOhGiKLun7TwHTunZsQgQ+/QIgkJbIxNYkNaiJxaqhs7A4+BmaW/9Z6eX3KH6S4q11rrUtpJJi64dmJfJsrtuJeRXOhKhPQLHLPg8UJTwVGTVri43MJFm9DHqkxHCmkNMSBrF1xGrQb+Pq/G9QTU4Oo/nvOg25UsY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR04MB12445.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(7416014)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(6133799003)(56012099006)(4143699003)(5023799004)(11063799006)(261022075727099003)(10067099003)(261028144727099003)(261021121427099003)(261022105027099003)(261026121527099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Rwk52/AynTp0xUfiQ0IHbHrfeCDHmmHXeln0KwvcmZedua10B7fqepdqmr3m?=
 =?us-ascii?Q?O7/RRnCG71O8Xf0Mca1WvLadJquGtdHasjAXDA/8V9PnrpRyIj15OWSdITro?=
 =?us-ascii?Q?OdQOeP+JwHJEgrRuzjDgodGOomFPd4Zzq3f/Yioc/ShYapRElZ8G+JWRU1wz?=
 =?us-ascii?Q?Wz9Zy8yuwMAHeKfVQmj3HbsQWbKZRR/e7qJNc09+VK0isw5G/ZbGV4nwYGEH?=
 =?us-ascii?Q?ZPJwikEdFT3+QB1CJ8BGGXehIiBvY3NzDz1hAO1tqcKESwrJj4KG0GKpZLMz?=
 =?us-ascii?Q?mvMBd7ROxbSrDAGl1auYiX3jMWNMNlP4GrVvDGzoBfCVSPG5q6eU4vJDtSDz?=
 =?us-ascii?Q?Z2fhbiuAFmqYFBvAJz6YIlI5ELpnyF6V1Q6wUYwyAKpeH9BTtQZ+XY5F3jOD?=
 =?us-ascii?Q?JZ58yxGrtx8ZMyplhMK5RgEE/qW9ZziAR4g7iAP4qdBphYCrC4CQCz8uQGBE?=
 =?us-ascii?Q?PK3/gSFYyddh0APJMVwll9VdIS28+V/+Q1Q/1qWWRJHHADvkUd7+BC7R1wGH?=
 =?us-ascii?Q?YTjBiB8LSiTB7oq+o71vTRIoC/Zs9vcP/3wD+U0JwVCm3LQUSfJ/ytZ8RX/3?=
 =?us-ascii?Q?V74hUOOTGvk37L1KO0/52exBUZsrqFe1KTbIxlA2HD4gnBxS5TNPtlUB0UQ1?=
 =?us-ascii?Q?7zN8oiZefHasYXUvvngur6/T2M6b3vM7TmZFUeeX0qgEGQrEAMoa7oWWP4dE?=
 =?us-ascii?Q?5atTGfbneqX90JQiaINZx9M9MgNAw/zrit6W4JGFuBje7QVLvU8aq20bzxEq?=
 =?us-ascii?Q?9SqkqzEZuyQJshuFmlsPGz/MLmEEgkwy0nKI/O3rGVuXGA2yd05z1XuuqszL?=
 =?us-ascii?Q?s3HLVqmsGM+aniFXa9EjgCEf/Ezg/IDkwaeroG52b3y3byxOwDTMtEMRA0n6?=
 =?us-ascii?Q?/L2nADxUtQzL5lQ+sGyac74fhr0J+v/IUioJPHVSYhQATfYgG0DHrFPb3JdX?=
 =?us-ascii?Q?vICXww+NAWnprb7fXsTOZTEJwH3Xw+R1hP7g5VMzV3fhIFGj8RfdU/ILE+cg?=
 =?us-ascii?Q?DOTmo4n7ZWqOwZIhCqd2z+RJJnWtynNYcJbh3xhFOKMX850FzFi4ZRGoTlQQ?=
 =?us-ascii?Q?JeX4Bp7zyspJhqLkdZFy/pILpAaSwfx+BmnosMjE+8Gybg8B7VH9nCn2JpdV?=
 =?us-ascii?Q?4MsCir56OcdBTP5d5pq/qVsYKGp8gadKU/yyp8ub092QOhXILL5NiGO/g+w5?=
 =?us-ascii?Q?EHjTc44VReoMYWmk7nTjo0+ntgR9zrv5bm2mQBZjUcasNyLCEOZsGjUYOBrt?=
 =?us-ascii?Q?TgGWFOfLIaSR0VMYWelxT6cLBoLATLDw+PyhntA3e1dEk2KLzpnC6lb7gx3d?=
 =?us-ascii?Q?M5fyWPTNpsR+zDhU7dInLiZ0RFk9zSz8lcEcn8ZX9TOdxXgZum1d71ZGnxHC?=
 =?us-ascii?Q?a5noFXhI5Iozwau0jnyhqV8nIE+mT+FMVsfGdFyVY4D3jKEBHEnAWqA8IAXO?=
 =?us-ascii?Q?aHdjpLCiNfof1Qs7P6islnyLZrPDJRonK7ttkyU1Zrjdk5LAjiekAkj4qS5y?=
 =?us-ascii?Q?Q8MYt44OPfHqFJlWDJOcGM/N039UhCXLqxzrrRAsG9l1tLFxoe6eOy5e2S7J?=
 =?us-ascii?Q?r0xnvv2xpbxuFsDEqkXpMDQIwFuVSiufoGsSSPw+uzxoh+sO/JymC9yNaZ4j?=
 =?us-ascii?Q?uwY7S0lQAkkhOjInydF9qkEET3wkW7D98XM0PYMI396yTI7LSOk6snRUSHZ8?=
 =?us-ascii?Q?kYLhqGw6A58gVRKOfUdLmL9C3Hi1VDmXDheYzNL2RoI2n0MbfXx8+xW6i8Sq?=
 =?us-ascii?Q?yhA14i4liC3TAb+U2rDd3HIgTRfXsIQWDG3s/0YERU0HubeNPLOu?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b676a872-b5fe-475e-5860-08df369a9853
X-MS-Exchange-CrossTenant-AuthSource: AMBPR04MB12445.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 15:29:32.0160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SUgFB+l3N+dUx8FvIqi8W4lqSq2Y/fgkDzvXDBGiBoPko9+JIlwRCEkwPSWJlom+EGQ9D4H5W+WC5gvwA9bneQ/qbiyF8DSmnqyXLKqiPGHA1VDgh5ju1zFg10ebgVCi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7372

On Thu, Oct 29, 2026 at 04:29:39PM -0600, James Hilliard wrote:
> The controller tasklet invokes callbacks after dropping the channel lock.
> Releasing a channel can therefore clear its configuration and disable the
> controller while that tasklet run is still using them.
>
> Disable the tasklet before clearing channel resources and re-enable it
> after updating the controller's in-use mask. This waits for an executing
> run while preserving pending schedules for the other channels. Have a
> pending run return before accessing registers when the last channel has
> already been released.
>
> Fixes: 3bfb1d20b547 ("dmaengine: Driver for the Synopsys DesignWare DMA controller")
> Cc: stable@vger.kernel.org
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/dw/core.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
> index 1d6419e1cd3c..3bda85adbeee 100644
> --- a/drivers/dma/dw/core.c
> +++ b/drivers/dma/dw/core.c
> @@ -398,6 +398,10 @@ static void dw_dma_tasklet(struct tasklet_struct *t)
>  	u32 status_err;
>  	unsigned int i;
>
> +	/* Channel release may have drained a polled completion before this run. */
> +	if (!dw->in_use)
> +		return;
> +
>  	status_xfer = dma_readl(dw, RAW.XFER);
>  	status_err = dma_readl(dw, RAW.ERROR);
>
> @@ -1067,6 +1071,8 @@ static void dwc_free_chan_resources(struct dma_chan *chan)
>  	struct dw_dma		*dw = to_dw_dma(chan->device);
>  	unsigned long		flags;
>
> +	tasklet_disable(&dw->tasklet);
> +
>  	dev_dbg(chan2dev(chan), "%s: descs allocated=%u\n", __func__,
>  			dwc->descs_allocated);
>
> @@ -1092,6 +1098,8 @@ static void dwc_free_chan_resources(struct dma_chan *chan)
>  	if (!dw->in_use)
>  		do_dw_dma_off(dw);
>
> +	tasklet_enable(&dw->tasklet);
> +
>  	dev_vdbg(chan2dev(chan), "%s: done\n", __func__);
>  }
>
>
> --
> 2.53.0
>
