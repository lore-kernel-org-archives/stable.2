Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.70
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794944566;
	b=Xp+B/kTOAzTsZ2xYHjL4fuOqjsB7H/FOm+8yao8hqQdRr0J3WLK4qhcJMn1KmrUPa028
	 PHgTpr0jv579+tay5aOdkA5M+/vUPrUSdLoZhv6tsT+eK/qjd4Mb0euzkKsoumnGOhtQo
	 8N73DvquIrHGEu25QkBmD+E8El5EQP/Cq1bOw2/AE8LAJ6HxtN8gMDufmCPhcf3vxRMKF
	 kLr8c08M2gM8/s5maD9CnQ1nebZZgWwUIAqJeUMArS3UVr/5cRz2OQ6tXOY1V4CwMs+Nx
	 Bs8ibYmjt8aBIziXlmz6XFMPOvoO5cZbUwyzM74d63nSHFnoHSQZBPzCGAwE4pGZu/w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794944566;
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
	bh=LSJRsP0I1gQlPfqYsbJTfjUjUfWOQLZxzCW7eihh2z0=;
	b=j+3jRoMle4bhTnEgKiiQlpSe6QczQZ0CgOaVu3VdWPNvL9t+G0bE1tUOFOJGMEYA65Bj
	 Kcy3zxsbPlfjP24e5A99D56fbFTe5gxhyVbs5hzjy4xdEK/kQTGr9UV/kspVxX0v4Pr9I
	 ur9ftvAivLr8a0ZjZgSKX1UWmgwZVxUNaz3J8/1XfOj7xmbH/g4PeVPqSXHLV3dqMIAFj
	 fw9ESQK/V+SYoQ11M2uvSaGpwPO0jqoeHSACE5N8k150hO+4S4xtapbB53vLLDVzBhI5h
	 1Q1dimiFztEr6+3JJg/NoW3fNh9bu4D5FV4HajPafTI8XeOG3He6cMPk6m8DLiw1fmg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=kfOsmgMK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.70
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013070.outbound.protection.outlook.com [52.101.83.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF74606A31C;
	Tue, 17 Nov 2026 19:42:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DF74606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=kfOsmgMK
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=arJh/b+2ndZtnk5xo+CI9yUWRTGNa1NEXql8lcIulayBGW1rbmmkIuX7IjS1ofX1TJQJSyqPdpf1Vou36TMFm+ty1x6L6pG3Tf3m+WRkktR/w9gGzjHtRAcWPeYbfxFFikes4j4pbsL8W/zoC4zqHDSFDprLXYl2FfM0ilMn2rrowJseVkua9HnMMH1urlJekwBeI7n1tH6zg5gzPRSqL+GlQo9+yEOLGNEof3oUlEf4gYTiZpndMvsl42PxFJbVv+JlMTpvpUFQt/D2YMG8EwJ3X4n+mapV3aMEcqgG1CzL7V8/G1cKA+87Rdb/zqhNyvU9HDtDZEOXij48bkHi5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LSJRsP0I1gQlPfqYsbJTfjUjUfWOQLZxzCW7eihh2z0=;
 b=OasyCZ4yZw//2rEm+2DB48lAEpKRcf4cWgePMN/7/1m9NbzcE8dE2nJh3Qspl+d1to+JQP3fQgriv3HMQVHeJ4QiKODA/npZYNeHUY0edhbJKmk6TwNnqrurmubLrlGKONPwiygMCwKcWzaE0Q8bSpb6VR/EYLqUh7TvpRXeNcWh/dDDj75PqYvD4JebHLXnKeET1L0qtLb3z0qZjTrZRwHKwa18qG5vIhDT555oYPDcaNwiI5871u8+oTvRD2tHIXV/A9N2JsRaR5iY0gXA4i3OrbczMobhCHM2K96VB21cQOI+JNTZi4JgTN0lK/T1RKq9TnZNaB6HMHPsXFFD1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LSJRsP0I1gQlPfqYsbJTfjUjUfWOQLZxzCW7eihh2z0=;
 b=kfOsmgMKguig+p2BCPFoZf3lHHzg0dy6QDLLy4d/XEB0hv/W+/jCkqsiL5UcrmNO4vlP6bo9GtdCHuHeoGYtgYYtZNGIjcWXSJYxkwYmAxLZcYYrHB8fGJFopYUjJWQhSut/6iRT827IYurFLSO2FOUcH+/f3SdweoyupN8ut+AufvxaqWa987KakJzpX9aZmgnFUEWN0vcTKKTDW352EeMWnWVrfEgt0MVUwceV4+XW5U4ctzRReXZzjreia8MbztwjriCXr8+P7tkpLrPDr9VZHG7CvZR59wAv5enq7N1K7KI6UqtB2KfSL+80FNR7bvVAl76AW3ScuYSkzNJylw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by GV2PR04MB12191.eurprd04.prod.outlook.com (2603:10a6:150:33a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 19:42:43 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 19:42:43 +0000
Date: Tue, 17 Nov 2026 14:42:35 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Lee Jones <lee@kernel.org>
Cc: Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Sanjay R Mehta <sanju.mehta@amd.com>,
	Gary R Hook <gary.hook@amd.com>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 05/11] dmaengine: ptdma: Remove completed descriptor
 under vc.lock in pt_cmd_callback_work()
Message-ID: <avyuK7oYzR3Qfawd@lizhi-Precision-Tower-5810>
References: <20261117163809.622249-1-lee@kernel.org>
 <20261117163809.622249-6-lee@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261117163809.622249-6-lee@kernel.org>
X-ClientProxiedBy: PH8P221CA0050.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:346::11) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|GV2PR04MB12191:EE_
X-MS-Office365-Filtering-Correlation-Id: a10c138e-87d4-44b3-5417-08df44e2f26f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|19092799006|376014|1800799024|6133799003|22082099003|18002099003|261009223027099003|56012099006|11063799006|5023799004|10067099003|4143699003|261102123227099003|261021123027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	/Y574/i8n0xpSLMzJGggqH0/lmHXLZXxq+4A2IDuTcjmPcYdd+RD+DAOHuUgEFW3Xmuff0/BvIXnEnonXrTs2iXaBu6vPp2/xpOxbq0sBwRU4n3s5wQ7eFD9BcrFayfhzmT9XQZAyKbius5RFq5XtADA6CE3Slb4ch8ikw4sJfdt8vwglrXfSpw2DtgxrMlzjgqpssxG2hE77SwjWDoO9uUa3z9tLu4HETeh2ptWdCBFhvuaCWIQOB4l7c9SQuh/DyOoegv3RJ1rHA+JQLJYNQF+8hYogV4E6z0bstIjqtkN8n0rxtE/iO5URQf1RlfayC7mbXMOKqMR+Wk5q7/yVvX5WQsIIbjXKlzXsVAcVoPgzYm1GWVJ+cz+R742td7o5zpDIm/DYbrwulInJyRL6C5uy+P2WDqiWY2pRTmmzAnY/SQx1YXcGmHhLPTh4fYEQmxEn+WoK0X3WZC5g5D99p+wjbpwv7vGDRgD0t12urhlKtLFVE0n6lbeZ2tfa08pKafgL30FWqSXQANbp7xEP8QzDpcBtYyMbVJjdsNmBMzDfYmxL+h5IMPYg52bwm2HnLFUjsaKFTL5z5O3C0CjMJFU+NY/PHXU0P2hdQSiutk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(19092799006)(376014)(1800799024)(6133799003)(22082099003)(18002099003)(261009223027099003)(56012099006)(11063799006)(5023799004)(10067099003)(4143699003)(261102123227099003)(261021123027099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jvaruOiYyRIRtgbmN1JpsNetN6UT0Lg96/jVRKjQiljWs+Y16C7YNpLkH9yV?=
 =?us-ascii?Q?gmW5YZiwKCbVr1puYrwSPh1/rX0kmUI05F35IclxVUmvk1uGNPuRkOC7dS21?=
 =?us-ascii?Q?u2bwO2jiskAMLkWsitVUp0EALyPYRgexmxJnU+o46PC9GNPXFGU0euWc8nBy?=
 =?us-ascii?Q?h12wQvYS+gYerptnADKxhQM+5F7eSgruf1Zcpbk+FsXo076Mx85IL9lnt/gY?=
 =?us-ascii?Q?hHO27E+ler/OsAMpaQvzX5P0gvk0mSEAPidZZNi5+d1C7y4t9eB15vzg9Nyg?=
 =?us-ascii?Q?8Lt0jyQ6mUVFRXQtvmdbr6NjJufDlTZJ5DnW3qTh2TVw7TgyO4HCSeNaTN9v?=
 =?us-ascii?Q?n/4gGt0dA4SN/LYCb5UDpKC9ouGJjE9SiTcBw8gnNUDS9iUam1hgnyzLdgfC?=
 =?us-ascii?Q?/cKXBkevnmuQSbQqZ6eZC4EMjGYhHWNAG/sHjWkV+J2EdDtw3sKwwi6d+bPz?=
 =?us-ascii?Q?lb9itvLm5ByuqqwJcciYlzpxrdu263rAeQ70fJXJId9N0KGJzI2bq/+dt7ld?=
 =?us-ascii?Q?M5Yg1DLIejuTFMS1oHdbQU7BZqzls0PVXcEFqVQ27Jt8C2ZBcetJvsLNfJNn?=
 =?us-ascii?Q?Y8455usbC1JFwO+ZxVszcRWgvf335MLYfuaOm+A0GN1k2j2YcQZcb1RAlcBp?=
 =?us-ascii?Q?TeFyIM8hBAM3+em8l4CZjBfojoMabj9byY7Ko9pM1Sl8Vz6sNVJWE2KJhILB?=
 =?us-ascii?Q?HeXmuU8DLUKyD4VqRCDr8KT1vqfA5nwP4+Bic5sSvQUL7pQmEr0l20QHTQPq?=
 =?us-ascii?Q?B2owFG+mLrOamu1zKtk49V+0BI5ra6kWm91BpP93GGfsMCrQTFODUFSXf6hr?=
 =?us-ascii?Q?VkLlIdWaP5TnuW+23ZpwkliKAt/NmEq9T3+6s7Gc2CnjF8oUkmI9PeWVKeGy?=
 =?us-ascii?Q?0mn2gMj8jmc2JkLB5C/4Px3+uyVeBD2Zg9s1ssTuirWrHqkxOly+yHNpqF7y?=
 =?us-ascii?Q?t4GspMS2hMV6NSN6+iOqZ0dzugqrrhWonSXJUU1XrMLT3RgAZYPzaMSywTR1?=
 =?us-ascii?Q?Wqi6EHvYRG52N6qyUDAsjynTK6XK23KMa7vnNILd9ZOHhU5UhEI/8prI17Eh?=
 =?us-ascii?Q?9iJCOilZTqvx+zlozEkraAx8osZ6Jl0KaMAvU/9g9CPY2h6wkcnKwGbkbyJD?=
 =?us-ascii?Q?0UP+HJCO2qPzehlLyPV+Qnr/LeyNahL2lhKlxWCGOAuq5gWQ/GYIqqDa2wEA?=
 =?us-ascii?Q?nOidnkWehRmqdO2UaB+LrRoJK8i7+EFVn6NF6Ubf7wCEzWZuu8oMgy79inad?=
 =?us-ascii?Q?32ubt8lRfqJW+HqXRzFAPTS8HOzYvk0VRKeZ4ZNBN4AMPXjCH18UC015KBKf?=
 =?us-ascii?Q?uL6Yrbb9ZyyTqys2Sbqm9iyzvPrAkbQavEXD5Jm0OdbjesdtAMHQTytKqr7r?=
 =?us-ascii?Q?lbWrORwyzobWas2+3e4aR3/+lwxF7ZNl084+/3zO6dptJbvQEBloNNqhIpin?=
 =?us-ascii?Q?5iW2dhIB8Bn5yymtnJh5nGhmN6uA3Wi1hOHbOZr7UH1fQ5VnyCi+L6/XnqVL?=
 =?us-ascii?Q?uk5wnAnUhveW/mNp21QmUuLTNhPvN9Dk8DZxd9lvcxy2XWQDjn3wWwj6XUFu?=
 =?us-ascii?Q?UmFvvjNARwm1GFN2I19Zb1z/Hu8bKmvVKUGx9srDyLNC0odjO0Gd9y9CVxhK?=
 =?us-ascii?Q?RsRoRj4O4pKvjJOBag0zV2G1Bab6pFOjYgP6+L31O4OzpueTiiAGAdR2PVAO?=
 =?us-ascii?Q?lTJy5lzw2DlgxeS5MnE484JNNgzoENEG+WIQccNUQiTt+WnrZK6XzN2/wIxd?=
 =?us-ascii?Q?WSoBjWg7Ap3AO0WRB90rRI26pi9MDnK5ZsLv1k9NW0PiMKhdufw0?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a10c138e-87d4-44b3-5417-08df44e2f26f
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 19:42:43.1128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: orN2ZEXDKhwgeqU/gQcUdDt8kajliAIgk/BBWbD8Lrk0fzk0fY/gIs4tWzojxJiHC5DMuZnRVQ5m53K86MtwzEHx3SRRPJWBgf97QEzOg3zvGArZ/TZimtBcVjTfMWXW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB12191

On Tue, Nov 17, 2026 at 04:37:06PM +0000, Lee Jones wrote:
> pt_cmd_callback_work() drops chan->vc.lock before calling
> list_del(&desc->vd.node), racing with concurrent virt-dma list
> operations such as pt_terminate_all().
>
> Move list_del(&desc->vd.node) inside the chan->vc.lock critical section,
> matching pt_handle_active_desc().
>
> Fixes: 656543989457 ("dmaengine: ptdma: Utilize the AE4DMA engine's multi-queue functionality")
> Closes: https://sashiko.dev/#/bug/linux-55f1563b-5563-492a-a291-1a5b772ffd42
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> v1 => v2: No changes
>
>  drivers/dma/amd/ptdma/ptdma-dmaengine.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/dma/amd/ptdma/ptdma-dmaengine.c b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
> index a0a1c7ec2ae5..a75a9a316e83 100644
> --- a/drivers/dma/amd/ptdma/ptdma-dmaengine.c
> +++ b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
> @@ -365,6 +365,7 @@ static void pt_cmd_callback_work(void *data, int err)
>
>  		dma_cookie_complete(tx_desc);
>  		dma_descriptor_unmap(tx_desc);
> +		list_del(&desc->vd.node);
>  	} else {
>  		tx_desc = NULL;
>  	}
> @@ -373,7 +374,6 @@ static void pt_cmd_callback_work(void *data, int err)
>  	if (tx_desc) {
>  		dmaengine_desc_get_callback_invoke(tx_desc, NULL);
>  		dma_run_dependencies(tx_desc);
> -		list_del(&desc->vd.node);
>  		vchan_vdesc_fini(vd);
>  	}
>  }
> --
> 2.56.0.679.gc527c65306-goog
>
