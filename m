Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.65
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795105659;
	b=wg9fuXkXUYKSGYOIjFD+zccVqOHTV2brR58VcQJE4CuyWMJylMVQVhbQ22n9iAcLzFls
	 +tV266247qzXMLGxbIgj30qL8xo8kuEHOBMJF6b88K4fNjsEjSqzNrH0+16CwR00gPISa
	 b7g+WSpkXqfHfGJutqF2XBLUxfGc27ojhs82IuYXJaGEaeupGvkD09nVMbMOcARK0rvHX
	 eahbey0v4BE2nWR+fm98ninhVRpJk5XuielSYvGjgVgOyOe9qveJoqi17Fb0spUtaQUyj
	 schCykluIm/V18Xqgsjvm1gtls4Xztrx41Kv6rgudP43GY4kna+mlKAJbJlUuIaoSwA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795105659;
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
	bh=Gg2JtXn59N35z+gZ3bbOn+tJsfvQhAF1ko2HLXIN4IQ=;
	b=a/aw0txlLsvQxKEAaimyQ1Tkret2lxpWCqcLNRHtX5PVdXx3ZQ1MDyTvm71WRZMckmjZ
	 oYjC1KJ0+f9AxKhAhlPPfEC3UJ0LmH8jTcsZG8biAs5l0pTukgGI32JNCt+cJCwDyRkOs
	 c/Y7yQEStw+uChQJDpEdyMKYuYvJo24o5I9MNxgDk9VyP6pbWrdeEtK6zLKDVJ2uWBFH0
	 mVI1ViLAiZE9tyHW/DcWUdTOzZQd7BF83FUV0D01DnjdZM1wk2cAsAJYuRKp8ywF7Dku8
	 AI4fz3qHn9t904pl3BTSW/TBrsv1y4VhdX0lrmAJg/gXkFlPM8p2yv44jIbaNCTs00Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=sDhP9O6d;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.65
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010065.outbound.protection.outlook.com [52.101.69.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083D0606A325;
	Thu, 19 Nov 2026 16:27:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 083D0606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=sDhP9O6d
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NxZnA+aLEU2Uvu1mfaNHL0IDcRmb7sipybNfCwkmj9nskCABITr/cYZBEkL8CzONTGqRiIUN3g0JaZ8Y34zKBDJVe3jrDgqmwOJtEpnIsRg6Kpnls0kgRAdXk9DXlGnF/VcLCML3Z8ldvuT153h6/AlKZJ1LU4PyAfEwiQ+3mdjDxFTDhO972svsrJz0ckT1xZiwptV2Jumk1AZnCcDmijLyzs+1xHCNo2ONFAX0FU9m/KCd6ySL3xy/jBf+AB15+UHyvRYCQEuu4myZeXtL6vHeTOYEnZyRvS5/YglOGRybwq9WLohNgN9/1nMABLWFmLWGYTyXbw8an0ddIa3lvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gg2JtXn59N35z+gZ3bbOn+tJsfvQhAF1ko2HLXIN4IQ=;
 b=dj2RzHy2bMTi47p9RAKSCWRAipqYAlZevZPe1YDYnfqR4gbSvGsYKLcBgGOql0kc4ukkA0ljgaz+grbKTgN5YOtgAem45EoKO9XoTA6nDjPVCJIzhdmY8gPigvJfS92/Oer7/Q7YA4dWkRXF54kZUMXVX+z4XRu5gSvqJ9PrO3OlBAiCDFvTdE8/Ffkcx6iJ4pCcx3HXX4msyM8pGEuhCCbxQqdKws0LjaLdxHNWzIYBzLidFUrRFybNAC+F+viMIG+p+ycYpHjqmZbq3sZAUBI2Rcy21qKhMhJ9+bStBWdsyBvBSB/ONvWlqK+92j92pbNSBSLJYyW0M9eVKLD3pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gg2JtXn59N35z+gZ3bbOn+tJsfvQhAF1ko2HLXIN4IQ=;
 b=sDhP9O6d0GPHqrX1SC8DRDqg7jJmCE8F0CrTrjJYX3BO5rpqxzyoeViDdLKbaoBnsXr2oO/dm4hu9InxrESQXW/wMtkt5bKWRlyyKWpQatxfl4aVcQBZQRKMdi29/XblM52ktuGRal9LAqAmap2+AmfdMU5kKK3evoHUXMHXkERDJbOktp8WebrZznaxRvi9I9EKYtwV255ny7KWHcSb/fe44FHvmE53nRWdhLdWtwXFA13rVEhyLtNix+xm+RsY4qxHgkqPZ9+lnsE8fGLdYKj0m3+sm8dSwonH+zA/o/a5cHBVs8j6GJ9aMJAnf390D0oTAPm6r1d05kzsVlBEkA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by DU7PR04MB11234.eurprd04.prod.outlook.com (2603:10a6:10:5b2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 16:27:31 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0639.010; Thu, 19 Nov 2026
 16:27:31 +0000
Date: Thu, 19 Nov 2026 10:27:22 -0600
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
Subject: Re: [PATCH v8 5/9] dmaengine: dw-axi-dmac: preserve pending pause
 requests
Message-ID: <av8jamIp8oT_M_eU@SMW015318>
References: <20261119-submit-dw-axi-dma-stop-pause-v1-v8-0-f8e7fe60594c@gmail.com>
 <20261119-submit-dw-axi-dma-stop-pause-v1-v8-5-f8e7fe60594c@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261119-submit-dw-axi-dma-stop-pause-v1-v8-5-f8e7fe60594c@gmail.com>
X-ClientProxiedBy: PH7PR02CA0001.namprd02.prod.outlook.com
 (2603:10b6:510:33d::18) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|DU7PR04MB11234:EE_
X-MS-Office365-Filtering-Correlation-Id: 29b3154f-b240-4268-485d-08df465a024a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|19092799006|376014|7416014|261022105027099003|10067099003|5023799004|261102123227099003|56012099006|11063799006|261026140227099003|4143699003|261028144727099003|261026121527099003|261021121427099003|261022075727099003|261021123027099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	cWWMaHxZ02W8lpHGGKQGMzgA2AXA8Y4QXlfJo5rQlfF+8oeDNOOegupThFO9UiEoI6JPq8VcaDh0lrispnLdEx/BTc4CCXNY3wpe6eXYIhxaHwmPxEM2v0TvBUUs4q8bOXqBtO4BetyNTrSF7JmGpPat7Q9BIvnJ+huQoSVVlyp2moP6ZrbTBEs36y79z5sjmY44SrDX4AvfZE3GHvtbYL6FdzNLiQopZgfMyqMVYJEaP7IxLvaJQC58ighNRV7eXbcd4RI9gmz7WQYuU9n/v5jHdeyD/KB3ffYBsK91ZgGJcIj3Aet5QRvm2X3TJPBMSqoOpcffRKlaYlxO3u0gdqZVD/0kneWUFfo7v/MGCsdPF+KqcCowE6rDft9ErPhlmAMNniaUo+8/uBS4zWw7npy+6oWVeCeKve+8rf+wI6qkJAH+qqeY0vMRex32k8UkL10Z20HmcTMWhZdSWnDqyoV95axm/3T5ZO9cljLu7XvTBu37R5ag+Y9YXgYMcovLsN4CgAMijZkyx//7pDaprHh75jDbVcgHOLAalp0SZKdHOzMPW142LMp+HjCJZg5gVoPSkxvT6kl/jt69vLznS3CjtSECjXa6aoRWCxDuhf7fhI1LnDwNM1A0KMbisF3LfpGAKnmzS+GZlp7SCnC48T3TNpFpCczAPm2SQBiRVzs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(19092799006)(376014)(7416014)(261022105027099003)(10067099003)(5023799004)(261102123227099003)(56012099006)(11063799006)(261026140227099003)(4143699003)(261028144727099003)(261026121527099003)(261021121427099003)(261022075727099003)(261021123027099003)(261009223027099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hOi4zvHLdQU9tuaYnMXfjk7IVHUD5QRbfM+bxGTzW5igWecXNeyN+y7g/3L6?=
 =?us-ascii?Q?jJW27nmXa9424Y+qcErJOOMSPCmXh4qfswOFF3E/VWb6VIRMzHU2Ad8sYaqp?=
 =?us-ascii?Q?u93i6cIqK2ESXa6vdr+hRD7sLzrVoI7V/Fw+fqKXbwNf0agrAEE4aSFe7vJL?=
 =?us-ascii?Q?vhSW0AmsfzDD56UzUEKFYVH6+NEMmDXIWY2IPEfG4cn4VAAvdICOlNIT3ySX?=
 =?us-ascii?Q?nkwWezRVVo1RkfIU96YaVL+1py8eoUYft1gZVFUsxBK6I/9ykUMnn8v8NWM0?=
 =?us-ascii?Q?JXCEh0XKRIvUH7fSLrWHRS31tBmRj9NQhCsY49vcS+VoTc91m4v8D/WZLLQm?=
 =?us-ascii?Q?srLJnri5CUqKCAOlDh9831sThBYLxlcbbbmZWt+hvVDAbiAcEw1AALu0Iw/8?=
 =?us-ascii?Q?UP4Ob8dW4bWyDQwUEzhUoNahuZhWE4c5PmRn3X6fxWWKU40tJMp+SbqDAs2q?=
 =?us-ascii?Q?wj8HE6zp7JBwk1h33MBOOc4rRUO+UxmluEG/prWrLtKzRmRZlOhoSZ2YR3cD?=
 =?us-ascii?Q?Sq1bVSHT9D1kl/ivDrmojv+xtfGvpj0Id/CEbTNeWHZWoSA0KoMx8dnIQfrx?=
 =?us-ascii?Q?aRQrH2Nm+xLPtr8Hl+I3j7ngi9PcuCSP5x5+3ltyrx+/CslS4y6tUONL4NmL?=
 =?us-ascii?Q?FvnKbtcSVOqCcEPQ5r/ZennanUKVBPokDYx9bySsU8OHn6DMXkpvBbJ8px9+?=
 =?us-ascii?Q?W395wkZ+uQgC9hx0UkFQ+5fClPLLazMI+9g4C7vu+hoyL2+kiJZD0RSI7Hiu?=
 =?us-ascii?Q?CeWT6ELOE3fDZoCJcEUbs6w0PZzGGXJhQax9JQKChOeD0JoO7TuM3maTRDJ0?=
 =?us-ascii?Q?07C5lbATAf+CYJyrveXVUWaF+gXyAGgegilZcsIfJ1ttEM+HTFDwQqrxOyp6?=
 =?us-ascii?Q?RUzXwLNl/miD58ZHk1ReKlk+IbpmoRY9uZlCvktyKofNENmAAdO+c+HBTfXY?=
 =?us-ascii?Q?MGZGV6YObFEStXpSgwggzOMEwF28B1pAAMah1JWIpGiBn+jsg6chr54PmFu6?=
 =?us-ascii?Q?FMOo+8qm3yKp1A9JQbDMaXOwBrMyaeLmMcBWgeIyZafaM602FbMwNxsasAqi?=
 =?us-ascii?Q?wS3FU3SXSPyIdfMjZ5eWrhqauoNXB7v/ngOesldkdz0KWwiAFf9wVNeVzLv/?=
 =?us-ascii?Q?WwUSBLM1oE7oaKUdAtjCDZXibrrl/OiP5lsP4nX+x9agb9rVu4okCzNWa9Vm?=
 =?us-ascii?Q?WRi1AwzZbZpW59DqlX19iCbSBa+hOqGA6rE2mEETJkQifTdrQ5xvMT1i9J0+?=
 =?us-ascii?Q?VqO8iOnuqRxt2FTzdxq3eL92QHMYKx3f1rCrZ4ksZYYECQTg8oHtvUvvr3hj?=
 =?us-ascii?Q?wkyII6y1IiUn8phm1r0ok6p1dESZT49I9PUw5En+LzsAEwgkAw5IJL5r6Mkj?=
 =?us-ascii?Q?5Dq6bdD86kp/BLvCqtQ2rDHL6icSqu+XFimB+YOJyralbS7AUGxDSTJb9XT9?=
 =?us-ascii?Q?xGLNCkb2/gb4u2sUrVX0eQywlYsED7MpjWB798xuyP0FVHqChBR1qoWD+bYk?=
 =?us-ascii?Q?+lgb+DVeWrKSyYwm82N3ATnktT+bU0Y8BAaf9OhlBewRut/HryCZ8Nu41FdA?=
 =?us-ascii?Q?rYcWrRgOCwwdfqSmRDsMyR0Lc6y1zvyyHdw+g+TTBiO9v+5UkbM/xf6QJ0qr?=
 =?us-ascii?Q?yiBOphYQ0/8Y1OYf7PSG1k6jJftOF6alIl2wmSDDdfJpERJk6o+CSAC1ByDd?=
 =?us-ascii?Q?WEnBBlXMrtQH04D1J4rawyygZQo2z5PK0UoMhNKShVEIb2WYrHV5RW1/7jCT?=
 =?us-ascii?Q?0RCRj0qZHmPlQ3Zs6OyAnUK11liv/lUdryDS7oUbVU5Fg/H52kGr?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29b3154f-b240-4268-485d-08df465a024a
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 16:27:31.0630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fILscO9HWU80DWa5e7dkcGy2xILirhVr/3cpu5vZtUdapVEqkT4YS6xvK0J0DRsLxlD0zYKvaqqgj2Cs7+UKTzBE+zT/amhlWRi2mF6pdtz1U3VMth276YGuh/ddc7NN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU7PR04MB11234

On Thu, Nov 19, 2026 at 09:01:00AM -0700, James Hilliard wrote:
> dma_chan_pause() clears SUSPENDED even when polling times out. Hardware
> can set that status after the last poll, and the unconditional clear then
> discards an acknowledgment the caller never observed. Another channel's
> interrupt can also consume the status because the shared IRQ handler
> clears every channel's status before taking its lock.
>
> Leave SUSPENDED to the pause and resume paths. Track the suspend request
> separately from its acknowledgment so a timeout can be followed by either
> a pause retry or a resume. Wait for acknowledgment before clearing the
> hardware request, since hardware ignores an earlier clear. If that wait
> also times out, return -EAGAIN with the request still pending.
>
> A completed transfer is also quiescent, but its completion handler may
> still need to advance a cyclic descriptor. Defer that restart while a
> pause is pending, and resume it without reprogramming the first LLI.
> Track the active descriptor until its completion handler runs so that
> resume and issue_pending cannot restart a completed cyclic segment or
> reissue a completed noncyclic descriptor while its IRQ is pending.
> Start queued work after the active descriptor is retired, respecting the
> pause request.
>
> Clear stale suspension status at the start of a new descriptor rather
> than at each cyclic restart. Reset the software state after successful
> termination and when allocating a channel for a new client.
>
> Store the lock-protected pause flags as bitfields in existing padding.
>
> Fixes: 1fe20f1b8454 ("dmaengine: Introduce DW AXI DMAC driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
>  drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 99 ++++++++++++++++++++++----
>  drivers/dma/dw-axi-dmac/dw-axi-dmac.h          |  8 ++-
>  2 files changed, 91 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> index 8c115d20728b..99b648d4ca76 100644
> --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> @@ -482,6 +482,8 @@ static void axi_chan_block_xfer_start(struct axi_dma_chan *chan,
>  	irq_mask |= DWAXIDMAC_IRQ_SUSPENDED;
>  	axi_chan_irq_set(chan, irq_mask);
>
> +	axi_chan_irq_clear(chan, DWAXIDMAC_IRQ_SUSPENDED);
> +	chan->desc = first;
>  	axi_chan_enable(chan);
>  }
>
> @@ -490,6 +492,9 @@ static void axi_chan_start_first_queued(struct axi_dma_chan *chan)
>  	struct axi_dma_desc *desc;
>  	struct virt_dma_desc *vd;
>
> +	if (chan->desc || chan->pause_requested)
> +		return;
> +
>  	vd = vchan_next_desc(&chan->vc);
>  	if (!vd)
>  		return;
> @@ -544,6 +549,10 @@ static int dma_chan_alloc_chan_resources(struct dma_chan *dchan)
>  		pm_runtime_put(chan->chip->dev);
>  		return -ENOMEM;
>  	}
> +	chan->desc = NULL;
> +	chan->pause_requested = false;
> +	chan->is_paused = false;
> +	chan->cyclic_restart = false;
>  	dev_vdbg(dmaengine_chan_dev(dchan), "%s: allocating\n", axi_chan_name(chan));
>
>  	return 0;
> @@ -1088,6 +1097,8 @@ static noinline void axi_chan_handle_err(struct axi_dma_chan *chan, u32 status)
>  	vchan_cookie_complete(vd);
>
>  	/* Try to restart the controller */
> +	chan->desc = NULL;
> +	chan->cyclic_restart = false;
>  	axi_chan_start_first_queued(chan);
>
>  out:
> @@ -1135,11 +1146,18 @@ static void axi_chan_block_xfer_complete(struct axi_dma_chan *chan)
>  			}
>  		}
>
> -		axi_chan_enable(chan);
> +		if (chan->pause_requested) {
> +			chan->is_paused = true;
> +			chan->cyclic_restart = true;
> +		} else {
> +			axi_chan_enable(chan);
> +		}
>  	} else {
>  		/* Remove the completed descriptor from issued list before completing */
>  		list_del(&vd->node);
>  		vchan_cookie_complete(vd);
> +		chan->desc = NULL;
> +		axi_chan_start_first_queued(chan);
>  	}
>
>  out:
> @@ -1161,6 +1179,8 @@ static irqreturn_t dw_axi_dma_interrupt(int irq, void *dev_id)
>  	for (i = 0; i < dw->hdata->nr_channels; i++) {
>  		chan = &dw->chan[i];
>  		status = axi_chan_irq_read(chan);
> +		/* Leave suspension status for the pause and resume paths. */
> +		status &= ~DWAXIDMAC_IRQ_SUSPENDED;

If you don't clean DWAXIDMAC_IRQ_SUSPENDED, does it cause irq flood?

Frank
>  		axi_chan_irq_clear(chan, status);
>
>  		dev_vdbg(chip->dev, "%s %u IRQ status: 0x%08x\n",
> @@ -1200,6 +1220,12 @@ static int dma_chan_terminate_all(struct dma_chan *dchan)
>  			dw_axi_dma_set_byte_halfword(chan, false);
>
>  		vchan_get_all_descriptors(&chan->vc, &head);
> +
> +		axi_chan_irq_clear(chan, DWAXIDMAC_IRQ_SUSPENDED);
> +		chan->desc = NULL;
> +		chan->pause_requested = false;
> +		chan->is_paused = false;
> +		chan->cyclic_restart = false;
>  	}
>
>  	if (ret) {
> @@ -1215,16 +1241,49 @@ static int dma_chan_terminate_all(struct dma_chan *dchan)
>  	return 0;
>  }
>
> +static bool axi_chan_is_suspended(struct axi_dma_chan *chan)
> +{
> +	if (axi_chan_is_hw_enable(chan))
> +		return axi_chan_irq_read(chan) & DWAXIDMAC_IRQ_SUSPENDED;
> +
> +	/* A completed transfer cannot acknowledge a new suspend request. */
> +	axi_chan_disable(chan);
> +	return true;
> +}
> +
> +/* A timed-out request can still be acknowledged. */
> +static int axi_chan_wait_for_suspend(struct axi_dma_chan *chan)
> +	__must_hold(&chan->vc.lock)
> +{
> +	bool suspended;
> +	int ret;
> +
> +	if (chan->is_paused)
> +		return 0;
> +
> +	ret = read_poll_timeout_atomic(axi_chan_is_suspended, suspended, suspended,
> +				       2, 40, false, chan);
> +	if (ret)
> +		return -EAGAIN;
> +
> +	axi_chan_irq_clear(chan, DWAXIDMAC_IRQ_SUSPENDED);
> +	chan->is_paused = true;
> +	return 0;
> +}
> +
>  static int dma_chan_pause(struct dma_chan *dchan)
>  {
>  	struct axi_dma_chan *chan = dchan_to_axi_dma_chan(dchan);
>  	unsigned long flags;
> -	u32 status;
>  	int ret;
>  	u64 val;
>
>  	spin_lock_irqsave(&chan->vc.lock, flags);
>
> +	chan->pause_requested = true;
> +	if (chan->is_paused || !axi_chan_is_hw_enable(chan))
> +		goto wait;
> +
>  	if (chan->chip->dw->hdata->nr_channels >= DMAC_CHAN_16) {
>  		val = axi_dma_ioread64(chan->chip, DMAC_CHSUSPREG);
>  		if (chan->id >= DMAC_CHAN_16) {
> @@ -1251,17 +1310,11 @@ static int dma_chan_pause(struct dma_chan *dchan)
>  		}
>  	}
>
> -	ret = read_poll_timeout_atomic(axi_chan_irq_read, status,
> -				       status & DWAXIDMAC_IRQ_SUSPENDED,
> -				       2, 40, false, chan);
> -
> -	axi_chan_irq_clear(chan, DWAXIDMAC_IRQ_SUSPENDED);
> -
> -	chan->is_paused = true;
> -
> +wait:
> +	ret = axi_chan_wait_for_suspend(chan);
>  	spin_unlock_irqrestore(&chan->vc.lock, flags);
>
> -	return ret ? -EAGAIN : 0;
> +	return ret;
>  }
>
>  /* Called in chan locked context */
> @@ -1295,6 +1348,8 @@ static inline void axi_chan_resume(struct axi_dma_chan *chan)
>  		}
>  	}
>
> +	axi_chan_irq_clear(chan, DWAXIDMAC_IRQ_SUSPENDED);
> +	chan->pause_requested = false;
>  	chan->is_paused = false;
>  }
>
> @@ -1302,15 +1357,31 @@ static int dma_chan_resume(struct dma_chan *dchan)
>  {
>  	struct axi_dma_chan *chan = dchan_to_axi_dma_chan(dchan);
>  	unsigned long flags;
> +	int ret;
>
>  	spin_lock_irqsave(&chan->vc.lock, flags);
>
> -	if (chan->is_paused)
> -		axi_chan_resume(chan);
> +	ret = 0;
> +	if (!chan->pause_requested)
> +		goto out;
> +
> +	/* Hardware ignores resume until the suspend request is acknowledged. */
> +	ret = axi_chan_wait_for_suspend(chan);
> +	if (ret)
> +		goto out;
> +
> +	axi_chan_resume(chan);
> +	if (chan->cyclic_restart) {
> +		chan->cyclic_restart = false;
> +		axi_chan_enable(chan);
> +	} else {
> +		axi_chan_start_first_queued(chan);
> +	}
>
> +out:
>  	spin_unlock_irqrestore(&chan->vc.lock, flags);
>
> -	return 0;
> +	return ret;
>  }
>
>  static int axi_dma_suspend(struct axi_dma_chip *chip)
> diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
> index 3c86e5d468ea..b18c9880711a 100644
> --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
> +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
> @@ -42,6 +42,12 @@ struct axi_dma_chan {
>  	void __iomem			*chan_regs;
>  	u8				id;
>  	u8				hw_handshake_num;
> +
> +	/* Protected by vc.lock. */
> +	bool				pause_requested:1;
> +	bool				is_paused:1;
> +	bool				cyclic_restart:1;
> +
>  	atomic_t			descs_allocated;
>
>  	struct dma_pool			*desc_pool;
> @@ -50,8 +56,6 @@ struct axi_dma_chan {
>  	struct axi_dma_desc		*desc;
>  	struct dma_slave_config		config;
>  	enum dma_transfer_direction	direction;
> -	/* these other elements are all protected by vc.lock */
> -	bool				is_paused;
>  };
>
>  struct dw_axi_dma {
>
> --
> 2.53.0
>
