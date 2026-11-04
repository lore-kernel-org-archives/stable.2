Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793814449;
	b=dVLOLNJ4BJ/vP5kxP1R9ceqVvbL8fFYRgIUmJB5Dxd5moP0np+SVifi2Xxra1i53e+0t
	 QB2ziax/2T/9v5crqenXusSol+2H4PJECMxJ91ujGj2yofH0DPb2V86lcv4nvc/cR6SWS
	 ATlqcxUinA9XnJYF/noZ0ouz+qKu1E1RwFj3BZjZD6UNppvFMJaY1Fc2cKyrf+mAlE6Sf
	 70lVwUncra5EZANGmjz4X+/zHHW6aWrIcR7TXY0QcNF6DU1yqhN1pjEsAt5E5OeBB9AX9
	 QDxZCnjLFoYPcrFiZzM87U9x6h7cSYOOWtKTdqhW5fHw8xgvsziJnkjj/C68sav1KiQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793814449;
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
	bh=Pf4keWeuKzeRCU9gmi6BgfwYPUKTYm5EeZzjlNOSvdY=;
	b=xwLUqRI3OgTf54ajCbNnF+VZwPE1Ry10hQUQHiJszUF4mxkjquXXITSOEV1WXkflHjNZ
	 KNTbzR8q9b8XpljgYfHuBcMbHU1bdhquTxb9JDTfEcLGe0WQB881nH/JOsMyCzC5zC4yY
	 XawB5pFXUxM+Hapke7q8O3Yv5kav1LaobuYdqnEA55ziMX4zEy7Hzlcoipgo5g98wmWpr
	 jpxcAcCp1Ic9PwhbGO/07ZqifW/8JTqtPJiQPU//0+d+IStyVEXGXFKkOiOnC59D5BDgR
	 HfV9kKSVBTMIgRBSZt93FlWyvdRRM98x+hAq/8/TuHwSYhE5IS453Dw/eLXo7Es/7iA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=AEIMEZwG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.51
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013051.outbound.protection.outlook.com [52.101.83.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B095B606A31B;
	Wed,  4 Nov 2026 17:47:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B095B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=AEIMEZwG
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Homo8Xj2vtqVzHZWlaMid3yS/7Fl6ZzCGuZX4h0Q6AY77QS/D00OIlPwfWIybLybROxhkqHbXpESfsxAuLSTRgcIXJVfLP5D69D0wx5g0m0tjiNUidbZ1tMuVTXjt7eJL8QbL8HpE0DzLA5mqqVJ797+/QGoWBGrLb/O/mqgYXHH0fcWJ5IfN4UWlhx0lIJeOoSnwCxgfy0KG/yXCaXGFR9p6mfo+iwIX6FXNAExFa8u4gKQADku62RHwp/kM9MTmIX/ndPlc1/1dnxxTez1oX9RZfV0yblszQ7GhRktoZMEbDFLHI+wFvQtWPM0EaShtWyGQpI/LpfFZrFc17Yf5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pf4keWeuKzeRCU9gmi6BgfwYPUKTYm5EeZzjlNOSvdY=;
 b=H65PNW79fOkLIxHvZOFbP2Lqm/lEWTCHK3PdaoAHVa/DkVWd5NVkioI6fhiY/S4J+BaltS2Bo8s5rjBBcIAuBqaUCQmgva7yqQCq2w/9NVfamxPtYhpOm4lBxBNMFz9AQWmE4lZSUUOb0gsX+2RloQDt6MO7hUcvKl1C4yVxkVTiveossqCh1pkBfthnpMzhZ7eY7rT+izFL11qbt32sERHbWekNUgqhb+DdhdCLU1rBgvbi5pC7UviseQ37W141vRHIoG7b1uqPRfbjrzBiwCW8WXZwRRlt4NcStlZOy28jSRO5h8mhmydB0+5ribs0r/vY0/7uA1MpMfma0/2J+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pf4keWeuKzeRCU9gmi6BgfwYPUKTYm5EeZzjlNOSvdY=;
 b=AEIMEZwGXHcNMq8R5vIpAre1d8pFSMMpizZEOuM6VsAZP1F0lr2bPTfJTCONUeAHCk70XPi7ywHJD+5Xbb9JthhL7H6ZekyuVDa76tdlscZV9BcDTx7E9lj+vxEPKThhTXuvasPjLmtJQDoQzu3YMFPQwiyGUIfcOiEqxxLsWGXK5QOd7BuN6CJ75NUivJb/6+Ec1V6dAhYKKaGfrN/MdvxM83T1VBLk66ZS9CfNqWALt759vGjxKGNnD4iUMQ/yrfXl17opvhEjNEA12vP54ajKaJQg4RidzhUyKrH/h8UiRXT7+GmlTqqXu4bgddI24jzG+kHHXdqsKwuHIKYZ0g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by GVXPR04MB12289.eurprd04.prod.outlook.com (2603:10a6:150:30f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 17:47:25 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 17:47:25 +0000
Date: Wed, 4 Nov 2026 11:47:16 -0600
From: Frank Li <Frank.li@oss.nxp.com>
To: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Tony Lindgren <tony@atomide.com>, Daniel Mack <zonque@gmail.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	Julien Panis <jpanis@baylibre.com>, "Mendez, Judith" <jm@ti.com>,
	"Francis, Sebin" <sebin.francis@ti.com>, stable@vger.kernel.org
Subject: Re: [PATCH 2/4] dmaengine: ti: cppi41: Fix register access in
 suspend_late
Message-ID: <autvpCjyMBtH0KJo@SMW015318>
References: <20261103-v7-3-topic-am335lpm-cppi41-v1-0-d7213446c5f5@baylibre.com>
 <20261103-v7-3-topic-am335lpm-cppi41-v1-2-d7213446c5f5@baylibre.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103-v7-3-topic-am335lpm-cppi41-v1-2-d7213446c5f5@baylibre.com>
X-ClientProxiedBy: PH8P221CA0039.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:346::14) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|GVXPR04MB12289:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f8f5e3e-e1f0-48e0-2649-08df3a9bafa5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|23010399003|376014|7416014|1800799024|10067099003|22082099003|18002099003|56012099006|261102123227099003|261022075727099003|11063799006|261026140227099003|261026121527099003|261021123027099003|261028144727099003|261021121427099003|4143699003|261009223027099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	7C9SXhyEGsIHxFluHkxOwgUz/1Xqg+dpMRUdFvq0nfeEQxlj4zqy4uBi9ds5M3OtDkMVPmBmK6cI9sqfyLx3/nfihPEv1dY9ueXvYwU1SviBR0YYDyArOBJLLAxL+bkSGBTH1iEK/GrQmk3HrR1ARLA3bUUGNDxMiKU08KC3GNs4BPI6hvOUxX6iFIkK+B5PhCaOo6OLPp4U3b2L3tNOhy7G7Q6DOnaq6US0diHpQ+HiSED/NqCz9ZP2C4JXXjcq1UUr08j7BFdHO0oZWwlNElRPkvM7y6mqYeWfeP49Ee5BCqDKqgEkHuJ+khCaVEL6LUdxpRqa+vfwIsXM+n+zQyuezr71ZnmDGt0VMAAheIN8oBcCAQ1hob7O7mtrJVoArEAX59urWJ1jo+jav0/hZ1vlaZ91hjGA57d1LiZ4XmHN+ASu+DMcPnNiYpelMHskwqB7iyDxZ/aQ/3PHrqCKv6aDIS6b5Ptst7muNruqwhzEzOLYfWYF4WDuiHCdldKC9O3XzTVErdcC71kB9C6N81u2EMF/6bgO703jhYLUNJTXSMpWOEucdPXrBA6lx1IWCaJToAku8QxuaJVaFMJpXIWkPebwQ3CV8FZqdiVLuqaFF+9lz9PrwSgSzxs4B9oW7rXKMWuBR0mYsQtKKoC2w1RZgnxvMoSQp+Sfmyebtk0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(23010399003)(376014)(7416014)(1800799024)(10067099003)(22082099003)(18002099003)(56012099006)(261102123227099003)(261022075727099003)(11063799006)(261026140227099003)(261026121527099003)(261021123027099003)(261028144727099003)(261021121427099003)(4143699003)(261009223027099003)(261022105027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/9Nql2iC4xxf2VM58+oUcD/CB+oZv2bO/1JNhLqBxekeq2eaKyefAUmqU2UH?=
 =?us-ascii?Q?ahSlY51zPZeVDENm4acHv+u9Tafh19Onu/toQJnu4QYS/1WWV6dAfb48mL4P?=
 =?us-ascii?Q?KtkgNz1KqWhSNf7O//ixaNfaALjzQJF7QEDjE3upgZrZtAfKoDHYYtaA5elC?=
 =?us-ascii?Q?f12F1iki//K5/YcomD+WhyNJ5TCfRDin2PQvpYBr3TkBygkHjuq/FxJC9rCU?=
 =?us-ascii?Q?xSGfiRG864rJxPIfXyfkrmXqFtfctPcvqm1Zy8sjcFj7fAvY4yTNQ26jd+/o?=
 =?us-ascii?Q?BI6J+rwfU2KRo9TD++O+l9V+kU9OgpJ3xfLo3F9sRK7dDMhpZr2btl7J4h8E?=
 =?us-ascii?Q?+gVR7NT7aHMo0yq0MvNHcarb2u9SpQk/hoZqHg2p+8qKxaErKqSB/Av2Sc5B?=
 =?us-ascii?Q?phIkHy2oqrS5Ln6IcOOaWODlJINetmYCs78e8sRA7HPAvmvdqL53ojhKJ2oU?=
 =?us-ascii?Q?ipQKxZWwHwhrhXN2HNj0h35c5emnzyMERqIoq9cj0Nuai+BBtnZc8B5AVNbr?=
 =?us-ascii?Q?OZ+i7+2j7330x5ZhCt33h/IEYEruphsP1DWXzCjYQYc7ZgHBXG2DXvypn5mB?=
 =?us-ascii?Q?LNZuxfJ1DdPyLq+pUNSdz+MgJpIpAgzNtgIVhwnzv3ShIv5I65fgcW17TJL1?=
 =?us-ascii?Q?2u3Q1if1dwWNUJYYFBSEnwDZNfUyv5FG8+im/yNu9aQfSwyYiGd82u5p/hcv?=
 =?us-ascii?Q?na+ZK05NVKzxC5mpOk6wbAe1oQ3ty0VVIFHtbIvqenvlk8ekS/IIF7ya5Uyf?=
 =?us-ascii?Q?JIpiAx9DaXMy04eUMsiT7TuLW9NJSl/3d6Yo39DXmIvDJlwzRwX857FuWZI4?=
 =?us-ascii?Q?czKAY8bqFGcIeQv4Mej9vFTolUqNNta5vJ6ym8YndX4mVNVN7ptWhxtgIB7D?=
 =?us-ascii?Q?pfYbpAicefpLbVKqzRjdaL+BrPkrgoNGc6HzGoNJ4twAGBdnzTUY58Qbfz+v?=
 =?us-ascii?Q?FG/Wp1+Ujtm5372J8gYc1CSd+CORk0Da9k5O3BWd/S9hztR/OPOjLy6WkSqM?=
 =?us-ascii?Q?T/ItyC1n4lpfoBgmcnI3fXLgGjrj6ZVvtALG/5msL5DW7bsHEEOPMM1UZSAR?=
 =?us-ascii?Q?BiuRIh4+qgmbLF6rg4d5c6TXSPWPu5aPRfacueeMO7eZXKau4bKIe8Zxt7j1?=
 =?us-ascii?Q?12E71s8Zr3+cI+w1hKcEHdzWc2cmVOjURYKZTJEOlScyOo9LSc7dJHB8P439?=
 =?us-ascii?Q?+aZTUeVDlMUc6MW7QCh6RTSfBCzKgeV5vrSudreIBfVdo4h+72v6SSXRDvnf?=
 =?us-ascii?Q?ldPzyNxu/zy7kmZ3WXMetK3jUasWf8PNx9nq557Lgiv71k0rhmEt98TNV/l4?=
 =?us-ascii?Q?3OIwcZE4CAM3ghinPqI+vMLt0OWFQDZz2CkKpddsazf0UFLrHAW7r2Yqd73F?=
 =?us-ascii?Q?w65xfk5/qEC5/rrLO5g5f1MJJ6FBTWGdvJmRdSAvT57gco9CEximp61o5Icb?=
 =?us-ascii?Q?CqTJ9X0lxa519pqn/BbGRyzj/q+QQNKexDJyaKG8ttUgLr1tnh12+HI3YbaR?=
 =?us-ascii?Q?N5z20dt9iF9nYKdJl5/MGlN4J1ocLgElKIyBu7Vc/VUZTBy3h8L6XIGX4Aqv?=
 =?us-ascii?Q?F5bNhmblKx2A8B5Kp8K/dSqy436v0dyADiBBidyKVsKLKcIt8qey1U1u6n9z?=
 =?us-ascii?Q?dnE/AdwrSGxw+FdK+vQRISzWIJjky+ByQAlTPHlBEZtOk8yAhqYgx7XsEGJ/?=
 =?us-ascii?Q?+Z77LMgCclzDh6n1rbmQZlSw8KyegJqbBfkq90Z7X2A8luzLjD6xg3xGCauo?=
 =?us-ascii?Q?pN3hfuFo4/9qdyuvYVfAWB54KO3zMFvQBdnbpGKcnIcOxiTW8Fzo?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f8f5e3e-e1f0-48e0-2649-08df3a9bafa5
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 17:47:25.3234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HmjWb89YjZl4UYi2JQY+c2pyIURtKrcJ1+95HuZu1FqAEyMa+6py5SiFaZdm3LFIVkD+md9o7BWZzL5kIcKVcVU074ZjDVCev5vxH4doBbjR0Q5woVKbOgXICSlpzACD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB12289

On Tue, Nov 03, 2026 at 08:37:29PM +0100, Markus Schneider-Pargmann (TI) wrote:
> [You don't often get email from msp@baylibre.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> cppi41_suspend() and cppi41_resume() access registers. However the
> device may be runtime suspended in which case it is not allowed to
> access the registers.
>
> On suspend do not run disable_sched() when it is runtime suspended. This
> avoids accessing the registers and crashing the kernel during suspend.
>
> Resume when runtime suspended is delayed until cppi41_runtime_resume()
> is called using the variable ctx_lost. This keeps any access while the
> device is runtime suspended.
>
> Fixes: fdea2d09b997 ("dmaengine: cppi41: Add basic PM runtime support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/ti/cppi41.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dma/ti/cppi41.c b/drivers/dma/ti/cppi41.c
> index 458d20b12462..f5a824418fe7 100644
> --- a/drivers/dma/ti/cppi41.c
> +++ b/drivers/dma/ti/cppi41.c
> @@ -146,6 +146,9 @@ struct cppi41_dd {
>         struct list_head pending;       /* Pending queued transfers */
>         spinlock_t lock;                /* Lock for pending list */
>
> +       /* Register context may have been lost during system suspend */
> +       bool ctx_lost;
> +
>         bool is_suspended;
>  };
>
> @@ -1171,7 +1174,10 @@ static int __maybe_unused cppi41_suspend(struct device *dev)
>  {
>         struct cppi41_dd *cdd = dev_get_drvdata(dev);
>
> -       disable_sched(cdd);
> +       if (!pm_runtime_status_suspended(dev))
> +               disable_sched(cdd);
> +
> +       cdd->ctx_lost = true;
>
>         return 0;
>  }
> @@ -1182,6 +1188,9 @@ static int __maybe_unused cppi41_resume(struct device *dev)
>         struct cppi41_channel *c;
>         int i;
>
> +       if (pm_runtime_status_suspended(dev))
> +               return 0;
> +
>         for (i = 0; i < DESCS_AREAS; i++)
>                 cppi_writel(cdd->descs_phys, cdd->qmgr_mem + QMGR_MEMBASE(i));
>
> @@ -1196,6 +1205,8 @@ static int __maybe_unused cppi41_resume(struct device *dev)
>         cppi_writel(QMGR_SCRATCH_SIZE, cdd->qmgr_mem + QMGR_LRAM_SIZE);
>         cppi_writel(0, cdd->qmgr_mem + QMGR_LRAM1_BASE);
>
> +       cdd->ctx_lost = false;
> +
>         return 0;
>  }
>
> @@ -1217,6 +1228,9 @@ static int __maybe_unused cppi41_runtime_resume(struct device *dev)
>         struct cppi41_dd *cdd = dev_get_drvdata(dev);
>         unsigned long flags;
>
> +       if (cdd->ctx_lost)
> +               cppi41_resume(dev);
> +
>         spin_lock_irqsave(&cdd->lock, flags);
>         cdd->is_suspended = false;
>         cppi41_run_queue(cdd);
>
> --
> 2.55.0
>
