Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.25
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792791368;
	b=PStKMkxoYgb8MmnbT4CO9fB27zF2MfwdlOfgCgL8vVJ5RXiPwAzhiGeDyL8sGa1Ly3hR
	 NKQImsTeTqsDQwb30VJcZdTehmm2kjZ7ykdjygN8ZoUxuAIkG0qRF9etIBj0ryE7Z3hir
	 q+OeGtugUycq0gD1HehptHW90Es3s6V2o5pHYTeOF7HDi/JM1buFvJdbgZ1Hsztu4T3UO
	 kEttaFoeTfyRxVIIN3/xLFPbgVt+AXhNMMwflgTdB5g3CqZfSC2zMNAwyXLU/Jc21etBn
	 LogxObKWi6j1cPOs8uId9aO7DgLRjocspJtLbuDnTtuAtjvpiuC603humRwGZqc52vg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792791368;
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
	bh=UQYXRg0XLuZur7tP6OlUF0GPi4QD2xRjbaGyfB1wWqM=;
	b=N7q04vdfpY9kXbh+fJbqUCbmN6VOHEDfsfNuIspLWO9bBIsFjLzb0q4hk/OjoOw3EZ0S
	 0E4lgleTDhcmmfcjFY7dWWKuFKOXmXR/NAY6nnS76bi8nf/qgPE9HHmssB3RfMX/8v2/z
	 +yYWylywg+tCLTCRbV9NubVZ0/YZffZ2HCw0d07EVwymb9b1AMcGPEEOWHgqoalby6wOM
	 XdgMTyQKZcFKgbdQQY/oPLBlX3OXay8cF/6PnDwkTH1bxmovovw8Q02aHETyEjvaPPK/i
	 tb6GBsQ98hAydhl16dkDa4vXuC3eua1DMlSDxJGMueuXR6ZmvHZxaOkmlKMEDvP3JnQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=cXKkaXs1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.25
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011025.outbound.protection.outlook.com [52.101.70.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C120606A31A;
	Fri, 23 Oct 2026 21:36:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C120606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=cXKkaXs1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kxZxaJRE0n0+Z2OO5y/eJt2PHoKLW6BAwT9tUUqA/iGNAh25TyoSV1Sd7Ya4XxYyQXNTT/GWtta2d5rHfyS8IjLBU0XF1d+bKEMW/b8bgQIl5vVj99PY7qbcU3reZjPt3Lk5AS0pIOadivqd/QwTcZ76B0EqGl6zVqmQI+V3Snym79V4A2gxMv2jsnhWZDB/liK3FNh15raR864WcVJ4s/8Vp3RafDqxxcBT5SHVFza4qfk8XQ+rXKxpzplljglGr8xhyIt09Hrg20pWVreWaFalxVBta/30VwnJIFZ7L/3tGHgMpOebaYk8Z6Ih8Fq6ehotcgu+2lvUIPrwns4+mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UQYXRg0XLuZur7tP6OlUF0GPi4QD2xRjbaGyfB1wWqM=;
 b=EgM4QVrfPXhhsmRIVUF2Wf5RiZgrfQ6dL38+ZpAfnFL+qGmTGCsX/xpNmUxVWRbO/KHWPiyln04GPmEiQgiFSqpGFmZ4ps/lPJLfi7kD+O51Dc5oKeB4a+GljWcmCUMHuYvqrXJNji3Yfkildw3iLYpcyPcXiECrHo54wJEGFXHgRvrvhONfztMeMU3xeQE7Mkz4laWsSWyo4i1xtppJXFxPIbNr3RgBno6Ou7aH6t9HRfSD/h8TijPW/kfAiuryNDZTTAZ7vG4fBQfegrT7j+mEA88YjhuWMuvb9FiVE5Qot8RGnpmIO45ccZu2C+xE7lqwDcQhluIDOAnVOs+Tuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UQYXRg0XLuZur7tP6OlUF0GPi4QD2xRjbaGyfB1wWqM=;
 b=cXKkaXs1b3t+6VSSB10+Et9LC41Y1XUX1gXgv8Zm+pItRO5THxoMfuvGBNVZmpFA/iY2sX3KXAs77b1MkuhOZftHYtNObyhunjTRZHcKYxL+UWIji/7Gk1fQcdXsRJ5VXRf1xXJyEPDZDA898XcxFurVaoDrV3rRDGUxw3Vs8H1optv5DKOclzBzoc8ArcIqkf/iOPkLl8p3of1s90XXHpjpWzI1VkQI0+/0thmsnUdUN3L+tqxPc3fMSuo0AaFNEKpspozkGEkUX1HHlTQQEJSjqQPMLLjfPF0h2UpE22xwBc5ojtzV92lvcKQEW/CsMkG65xDaA0lsQexqMVakxg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by WA4PR04MB343709.eurprd04.prod.outlook.com (2603:10a6:1d0:2d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 21:36:03 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0546.012; Fri, 23 Oct 2026
 21:36:02 +0000
Date: Fri, 23 Oct 2026 16:35:53 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Viresh Kumar <vireshk@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Maciej Sosnowski <maciej.sosnowski@intel.com>,
	Dan Williams <djbw@kernel.org>,
	Haavard Skinnemoen <haavard.skinnemoen@atmel.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	dmaengine@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/4] dmaengine: dw: Fix XFER bit set, but channel not
 idle error
Message-ID: <atvTOT0SApG_tNZO@SMW015318>
References: <20261023-submit-dw-dma-synchronize-v1-v3-0-c62bf048f5ce@gmail.com>
 <20261023-submit-dw-dma-synchronize-v1-v3-1-c62bf048f5ce@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261023-submit-dw-dma-synchronize-v1-v3-1-c62bf048f5ce@gmail.com>
X-ClientProxiedBy: PH8P220CA0058.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:2d9::32) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|WA4PR04MB343709:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f00b567-024f-41e3-cb96-08df314da2f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|19092799006|1800799024|261009223027099003|261021123027099003|261022105027099003|261022075727099003|261021121427099003|10067099003|56012099006|6133799003|18002099003|22082099003|4143699003|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	lw6QIeh84atyqgZQpBaQ2BjqT0H2pLl61OdZr9qmd9ixcfigH8H5x1HhWyQiPwZQuGjrBOZJhwJ8GMXAC29T9pb//WU5pk9dGVUIXR517C9NJheOCy3d0KfrsacP58LN7kgiSRZVULYATvKwOAbleKhvZqSRTI5pM4QXTdZAdJvNJTnyz/+pu54GC1wxB5P5IEMqxFz2O+zBdUn7RFCLcc1h76feG1d0vMiJc3ikP0h+B3RN2mk1Ue85rFHlI2zuZbgSFg4RLbz2NhL7s83aB9Z4YOiD8pLJ+IZHpG2wqbYKWebJzkmkbOVKVXA+r/qSJmL02AopLPXMteMeIdkB4ZCCyW5pWLhOnZW+oejQk696wHayehhxfqkG2xyasnH5aMM4WRyx9QdFCyyqw9piskiSTDgktj9i3CYPx7qGOj8JmTfzrFDIkFtLxlHDNwI6ugt66Hc2QcxF/QUR15RvZth6QwZR9+NvTAI8Y87pW9Xm8nkWepAX74Xa0aVgCDDul87Wq+DVgrPh6P4CsLGKLGPTBFUzMUOHiRjfk4fdZw0AhCqEwV8Vw24NC3hYbC4fA6qB9XNdEQkfJuIWcYfTJ/KynHYUsBojlMTK5b7CQkbPyZNMJvx9SCtTi9q3gesbH9N5lxbDdFjqjLO7Ka2W7t36zCOSPrNaS2nsQ8cWZLg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(19092799006)(1800799024)(261009223027099003)(261021123027099003)(261022105027099003)(261022075727099003)(261021121427099003)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003)(4143699003)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/5qmgVJmYBnAmQCoz2j1iFOJqPDj5wr3ohSDtAVzqacULbetbel9p4/RiijV?=
 =?us-ascii?Q?LTheXleE+6Szt/GQlAs4Mil6vsLfviE3Z31npVZF2ZCz6bDx+vwVQjIz2QAj?=
 =?us-ascii?Q?+byF5lqhga6AkKWGOsg6XPQigtODExwPJWW3vGPRjRgmTbCwc8PPplPIHAXw?=
 =?us-ascii?Q?Ki9sWzQRCGEdMJKdzTXFAHm8nHU9A+v/FuHdOXcaGrMYkV+9ehufx8KG+OJw?=
 =?us-ascii?Q?HYXyt+OGFbhjvlN0zAdC2thFHtlHjJxRbTGltyWIqsBOmCX9ootSgCGEN4H+?=
 =?us-ascii?Q?/UfKVtaekWgsEo2JmcMtuEusrBPIu/2Fn6KYcB8HuuDfGNSKt/+Yw71ncJqh?=
 =?us-ascii?Q?zDLXGeihea2l0D35Q01zMgDs2lkkP8Vrwlp1g9b+jLxxePPdHrIfEwBJhwsv?=
 =?us-ascii?Q?thtomemg/qA0F30NqMYwJQlh6AYbR64O1l0eSWZEz5ZPG4XyxzI/EEttWoDD?=
 =?us-ascii?Q?4sAbp05B197yx+2XrULItwrnOfwTVBLVVOEu0fKS//a+/jAnpSv5+p0gRFsH?=
 =?us-ascii?Q?xekHhK6UMgcXkHqra6+7AmiFZmoa9K0MSnpNnZUbmTV+riLNSfpzbdg9LDno?=
 =?us-ascii?Q?+70WVf4LgJRlpOx2cN3IYhQ4DN9NaBFXfWoE6KXGYpZJEIITWemIUDgfKzaU?=
 =?us-ascii?Q?2T0ZZxCOXDSQT2iMkstgeB3VlTfOWqVkFZf79rqcyydjMiC2h1gP+94jiQIT?=
 =?us-ascii?Q?G6balA1wFQ7VVWAvJVPSp7qR5LtwqAjSrgL9DgMifSTuSZ8rc+s6alN61ElR?=
 =?us-ascii?Q?M8GFnRKIRPhLaGW3DHi8N9UQhNfUBYHCcZckwHYSxnG0Zxyvcswq6uHtNapB?=
 =?us-ascii?Q?gOMT7UHqb/bmiv3GxmTFt1hb1CYQjDUncm4xpOv1/eWDjESWWn1mWP5XLyYx?=
 =?us-ascii?Q?nRGKYjAouB8EDgsfkSCIHVA1rvz6J+2fZENyb658/Rp0h47+YqwEel5OUud5?=
 =?us-ascii?Q?cMstyTkMJ38D7nUkmyk2Bu2mbwg92/z0VV1w9VBbQeyQVO7Ei0qeNyO/gAMu?=
 =?us-ascii?Q?a+AnpIvnXnfUMNWRj2XKRa+QFOaJAyQbFjT604xEoGGd8iHFUeTIHn8G/7M5?=
 =?us-ascii?Q?yROVQvm7KmDGrwXbUNJ/MMJ4F127oP0cQxN2T5y0WJcQucsdYs7oCVnaCE84?=
 =?us-ascii?Q?pP4YD8x9dOLog1vjYGSS4/Kz7+dQz7AqnCn5ytFHSw3ppji1lIA5mLZVZTCb?=
 =?us-ascii?Q?kmaQV0KZssFSBsfEzWAlAUbSwBuDD7fAL7sib5RJZt8LXNPPuCAYiA+hz1Xn?=
 =?us-ascii?Q?nau1Ovbr9avoCoZciV/EAiJoMmnhfJzxXXeosG4y9jra7oDLjRN7qswxrBiR?=
 =?us-ascii?Q?Y16wG4mjRdskTd0+7hylyNm0zKlS3mt1HJUcoEBj9tT5PtaE/obh3ZSO08Md?=
 =?us-ascii?Q?h6E+T42gVOdd7KTGWaSMBVUbejMGb2vutx9G276Fi+5xNFJP35qd5m5Bw4BX?=
 =?us-ascii?Q?i0AcoC1lT34UdYluqD6XyxAd3xh4ZAsxnMfI3iGfi5XBcxxltRLCHNTegbAl?=
 =?us-ascii?Q?rwnu+A1zrKnKcgK6BjM8mq9IWG2cYxBZ8KxLMcE3XTn3++DotJJO92Q6Bnds?=
 =?us-ascii?Q?T62BhglQmXcEGkp0SfrKIusi4rjgRUl4TeOf/8/8vKvBtDkD/aeRu3MpBsUO?=
 =?us-ascii?Q?ex6ehYUHtsP/gG7k50Jxtg9/Ul30IjUlBKFJV6ufqR50zSXnwyBEGuBGOBGF?=
 =?us-ascii?Q?MTUhTuU66F50nkfnYStwcc97ynJdvWA/jIF/jVg7bzmPYAXaGZ1Tk426UZd+?=
 =?us-ascii?Q?JPXUvY8nKcLe1iUrHWrlnJgsSpqzp01c6i0zXbFh+ZfMttpR4BYB?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f00b567-024f-41e3-cb96-08df314da2f5
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 21:36:02.8634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LFxQNlT7fEu7MwoskGT61dnLb96Qql9uhGGpdHWOytJBsYOGVasHKGEcBreNk1fIj3gZyd7sqN2yl/x2tO7DxJI28207Is/tcfsZfQNC1YdiP5ie9jh8gDHlFVkGSZku
X-MS-Exchange-Transport-CrossTenantHeadersStamped: WA4PR04MB343709

On Fri, Oct 23, 2026 at 10:27:22AM -0600, James Hilliard wrote:
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
> ---
>  drivers/dma/dw/core.c | 70 ++++++++++++++++++++-------------------------------
>  1 file changed, 27 insertions(+), 43 deletions(-)
>
> diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
> index dd75f97a33b3..07a5f5105787 100644
> --- a/drivers/dma/dw/core.c
> +++ b/drivers/dma/dw/core.c
> @@ -141,6 +141,12 @@ static inline void dwc_chan_disable(struct dw_dma *dw, struct dw_dma_chan *dwc)
>  	channel_clear_bit(dw, CH_EN, dwc->mask);
>  	while (dma_readl(dw, CH_EN) & dwc->mask)
>  		cpu_relax();
> +
> +	dma_writel(dw, CLEAR.XFER, dwc->mask);
> +	dma_writel(dw, CLEAR.BLOCK, dwc->mask);
> +	dma_writel(dw, CLEAR.SRC_TRAN, dwc->mask);
> +	dma_writel(dw, CLEAR.DST_TRAN, dwc->mask);
> +	dma_writel(dw, CLEAR.ERROR, dwc->mask);
>  }
>
>  /*----------------------------------------------------------------------*/
> @@ -257,34 +263,6 @@ dwc_descriptor_complete(struct dw_dma_chan *dwc, struct dw_desc *desc,
>  	dmaengine_desc_callback_invoke(&cb, NULL);
>  }
>
> -static void dwc_complete_all(struct dw_dma *dw, struct dw_dma_chan *dwc)
> -{
> -	struct dw_desc *desc, *_desc;
> -	LIST_HEAD(list);
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&dwc->lock, flags);
> -	if (dma_readl(dw, CH_EN) & dwc->mask) {
> -		dev_err(chan2dev(&dwc->chan),
> -			"BUG: XFER bit set, but channel not idle!\n");
> -
> -		/* Try to continue after resetting the channel... */
> -		dwc_chan_disable(dw, dwc);
> -	}
> -
> -	/*
> -	 * Submit queued descriptors ASAP, i.e. before we go through
> -	 * the completed ones.
> -	 */
> -	list_splice_init(&dwc->active_list, &list);
> -	dwc_dostart_first_queued(dwc);
> -
> -	spin_unlock_irqrestore(&dwc->lock, flags);
> -
> -	list_for_each_entry_safe(desc, _desc, &list, desc_node)
> -		dwc_descriptor_complete(dwc, desc, true);
> -}
> -
>  /* Returns how many bytes were already received from source */
>  static inline u32 dwc_get_sent(struct dw_dma_chan *dwc)
>  {
> @@ -302,6 +280,7 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
>  	struct dw_desc *child;
>  	u32 status_xfer;
>  	unsigned long flags;
> +	LIST_HEAD(list);
>
>  	spin_lock_irqsave(&dwc->lock, flags);
>  	llp = channel_readl(dwc, LLP);
> @@ -310,6 +289,10 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
>  	if (status_xfer & dwc->mask) {
>  		/* Everything we've submitted is done */
>  		dma_writel(dw, CLEAR.XFER, dwc->mask);
> +		if (list_empty(&dwc->active_list)) {
> +			spin_unlock_irqrestore(&dwc->lock, flags);
> +			return;
> +		}
>
>  		if (test_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags)) {
>  			struct list_head *head, *active = dwc->tx_node_active;
> @@ -341,9 +324,23 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
>  			clear_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags);
>  		}
>
> +		if (dma_readl(dw, CH_EN) & dwc->mask) {
> +			dev_err(chan2dev(&dwc->chan),
> +				"BUG: XFER bit set, but channel not idle!\n");
> +
> +			/* Try to continue after resetting the channel... */
> +			dwc_chan_disable(dw, dwc);
> +		}
> +
> +		/* Detach the completed transfer before starting queued work. */
> +		list_splice_init(&dwc->active_list, &list);
> +		dwc_dostart_first_queued(dwc);
>  		spin_unlock_irqrestore(&dwc->lock, flags);
>
> -		dwc_complete_all(dw, dwc);
> +		list_for_each_entry_safe(desc, _desc, &list, desc_node) {
> +			list_del_init(&desc->desc_node);
> +			dwc_descriptor_complete(dwc, desc, true);
> +		}

what's purpose move dwc_descriptor_complete() implement into here?

Frank

>  		return;
>  	}
>
> @@ -389,22 +386,9 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
>  			desc->residue -= child->len;
>  		}
>
> -		/*
> -		 * No descriptors so far seem to be in progress, i.e.
> -		 * this one must be done.
> -		 */
> -		spin_unlock_irqrestore(&dwc->lock, flags);
> -		dwc_descriptor_complete(dwc, desc, true);
> -		spin_lock_irqsave(&dwc->lock, flags);
>  	}
>
> -	dev_err(chan2dev(&dwc->chan),
> -		"BUG: All descriptors done, but channel not idle!\n");
> -
> -	/* Try to continue after resetting the channel... */
> -	dwc_chan_disable(dw, dwc);
> -
> -	dwc_dostart_first_queued(dwc);
> +	/* Residue describes source reads; only RAW.XFER completes a transfer. */
>  	spin_unlock_irqrestore(&dwc->lock, flags);
>  }
>
>
> --
> 2.53.0
>
