Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795105122;
	b=tITl6wYOm9mFG6ucmE9eRcWTGcnr0Xf+Uj6IpT7elai9cyG0fdYeU4Wdzhla67YnmHf4
	 AatPQBEnehjOo1Fm7jWuZkZ3YWgghkJA5aB8togcYKcY1Iat4BWUGY1ydLOiSbA2cRcv7
	 t+GUdA1ZlKGO2pFxSBIDM8T4MomEC4d6SyApvVa/Zp6C204+ABUmN0ql81KsnBdsrKoG7
	 /EXrlqQo9EG0TfshM4BK+jXLmq+kGCdDZiYLqnC2CZdBUg70CdCpO1lnBYhwVzndYuo6E
	 GZdBChQfcG43m2smS3DNzvuAaADCAq1+TJ1+pZB1HuSWldLpaKyl23pt3lBtLjr0HGw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795105122;
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
	bh=nQilpZANu/FJ9Es66lQ2Z1wYPhaPYBi3c39hBlCkMJ8=;
	b=hr/USqdNfHoZihEvnYwTwKSlrAXfw6z26NTgjLTGK4IXBj6Y1Pf7MWr+WhT9PJ05jW85
	 r7MW8ItROkvyklWk1uUzdqN+wnI0xjAHCuGP7QP9lYCjz+3FyMwBgBfDtoTOW6gfSYXJU
	 J36rSJt/H4fDBCi9j1k08+wn/prGnP7LUj1abX/wfZ12DRQhbfo1i9buYgVwHIYgme6Ko
	 +ObffFX2dLfJvgOKGuJkpoTBu8wP6hruNQ9qxUqrz9EiwrzpSgj2sj+Bi76MJlQT0Aidr
	 3qSxzHC40twVFMX9z5uTGhUy1c/JSlUHx9fB1lyplxU93W5ZmIEeN8IR+SgafLMtEVg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=HZ1JPSvl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.11
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010011.outbound.protection.outlook.com [52.101.69.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E30606A320;
	Thu, 19 Nov 2026 16:18:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6E30606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=HZ1JPSvl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GSu5H/pgNAVF6gMyI33NMkCWer06Wb8WrDGde4LVAp2GJDd1IIE9kdOed54mqwx6bsa0SrRz0b1mzR6uEl2pRxh6ZC7HwEdDYL5I2wa0tITtinuzEhEufNXYD6RtMir1VB4SXkoWaGUXVC4W5Xm9IETLZmEoLOUTneHYAUo29ZYvoV+8So0Ul8Zs2fC88G4EWELtPSoqgmf8qU6ZJNSp0Wp4dpt7LGuBIEpc+fpAuYNAXfFksKGZ/Z1WqWhw1MdsXtMaR4faSycngr+zzRrN+1gBBVPIP450ZMEZzGCsGxB2TB0g+6IQM5KFJYaDgKIM1pNMZqN7flVHFYRlpImTOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nQilpZANu/FJ9Es66lQ2Z1wYPhaPYBi3c39hBlCkMJ8=;
 b=odrQho3DnhXWsPbGniE9f5v2s12nJbd00mOse35kEKu3aDII/SuxSRZ+t+xOH8wimdUwjkJIhpp0JgrZr2BRucMUVLCLNwP/me0gv/q7/dbht+zF8AQStcZOE6A0KocZJ8cmUTkcTcYFKWNGUVbV2+KbEeQQabbj92EqTunRO2qICTTaTnL2Xs5r5545ZarAzwIDT42TkNeQQLHxjkGJAmRpvJ87mUZgyWyiK0YfBU6RgavxRMumrNDavN8rJ4b1q9OiRqkbVHxS6ttc7AduNDpWYDTs2j/c56ehIUmS6aPGH3poDzu44tltGjh5fbdiZ7mwbtNFlhsIxw9mWGkREw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQilpZANu/FJ9Es66lQ2Z1wYPhaPYBi3c39hBlCkMJ8=;
 b=HZ1JPSvlIUxQQ4xCL132dojVyuah+WE0SI+cc4UglAs3C0gEaQxjpOa6p16PFxHJDGyIYfq2XW/xbc8sURk6tSKioocQqC4x2zR8zw+//FvRoylcUkmOqkQyT0JhGKp3ozZZaRDR85dWMIzrKlJLJmDjNso1FB1ZJG00voJ81RdDhbi9q2nxsDqXR+AAALq6UO7MUVa2iv4XmRMni3YTyQnWi8XZ5i0LtzUyFTsSlfjKEPSxEQsdC4D7UASWU9d/mk3Kvhh4U7tiTIP4TVh4IQdX//QrkX6g9BnFKNtRPuuaxfTtdGW9edEtm84J4bnG+cjouFl05vtitj04ohou+Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by PAXPR04MB9231.eurprd04.prod.outlook.com (2603:10a6:102:2bb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 16:18:38 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0639.010; Thu, 19 Nov 2026
 16:18:38 +0000
Date: Thu, 19 Nov 2026 10:18:30 -0600
From: Frank Li <Frank.li@oss.nxp.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Sergey Khimich <serghox@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sia Jee Heng <jee.heng.sia@intel.com>,
	Baruch Siach <baruch@tkos.co.il>,
	Mitch Barnett <mitch@accuratesound.ca>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v8 3/9] dmaengine: dw-axi-dmac: retain descriptors when
 termination times out
Message-ID: <av8hVoC1Qng9ElFt@SMW015318>
References: <20261119-submit-dw-axi-dma-stop-pause-v1-v8-0-f8e7fe60594c@gmail.com>
 <20261119-submit-dw-axi-dma-stop-pause-v1-v8-3-f8e7fe60594c@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261119-submit-dw-axi-dma-stop-pause-v1-v8-3-f8e7fe60594c@gmail.com>
X-ClientProxiedBy: PH7P220CA0141.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:327::29) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|PAXPR04MB9231:EE_
X-MS-Office365-Filtering-Correlation-Id: d85bcbca-bdb2-40a6-ff0f-08df4658c475
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|1800799024|376014|19092799006|23010399003|11063799006|10067099003|56012099006|4143699003|261026140227099003|261028144727099003|261021121427099003|261026121527099003|261022105027099003|261021123027099003|261102123227099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	dfrF96rFNvOy7qXsfRe5P+XqhhpQu5wwB5k0RgJGtec3kTOvC0AVX/t25ynJHH6cMTKPlPdAmTQNJ6es8FX/RWWXCD02BNNdO1hm6Yn7HqZAQ5TgoBQK1qLo3wJ0nQrTfoX9GKTZITltCfhDXKaAZaWvcLMG8Yyu3+bQiwwTJDWF82x1CQyT6gw6SSKlkU9xFCpHbNgBDrJTEkHBIoTIpAewTLpzOUdIInY1iks6Waex16mRbYH1y+dLG6iRTGwLOmBNS/Gi9h3y7XxaZJlzl221UTRFSM/jlb2o5c20+oUEpdWlNUw5cjgi3kToUozEZ/6VGY2e6v8S6FYqzhpufm1VDjRxdkDduU3qFUBqUuOcDCIUobjrxKE2PeIJwj3Lbm29ypWTJdmmKw+45sx5uK4mhXd/W6GhJBmZdPAwNKimambKeGF1DQ1BamKs7XPFZtm+vDFrbhmeHswEUyqKVwBtCXlxBa+3aYAskD13zt45u77XhrQ+CKwEIBF+5IoE5/6pPYPoLOCAF73l9C+/YV9PQatIp8iWXzlEge7nIHNh80kWX1wihvbumFfFlnI1SzIRuKtLeHC61FsP29FK0G0qSzr01DxNiO9N/NE4AtdgJgY5MG/N4avQgXEN/rQkSMLATb7OTgwTPjYYBRBWNGhm/j9xo2zEc0l2wOfNyyY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(19092799006)(23010399003)(11063799006)(10067099003)(56012099006)(4143699003)(261026140227099003)(261028144727099003)(261021121427099003)(261026121527099003)(261022105027099003)(261021123027099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nNaYY4tn6QSKlivoCYKq4X9sofab2DUKMU0lY6OKWOAZd2cl5poX8W1cp18C?=
 =?us-ascii?Q?xyeq9NKfEiK3UzqcCjGpCS/O0SP2xnnBEQt+NZ1kTFeJlngGUaAUeZQFwyL4?=
 =?us-ascii?Q?hKoMCoHPacLkNMMMc4nhYlwkIBfbp37Wsd7JH7wXuJ73/zWa6K1W+EU2G8IU?=
 =?us-ascii?Q?F54HGYYwlwLbwOfMZdWWjZDcqqqgsRMZi++dRgAmPnIf2qlxTDlvEwXI1c85?=
 =?us-ascii?Q?itbnSt1hxUEB/4Nt67HAqNUgwmHAQyd3Pk35p5C3sgYM60ka+OUDZMmS26gk?=
 =?us-ascii?Q?um8Xsu/gjQsWnFjw9lnZ3pemNWUArNlzipsLMSEGYNPfQtzmf9T4lvK3SQwL?=
 =?us-ascii?Q?0sVu+ujQcVx8VlfylxA7yKWQ1o3+5zfVhoE+aE8t0Sg5GoR8jPgNWs81hNe9?=
 =?us-ascii?Q?0pk+Jb0XmRc2dZ4heBVzXhKTnWc+42Q/Ze+PVAWnFPWyENkkUodcLL65c0TP?=
 =?us-ascii?Q?8mo3uITuj/M9PLLY3OJvnNgwkdZBNwnnXg0eZMjzkf26YZ+zvlFQVUb/76Vm?=
 =?us-ascii?Q?CQFl5m5aLH1l1bg/623KS6yDXPCCvugb3VZrmogKFGHFWYo3R2kjkAnzr3Tx?=
 =?us-ascii?Q?c6mTSeu3DYxsiBmQPWmMBMOp1IJizP/XCSLeN6uWq2SGjpAxbWzn7w8/tmFD?=
 =?us-ascii?Q?MF7AsZxxlH6vwpOg1D4guGhXsxkFJi5Sh1MHtZ9lfry2PQ41yV7UJthl+8zP?=
 =?us-ascii?Q?yGtVqYN2uO370iAeXL68BZkOAv8YRZuFO5LL78PaQ7HPl/qbNvw+gcagS6Ec?=
 =?us-ascii?Q?2W9V3rXcHVL7ixJUi00TiPFHUezHec003VmvSqs121h3tyymLEZrrEQSWQHw?=
 =?us-ascii?Q?xLutHS4rwKBjdqLx/xgAPdLjo9uyT65vfNIHJMjnkZwPjOC+10k+l5YjAHA/?=
 =?us-ascii?Q?rBd6PweOYncwd49p4X0FJO7y6HV9JNo5cuWmuZ5Clh/NIud3g2MbjXCHsjJJ?=
 =?us-ascii?Q?ZmCR1mHb3G6Kf6DAyqD0dfSCKztpKC/aw24CTay7MHX7e6z5KBK7WEFqY2+g?=
 =?us-ascii?Q?a/HT2z0jWkGH37qJjuZsfMw0607rCVi2DmwJr2eN0ENQvxGb4L1d1VGTAtpv?=
 =?us-ascii?Q?SuIvpkhZmzU61vz+WKONeAdk1//FxO3Uf2/vyxTjx6CQ7yG/M+eicUm5F326?=
 =?us-ascii?Q?ViFDYoEtqMbkr9vFNrlj9rwO9DAu7jvIqvpoeWkd79CuBbPjiJwgbe3Ds0L5?=
 =?us-ascii?Q?++aY3uV4UINDMqRYH5gZfH9wluRYDsa8OPV00JKtUL1dXOZjeKIq1XMWgVsN?=
 =?us-ascii?Q?sX55vfLs1eP3A9TCmZ+te7XQCgb998tOQjgA2kO590THlLO75RYnaHuFJJKY?=
 =?us-ascii?Q?quk1z6Li9LteuEZq47MjJEPhAGzLN224K6UbNoyQgcFHejiSKN20950oMnUk?=
 =?us-ascii?Q?RjQeR4RJJL1Iy2GntZ2WZM2rz2b7Q8VG0wC090SEvFAj7e+4eJa/Cu46prmR?=
 =?us-ascii?Q?XDtQQwaPN4S5sJZ1Hma+k++GdXPPeuJgia/Z8FE3Bz+N4zRcvSlZn3h453tW?=
 =?us-ascii?Q?5Go5qTe8sLYRwo3+H+buIoecv48My2mwHwoSlMRekA9WKbZv9BfJGWnMvP0P?=
 =?us-ascii?Q?QIGdnlKiHvCgyDvqjUmVU07bNR7R2HvXErA/S2W2Dh0jHx0oPFpgDWUcBwg6?=
 =?us-ascii?Q?RteEjSfMEbgMSLcQk3wckDMbMgkXPz0p9wD9dy0vgM6kqIkf+wSIm49/cHvf?=
 =?us-ascii?Q?vqWUOzFaJqC4BioYvVvLYivhay7vclxxjFxLhY0iGUjYRzSzcSxpB7R7FBey?=
 =?us-ascii?Q?Nj0G5S+M1Tkwcmreb0nklVOXy/yArnHUzAjplcFT+X42Pkej9BVU?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d85bcbca-bdb2-40a6-ff0f-08df4658c475
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 16:18:37.9111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4KiHfma1pws9kNj+h77zPgy0y34gNGpOlYmO9GkFaPxoCA0r4g7HBvPYpUJ8YjI8cvtkCESd4Y1qVq2su9SM553oy+lu5PB9FJKXzRTCuf2Gpb4PPdrzBubUjoo2uBmw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9231

On Thu, Nov 19, 2026 at 09:00:58AM -0700, James Hilliard wrote:
> dma_chan_terminate_all() warns when the channel enable bit does not clear,
> but then frees the descriptors and returns success. Its synchronize
> callback only drains virtual-channel callbacks, so terminate_sync() can
> also report success while hardware still accesses the transfer.
>
> Return the polling error before detaching descriptors or changing the
> peripheral routing. This keeps the transfer resources available while
> the channel remains enabled and lets the caller retry termination without
> treating the timeout as a successful stop.
>
> Hold the channel lock across disabling, polling and descriptor detachment
> so an interrupt handler cannot restart the channel between the stop check
> and cleanup.
>
> Fixes: 1deb96c0fa58 ("dmaegine: dw-axi-dmac: Support device_prep_dma_cyclic()")
> Cc: stable@vger.kernel.org
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 37 ++++++++++++++------------
>  1 file changed, 20 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> index f17a71183050..def591fc75ce 100644
> --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> @@ -9,6 +9,7 @@
>
>  #include <linux/bitfield.h>
>  #include <linux/bitops.h>
> +#include <linux/cleanup.h>
>  #include <linux/delay.h>
>  #include <linux/device.h>
>  #include <linux/dmaengine.h>
> @@ -1180,30 +1181,32 @@ static irqreturn_t dw_axi_dma_interrupt(int irq, void *dev_id)
>  static int dma_chan_terminate_all(struct dma_chan *dchan)
>  {
>  	struct axi_dma_chan *chan = dchan_to_axi_dma_chan(dchan);
> -	unsigned long flags;
> -	bool enabled;
>  	int ret;
>  	LIST_HEAD(head);
>
> -	axi_chan_disable(chan);
> -
> -	ret = read_poll_timeout_atomic(axi_chan_is_hw_enable, enabled, !enabled,
> -				       1 * USEC_PER_MSEC, 50 * USEC_PER_MSEC,
> -				       false, chan);
> -	if (ret)
> -		dev_warn(dmaengine_chan_dev(dchan),
> -			 "%s failed to stop\n", axi_chan_name(chan));
> +	scoped_guard(spinlock_irqsave, &chan->vc.lock) {
> +		bool enabled;
>
> -	if (chan->direction != DMA_MEM_TO_MEM)
> -		dw_axi_dma_set_hw_channel(chan, false);
> -	if (chan->direction == DMA_MEM_TO_DEV)
> -		dw_axi_dma_set_byte_halfword(chan, false);
> +		axi_chan_disable(chan);
> +		ret = read_poll_timeout_atomic(axi_chan_is_hw_enable, enabled, !enabled,
> +					       1 * USEC_PER_MSEC, 50 * USEC_PER_MSEC,
> +					       false, chan);
> +		if (ret)
> +			break;
>
> -	spin_lock_irqsave(&chan->vc.lock, flags);
> +		if (chan->direction != DMA_MEM_TO_MEM)
> +			dw_axi_dma_set_hw_channel(chan, false);
> +		if (chan->direction == DMA_MEM_TO_DEV)
> +			dw_axi_dma_set_byte_halfword(chan, false);
>
> -	vchan_get_all_descriptors(&chan->vc, &head);
> +		vchan_get_all_descriptors(&chan->vc, &head);
> +	}
>
> -	spin_unlock_irqrestore(&chan->vc.lock, flags);
> +	if (ret) {
> +		dev_warn(dmaengine_chan_dev(dchan),
> +			 "%s failed to stop\n", axi_chan_name(chan));
> +		return ret;
> +	}
>
>  	vchan_dma_desc_free_list(&chan->vc, &head);
>
>
> --
> 2.53.0
>
