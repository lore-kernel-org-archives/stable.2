Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.66
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795105043;
	b=LX7Pr5v723rv6EALF98ScxnnxdCpKMqFMf4SnoHLM86yK8e6hHlBkvSuDTgUzht5elwJ
	 TuY3zI8ZoB1Z8Qrka9K/zsN0978cE/MMhEZNqP67Xga0M8Zc/RJwY+s0au4MidWrQNimg
	 FU9oP7YNhQ+cDFjOcbGD/Ui5tpS9bZhZSzVx15hYPFj6lgnqZWj8u6PoCwdjPtVPA5j/Q
	 M3zcLgEt6Dq/rsGvdNpV0lpTpib7LOly3eCU3HcHdn3/1bNAuLBEsVZVWRMSNQEB+EzE3
	 LeWGl+PH96ouY7LBKJByhCGZqxxak8lEseIpIm8UxHgTNmVzr6NEKu/TWhGB6vZ1mKQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795105043;
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
	bh=SGnNIi7HbuyKar8WXCDM9qg+7uUW+UVdZfkNAbQTPZU=;
	b=JB8ahefgUAjtU0Rc+Zyrfv1f2S4d+jE6u3AAAJj42WFM3jcGSnUPOza+JqZZkj9RXcZA
	 h9fb1h/EEt0PA2pagPdsLfRpYQtprnTKx7EgrFZIkrDlSoZ2h8tcNHiMVmWfTimalbz0G
	 wqeWs/fK0pl/55IniwIxQc4Pmvz06va3Pw22VG6wQ3jI+ynu2auB6qX/ND84gXgQSUy52
	 sihNcTr+zgFk2OD9v98mbsH/gCAZKuAwjKb4bBil1QXzKpKtZl9bsVvOG8K8zikTWVp6f
	 2Bq/KCc9h1ttWWc4+XOWNp3JtJ8aQTt5aDitZQNpdqaW4VIO4oq2HEywmgVgWb5y52w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=UGONzjZV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.66
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011066.outbound.protection.outlook.com [40.107.130.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6A5606A320;
	Thu, 19 Nov 2026 16:17:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC6A5606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=UGONzjZV
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ar79nBpgKsOcwZoAOItzvivxG5WOZVVQgAqTB+GzXs1u1YKMzv/sUwvmfZ/C3PFZUFepjbOZhBGa9S76yxATTQUWsI84qzRZRbillEbT/1PJhRT6+0z7iFOhaNpxGzv6W9arYLOa41ATkZcAYK9fFLQEE/Y633E62xAvYBBBtL40WWa2xRoNPEPyE/kD5h5lHkEhO67GtOXiG9d+11XRaDPAo9Sqe7UyRFR8521DcoSkewt3hxB1NEt7VXCB26ULzGyec6MWrkzGR9/uDM0KeaxwWVzGV50RT3Sc8G0gt7dCTnPz8BMHQy6GHvkAgc1oLLnWcAk5j+RDKkthuXWPAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SGnNIi7HbuyKar8WXCDM9qg+7uUW+UVdZfkNAbQTPZU=;
 b=XX0+c/NaJG2YM1FQuJ3Sp8CI0wxYvxccDQ/S3n/HRokryeQLzhTEuHxCP/OBfghdshOXfDDLuvq3qmvkzqXoucwD5S3mDG9XNtmlhKupVs++gRrEB4S1DjouwpYF1yndyO/vXtcyVrKfekyjmitN3ehKGhChj41Q4Uh47rp7F8yzgNoQY9KdRHSV8wEsOQjWBfJMCTVITv3zTQLKFz4Ciq8/CV6hB7DM9OtmzyBIY2pOv8M4iyAN3Va9csKX69y8fazem/jN9k31NmuOV0CelvY9yQRUpJ0R/m876DkPek25fCQs7E91vtmL88kv+siYVCnQpLgm/bRfzaaNEATELA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SGnNIi7HbuyKar8WXCDM9qg+7uUW+UVdZfkNAbQTPZU=;
 b=UGONzjZVAqyoHMW3HXD0J+kPSMSTZ5GqeU4zVMEEyp7cHKLju2V7a3sEzOHVrDe0H6C3B8Dbq8yHPGgZdmjWF4pyAgTAZZYisFh6E8xsU8toJoPiwLyk7SpIiBFHctM2eCNQ8iTdZeew7TfDMTy8U3CSojbaZmBCtmZE8Eg6e1IeBs6ObbNiAQyHJ/jzKWDLQIQa7QdDuvk2dAhKbfwvu5pVKbo9N9+KoBpV6WexAijFVE8Hbv4xYaswj47xkHGsr1u16M0z8RatlmKYMFH20UzoaWKNEQwilbj2wYZGv91XLqu0rPiR9OnbYE7SurMDFH3k97o2EZV6hhTkcTinBg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by PAXPR04MB9231.eurprd04.prod.outlook.com (2603:10a6:102:2bb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 16:17:16 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0639.010; Thu, 19 Nov 2026
 16:17:16 +0000
Date: Thu, 19 Nov 2026 10:17:07 -0600
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
Subject: Re: [PATCH v8 2/9] dmaengine: dw-axi-dmac: poll the correct enable
 bit during termination
Message-ID: <av8hAwftf06wtsE_@SMW015318>
References: <20261119-submit-dw-axi-dma-stop-pause-v1-v8-0-f8e7fe60594c@gmail.com>
 <20261119-submit-dw-axi-dma-stop-pause-v1-v8-2-f8e7fe60594c@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261119-submit-dw-axi-dma-stop-pause-v1-v8-2-f8e7fe60594c@gmail.com>
X-ClientProxiedBy: PH7PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:510:339::14) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: cc0779d5-6c34-4f05-f040-08df465893e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|1800799024|376014|19092799006|23010399003|11063799006|10067099003|56012099006|4143699003|261026140227099003|261028144727099003|261021121427099003|261026121527099003|261022105027099003|261021123027099003|261102123227099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ZjjrITdiyWBDyXOK+3B83iBh9YWADIrcfGT3E8OKi/99LiXE2kn2r96S1JRIoOH0UA3NapjpyhyFaLr6FI4AAinFlZCc9eS6dcFDJDlP3sADMKFfzkMio4WTBkcETIFOU1E5Ihhoef44hb1mb8PWbDZ+ARtt+O1n1b+ONQUsNyX0jZHjAp0DYUuLrToH9TlKWQiAiNKpfSXyq+2KNKbcOTkQn46Lo38Lbybhr+XU4ZnRhCACJWftaKZOvr8lIAVdnKl18TvMjT6dFnWBKLdBDqokdrVjOrsAgZStVnDQi8qL37HIeresIBeobdvFvP+AnNiPlzO+fe4Hh9vFlLclrM+/4OOGbSPKuxK7uLMKO254CnciPsamp7u2H4cTdQpoC1YX46Cx00ZqbmSGpu0HlrsdhtJSGoSROmdYVoBUuiupb/j98nyRnG2EbAM7TdETHmHAm3+P5GaS2AgIEu0XBqpEQtu/1Akw3SzXnhTnqkn+tUW67tIcLN0NK70upcZlngkxEEPtvhA14n6TF8EuFYYu09MB0sHln4nShERUKMZQGIYJhZ61SAsT6cO+iGL/yGuSjkSjiUi0A2yp4i5K+XTszN1Bf/gkzUOCZIYIDQGbn9jInfZdNLpZR+Hv2zCOIJz4WfrX5BYH/7LTtG12WREic/26PJs7WAif7CeqEXA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(19092799006)(23010399003)(11063799006)(10067099003)(56012099006)(4143699003)(261026140227099003)(261028144727099003)(261021121427099003)(261026121527099003)(261022105027099003)(261021123027099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q6H5UtNRKJ4bvhEa82o8NOq+ME0qrUSdVrARhrxSwlJs3JLKm9tGEFAk1i2s?=
 =?us-ascii?Q?SwelgzsdnJ936rJ9mcxVv2dZpnzSrtAMUtiHp67dWYjXBk7N+YjuCGyAdR1F?=
 =?us-ascii?Q?j5uKAfgQQBJNuONxOXFt4ZDJsRRVasmC/2BbXMOunrnhKhQnVL88tYQVrbK6?=
 =?us-ascii?Q?mHXO63ViEALLFWIrp8uCyD9I05Ixt6uqPt1hSWkmKJibX/pr5OMoJv+GCupz?=
 =?us-ascii?Q?db//beZI7pKXTMkjqzflLiwxEi82f5xXVakA3wK2YnLHl8+M9rwjm7p5brd4?=
 =?us-ascii?Q?cZ7hJXFcglK9uWyCTue8kdJlHbmf8C++8VMM8a9nT8eeJbnezGnQgT/oeODa?=
 =?us-ascii?Q?mT59L7C0Ag71A9WJxjoFsdxTp/Ru1SbyBXUStuNqMENHapmLxr0nk/YjnZYC?=
 =?us-ascii?Q?oWSgiyzIR1EUc50D+F5+545IS7aAHXrRBxDna90LvhatY5Yarqc1vX1SMluT?=
 =?us-ascii?Q?uSQBd1NHdQC85y25yJKsubW9OuI4xMiL8etbbneWTrLnCtgFJX185apzcsiW?=
 =?us-ascii?Q?CN1JlKxJBOjwRhwTIj8uo+QNqUM8ULw4yiFFtamNHUgun5rYfl07LH9hdZVs?=
 =?us-ascii?Q?t6LoTP+e/67tvnKSR08MKmGjorg+YGo3v8i8YY3IEIx+ZiP1pjCV2e1Bf4uC?=
 =?us-ascii?Q?qCUKUG8SJglqcD0hbfhRcvyzQyeMt1AsK9vVPYcy1StFtI/H2iakTKGC+aHp?=
 =?us-ascii?Q?WoeC2SuRAkcxsS/Rii3YX1zlPnTlj0waMWrgZkB4lpguTjDnxtdzUWt5Dyep?=
 =?us-ascii?Q?N5s9mguVf8W0uKpKVk37VOYNEcJR+z8ejbnyLm+ezqhSFbF/q6B8jj7IPCM4?=
 =?us-ascii?Q?SVsMwpOh+NRNttWFQCJwzrEVS3b6+Y3s6EZ0GxPHE4vRkU4VH3rcJAnjiFrr?=
 =?us-ascii?Q?wbg0EznXiqvSJCj8U1uPUVngPSvX0nM5QQscNIfZxs17h+WHT5bpQzHiN4UZ?=
 =?us-ascii?Q?kE8P+NXzQWec/qMjAeCIjAqi8MP+wtw5ZOo7yEaTnpiLTE63wdPAriF5D/4B?=
 =?us-ascii?Q?/vbJJnmY/O5dGNG//wr7X/k6LrgxQtQ6DLf2Ikw3m+MOSN8EPvm4A5KLoEGr?=
 =?us-ascii?Q?Jb7SEomR+T9IZrtjH8/QYg9sCEC0/N3KK1Wmji4jrN4WXZvwc17M+abtRd7R?=
 =?us-ascii?Q?BN0BhPAitUI8J39jzp5Aw0scxCeAu1g/AEXLLEx94LXoAArrAv0in1rrmbnq?=
 =?us-ascii?Q?HhaZtc48dnBAFbPckk5AWjUG/HK5qfY9mjzw21JsRX0cyxg/aFKt921KA5QC?=
 =?us-ascii?Q?hTY/A+xW0yh3YxGqB5o/Sb69p4eWu5/5Kxpdvv/4Xd0zSUxm55qSuU5m6/ky?=
 =?us-ascii?Q?zcKMPysa08cbVtVkYj6zyehL8QBXf38BdLPzTzODJCI9/OyHtFPeosvdoKzA?=
 =?us-ascii?Q?ghYQHXajHQI9zK354N7n7ae+6BEc06Fam7tPSXxaBG4fM/yl3DtxqtNaP2xt?=
 =?us-ascii?Q?zEufauD3CXMq0ggTP0zFe5cQlUxhJO64qO91d+NnK7HpNGBtXQPYGNj6bEno?=
 =?us-ascii?Q?QgpFstCOSWrHQF2SCHSk4m7mKjxS0VjOft2GSA7qtM+eY+VsErWNNpbE2n/g?=
 =?us-ascii?Q?DXfR2sTJW9GpqV6/qTTLwAP+r1pOu0dj16zMNTQrFL2lYH2p7NtITi81McI2?=
 =?us-ascii?Q?XxXmqU9qhVd+fTvSegRbpceVm4BHnJo4aySBKi/AebcKfO501RsZ7Y11xz9Y?=
 =?us-ascii?Q?w0DKqZJlmXa4OdxgXFQ4y8OFLt4P0NbftUOKzQF3nQ8bkiKsx0+XE6DLKOAV?=
 =?us-ascii?Q?CcUezTo9DIko7eLrsf/SvfMKE0ByAe6X4hPPylzHTNEReadgSgMg?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc0779d5-6c34-4f05-f040-08df465893e5
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 16:17:16.4390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sNYQYFYRPYD9AhClH4hWKDPVar8lj1pn9zGt+UZoj38gEAdJmHSMfZvASSjVmETLDuZ57Qbz3ZyArbz1JElWHTs5mprLYEJpF+/+VkyrDk2Qg77ZvQKpcu8TRqgljTCQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9231

On Thu, Nov 19, 2026 at 09:00:57AM -0700, James Hilliard wrote:
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

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> index 6dae63024721..f17a71183050 100644
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
> +	ret = read_poll_timeout_atomic(axi_chan_is_hw_enable, enabled, !enabled,
> +				       1 * USEC_PER_MSEC, 50 * USEC_PER_MSEC,
> +				       false, chan);
> +	if (ret)
>  		dev_warn(dmaengine_chan_dev(dchan),
>  			 "%s failed to stop\n", axi_chan_name(chan));
>
>
> --
> 2.53.0
>
