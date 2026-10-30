Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.1
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793372871;
	b=ZBYt9GruUzsI7gQKsuBYw4salWryUYldimp/SUEZH1eI3W8GClLvjTOykf5+tYOgEuNw
	 Q21bpBMOJWW6UwvK4ZTbD85MNYZx6BjQQSKLyphTm4lIPwoQ00BvlicnEXP8Gm1xAxyHP
	 2AEnEMIEZHt7evWwOQHnMuBQXpddjlrugTxkjyuVS8+Jq4BEN/reXk7Xzh0KdZTKggeyO
	 /GiCrM0fQyGCaBCbfTQUwccLaNpJlwOG/YopcJpo2ju3zkU9YKL/CchkOVBMoH1PswKaZ
	 RcliLEUnY3FNa8PM2bPVDNGHx26TJ/olSv3EBNG9ABnP1vMNksgtSNPVtxDXIjXDohA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793372871;
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
	bh=VgsNqfo0W010yDzuxxGlZ8tWfm+NyHszMZpr9oGNh0M=;
	b=cLl58ZxScsgm0jOj9+pwSwQkSn5ADxG2fBU/wD4E2k6+NYmDUCC9cqd1Ywk51TdpTFm1
	 m1P1m2CQX2V+l8jLvlX7MCHpE4L+gvnTOc4uvSeuneSi9+2FRqiovGOVHXx11vwpFvjN2
	 pNk4Cfapg02qhT/aHJWpB8OCKjNkiokQ+udcj6NWE7GoYMd8oAUQ664eDK0gvMjwdVIso
	 jiwSqi4PZwARV9BHzZJndtUdNlbQDIvVJBi3wajiW1w4+HNsmmhUR/Tcd0Jy3SzX18L2s
	 dPEQGcs+IG1bXiPcoHidN9GIxRu4d5ZEErYLq42m6R18SHoe9SRntXfKJ5XWPInwecg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=g3coVtGY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.1
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013001.outbound.protection.outlook.com [52.101.83.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DD7606A31A;
	Fri, 30 Oct 2026 15:07:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50DD7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=g3coVtGY
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gaMaRBQATKlMWEyGQb97P8pedHhODOM1Hm/owDZI/HYUXfqIWAUc52bKZRdsxuvHYndsh+JNMVvnnF6C8K7rrMpSKD1yKSGcNWvrSdSYT+l3AufPBcXJn8wxt4i9hcAcZ57d6Eeht5S23bd0qBGj5LUvLxzeDz7Y0WqrqRtS1x5earaDSHMFHK05TE1TMoGLqvvnm5jPtQSExY0/43DJLP+7ZBF35AwEGo7Sd4dSX8L4OFrsD6TVpiqq6O1LcPYHUKe6ZMDFaekWm9IYUYn0B0Ng21YrVPZDg6cMxH1BSIPQp+/sfAY9oNZBFszw55GcMyGkor5JV/y9GkzrAw3SKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VgsNqfo0W010yDzuxxGlZ8tWfm+NyHszMZpr9oGNh0M=;
 b=IaPStiQ2qanqNoUmH4ZPuLmK6/vNC4vE+pc62qT7kbWbg+LQRrnriaaowLORizKY60+HmVs6ceJWt4J+6RUp+8sOJzCD6HKvE6jLewtn8rf+ZoGVxUoYraex3tx1XMwvDLICz0TKv1CJ0jf+zEM/Azn3VgYwCrp9CIQx5o1Q+WgqvD8HY1LPiUFgCMWc5WlQX20TSyUQU3Dx/MCb2OF4QuWwFiM57aOoMXBhU7+6/0P16hGIoYk87Tg9NCCd/6sPWp6EQ3QfPuXWA7kSYKwqwNOKv8+YIiLCFD8QD0vaMhXk5HWrmqe8QY/CPl6RdPZiCrBCGdTivXQ9wlSGh8C05w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VgsNqfo0W010yDzuxxGlZ8tWfm+NyHszMZpr9oGNh0M=;
 b=g3coVtGYIUrewxFOiKTLExBIDzBYchVtNI1iJ79K6kkU5KMVlXatda+tjhaS+TqCTdImEwHzjmrYVS8q0CJkxhJRMHu08BcTtSBicb+KJi3g93eP3v810E8I1yzqxoKOzCQg3a+chAgWd9HuvG8fSu9bEDnOkGzg2qBsaxbeqKcuqGRCLMEfBGQOOIRZ+AAlcp8fPpBg6iz4vYwzorOxg8mfjiHGVZ+OEzAO1Verp9mRnwz5m1f1xIIncAqQsAuJm2p5OZC2brXMs8KoshJnTjqM4KFDHGDBgb/DZpCtFCrM85cxBaUNoK9KxS+eN8fLC7klU1HtGIO/4ls+oAf+aA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AMBPR04MB12445.eurprd04.prod.outlook.com
 (2603:10a6:20b:75e::21) by AM9PR04MB8601.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 15:07:47 +0000
Received: from AMBPR04MB12445.eurprd04.prod.outlook.com
 ([fe80::ba23:1fa4:ce58:ff06]) by AMBPR04MB12445.eurprd04.prod.outlook.com
 ([fe80::ba23:1fa4:ce58:ff06%3]) with mapi id 15.21.0569.008; Fri, 30 Oct 2026
 15:07:47 +0000
Date: Fri, 30 Oct 2026 10:07:37 -0500
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
Subject: Re: [PATCH v4 3/7] dmaengine: dw: complete cookies before releasing
 the channel lock
Message-ID: <auSyuSby62iCcrlT@SMW015318>
References: <20261029-submit-dw-dma-synchronize-v1-v4-0-fea447d9f285@gmail.com>
 <20261029-submit-dw-dma-synchronize-v1-v4-3-fea447d9f285@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029-submit-dw-dma-synchronize-v1-v4-3-fea447d9f285@gmail.com>
X-ClientProxiedBy: PH7P220CA0042.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32b::25) To AMBPR04MB12445.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AMBPR04MB12445:EE_|AM9PR04MB8601:EE_
X-MS-Office365-Filtering-Correlation-Id: 12524bc2-6503-4fcb-cbc2-08df36978eda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|23010399003|1800799024|19092799006|18002099003|22082099003|10067099003|5023799004|11063799006|4143699003|56012099006|261021121427099003|261021123027099003|261022105027099003|261022075727099003|261026121527099003|261026140227099003|261028144727099003|6133799003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	LxrNb+9oWpmY0mmUBTYKUtOpODOi31PdeKfolbWjMYVV+oMyT2xTAWTQFtTxXnXaNFTOY9XqgkUyDCt5+c3egPOSp08/XNwMNwPxWT0Hd3s9+5XjMqdgQ3ldfVZO2C7HJLcs/XoI0SOS1AUKtvW3ahqoCkd98sKYqotdPdiGCQGXLC/CLlgFfhrrfWzeXsb0bJ6ryUJNK1LM4QdpYTir3+gyBcsyaaVmbZC/P4MKCEMgfR+/Wmz4GZvmdiltfYbLfWep8f2/mdRFfRijrb/f/c0pp1K3dAVPUDg2S0QKo0d0uLtKfFXrgEI/zSja40kn9QNnXjEU6dxN0KVao/JMzfVstODMaSJH13VzQ/3tNRLXYfixkisXUAGKI1p9ETcGhqmDGqd2YB4ugsVwnopdWYz7dL9OihwKWzmB6ql7/N3SnhwHMNOjc+yfjPHst03b4spdvQxiMcmO+y0MQ0GWDk/3obhlByIglgLhBCSf6dTSnPOz3A3hJYh5QBulBNXiLi+57p5jtSTSb5tqIRcCqacL6yrQjddgSMbfJo+LrgEd1MzHfPNrWlOnlFvwjfypiVeMz5iO4Poy/tOW5eNrMPRfl769HfW4A0ufymKsvjbTzEskD1MJOABSZaRSCVPXtTAoIlXcjT0/yiKDTum95In5c98eL7JvEz2dN/sVv2Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR04MB12445.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(19092799006)(18002099003)(22082099003)(10067099003)(5023799004)(11063799006)(4143699003)(56012099006)(261021121427099003)(261021123027099003)(261022105027099003)(261022075727099003)(261026121527099003)(261026140227099003)(261028144727099003)(6133799003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u8E1/AEfRef9Uzq0phCo2T4Uh7EItSTDpOEaT/V9FTt+0mnX00ECcUsVS7Yo?=
 =?us-ascii?Q?5lurhDdowRqzOttgBPgThVx282couCdwBjfB4J96leDExWHe7lPh1o4r0pfh?=
 =?us-ascii?Q?wTmjUiYibu7n5fwRlHZXwv2SGKfGucwiNTveSoI+gM9ovEMM8eZCgPutijv5?=
 =?us-ascii?Q?zGOT6yoM2F+XMEGL39kVp+EwU2ny+K1UxH5K3BV70a3G4RXGouip7NRxord/?=
 =?us-ascii?Q?VD6cEwQEkqFnmZbusd7jjUtpNvX3uhHYsc2v3ocbpMVH4LdXsBxWB/T8syFV?=
 =?us-ascii?Q?LU97BBDmlMomV0sJr5uZfdqRIGnRLqBu78VgLBTDWAaJoleDvn1JkBGcKhJ6?=
 =?us-ascii?Q?excqF6WqfmWKMUvPq/9gM63zZjh24hQuf7GC3znkzzsunTNB36BGbbLEPvdP?=
 =?us-ascii?Q?YdQPlUR17sbFzKz6AvuZKG3fFttuVOxYAmoVhzYarML9W3uMSMvZD5TAf67f?=
 =?us-ascii?Q?GKdr1WLjxsKhbC3oQqojKmlL5/gU5+o6t/FWCKWoWmy8gvzqKc5DrODZDNTK?=
 =?us-ascii?Q?XnVdyJ2CsqBeMKuZZ0JEvqTiyJiMGr/p1GmJpXsGLwVKSjqGYKh5m9UBa3wj?=
 =?us-ascii?Q?vrZqpkq1rjx9f5qKAnSPbP29yzmyN14TFe4pTvzXxtvMtAc6c8VlJ+FXmIY3?=
 =?us-ascii?Q?WRAMYvmvMdSH6gYnzed1CYf4OdLwbnxMLmXoaWj75GrKZ8Gz93VaerUTsMo2?=
 =?us-ascii?Q?xgAenABkRpCBuSpU+4yxGBbdl+qL/+wO/hfya3FVjkDHgLBtDI+WpYLkjf3P?=
 =?us-ascii?Q?kcbZdELYWz+1v09SEX2eeWMNUC2qp5DwVoz3Y2fNIViAWLBNPsWbIueMy0PJ?=
 =?us-ascii?Q?ZEsdULqGeENLOBJM+R8gEOaDc2lSuni+OBaLxseWkh59iCI0mxLaIJDFKBFO?=
 =?us-ascii?Q?V5eok6OtHVY7urq8bOvupukWe7FJzUD54UEr5GZ7yC4qYVpAm323XqxRRzCO?=
 =?us-ascii?Q?t+xO64GVdrmQAKHst1aNEib6atihqWzSMyfr48CuptmVcRDblZaDs/XUDiJ4?=
 =?us-ascii?Q?nlcY77dCL3sWE+Z2C1vhIDWx5Tj1yTsez64Dqe5SIdQNTTGmAyHuFuC8HBM8?=
 =?us-ascii?Q?eoQL11baGtuFVVPzvcmIUoENaXZIhsnnW27pX9EoByqX9abQbb9Z3wPdTO7k?=
 =?us-ascii?Q?Q296p698fAnbBJ6b/lLKKra1CF+v26gAGrQ+9AUDh1rmHAS31g3OYCvq/u1z?=
 =?us-ascii?Q?LhVcagQ3CkWlEYYZFqX1Uimmg5kO5v0880CmoVJ8uI59eMg9lucwamXBFvlo?=
 =?us-ascii?Q?DWhZ5vgDPs6aagFE4+7dy3dLZz0PG6muS/hD6wK6jixNa8CmrIAT7L8ItyDD?=
 =?us-ascii?Q?V0Lv+K9sdJ3lXmRL0xymvFidliMs3vyN3vrfKFhRuXzMGBkO82/o7NgYCqmv?=
 =?us-ascii?Q?64BV/t4+9SGygHD7gxR5ye9zcg2q+3JjXN8F+8T0fsaG9/SKTFLtsZWUIL4l?=
 =?us-ascii?Q?JkWQzbV3TNoWw5c+1NaWf6JuTVvllHc9o/a1ldlQZo6KraxTtqzCZL6sab5U?=
 =?us-ascii?Q?png1529lTTamyMiSdbtYLiunRmL+E4NcyaZSTlgdVpjmtgzz/x1ITKeNkvVU?=
 =?us-ascii?Q?t0FAve0s7HVHH1aeMNfI4j1ogrVs6t8ASEXuIokwH4qE4t2CsfLSvsZAFF5A?=
 =?us-ascii?Q?Xs+fpjfZsGCDGIgYZs9Wwr095VJztdq71B4yQHykGr/+2UWxO6pdocGuM2yn?=
 =?us-ascii?Q?zpMMrfofv+jDdM4Ei39YW5CrdmtimjsWLMhIP+jcRZ1V03shU0OxhLn0/bO2?=
 =?us-ascii?Q?rwsOSvingbJn0R+CRygo5ZDyjgNHAagnt/7ZGaQkwiZolJCfEhm+?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12524bc2-6503-4fcb-cbc2-08df36978eda
X-MS-Exchange-CrossTenant-AuthSource: AMBPR04MB12445.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 15:07:47.6641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g1bXBMYkOWMavWNAb4xYAvzgsjyIfxBFLKJ/ejYCf3qv1s/fE52Q/CQ2tUfsikdY6JkXwVy6tLlAlYBEzlOKOwdo5RSSX18kGwfgXFbCfUs7LZ0otK47FiVfova3YHLc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8601

On Thu, Oct 29, 2026 at 04:29:37PM -0600, James Hilliard wrote:
> Completion detaches a descriptor from the active list under the channel
> lock, but updates its cookie later when freeing it. Termination can take
> the lock in between and complete newer descriptors. Completing the older
> cookie afterwards moves completed_cookie backwards and makes an already
> terminated transfer appear outstanding again.
>
> Complete cookies while detaching descriptors in the completion, error
> recovery and termination paths. Keep the active-before-queued ordering
> when terminating so completed_cookie advances in submission order.
> Descriptor freeing and client notification no longer update cookies.
>
> Fixes: 3bfb1d20b547 ("dmaengine: Driver for the Synopsys DesignWare DMA controller")
> Cc: stable@vger.kernel.org
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/dw/core.c | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
> index 51c5460b4670..1f7afcd01565 100644
> --- a/drivers/dma/dw/core.c
> +++ b/drivers/dma/dw/core.c
> @@ -236,18 +236,17 @@ static void dwc_dostart_first_queued(struct dw_dma_chan *dwc)
>  /*----------------------------------------------------------------------*/
>
>  static void
> -dwc_descriptor_complete(struct dw_dma_chan *dwc, struct dw_desc *desc,
> -		bool callback_required)
> +dwc_descriptor_free(struct dw_dma_chan *dwc, struct dw_desc *desc,
> +		    bool callback_required)
>  {
>  	struct dma_async_tx_descriptor	*txd = &desc->txd;
>  	struct dw_desc			*child;
>  	unsigned long			flags;
>  	struct dmaengine_desc_callback	cb;
>
> -	dev_vdbg(chan2dev(&dwc->chan), "descriptor %u complete\n", txd->cookie);
> +	dev_vdbg(chan2dev(&dwc->chan), "freeing descriptor %p\n", desc);
>
>  	spin_lock_irqsave(&dwc->lock, flags);
> -	dma_cookie_complete(txd);
>  	if (callback_required)
>  		dmaengine_desc_get_callback(txd, &cb);
>  	else
> @@ -334,12 +333,14 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
>
>  		/* Detach the completed transfer before starting queued work. */
>  		list_splice_init(&dwc->active_list, &list);
> +		list_for_each_entry(desc, &list, desc_node)
> +			dma_cookie_complete(&desc->txd);
>  		dwc_dostart_first_queued(dwc);
>  		spin_unlock_irqrestore(&dwc->lock, flags);
>
>  		list_for_each_entry_safe(desc, _desc, &list, desc_node) {
>  			list_del_init(&desc->desc_node);
> -			dwc_descriptor_complete(dwc, desc, true);
> +			dwc_descriptor_free(dwc, desc, true);
>  		}
>  		return;
>  	}
> @@ -441,10 +442,11 @@ static void dwc_handle_error(struct dw_dma *dw, struct dw_dma_chan *dwc)
>  	list_for_each_entry(child, &bad_desc->tx_list, desc_node)
>  		dwc_dump_lli(dwc, child);
>
> +	/* Pretend the descriptor completed successfully */
> +	dma_cookie_complete(&bad_desc->txd);
>  	spin_unlock_irqrestore(&dwc->lock, flags);
>
> -	/* Pretend the descriptor completed successfully */
> -	dwc_descriptor_complete(dwc, bad_desc, true);
> +	dwc_descriptor_free(dwc, bad_desc, true);
>  	return;
>
>  unlock:
> @@ -945,12 +947,16 @@ static int dwc_terminate_all(struct dma_chan *chan)
>  	/* active_list entries will end up before queued entries */
>  	list_splice_init(&dwc->queue, &list);
>  	list_splice_init(&dwc->active_list, &list);
> +	list_for_each_entry(desc, &list, desc_node)
> +		dma_cookie_complete(&desc->txd);
>
>  	spin_unlock_irqrestore(&dwc->lock, flags);
>
>  	/* Flush all pending and queued descriptors */
> -	list_for_each_entry_safe(desc, _desc, &list, desc_node)
> -		dwc_descriptor_complete(dwc, desc, false);
> +	list_for_each_entry_safe(desc, _desc, &list, desc_node) {
> +		list_del_init(&desc->desc_node);
> +		dwc_descriptor_free(dwc, desc, false);
> +	}
>
>  	return 0;
>  }
>
> --
> 2.53.0
>
