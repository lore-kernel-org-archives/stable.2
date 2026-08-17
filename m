Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012024.outbound.protection.outlook.com [52.101.66.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8487940BCBB;
	Mon, 17 Aug 2026 14:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786977068; cv=fail; b=VZNOq6Uyxb/xzCLmTKRqVgX5Y4P5SPlFsB9bHuJDcK1oXDDTuZoFU6E7jrsp2tQPSHev0xX18CwUSWJu7ilMhM6EQKF5FNacCBCR45Xa0mGYm8IVzraOQpqqPSfrAzTIeFal5AN6QmFDBYV40tnOyWuczkDoft/l53fA0TxeyA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786977068; c=relaxed/simple;
	bh=KBXn8Is6+J3VLnVAxK8md+FSLFrlCZXr1KLDGyPcXs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QA6xFnmVDhqhjkdfLmwsGZUt1frvNzcmc+aGGR2YVfKSmncK12YOjxJaVDqnZTqfZMnd8Hse2/8HTZQspIANEbn8/xO7EbwzfEyYOjSH0SWwaPiy0AtrIGP8RhOPQY98oy6sGm6mJDEmzcCtjbgbsoinEUzcVDFa7T8dfXQX970=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=IBA83DAf; arc=fail smtp.client-ip=52.101.66.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="IBA83DAf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AJr4iRhw7QDNITs5CSKEqUrxrPWLS5+23T41x5ehcjiD5hf6efsQmd94iS606C2qfU00xSh68yk2fvmMzOV+TvKLySGeubPkM81UhFe5q+FfDpwm8tNModamZ9vVc0sa2kUSsDv3/9GFX/x2merOFuECGNws5PkHFgUmoDO18wUFU+y+MxaF5V5+sN6NXig07cwAMY+Hm+ZWYgv4f6xBacNXA0wBeAmmJGQRIIyXFYrB9Dqzqfm/nwL1nBFNph+Fftg+n/LnAQbTIar0UFBiSUJU9DlH2N8lxVLnvfi0Tw56GPouf9+F0Kb2R/cSDZcdsXZXM5fyz6jsLSknAL9KOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jhO59uIgMuRifGVXGjRak3rX5fbpUfCub6SH29uQnRw=;
 b=DqRSbH+mywRY7hsAluDVgmosS8HwJtiAOxpe5P2+BAOQqmAh13hkWhYZWWJmtYbjIrR62n+rRsLScmwwDM/2/9URyvpdNG+9VnH7x/TLmNHHUeS0WujyVwbBt+edoqnJSHireIwurU84U1p0/DZzzbtPF3a/eDbA19nca+KRxKcIhsDao9uoxMJ5pj3zi9uJsAIbWDpNxGx5hZawGPNrlbYzeU/oYYLfDV7PiOFWtKuaGGWvxzFi/IOrnGMBeYkvzj7Ic5Go4WRmlVruhmz14XOpDgYQf5asRyANpyJxZkDAh1ia63hWkVbOKlgcu/0kzNCiNapVtY1IdDe1uF2bJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jhO59uIgMuRifGVXGjRak3rX5fbpUfCub6SH29uQnRw=;
 b=IBA83DAfdwA000tQZ3vQ11Qcv5A/BMyeX1hyRCfVzV5oCf7b3iAX6sN9wSHj9a51kXmmkYdR+FfMfrB476V5mnkxPuBBdQ92ewnwt2iVGMkQBiO/HkrF/DHKcunnQIFBrcPtf3qqPrrSvrybBmfa3lg9g8O3yOlwcuOzIBOL2hMKFyZo33t80vAE4XRIyb41THGGY3C1VUPSiZlwZvACpEr1iEuLPP+axKbw74JkAqxs7VSRO9lSZDTsUOCj77q4Vrl2ZsXPVA2QEoD9bfVy2KusvPRtYZArMJO8HM3DyEBE23i/OYhqWyx3JDTuuWfscoCAgwhnhXtHrMBFh0Zv0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AMDPR04MB11584.eurprd04.prod.outlook.com (2603:10a6:20b:71a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 14:31:03 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 14:31:03 +0000
Date: Mon, 17 Aug 2026 09:30:53 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Christian Lugnberg <christian.lugnberg@soundtrack.io>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, wens@kernel.org,
	jernej.skrabec@gmail.com, samuel@sholland.org,
	dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dmaengine: sun6i: fix non-atomic read of DMA
 position registers
Message-ID: <aoMbHdPOyO5lE61r@SMW015318>
References: <20260817135723.12807-1-christian.lugnberg@soundtrack.io>
 <20260817135723.12807-2-christian.lugnberg@soundtrack.io>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817135723.12807-2-christian.lugnberg@soundtrack.io>
X-ClientProxiedBy: PH7P220CA0151.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:33b::11) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AMDPR04MB11584:EE_
X-MS-Office365-Filtering-Correlation-Id: 11e56a37-68ae-4204-a1f7-08defc6c2aad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|19092799006|7416014|376014|1800799024|10067099003|56012099006|18002099003|22082099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	9zETJb8DOzsMn5ZlZMdb66AVpjsPw+MTtpR6WZB0577q6Zxt5hWEWvTq/iA+SwHZc4qZstHJh0Ue4kVGn6C6hFEwYMiGIFthmdC8whapA1li3olSuaumYArpt/5SXXZqlC9TaJ8rwaueVw1QhYeFaWSevIzaN76AFi+dD3AHekx82d1BVW2GwlaPdAjf3hUxxxVf3EJkExPWtbIP9zejx0A/W6KwUOwqkJSwNVk6Gitxc06SRhrZukSIK1cttLXdpgsXazt1ziaaKRm2t6pENPs8IyfG0t2ttXN6Sdnekv2hBX96RKp/d0uOTrZsZYFHYD54Aqnh96oiaqhjdPkEZUcyY6N96pRgkBHJxh/TQ0PugxdmOqG5yyMjJ2LUTRg339W5BEZKXQ1eFypj8+WFHfqPLypvUeyAlNBsU2FvuQ9EGAbzW924bWyJltK71KsNK26r7R5OwZA+1oh3xdlYKtJBlmapPSp7M7crqIkHGLbvd2jWNq9H3ssxQX5RE8dEjlkcLxstFaD8VMzQTxZmOolLEi+Nfvo6vKGmxOyXPX3yRU7p/HDaG18uwmHO9dBJATe1dkmCraUEsaM2KhizD9Tn5VB4oeY4pvjNub1+wIKIguDA3KmBTPvqx0R2mdpHiVp86wuiDDHbTokTPQB6+VFnhkWpMqE1H33a66jQU0U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(19092799006)(7416014)(376014)(1800799024)(10067099003)(56012099006)(18002099003)(22082099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/oaWyHFLALJZ3DJ8cszK+G5vg7vjd4gsExEXIQO6WJKvVoBuTF3XgtH0N9I0?=
 =?us-ascii?Q?ZSiJabFchqkx9BNbJhP+WXaicnSqOLLB1XZwrPHzQXxk3MKMJUwhZdXl6Vdd?=
 =?us-ascii?Q?lhslU+nFwRlJ59g+FRjU3c2XZgKE9SWpyVAh6rF0I0BL8L0vTAj0qLy4Q4pi?=
 =?us-ascii?Q?V5R2gmUiupmK535LebtbtbGgxY9o50NFeMSANOAL7ejpUwfxG/lUKI06+nt0?=
 =?us-ascii?Q?NThaRKlvUANWVavfhHaPwTzRm05OYumg81dTj31Qt1gNXlUYFF7aE5DsG5F4?=
 =?us-ascii?Q?R7RuWm8rZ6uj2fswRyKsqeWLJL/N0dex9DB17FaMGRLEPM39o4IOJ+qtcnb1?=
 =?us-ascii?Q?tQjqy+PwKUapW+2JQd7yeuxyXF/hG4z2cDfbehMSz0R2m4L8MrQ4VXp3yma1?=
 =?us-ascii?Q?0JdjkEfsJVNL8YC5VyT8cJeS7/hzmX954lkTpk9x7+Ay71LBwwQ9MJcUxyjI?=
 =?us-ascii?Q?ruVlXMR4DQM1pZpU+a89qlrvfHcwTGCtjqZeDWpGQGw0i8cjYqZ3oME7iiV+?=
 =?us-ascii?Q?6ssZJnqra29iYaaawf1GO0xSuiQFGYxOlvvTxfVeCumwOF00Mty5tSyKJ03S?=
 =?us-ascii?Q?lgVymgmEAzauUPeWjy5B5GZihPS0c12kbKgkry890ZB9A72gzPBw2QE31nZA?=
 =?us-ascii?Q?K7JsqUglTy/6ITtpMhcB65BsR4MsssI5CoDy2EBeZNSbxLRXZMXsIK0HAqzN?=
 =?us-ascii?Q?FiGf4JlME/+hSIQpJW1kvVu8CKPKJRAIc6QJf8szDYkgta6q8bLcNmd96qPz?=
 =?us-ascii?Q?SeqwapVsuiIjGDkpzbvTC+U4BmKW3x4u+8VhcdZGfGJjI/0HF/MqOzBDeXxH?=
 =?us-ascii?Q?k0hv+UomfKJ5PoNhJMwZ5Q5nouLdIrmWKRDKnEfQuMSCnFLfN1wSJFxNKYy4?=
 =?us-ascii?Q?dpbAGoftvZwTfDb/IarmjZwL6pH+JoWy/OlFjo02M/tfZ/XNDNbtz8bsO5Jd?=
 =?us-ascii?Q?fPOjzidnx2Midt+npbQBrAI1g2g+JlEtFt5mU1egRGxDATjG0iHVlsRvN2cQ?=
 =?us-ascii?Q?KPKYp7HtpE1bfJAim5gyZfqsVKgPN65sfj83mr+CX6bgO4lhBtz+oZkYYI9z?=
 =?us-ascii?Q?7/g6JgU2PHIaKM8cKzgi+c2miTM+d5zj380QjKdOoBaXfdMQ/5tUZZW3amAR?=
 =?us-ascii?Q?flPRRPgrgcH/EP1lLvtF5QprMW15ZoZGoaJcRUUUb3upMU/rsnTirqeproWm?=
 =?us-ascii?Q?sO8L0R/021c0QRiOtm76zEOe7QzIDAWuQV1DbRhu2CygQqjQIMH5FxP3uq/t?=
 =?us-ascii?Q?H4QqFNbdK00YUaBsuKGHWCZn0JyREUjBV4wjLRvtzxzGwfrdGYnqTojLEooM?=
 =?us-ascii?Q?OOFcR1BTa3TPaZpcS9JTPebBR1U8Qoxlh/esb4QQ6HI9/HReXh8RRMmx/Yj1?=
 =?us-ascii?Q?KrOjVwprg1y+q2nprbPTozlapkKycNNkWyUqhwDCjMXUzVMnr+WahRnOT6ph?=
 =?us-ascii?Q?LacoGjfISk7xdSJH8sLxyFP9R1mDGU3N/aLx4fOt2I7NYTuF5ru+dL6UGCCF?=
 =?us-ascii?Q?yfQzBsBhCxNuo0pcn4SDRKNj1JObZS3ZKBI8PiJAP7rQe8wZkG780gpzcnWd?=
 =?us-ascii?Q?ez0bHmiejGTRSdJbc4TOhHnWxTyDvtkTuBvOLdiAJnJv3kvhTXTePl69p6iI?=
 =?us-ascii?Q?iUcIrRw3U0ebaUJfLThgNKJFQD1P+RFZYDedLYRMcf5DYit9Dc/0JL2aR+XF?=
 =?us-ascii?Q?KuP+MVSE0Ta5DseyQC0XdTYiR0xhDTjPaxZxuZQSdMe+fUL8FN4DuhC8JzkZ?=
 =?us-ascii?Q?Ky35cHLPpvT4b1vhaODdRAgCzssqa5rgEQA26nTc73qrJCLMBEVq?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11e56a37-68ae-4204-a1f7-08defc6c2aad
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 14:31:03.8719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VC+++A73wGJZzovDp/RsPloABHWfAZ8EqI/7p+RTYy5J6KVoX6fFBxDv9DExrsN8Dli8bqtZltOLCh1JsfmHC7a1vjxmZBi0u/bBJU9JAAHV//GV1gTztQH6iEyMBPX3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR04MB11584

On Mon, Aug 17, 2026 at 03:51:22PM +0200, Christian Lugnberg wrote:
> sun6i_get_chan_size() reads DMA_CHAN_LLI_ADDR and DMA_CHAN_CUR_CNT in two
> separate readl() calls with no synchronisation between them:
>
>     pos   = readl(pchan->base + DMA_CHAN_LLI_ADDR);
>     bytes = readl(pchan->base + DMA_CHAN_CUR_CNT);
>
> DMA_CHAN_LLI_ADDR holds the physical address of the *next* descriptor the
> engine will load once the current one completes. DMA_CHAN_CUR_CNT holds the
> remaining byte count for the *current* descriptor. If the DMA engine
> advances to the next LLI entry between the two reads, pos becomes stale: it
> still points to what was the next descriptor at the time of the first read,
> but that descriptor is now the current one and CUR_CNT reflects its initial
> (full) byte count. The subsequent virtual-chain walk starts one entry too
> early and accumulates an extra full period's worth of bytes into the
> residue estimate.
>
> Fix this by re-reading DMA_CHAN_LLI_ADDR after DMA_CHAN_CUR_CNT and
> retrying if the value changed. This double-read pattern guarantees that
> both registers were sampled during the same descriptor interval. The cost
> is at most one extra readl() pair per call in the racy case, which occurs
> only at descriptor boundaries (~every 2 ms) and is negligible.
>
> Fixes: a90e173f3faf ("dmaengine: sun6i: Add cyclic capability")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-sonnet-4-6
> Signed-off-by: Christian Lugnberg <christian.lugnberg@soundtrack.io>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/sun6i-dma.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> index f47a326dd7ff..04fe1f5042e9 100644
> --- a/drivers/dma/sun6i-dma.c
> +++ b/drivers/dma/sun6i-dma.c
> @@ -354,8 +354,10 @@ static size_t sun6i_get_chan_size(struct sun6i_pchan *pchan)
>  	size_t bytes;
>  	dma_addr_t pos;
>
> -	pos = readl(pchan->base + DMA_CHAN_LLI_ADDR);
> -	bytes = readl(pchan->base + DMA_CHAN_CUR_CNT);
> +	do {
> +		pos = readl(pchan->base + DMA_CHAN_LLI_ADDR);
> +		bytes = readl(pchan->base + DMA_CHAN_CUR_CNT);
> +	} while (pos != readl(pchan->base + DMA_CHAN_LLI_ADDR));
>
>  	if (pos == LLI_LAST_ITEM)
>  		return bytes;
> --
> 2.54.0 (Apple Git-156)
>
