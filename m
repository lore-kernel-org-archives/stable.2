Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.61
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795022877;
	b=Dx4yP3HXlcNR9CC7Svge45vUnmT7iXONiE1otLXhuqAdP4S4+8CioGeO6cLjSRbulDr6
	 3K92C04ckosDzvIq4As7NtNin9nIvqaW7Q5VkCpyqevcgzvzJfZwtCrRmZ2qQHTpSoIFF
	 HuBvVaqVL8i+7b9+juGdTtXAher1k+CB1BzX2/J9ZXJQluO5DsNO/eddiXgvoOHUy5mC2
	 al2tZrhznAgo83RXnZb2fbuJ2dtsU3NVVxQq/xV9u65IrEEvL4P6UdTYcuV+Bvp1vHWxt
	 IpvSdlXyHHUDXKcoPpQDiPCa9pXuSsoj0O9nv6BAxyhfCLs2qCUqx4bw35GYxBGJFnQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795022877;
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
	bh=RBEX9mfKNAyJhjPWqjOd3zfNidiypztQHZ35IU/YGEI=;
	b=SydThJrNcGnbYjAhIITmMoavKssoEgt2zDLkbv9TsHMqzxmWdLM5/eiucqltaNr0NpVE
	 Hz3b+AJYdO3MnkdF9SuqBycsDQu+kXf5480zaxyELLypWVOu9YEPaB/pIUJO9W4HUwHGQ
	 R/Vg60C1lwis9O0uQdp/qwPdO4hOysb1pZI/co30ceAM0TXppGWRxGEYVfdXDUfyS7nT9
	 7smmRku4O63QobK5x+60z8sHjiXtNn6/hM5x5o5K+lbxetbVj0r4x9mIbWJ/FloZOgac0
	 mPTG8ARysGjow7ij0Y5uqx6QadR4F65n6yAkwyrLbGJqpzIPkqDKVBgM9lYXyIQ/TFw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=XNk90PMq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.61
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013061.outbound.protection.outlook.com [40.107.159.61])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA08D606A32C;
	Wed, 18 Nov 2026 17:27:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA08D606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=XNk90PMq
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eyaoff37DcdLc1PomAbGwprx7/uTxCbaRHsiuR23PDytKeDOmQ75QNS+i1crVGvLLRhE3hfwYDggik9yS0VEWTG7x/S/SdUiqGSZQ4GIteREaThlKz+k8iq7BQ5/LzKBFMO/9VnMgFq5cpFpVzTWozBrH07T8YawPwC8YodeMOqP+khbTz3Y8jw8w/6nj7+nthBcWT7bmNp5nmX4IVD6vXExsr8IZxKpkq0iEFvtpuLLzVQ71wsQNsTDzpeTfY0tvpzQccEjw6/b0Sl5yBnqZKr5OLMJb1r8y+hvAWzk9YRaJT/vSrX+/LYMwyC1aEWMiEaXJa2G6iOYnp850PiFww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RBEX9mfKNAyJhjPWqjOd3zfNidiypztQHZ35IU/YGEI=;
 b=Vlu/VY/8xgsRhJ6u+32bjfp7OG4IzzkG5LqW/ShyU3zqKPeBPwAzK991uXsvsAZ6NEWkM5m6X1XFQ0/8PQPrumAWUYvj/3zbX9ClYBZjYv5OLso9wFjnzFCRtskxll7oo4Q3E0d+k7lhaX5SK5vlHIP/MmOT2QC+67DINxSOTM9IBjRe3wPPMq41C9p8+BnEnj+DZWn38jjgERJ2ano7Oh8Py8iQ1kn753DJFiB17j9DV7WkdM+Df6iLGhNdMWgPfNpJIJky4kycV8Ttg0QWwzWIeO3Ys4+pJvynQral7PB5yvxWGpJObkc8PPcxu8Z4dcgd7uNl7oRgQ+f8u58q2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RBEX9mfKNAyJhjPWqjOd3zfNidiypztQHZ35IU/YGEI=;
 b=XNk90PMqysVoTtiJnpmK6wft68NG8cFQ+fgagqH9dCG+ViOhwe5Zs48khSSPP8w8NuCFPoshnCqAfRV9UVikehIhOUpJOwB+/bOE7Mc17xQs+yZ4Aqt/K3tV9Anq8VMrFK1QMI7WX0uDNjXFV548NLhamevwdO9i0/GWzcH7wlNsVJMcTcrCGc4bY88BLEjFkI/z+OrQvqJL2zasY8FFT9B1Q5hNtt2++5yNCfcQ15Iktb/tiQMC8d1RBz3fEaidQl4NIVodAA9DiQW/qkyPJWndYCaOOTyT5nnTL9NmhqTPNPZFKc6p1GmsYUTbFejmhGmeKvuuStpGbyKa+aDhxg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by GVXPR04MB10636.eurprd04.prod.outlook.com (2603:10a6:150:223::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 17:27:53 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 17:27:53 +0000
Date: Wed, 18 Nov 2026 11:27:45 -0600
From: Frank Li <Frank.li@oss.nxp.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Sergey Khimich <serghox@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sia Jee Heng <jee.heng.sia@intel.com>,
	Mitch Barnett <mitch@accuratesound.ca>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v7 2/8] dmaengine: dw-axi-dmac: poll the correct enable
 bit during termination
Message-ID: <av3gERkhJ-loap-v@SMW015318>
References: <20261117-submit-dw-axi-dma-stop-pause-v1-v7-0-d5f2309afd72@gmail.com>
 <20261117-submit-dw-axi-dma-stop-pause-v1-v7-2-d5f2309afd72@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261117-submit-dw-axi-dma-stop-pause-v1-v7-2-d5f2309afd72@gmail.com>
X-ClientProxiedBy: PH7PR10CA0016.namprd10.prod.outlook.com
 (2603:10b6:510:23d::8) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|GVXPR04MB10636:EE_
X-MS-Office365-Filtering-Correlation-Id: 55f2622a-fc3e-456b-629a-08df45994726
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|23010399003|19092799006|261102123227099003|10067099003|261021121427099003|56012099006|11063799006|261026121527099003|261021123027099003|261022105027099003|261026140227099003|4143699003|261028144727099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	yg1UFlfVM8ZdM4V+cM7jsKNLiuC1qDdiSDxKzSQUvNGfshDn38FUiTaiJBq9V6VnKP911FtwcO9G7SohAw7SKFwMmGSGB/TugrKg+tCLeWHMkareRbMUMgYsLiyfen1F0nNIpxW2xjDLWdOeiry22Utu8Qo7+fjdDXIqbtIVdUW+zV2z9460p+/AOJXtQs3kxdHb1r6XpCJ0n851L7g7YBsRDt4OSRUE2WWN5qqLWGIEKe3AQfMGNt0i5m6dNg1s1fqk7gLdnBU+YGg4CE5UZCaZhrFf74igRLfpu9b4uOKlLXphdBg+DVc3AabYFdAdaPbPFoJEmyDT0E21w07DLH6OqimrezyIwdZx69Zw3kRy3qdqjTPqzQKwiIia3pNHBW3ySd7hFBQzICPWoSXFkSQSwsvvY6JPmajEEp5MDi2dFqYxGiRkm3ljd9pTWmtZyWTH4iJl5hEqvKGmLMtwKfvzWdW1LuQag5RD4YIsR+dQ1Ytk39GTHw8C8Cg+Pnh4lPt9SNQWHRxLXj3Ksl0i0PqeCsvTvhZYM7J7Bek1rOjsflyz9U1nvTJcepzBQCTP3zDnv75XVthsfoCE69HD5bP3jfiOltvwqUtpp9wnQn1JMOkTvTfwiAv6QnYeKU0VkZnKQ/1K7ezNFEpxSpwIKEOeEegDAELMJUlJDgW2O+Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(19092799006)(261102123227099003)(10067099003)(261021121427099003)(56012099006)(11063799006)(261026121527099003)(261021123027099003)(261022105027099003)(261026140227099003)(4143699003)(261028144727099003)(261009223027099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ch6Bd095SnS34pfqe6m/B8bCwgOQbrOzUUn/OoAXHJSq7HimkbAYDBYMMkmP?=
 =?us-ascii?Q?8T20I3+lPssFqDWkOQX2MKWa80nlTsR2JIZJVwnc4W6PtywXiTA4Us0WBZ+I?=
 =?us-ascii?Q?kGfN/elJrdaRn0eNESSZRUq+H+pNBKbmqaTwTCxfw7CD2pdBn9JmdSRGbePO?=
 =?us-ascii?Q?KtPzf4fxWPNcWymyGcK65aiRsK5mx4U0LprfSFADRICe2+C59p2WRz8dpHE/?=
 =?us-ascii?Q?qDrzc3YdxX5hz0uFUX0IchmdrTdkfOiyzQBVbO9I6nBOTDXb1iuu5QPKfo2G?=
 =?us-ascii?Q?xkJh8JBFnMdWQj+mUU4agdZJ2vIVGs7JEZq1q6j4fImjColz/G4dI+EIdZKd?=
 =?us-ascii?Q?tXrKM5RlDBeq+QdMGnyNjKQdbVUUckvAT8acq7LcgCeNDdwjWvR2DRsrvxjE?=
 =?us-ascii?Q?JnYEJPmpHKjkY9rmdO5J9gR2lUbvWxB8q9OpMlRv8tN14M98YPC4UlfIZ51J?=
 =?us-ascii?Q?YU1GGL7a8lr16tAKyIVGqrzIg7mcnWTIF67x36alKhUIMjHjYtrTdVHjkRug?=
 =?us-ascii?Q?9u5MMpDESZosklPWNa+mLlPG5yUgTy0D9I5TiVFAfYt/f8YncTVTc5g29H93?=
 =?us-ascii?Q?E/JAoEhHCK0tysW+sOLLiyevuIpM4wCd72WRdYm+zy2z+kOw4gdxsV0V84ur?=
 =?us-ascii?Q?PpnmoOAfGAa1yZGy22PitHwc0QNQLs+OYjoYwWsntGoFtKZFGr28/rwJPgb4?=
 =?us-ascii?Q?G2YVuRkUXrPurMUGbUiST9yZ/QHeIPCXqziQGfHwxpT6jkeOWKWBZ1dEVe2g?=
 =?us-ascii?Q?QpEcVEABB9xR81gueE998VxNSHvKOzggGKgFa+EVVw+LrTci7zeNv8y8aHhS?=
 =?us-ascii?Q?S9kawClaJXOaUOw3Di1R4mWAe2HRkgDGw48Efdpaorvhev1jQU2F6PyH5VEZ?=
 =?us-ascii?Q?PyYGXHGuxhZ2MHrypx+mHxbEkpiP36qqY+F0XIG32Npt9kBFzhB6OudVLjm4?=
 =?us-ascii?Q?buVL/p360rNBNEsBmiujTFP8Ew15M+olWRKya9r9qNqTdwXFxqsKaDOKJtlf?=
 =?us-ascii?Q?9EjUxCC/vemfvr3asddtJ+QGfimMgfawSvBf/XfcCyxTu+QYF+UOrKymMH+a?=
 =?us-ascii?Q?6P1WArPH2n9P1uRIn6rfLpwsDnyZ2YLYNl7d+enLiWrYX8npsh0mp79W4Nxr?=
 =?us-ascii?Q?CCkRJo2JM0d8G3DJzxdAvMxclOLi+4IAppJbbtTpKJMMGiaTqfGXDveatX9C?=
 =?us-ascii?Q?TKInd5yFVgw+hpgcECBMHUENOSWTc51N4lvh/Y0OkoSzRy6P2PSiENjX22a0?=
 =?us-ascii?Q?aDWqXayQj50AxS+/0X8DALr6cdMr/K2B0Px/h0MGUyF5JHla3PhMRnEI2Plc?=
 =?us-ascii?Q?+rVPWQGBqmJKei+vUEgBwWwbVL+SYi9o+04vBsqruA4XKlSvjBvMpEwsIdGS?=
 =?us-ascii?Q?VqLzXtj4Twk3mcrKad7EWiwHpRDQqZfH8eq2JOThFxuv8qoXezGdwxHOWZUT?=
 =?us-ascii?Q?LH/NnHV/pKEVSymdQsLbu85L7Bo2uL218xZOZO/DudhCQqYLsu2Qrm1ZyNJx?=
 =?us-ascii?Q?P+e3pe0xJ2mSiRq1Zd15E5317NHtXfNf/To5daKFDg0yRlHN2D9ITaKbYv6R?=
 =?us-ascii?Q?GTLke/OBQPrNPHYkX6oMsAeG7VXrzbhKksn7RvXLqRc4RYjlvUtJtvfrYtV3?=
 =?us-ascii?Q?iDR2R1rO08LJUpCk+ZIl0lMxgG5BfcqhYF+uwZYL044R4YkwEaJQ5tfenP8A?=
 =?us-ascii?Q?NAiw4M/4m3oEfeq6hrrLlu6peRzJzkBjb/6GSnqaBs23+OBMTWUKDsPcrZTI?=
 =?us-ascii?Q?KeRMVUW1VFOjtsHgngDaDzUG3mARlGaoIMwHcxmKLwZS4jUSziU4?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55f2622a-fc3e-456b-629a-08df45994726
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 17:27:53.8110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9meIkLv0yMRP3YOOVgOPOgxpv6AtqGBzQ05due5amrnyn01nPAwM6zYVGDCPU2TIyzUHg076zbIqRDt7VZ6nTs39pxN9O9t46rNIfpVH0au+miXYoyk6qAu2QDvv2/8M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10636

On Tue, Nov 17, 2026 at 05:07:41PM -0700, James Hilliard wrote:
> For channels 16 through 31, the channel enable bits occupy bits 32 through
> 47 of the extended DMAC_CHEN register. dma_chan_terminate_all() only reads
> the low word and tests BIT(chan->id), so it can conclude that an upper-bank
> channel has stopped while its actual enable bit remains set. Descriptors
> can then be freed while hardware still owns them.
>
> Poll axi_chan_is_hw_enable(), which already handles both register banks
> and the smaller channel layouts, instead of constructing another mask.
>
> Fixes: 495e18b16e3d ("dmaengine: dw-axi-dmac: Add support DMAX_NUM_CHANNELS > 16")
> Cc: stable@vger.kernel.org
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
>  drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> index 6dae63024721..405ab9a78955 100644
> --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> @@ -28,6 +28,7 @@
>  #include <linux/property.h>
>  #include <linux/reset.h>
>  #include <linux/slab.h>
> +#include <linux/time64.h>
>  #include <linux/types.h>
>
>  #include "dw-axi-dmac.h"
> @@ -1179,17 +1180,17 @@ static irqreturn_t dw_axi_dma_interrupt(int irq, void *dev_id)
>  static int dma_chan_terminate_all(struct dma_chan *dchan)
>  {
>  	struct axi_dma_chan *chan = dchan_to_axi_dma_chan(dchan);
> -	u32 chan_active = BIT(chan->id) << DMAC_CHAN_EN_SHIFT;
>  	unsigned long flags;
> -	u32 val;
> +	bool enabled;
>  	int ret;
>  	LIST_HEAD(head);
>
>  	axi_chan_disable(chan);
>
> -	ret = readl_poll_timeout_atomic(chan->chip->regs + DMAC_CHEN, val,
> -					!(val & chan_active), 1000, 50000);
> -	if (ret == -ETIMEDOUT)
> +	ret = readx_poll_timeout_atomic(axi_chan_is_hw_enable, chan,

This is hack usage

 * readx_poll_timeout_atomic - Periodically poll an address until a condition is met or a timeout occurs
 * @op: accessor function (takes @addr as its only argument)
 * @addr: Address to poll

chan is not addr, although it is first arugment.

use read_poll_timeout_atomic(), just argument order is difference.

Frank

> +					enabled, !enabled,
> +					1 * USEC_PER_MSEC, 50 * USEC_PER_MSEC);
> +	if (ret)
>  		dev_warn(dmaengine_chan_dev(dchan),
>  			 "%s failed to stop\n", axi_chan_name(chan));
>
>
> --
> 2.53.0
>
