Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.35
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793118765;
	b=gqiyVx0U0v1Lz0E4bQUMmx5JPZlaTwEwm6ZjQ/m1Op3c7rz8ldge9ppCqfclMbnqas9j
	 THrxa9UT3vApthpjfpBapsI6tiAspTWEydfy944CZoVGczlsPHQ2heOk2gq6KboDt1kRI
	 mL+J9LchSlv+9oITRSf1I0DarQE4GeoUZAAnNAx5s3SsPt93/HeM6MGGh3xXAXPLwYXk1
	 yUyO8F4oRRBa2BR4A7hyFG7xj+G2+w4JKNOILLViKQEAUDVC4EhA3UmFvxn/nV4dSl9il
	 4sehiUINNZkqnLRmonk8V31emh6doYvtOCtUn/JckuS8ovrEbQXGlHrOMSN7+X6Pa2A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793118765;
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
	bh=msp/CdsNxPPQfCaPx/mtdKTHxVLf8rISD7+b75SPj4Q=;
	b=ELr7t1+muOOxVehNNmnfA3yNz4kOSWD8feyc9jcsgfGm9gL1PmlupfbGWKzpjJhv6+jX
	 N71t37SSsyVo+uSZt6WWyc79Y+8D2Kbn0x1uvUKAmOZb4LsmQMIHTWPbOecSoqk9F+YQ7
	 uxY+rBclUZBAOWGdWapT5JuVA7t1WzvhTgLs4PzqJ1JIejJ8WMKUAc3Zlm5NFH0ZH2C4x
	 7p+sMP21hyo5P28bZTEWQFtC943bHJpBLqjs/sFNBeh4/2JsrLQfnZn21dj5NPsbmj9P4
	 s1wSBubVsGx4wWbvfut93ryKV9OYuvY7dA7EHzqK7fKgaHA6ZFbWHWVyniWpGaia2lg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=QpIMNp9e;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.35
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013035.outbound.protection.outlook.com [52.101.83.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE0D606A333;
	Tue, 27 Oct 2026 16:32:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFE0D606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=QpIMNp9e
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d2bv4n5/cn8YY9sl2KwZagpxJyscbwX/YBFKHMIS2QHY4L9RUYL0XFVo6RZOR3h1jxw5KEDEd7dyNu3bVCWiXJIEgLdtxzfIHN4VN8S2JPRsjB2UlBbo0BefMtHzVe4AhoFLyDlmt1nNoKjabBeCvQvECC6wb3Ln0gKy/tIMS9ayZbenOhl/ncUbqJtoGLOR94wAXnsWswSUozOuBcMXgVm5rj7Ndv5P9Flcdr7Gi4zE5VyLj/PKMfBHDgytJV5uQ/A1t5kNgOYNumXduukv7047D7wvQQn84VGGExAjqOzpVK0jDbQI3d8KrbjYMu0jC/MX4LyNMe4bYPeQAgPSKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=msp/CdsNxPPQfCaPx/mtdKTHxVLf8rISD7+b75SPj4Q=;
 b=TsdtV2V7vqJzaommVGLP4+akdflA1xj2VyVeIWRRuW5e7ySbDpPed+SD7FKCsX5kea9nP4T1iE7eHNGLexCsBaQib0uhkxJxZw8zmvP+aOG5nlgHeoD2OsE8CxH/gOCBPK90QMwx23AFHKN3ko6HtCf7k4aClX5um4qKOAbXfoJgXD9pyknq1HuuS9PB3EHAyyoZmc/Mh35Fg3T6FltJA2InLPgVs9y2xjPd8BSLGSmOB3B6A7nSbtnqKOChHiSvnc1xXd7QgLvGgQDbdJ8K/yIay2K2NbpT8UBQPPqyh3YEXfpiKmyrUMzwgzSp+V8aP1UpiOvSX7guPM8ZsF5WNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=msp/CdsNxPPQfCaPx/mtdKTHxVLf8rISD7+b75SPj4Q=;
 b=QpIMNp9eN3yUOLLUkctxxCazB5TJw9La/hU5i/LGxxWGsVIoHjSVW6IDitdY0t0VCOt1xz85cWimr8L8P6ypjFyb1P3FnYBrSe0aEDRLskFPLUs8tOgaCZck2duWb1taIXmvpwtCj1/b+0EgZ7wi0zRapylL2nEVQpj/1nSeYdwYlcBzya1bxjXMq/wNNEz2Gy68Ac5H+R5aXl5SFrmpoYAWmjCnanKwrIimYFl8A7AxD+DXNI9+pW79y5RQxNsvM+Ke7pOr2pnyicwGiOtUIdYgsrfI5jwh8HEN82wTHHdADtABrUQFReoT4XPWmS/SRAxZC5K6RjZjdcemmraipA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by DU2PR04MB8743.eurprd04.prod.outlook.com (2603:10a6:10:2e1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 16:32:41 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 16:32:41 +0000
Date: Tue, 27 Oct 2026 12:32:33 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Sean Wang <sean.wang@mediatek.com>, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] dmaengine: mediatek: uart: make channel termination
 atomic
Message-ID: <auDSIVuE79Fl5BkM@lizhi-Precision-Tower-5810>
References: <20261022-submit-mtk-uart-dma-terminate-atomic-v1-v1-1-aa498ba5da25@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261022-submit-mtk-uart-dma-terminate-atomic-v1-v1-1-aa498ba5da25@gmail.com>
X-ClientProxiedBy: PH8P221CA0002.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:2d8::27) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|DU2PR04MB8743:EE_
X-MS-Office365-Filtering-Correlation-Id: d0d28108-5c52-4155-75b9-08df3447eb93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|19092799006|261026121527099003|56012099006|261021121427099003|11063799006|261021123027099003|261022105027099003|261009223027099003|10067099003|18002099003|22082099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	SL0iDcHYlSGlz3qTr3Q8CeH4tnrLWfFz/nZvQ8lacdnU7rCfw6Y7ILkyGM6wUUr50JOD8YOi6fcN/qbVcSjU1wal7xBAgszu2xsdRvMaP3ShYHJEpDiY4chc25llWWN5e78cZpFV4X41V/Vc2qhSICbkCw1OFm3CQVS8kl5LTXUVhtHvXT4ublJofbxpLAbg2awSJpONe8cz+2th5N0OafEUegY981jd/tYlmU73R9bD0hCn+lwnJ+yRjrKvWLqpVNXLzhED8HnQw5OwX8oWGuzMj+w2gP7k17aKTjyXTm+1crWF8OnTqdZEX0zF+YT/1VJ/rTYrCPIxqATrtNfFJD6Ysd0+k0a/zDw8tm4Xw47K1gXZR5lpzxcvt+zyJvVHwMd5Z5xw3ac3lr5sQH82YU7K+qOt0Yrwy6TyByVTtSmP0PbiOaMuP4omx5ln8oumjzQkzrR/k5mMUD3txUqPyPn0FxJkTlWxKfb8qntWwWfRP9G7e5WB4SeJtnlKfVGLBJpGpXJ81BkS7NAQ1NI8j8EvWW69Or5QBH9Ga0vbU4fDnTE/fcmDddDb6zu+J2t4mldk0XN/GrsOZIrWlcd44i5yQOOXCQYYGtAoJI/KKG3VmEsMolA9xNqhCQJecryVKNDhvtFQk2jUsPTc2Hm4xxl9Lh+3ynTdXtd7SYMcfGA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(19092799006)(261026121527099003)(56012099006)(261021121427099003)(11063799006)(261021123027099003)(261022105027099003)(261009223027099003)(10067099003)(18002099003)(22082099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZXa9UN6iGGHLkKZtCjUxeWvVbvmDumuXL9QeuanFVg7lzEsnIHTPEgm4X+O+?=
 =?us-ascii?Q?XGGUBTSgTEce9GA2pb6pIxDHAPmM9XKqAMumzF1pMTUJZokY0XDiobF/hHJ+?=
 =?us-ascii?Q?9PJKWQ3Nxv3pHbWs6mQidZsRacmbNLIfZ0veN+dOzqA7PhoF4SLSxiBwVZgp?=
 =?us-ascii?Q?3HyDIAfimM0bB8T60u3n0VRf2+Cgyd0OgD91T6Saah+7IhjtAjbYjGwKvsDg?=
 =?us-ascii?Q?wHpS0wcydFoV9utWaXao78KW/hymX877nWA6bmHoFDmMfa3zC+wv/QXdnw6U?=
 =?us-ascii?Q?m4xao9LQ1Jl/IVTfZEOVB2xOg1J60zErgiywvWPlcfD++z7B9TfBnPGCIstO?=
 =?us-ascii?Q?q/B5gCdBv+TjqlfoN//HdCBZ44aR2E9pLL2htC553kfZY/mTjyKnOx8UqQul?=
 =?us-ascii?Q?LKwUfcPiQ41kmE6BouWUujOUvaBTVWrpGciMOWEfsW1w0j3mehqVI2C5/Cgx?=
 =?us-ascii?Q?VVGr8VM5ZJK0aTRzSAYRZv8wnMvlCPaVQykkRhr4LRGcQ/BtATa2vFuN9C/i?=
 =?us-ascii?Q?opAkQZDK650hifHEOh7YqnTosZ0Lws1UB4uo8zpAoU9B54dP85Gs65xNdF6J?=
 =?us-ascii?Q?bKJtLoZ3axqsXZqNznUTfMnQolETt543RbczYVeTpIcTdy9ry+sOgoGO5ZH9?=
 =?us-ascii?Q?Mn+CnqRy32osVzg2WW0+20Wd1a9Wgx0RWJoqqu04qLMPQFaJvM/9tiLPg9Bt?=
 =?us-ascii?Q?5Ou16svygKvWD36/qtetofU1M1EWLHg2ZIxpuOsy7tXlsWopmnWqhl4bzTS/?=
 =?us-ascii?Q?qA+KjeQZoKbK4AWocFh/4xT92F6umGa4hsIQRWOFicB9VE9AeQnr44y3fJzy?=
 =?us-ascii?Q?+zCuHyXjye1ezGZY8mQWRwMVrBVXPRjzMarWGt/qjIUTe9Tr3IoHi5rx0JSB?=
 =?us-ascii?Q?8wUGe7dxsItzywmue7KPcD/WVydsRV7T03S06+fbu90gNtvZyOK9fWFrt5fa?=
 =?us-ascii?Q?whyOPbO6Z4sVFWsVmLFeXqDbCZFsc7wceo+A8KD/mICchyZMmZlVDg4XGroq?=
 =?us-ascii?Q?EM57aQGTaZs5YRpyux1offcJ1bTsGQn3rHe2CxbEP5bQ+1gcv1T2PuYCyufi?=
 =?us-ascii?Q?RbdLs0rInFwab8/uYCD7miauw6HyYaYGMzcvohfJEXb917QAeHUco+uFIbpy?=
 =?us-ascii?Q?+RY8nuBkSDL/+KxXGEpLjLZYWm5yn2c4qC8ENEwt8TM7DtHLJwD0ueM8IBT4?=
 =?us-ascii?Q?Tj3+OZQGmMAaS9YU7286EU6WqwN4bKfJ6PzDIC5mC/JXeifhkLwkwj5sqT/n?=
 =?us-ascii?Q?Q0UWDgzwCXWYCXpeiGuH1SOl/tlh2LQI9m5eaF5AgybK18Zag6HUdTljTrq2?=
 =?us-ascii?Q?chYKcp5AwR4oX3gXW4XKP2OZfUBlfyKJi4c5S//m5sq7ecZW7Lv6I+FmexEI?=
 =?us-ascii?Q?v9xigCtLk/FUnLB80duHa63QRmM9DcJe3Te+EafDN28KCOyd/cDgFgu/NzQQ?=
 =?us-ascii?Q?+AXUCt8SLWQoECmMIwB1Ny6y2pdorlwrRo6IHHXWyEX3lGCbTMdpHyefOraJ?=
 =?us-ascii?Q?mfPLH+UfemGlfSWfXQP0jUef57QPP3GSaDRKElglHHMO6ArdTpdstAQhcjnt?=
 =?us-ascii?Q?6bOxgmAMXKTvgobaJ4fBtMT2BVToLjhO0FLFjbabcupfHWgsUuE+WlWmk2ZM?=
 =?us-ascii?Q?HDdcIXT6r6LNHQ0K+BZ5igblwqmZq4O78FZZphqUiUbfVCo2JeabK2EbIaGT?=
 =?us-ascii?Q?PFOVlQfvPPl9oD5HgUYAw1EWixcW9o69pclxkpUzzgKfr9WFlcDdoDhlysDm?=
 =?us-ascii?Q?W/fbARG8Wz3USlRTMK4pVsajiurC98Ne7JA8czYq5EHcVnvD623d?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0d28108-5c52-4155-75b9-08df3447eb93
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 16:32:41.0114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VVZe6KKEPIZeqVnuGgubMAQ+RCknNPpXK1u+mVJTBAhjAiAvm06S+HF+q2Oo7SDdMiVD4RKp4aueLYblDfZeXXYi65R4WUmJ67HFEyViY9vdpnYN7T1bWu67RHa6p0oA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8743

On Thu, Oct 22, 2026 at 03:18:26PM -0600, James Hilliard wrote:
> The 8250 transmit flush path calls dmaengine_terminate_async() with the
> UART port spinlock held and interrupts disabled. UART APDMA termination
> uses sleeping register polls and synchronize_irq(), which can also wait for
> a threaded handler or for an interrupt pending on the calling CPU.
>
> Serialize the stop sequence with the interrupt handler using the virtual
> channel lock and use atomic register polling. A handler that was waiting
> for that lock must check interrupt status before accessing a descriptor:
> termination may already have masked and acknowledged its interrupt. This
> allows termination to retire descriptors without waiting for the handler.
>
> If the channel does not stop, return the timeout and retain its descriptors
> instead of freeing state still owned by the transfer. Continue attempting
> STOP after a flush timeout, since stopping the channel is sufficient for
> termination even when the flush could not finish.
>
> Fixes: 9135408c3ace ("dmaengine: mediatek: Add MediaTek UART APDMA support")
> Cc: stable@vger.kernel.org
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/mediatek/mtk-uart-apdma.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/dma/mediatek/mtk-uart-apdma.c b/drivers/dma/mediatek/mtk-uart-apdma.c
> index f74e9a328588..73d4b701ac85 100644
> --- a/drivers/dma/mediatek/mtk-uart-apdma.c
> +++ b/drivers/dma/mediatek/mtk-uart-apdma.c
> @@ -256,6 +256,12 @@ static irqreturn_t mtk_uart_apdma_irq_handler(int irq, void *dev_id)
>  	unsigned long flags;
>
>  	spin_lock_irqsave(&c->vc.lock, flags);
> +	/* Termination may have acknowledged an interrupt before we got the lock. */
> +	if (!mtk_uart_apdma_read(c, VFF_INT_FLAG)) {
> +		spin_unlock_irqrestore(&c->vc.lock, flags);
> +		return IRQ_NONE;
> +	}
> +
>  	if (c->dir == DMA_DEV_TO_MEM)
>  		mtk_uart_apdma_rx_handler(c);
>  	else if (c->dir == DMA_MEM_TO_DEV)
> @@ -400,10 +406,12 @@ static int mtk_uart_apdma_terminate_all(struct dma_chan *chan)
>  	LIST_HEAD(head);
>  	int ret;
>
> +	spin_lock_irqsave(&c->vc.lock, flags);
> +
>  	mtk_uart_apdma_write(c, VFF_FLUSH, VFF_FLUSH_B);
>
> -	ret = readx_poll_timeout(readl, c->base + VFF_FLUSH,
> -			  status, status != VFF_FLUSH_B, 10, 100);
> +	ret = readx_poll_timeout_atomic(readl, c->base + VFF_FLUSH,
> +					status, status != VFF_FLUSH_B, 10, 100);
>  	if (ret)
>  		dev_err(c->vc.chan.device->dev, "flush: fail, status=0x%x\n",
>  			mtk_uart_apdma_read(c, VFF_DEBUG_STATUS));
> @@ -415,11 +423,14 @@ static int mtk_uart_apdma_terminate_all(struct dma_chan *chan)
>  	 * 3. set stop as 0
>  	 *
>  	mtk_uart_apdma_write(c, VFF_STOP, VFF_STOP_B);
> -	ret = readx_poll_timeout(readl, c->base + VFF_EN,
> -			  status, !status, 10, 100);
> -	if (ret)
> +	ret = readx_poll_timeout_atomic(readl, c->base + VFF_EN,
> +					status, !status, 10, 100);
> +	if (ret) {
>  		dev_err(c->vc.chan.device->dev, "stop: fail, status=0x%x\n",
>  			mtk_uart_apdma_read(c, VFF_DEBUG_STATUS));
> +		spin_unlock_irqrestore(&c->vc.lock, flags);
> +		return ret;
> +	}
>
>  	mtk_uart_apdma_write(c, VFF_STOP, VFF_STOP_CLR_B);
>  	mtk_uart_apdma_write(c, VFF_INT_EN, VFF_INT_EN_CLR_B);
> @@ -429,9 +440,6 @@ static int mtk_uart_apdma_terminate_all(struct dma_chan *chan)
>  	else if (c->dir == DMA_MEM_TO_DEV)
>  		mtk_uart_apdma_write(c, VFF_INT_FLAG, VFF_TX_INT_CLR_B);
>
> -	synchronize_irq(c->irq);
> -
> -	spin_lock_irqsave(&c->vc.lock, flags);
>  	vchan_get_all_descriptors(&c->vc, &head);
>  	spin_unlock_irqrestore(&c->vc.lock, flags);
>
>
> ---
> base-commit: 93f51579e7df248780214094418f205253383cc5
> change-id: 20261022-submit-mtk-uart-dma-terminate-atomic-v1-19693366ae4c
>
> Best regards,
> --
> James Hilliard <james.hilliard1@gmail.com>
>
