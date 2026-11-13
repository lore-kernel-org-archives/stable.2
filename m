Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.34
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794597725;
	b=xGkGz8PDOhxW2glxyOKMYSsGr3C6sbX5EmCPHYAtVZpYil83b9aAZwvwCfytL3IAvrWV
	 SzWwCiCHlfaqyu6vDAsOTCwEOQaien8AQCxD5yZ9rOSb3HTUGcuTtyvpGCtkzFwMSiOCW
	 W+V6C3LgyxJIkU4ISyTZvOgmQcfxnNyAXkvVjfKrAKqsGFfxEYeVScLGL/EML80D9UHRn
	 k4Ia0AP5eqPBo4mycixfgHzlxKPmEDFe6G8/A8z/4du1MgQEB6IRyLmCIYQLcaKfR/cHO
	 WJ8ZOctf6zfT5PBYp+YsRp1M3wwUObXcVStzL4cywT1yPT3iNmE8dyvtD+vMZIbwRIA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794597725;
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
	bh=p4i9JNpOyHxYy5VGQ6RX8ZeU35OAgHMD5gWPd4aBxZ0=;
	b=nA75kuNIHk7vShf+rOdwUL8AQB6DfCC7A8iDIcDsKKIF70BAtFRHVuVsDJ8ubda8ZC0I
	 i+5+UMRifzudLi79ZvW8W/2Dkxu207q7zb780EPiqVfeQvI2xtb5/Yl3VG0ycxZd9UeS+
	 CYeU8PjWa7UHz6eZPw9KPXAtvgCpG+zNUa/gLYG8IHCE+TkOmZQFscFjfd1B0YpsM6iWq
	 AFGdqlkvNuTNn+ehWRnPp9KRpUvXNivroqd3omK+syvJEl9MF6F/1lhFZTslvY3C8eKMl
	 m2IIfiEsiYrOBCsvT7QKY7SN4W9xscepptBldJJEGYZ9KNUjNWdX/7kcuBj00odZh4A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=HdkzYFIF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.34
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013034.outbound.protection.outlook.com [52.101.72.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F264D606A332;
	Fri, 13 Nov 2026 19:22:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F264D606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=HdkzYFIF
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZgTtBDqPDsmUh8I6ADo5GgcszjghQK8fns7RKzgwZcYrm/Hs6FXiwaDv887nMMcRemXtIHgtPnQELgngQJiTMhLPK0MsyA4MXZasUsRwHxXR78Kn12/3tVGY8IokgbOKjLmm64aqle6GNTGtgFAYam61juz0x35QBtyfLD1SkFkXHsaQSG895BP0r0VoyMPz8N2tn5MAa0a82xjEgMjMZ+DrpVghlOFHHMuFzyeLCnoYFbpePDqjz47ac5pqO+EZmEI7pIfk/nW8scEHpwkyIPQqF8Ftagp/5MuvTS7bz1pgSwtIYRHRnCaEFAj5xCmg0vO45881bJ0lqKyW3chHKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p4i9JNpOyHxYy5VGQ6RX8ZeU35OAgHMD5gWPd4aBxZ0=;
 b=g8Y5+9gRiDXdyp4zgpPJfp0LhA/rgCjf2rfN93l2dQDYsa0jpBUGBVIEjQeXq398xSEvytUYAvkk3zAAV0S748bfl4CaaWfh7tArFHktACHpO1FQFFTW9S5G5cfIBuSIQC9+ejFJYkGu5pRLyPaILUe/sLRaxiMqDigb5/JQREJF9A4Ka48NybXkclnyu6xXLoZ6RdBJ743D5nBLLSOMKOGsjiMkCi+CGQkajcOypXGb71H5EG92BGXG8oiy0qpgrG6rG9S4RzFPiM4+1/Qj+sG/KG5637LL8J9EKrbioSXjpz3/pNjp2sM3+fwVxqgGG0fEb5r4wMr8J0FjKEWniQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p4i9JNpOyHxYy5VGQ6RX8ZeU35OAgHMD5gWPd4aBxZ0=;
 b=HdkzYFIF4m0G9abvQnF6Bn68wVDAsfsLMEAVcCVPW/XyGmdI4Pb0qbSJD1wOVaUVPzVkmm9v54vWtEjxsM4rxJhBRZHWtq95LdC0ZTwy7dgAXMm1kOvLuSGD1rDf2DY0c3eO4iB4Gs2iZhmPrWDAen/2t0Er/bot66xErn5195j5nINMgJfyspZSpQuNkDnbE2f0PJhnVMq/LQUCsZu+YQbMBF4TtNeqC0X/OUII/bPG8JOvRoJzp2kxhJd/xETbB4ZjgYajK+Bx1M0UShnSIsA+zqBIKEZkV0jEKnK8tSaB9qoAAvIWkxhW6asEQxaIckOfW2TtPG9ABuRyg1zJ2g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by DBBPR04MB7834.eurprd04.prod.outlook.com (2603:10a6:10:1ee::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Fri, 13 Nov
 2026 19:22:02 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 19:22:02 +0000
Date: Fri, 13 Nov 2026 14:21:54 -0500
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
Subject: Re: [PATCH v6 07/10] dmaengine: dw: report residue for queued
 transfers
Message-ID: <avdjUuAt2yhZFQ0d@lizhi-Precision-Tower-5810>
References: <20261103-submit-dw-dma-synchronize-v1-v6-0-2ee0c348224d@gmail.com>
 <20261103-submit-dw-dma-synchronize-v1-v6-7-2ee0c348224d@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103-submit-dw-dma-synchronize-v1-v6-7-2ee0c348224d@gmail.com>
X-ClientProxiedBy: DS1P222CA0005.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:8:454::18) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|DBBPR04MB7834:EE_
X-MS-Office365-Filtering-Correlation-Id: d7616446-1cfe-448d-d190-08df41bb6512
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|7416014|23010399003|376014|22082099003|18002099003|11063799006|4143699003|56012099006|261028144727099003|261022075727099003|261102123227099003|261021121427099003|261022105027099003|261026140227099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	zmApsCBx6nPU8zlc6BkZbuXMPtQf8z+x0s4iG38LOTz832Flkj9TvD5Fza9J67WCRIn76e/tNPz+0Og//8K0ohzHMK5O5Jy6EjBscB4CTn/f0w70LU/F/qk1kH3KWSSoNSA8QvrIsXrWn83fh+EdztCiW3yJhrkFdgQzUIVACHg4U8BjO856y+3JVKWjLX6wXpSSC/m9i/eLx35GfHkT4GKvwv29cXY6OD3ehXp18AUCmzXpMAtNhKOzPCUQzneyzwvlzls7f9JCU+Rq3B1V4CyT/JSEu8ajMnVyG5bNsULUw/wQ82pPkOzGV434kTj4R5SMb5Ad3j/v/miSaAhHxd5YkzrLmUChJSpU8oFiKlUnX5M7hoOj4B2kJpBBwrtESgdFlK3zgWPREaDBzABQd7bboGaipxpytKuMi/gsFf7mBX6oUbnTvzI4Gl6yx8l41y2dNH96avffWHm/CmiuOIA/+DgVs8WRbebGBFPhEgDBS8LHkSDf7jcTI3QdZFsJxyJeXCZYQP/rVZpBCr6YDrjr1gCJxhWVrFWSQvlGFMEEGqicq69MnI+STw0Vko5HqIrcJM13Pz1eZQcIBJX3ZMZOLxMtfD0KNE9NCC0FI3AO+9zOZ7zdNDJS7h8F9pTRwnzEsVMwJRaBMGfywZUZNuTAsg1i9xU+GqKvYZ0Sf0w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(7416014)(23010399003)(376014)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006)(261028144727099003)(261022075727099003)(261102123227099003)(261021121427099003)(261022105027099003)(261026140227099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dfCbzfTWSYDmgIj9XR0RQeCNa8NP3LsV1CcSiOgnVopbKB8ZqgYm/uEaZvsd?=
 =?us-ascii?Q?hRLMTltwlP3iGhq0mC1e0Y2hGLXbUjdnpkk3IHU7gQ78KNFri+n6hcsrlxfV?=
 =?us-ascii?Q?K92dqnBCk8A0nyB1nsyVYKBM5cPhW+9sIl9ZA6aqZ+pzXdnFspGbzGpCqTbK?=
 =?us-ascii?Q?JNmYjQkDhKl3AmOKz4LZ51NlNDHmnmmJfjE4bdtaLp6Vs4LM2J+pp6GRP7vi?=
 =?us-ascii?Q?XnvdfT5zLmI9e9iPtTHm8tt9pn2uMW6a7mOqd2mxw8kDPIkZVlZK3fJySCqa?=
 =?us-ascii?Q?UNuUcC4UcmvhpTVUzucMuE2Fr7WqQLBgfdwmlokSeKT4pL94e+Ld6g9sCdwr?=
 =?us-ascii?Q?Gl5YUu3r7YlZTQyH3lqm9JEj/TX5/e7qyvEfFMZ+h55VrzYq+yRQt+J71wIm?=
 =?us-ascii?Q?G0ENaF3xpj7B9iueIrvYuP6W4Y31ZS82/5JHbq5orrlMkBoZyLJDFQKN337v?=
 =?us-ascii?Q?UGfc6bV9YkIkkrS1/xcjKWFXhbOTSRoamkkNAzSrpM1oFnNlXBYjzCk6Vs7Z?=
 =?us-ascii?Q?qhUdVj8QYsYXOh0//H7d0UsD1TJ4Gzz7ejPE56/oUImRTCPcc4hUfjZ6tAaY?=
 =?us-ascii?Q?nkBfSUDtQAfDuaBwtpx4tcb0BLCSVYIqFYwUH8guWKgpEUPQiq5TPIaWd0mG?=
 =?us-ascii?Q?t+7lYc/ZwNGbA7sTQWYJkTGp+3QV8eH/HCEhHDv+DHqPNzWRarNtnxgD8QJa?=
 =?us-ascii?Q?mmX0sJhhkoRB89tMEZpZA4RrRC6sL5yRZeHE5X3tjKivHZNXmNRao7of9mKk?=
 =?us-ascii?Q?mIfBp5PBwbcsmOCHfq1ZlgXPtc9MqdCrDpiqCDzLBSuZGfPSyWtdOig3KyCT?=
 =?us-ascii?Q?O3HJnrRlE3PAcGRO60zzi/s3/xIqTXFyCywWGQpNSeqLTF0LYfwjl7sz4y0f?=
 =?us-ascii?Q?ZZJTr4hRHbc/T+Tx8yLCZa07RTY4AOdCo7snKqMF9/u77tbSkuJtbLR2qAEF?=
 =?us-ascii?Q?ANaBWKPcL/96ZK/1vLUOygYVDqIC0TRHb4JKd72BovigB7X8XvmoOlxD/s7p?=
 =?us-ascii?Q?WNvwE68twH51uFYNbNSfZvZ+LOi79TZ9ORZ7mUs2w9gtnQL8MLpjSGihNRTN?=
 =?us-ascii?Q?51twLx/pJFKKhqehm420SA8jcPQ3pme0B1lHRjPkYPXHBu2RScwMfh1VhPlM?=
 =?us-ascii?Q?y+835ipHoRqtEzStjeMgwO0OzSghqnZfVogQ/JAVmmIqYCf82yDml/yzI5c7?=
 =?us-ascii?Q?ygPhbHMh3xDhKJmhhyhoEVRR1rDovQIxdMEUGYAkSnudblSfzeHtEo+ZCM0U?=
 =?us-ascii?Q?ZCS/z/IYEZJC31xq23UigOvVMuv2gVUuXTUAaTOPmnrJdCKW0GbviAKt9N2G?=
 =?us-ascii?Q?nkeBLHu8u35pvpkn5RvD+lrTtKD+n6IpT4YkCoy4yuNFIMLqqW0WzVXuAzrI?=
 =?us-ascii?Q?FdWBINI+Dh8dSTtL1g1tD6/asZtZtiUvZVbXhBbv/Qb0fGz84g1EJRsjyrF9?=
 =?us-ascii?Q?VB/s8+gf38FHdYGx+fvoh/zSTAHuxN3nheB5H8uNQVER8uaNfSkIXZAfUu5X?=
 =?us-ascii?Q?Fx+wyjRFTcEB/3OXtqptLERwSkUUZ4ok7KS5yvIhV7u0PHCqqMrxuRdOYAAa?=
 =?us-ascii?Q?Y9fnP/JsVWfRYBV8FzAoVjI4PPQWUzlIXqIqmDrN3LyLVbrwBOFmslOb7B1I?=
 =?us-ascii?Q?GggrxZkLK/usxvnFVJjeC1qxAujEYqxE+q+hZ4K5ILL/qV2hr+voIOdTDBaO?=
 =?us-ascii?Q?fIsOdpPOtFZ/y2pdF0B+KsRkTnFF+yyj0V5Z0ucZ538vNKO8UWqwsh7e+47Y?=
 =?us-ascii?Q?oPhEGUTyrHOJMJGL8yMYxbfAYCjTLrkX00MdtVVGLc+WJe5sG/pk?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7616446-1cfe-448d-d190-08df41bb6512
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 19:22:02.1061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aIYb+JKPoJFxUdxADHRt1jlX0NV979JpXS3fzCYJCaQDWXTUmiELs0cE7sRL6OtmvDsP8ERhTNkmLKNIKKeFcenyKlZFFshBQgiF8BYY65cV/IcybMlcsOSxk6WIKiPc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7834

On Tue, Nov 03, 2026 at 03:26:09PM -0700, James Hilliard wrote:
> A submitted transfer may still be queued behind the active transaction.
> dwc_find_desc() only searches the active list, so a status query reports
> zero residue for the queued cookie even though none of its data has been
> transferred.
>
> Search the queue as well. The status getter already reports total_len for
> a descriptor that is not the active transaction, giving queued transfers
> their full remaining length.
>
> Fixes: 3bfb1d20b547 ("dmaengine: Driver for the Synopsys DesignWare DMA controller")
> Cc: stable@vger.kernel.org
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/dw/core.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
> index 3cc8579f8829..c602ea01cb83 100644
> --- a/drivers/dma/dw/core.c
> +++ b/drivers/dma/dw/core.c
> @@ -927,6 +927,10 @@ static struct dw_desc *dwc_find_desc(struct dw_dma_chan *dwc, dma_cookie_t c)
>  		if (desc->txd.cookie == c)
>  			return desc;
>
> +	list_for_each_entry(desc, &dwc->queue, desc_node)
> +		if (desc->txd.cookie == c)
> +			return desc;
> +
>  	return NULL;
>  }
>
>
> --
> 2.53.0
>
