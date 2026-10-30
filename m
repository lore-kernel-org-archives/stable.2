Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793372425;
	b=M9xoHL736PtZCgqzTFRe7RE/9CGB17nCdu1cO28phWGKx7WifRsX3NG3YMZUKNC19wKP
	 QbG+wry6FYqxIqLLHIYcz04iEaTy7dv4Na6ak+dA1KlOgOmKq0Uqdp4CB9532XhC0Qo6U
	 7d7a2ba98q4G6CrJDfdhEjSLLXRRHVLsvHp0wNY2F5Nm1Lnl8FmP56IaK+gkzn7/h5gV7
	 vqrbG1Wz7NaRodVqBAQ852F/azV8IERxR5Sv3a2IuxCDHiE/o6HBCfYTyCvUurL9z9ovZ
	 wtAcLReBGlAdTva0M4bzEu5H0xiIxnFfkX04dDIhZQ1d4GSGMXTHd+8VBl2rw8Dm3Sw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793372425;
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
	bh=npS28P+fvLY20tUV3o1nEvQCy6NkNpAAWU2SCrvYgUc=;
	b=E+uRdpt1Dh6N5HXUhAIym7C1mzGX672TmfL1FwPknNbHUusinJU3hlkg41I8ca3XrNbG
	 Nv1wNF7ofJWy5JrRpRkbV5iMjrBpOeIw3+1zjnll/Ol+DR3H3U2Nf/Mpg24xievuht9UC
	 S6a9UeKpaMlqf4GvxujNvGWV5iPJC7hDjEVXTUm+tHvY4x2u4zxNjtH2ZknmrEtD57pz1
	 TkKzum9/teR86G4AnMF2TvT5HwqOkI+f4vFbYTBFkk8JW83jmkBz65IcKxP+tTxvu6+kS
	 0efGxxdazLwG3vcdqLrqbi1qiwbZE7b8uLRbhs+m5yzCAqjLLsHzlHCyoEiepXEnwvA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=UgUICrA8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.52
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013052.outbound.protection.outlook.com [52.101.72.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C49E606A31C;
	Fri, 30 Oct 2026 15:00:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C49E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=UgUICrA8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WP2HrsYSAjED01B7og7Cv38MggT+yWF6ZhHi6myLNrcWnJtJsxWb9/gB2MDHmI5NvoLx0Ef3UGcqjDUZQaoTdv6SwcmD6UgwTycNnBzfWdkh0iKddwXLbCU2xmS9f2/hibegYuCI4JFcmiq7FJw2XS5XFrosQAt/6rHgW/HHpr7WDaE4362IM/szywfOCXPokiVstqawCyFnTuEZr/2is4jNZUSeIy2PDwEBtRwJR+t2zJdRGcv41hJPZYDcl1gkFMRWSDeVy9BesrOF/WO8hv9+u0OUEhMWeb0DqwNTTPWmY9xxv7FvyP0AIxk51powQIhB5Bb1hkR03qa07nTOag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=npS28P+fvLY20tUV3o1nEvQCy6NkNpAAWU2SCrvYgUc=;
 b=Pk859K/ZnYa9zo82o8mvopTvi4bPse3dMUP/9WxEhOyLThlEck3srcFN+6hsuvPn/sXUn9CKLwIUc7vN6cLB32cKUozy98ZpBOZigmAk4TQjiFgjH4h4l8uTTf6cSevs0I59oosy5ljHUdKbHz2sNPOyXNC3RxLVn1t/y+6J35SAjitJADORP/6Fkfpb1Ju4k158Pp3PK7hNnhAOYRW5A/ngZN3O5vp6R83+nYR2zJqh+KYzE37y400lYGt8z4dKcOgW3IJWXSZ+BdLi0PcnnjXWy84qlgRLGu47pRABs5g6wU+kYEMMfrvUEgK3rmQPAWrrNsOs1CR7pScd3w7dRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=npS28P+fvLY20tUV3o1nEvQCy6NkNpAAWU2SCrvYgUc=;
 b=UgUICrA8KEqpjot1Tl5ZDf7P4vTXK17HdjG3C49cn9o254L3P9nts5aV8WGtzY658IdJvBh3A3CKXUdjvhxxy4Kp62RVWl7VgOobsj/gv5DlLjGX5lcX/QCwpGsLlCCctEX6/CC++fl6TqCX9fQ37UxOpIHu+72GjQxQtfoDTCQogkU25Dfmn2GaBEC0+Jy+w25n9dULoNW3rDspixRoCx43IQAX4+/zFBrO1QgDf7X104VijlgWk4vLQuixxgA+3wLpPYi30tC1xx5x6JvL3facOhK1Fc0CB+gEYwaG6lHiGjGD6SjA1vMPCQv3EpeuP2APnycJyjPxyeB8KqkUgA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AMBPR04MB12445.eurprd04.prod.outlook.com
 (2603:10a6:20b:75e::21) by VI2PR04MB10224.eurprd04.prod.outlook.com
 (2603:10a6:800:228::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 15:00:22 +0000
Received: from AMBPR04MB12445.eurprd04.prod.outlook.com
 ([fe80::ba23:1fa4:ce58:ff06]) by AMBPR04MB12445.eurprd04.prod.outlook.com
 ([fe80::ba23:1fa4:ce58:ff06%3]) with mapi id 15.21.0569.008; Fri, 30 Oct 2026
 15:00:22 +0000
Date: Fri, 30 Oct 2026 10:00:11 -0500
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
	Lars-Peter Clausen <lars@metafoo.de>, stable@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v4 1/7] dmaengine: dw: Fix XFER bit set, but channel not
 idle error
Message-ID: <auSw-1IlLYgG2T2E@SMW015318>
References: <20261029-submit-dw-dma-synchronize-v1-v4-0-fea447d9f285@gmail.com>
 <20261029-submit-dw-dma-synchronize-v1-v4-1-fea447d9f285@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029-submit-dw-dma-synchronize-v1-v4-1-fea447d9f285@gmail.com>
X-ClientProxiedBy: PH7PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:510:174::17) To AMBPR04MB12445.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AMBPR04MB12445:EE_|VI2PR04MB10224:EE_
X-MS-Office365-Filtering-Correlation-Id: ec07c5e1-bfe2-4c61-dd83-08df36968548
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|7416014|376014|1800799024|366016|18002099003|22082099003|10067099003|56012099006|11063799006|4143699003|261026140227099003|261028144727099003|261022105027099003|261026121527099003|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	qjlsOWd8o40BD7H9d8GgSAUzKOuTLKteVL/33PSFQEDVl5Aj4fpGz/bRtVnUlFOdYtWrLUNWK0T3Xh3UQWQCLxGQ+nw/imxnFw32SJwvKzXy4TQPHgIGM73YY+vl1jObegoHKSIRCbgXIgiMtwRoTxdZnzlQzXWS+IDEIYGLVMSrC2insmMy00g8EKEQ+1fCZ32T54TYtHy9ucmXUeXfCZEB8ZUIxplqkICeg+pHK2DfEKNlwjOsI6bYXX1SAVlezxFFBighj+q9DS/P+Z/obDIOdqaS8k4YDGa49dqOa1hhqtpS50uxiQLBvQThQGgZW+5RH7lcbEcp8FOO+YZD1XQ2dL5JwL7Gcki6Wgt5DHoobSN/z5iGD6IpiIinQiyc1y5KLTV0M6FyjGEJI10ImNu4XOKy+th+IbiNPyKrDqk+SL2s50fUhMi4v1H7ERgqMWr5KM7WGc0DrL5SiPJqQ5pH3xRoIAzTPWUMMg/4BUW5WAnDuL9+kUKHlDerSfg9WvKEkVXoyZenE1gPcQQoMAQ2TIugPuRuWXjrTxYMFBhztvrjZ6odt1H6TyGZYcIrX+IXOqXA51rojIGJNSI5Unov+pX3hA9pz6MuwvQm1fCUg/qCXv6Glr4KSfDUKZezIEmhGZrJdZMxhgeDtjSd9OhpQq3X7yhdp++d+zFe8zc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR04MB12445.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(7416014)(376014)(1800799024)(366016)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006)(4143699003)(261026140227099003)(261028144727099003)(261022105027099003)(261026121527099003)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WNCzGPAUXssW8RLjkpbBQd+IuP++v9b1PcsKOCSrcGP1LJEi2foQHDN0EcH7?=
 =?us-ascii?Q?7YG0hTNetTZSsabMaz91fuvAf4EFHCskt6DaQf09Jb8jct/e3xe1HMyvwNnw?=
 =?us-ascii?Q?6fA3gpMQsU9Bv1FG1RX1IOEvnfJlkyLnkCMSnC0IRd8c7U0fnbGmysfpMSw2?=
 =?us-ascii?Q?681o6eeTXpUWp7nE9pykrYiuhr6P2BDDajKAbn23qkjCOWUCLvmnxW7jQ/Bw?=
 =?us-ascii?Q?1fgYnOf2T9YnMRi47EhGoR42LPQw3gBjM2wMS5zu2QVtjFSQYWzrTLUPS6WP?=
 =?us-ascii?Q?XKwi8vNuuFM/AparrrcOZ8Qsm7DBweygbuWOc8Pwi++5gdGBaNZmVXmCXBgY?=
 =?us-ascii?Q?ltdEnRdftaXJWVqZ4DeDysMkGQD2E2DlJZd2Wkm0g1rrgWcuWwtcNRavWvpj?=
 =?us-ascii?Q?QbbYF9YpMTF3sHQLOubOj6WeUeI5r773VcHJ8h8+F4NxM8SOitfn3OMSRT55?=
 =?us-ascii?Q?AvSgns00RKBmA5EiJ1s7SlnmtKUoCfwHr8MLE3k/a+Brb92neWB/nikhpmWt?=
 =?us-ascii?Q?gnSwEcU++SzIIqbTVMdOAoz8Uc0qcuw2SjpF6c8hV13zxmtQQx0/2857MKcF?=
 =?us-ascii?Q?V1NgLMDG97ZULwImX7R7Fq8kYjnTsRxsI0tzR3Imty/ooR+dkIVQ2Kkhjxn5?=
 =?us-ascii?Q?TUwVrP9PYsNsUL+r0zliq0RiUzTyNUhMa9lln6Glz7xFt0PI+1IyyqrfQJy7?=
 =?us-ascii?Q?qjqgJJyglRpHjTrn2w2QBkaWqHKglwQs/yEe43v0IVfBz3+Z0+1aSAo4LGvO?=
 =?us-ascii?Q?u4H5fFGs1UpVeb2NIhmHm/wcqBk1AuwsoDy/q4WftKEf6FaxnkMZ+4jUwkJD?=
 =?us-ascii?Q?mpBrztXQk4zS1MlHVQq/3G7VWn8ifbr6+Zh/mL2C8M5cG7aGkLDDAQlaUqAc?=
 =?us-ascii?Q?lZsvthRhsEJbJhiAWiYcD02/wOptHpvjsViEJ8zUVt+jq00GCcNPi3pps4TE?=
 =?us-ascii?Q?zeJeaCM23CBNI+aIuL1m3WmaUPAvPoDgR+QZYkhY5pQD+feZGu/e0MNXM+Q7?=
 =?us-ascii?Q?x4VzKDTyXy6uXg8EFoPygEhoRMSbkRNKEDcOENn6ucP2Y1wMqtaawwTOIGlg?=
 =?us-ascii?Q?3MwYwcz+qYU/hzABFUEZyaU9L/1ocdOrop7ZhpFTM6x6RbUjLaLH9d6+fuj9?=
 =?us-ascii?Q?Rwya/pPZZFBS2peOuYNYaCLHF5kjm7FoaF+wnlXmpqsOj1M+fNPTm1YLEwVC?=
 =?us-ascii?Q?+x7YxsWlVkQ2/7XxIbO9l2HVT7RP3F4iwpfuVHy4nuwbf3Xw9uIhkcYDwV/e?=
 =?us-ascii?Q?JzJxiMK0Gs/pmVUmIdb54fLORjOjqIeJST2/+3X2q1ZGXFOss/rHXxkNVipJ?=
 =?us-ascii?Q?eM+yyippxa3FvvobO6BC3obXa2ntst3P5dzNdtWUpZcMyEID2tJLM8YcP4Qg?=
 =?us-ascii?Q?IYgmWOyciFSp3EkQrdVwDwhbUX34VoynoEn3i4ms0ZEVZ7bItLTJt6ZptGei?=
 =?us-ascii?Q?thnUwDZ3JA40u2JJLf6oLlsDar0y1+v7Zzzrhm7sT3ikZE/pr2biKut5y3vV?=
 =?us-ascii?Q?VYzadpfEZ7RZfKJaw/dgotbCdSgHkg1AcuJEEh1CAamSPpcXjhVDTFQadI6G?=
 =?us-ascii?Q?ZauRoSkfWo4QM5Mg0DsPXZRbtvxDq04TAJkK6wgC+CFAbuyLTs6ai5kNQioz?=
 =?us-ascii?Q?h1815xn/1t5MoovTl3lWNTId5ZJtctlSouNqx6C2DLEeGCtHkucK/oaeMgie?=
 =?us-ascii?Q?pz6NSmXKIK23bC3DgDdlJYrGg2ugMcCfeaE5/35LYDCtdtiQFJ6YHv34ZW97?=
 =?us-ascii?Q?eh44ook+rs7UZ4k1bEBVgV3XC5F8t7p25Q8Zm1W2CT0B+GZw3d9Q?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec07c5e1-bfe2-4c61-dd83-08df36968548
X-MS-Exchange-CrossTenant-AuthSource: AMBPR04MB12445.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 15:00:22.0975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Tf8ANvRy2Dj9EwdCoOBubP7tSUQxjdO7XyhqF+ek6gmqTyy56rtMEgtiYfXnhD3GUhf+4gWE9qUE8aJ9hSnaw4vxMhFlkcpjgItpx80ijjr8Y9/4RtCdK62PMFLrhNZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10224

On Thu, Oct 29, 2026 at 04:29:35PM -0600, James Hilliard wrote:
> From: Serge Semin <fancer.lancer@gmail.com>
>
> If a client driver gets to use the DW DMAC engine device tougher
> than usual, with occasional DMA-transfers termination and restart, then
> the next error can be randomly spotted in the system log:
>
> > dma dma0chan0: BUG: XFER bit set, but channel not idle!
>
> For instance that happens in case of the 8250 UART port driver handling
> the looped back high-speed traffic (in my case > 1.5Mbaud) by means of the
> DMA-engine interface.
>
> The error happens due to the two-staged nature of the DW DMAC IRQs
> handling procedure and due to the critical section break in the meantime.
> In particular in case if the DMA-transfer is terminated and restarted:
> 1. after the IRQ-handler submitted the tasklet but before the tasklet
>    started handling the DMA-descriptors in dwc_scan_descriptors();
> 2. after the XFER completion flag was detected in the
>    dwc_scan_descriptors() method, but before the dwc_complete_all() method
>    is called
> the error denoted above is printed due to the overlap of the last transfer
> completion and the new transfer execution stages.
>
> Clear the channel interrupt status when stopping it, and keep the XFER
> check, descriptor detachment and queued-transfer restart in one locked
> section. An empty active list needs no completion processing.
>
> When the locked XFER recheck finds no event, only update residue. A stale
> tasklet snapshot may belong to a terminated transfer, and a zero residue
> only means the source has been read, not that destination writes have
> finished. Requiring RAW.XFER also prevents the fallback scan from freeing
> a descriptor still linked on active_list.
>
> Fixes: 69cea5a00d31 ("dmaengine/dw_dmac: Replace spin_lock* with irqsave variants and enable submission from callback")
> Fixes: 3bfb1d20b547 ("dmaengine: Driver for the Synopsys DesignWare DMA controller")
> Cc: stable@vger.kernel.org
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> [james: require a locked XFER event and handle an empty active list]
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>

Please follow b4 order. your signed-off should be last one.

Frank
