Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.40
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795020660;
	b=g/2XGrYiRas/0/NyGlym2LYAAm09wdSHVASP+OsxUUgCIDCa4wlI7xZmuLMZ3sO2Dd6u
	 8Ut7VR1HaIKGDpsriAWYRW7fhrqi3cjHU4xuTWIP7BYW2DcBPlZ2wwc0Cxl/cknEYdzeU
	 pNTjMirlrtciUM65J+OOhvU1WIycblxheDD8/+nLIAXD08SELGnb5wsObXRZDFaYcRV73
	 xiYjphHRRjOjIK3FpzUZQmOs7FnRJ+cIYWMjpKzjN5+Ce6q5FeTzdkhJ7OzUh7NR1UbGK
	 cIYsaufDhNXR7Llg1koqT87LlVijTuUrJ2qEr6X+I4CSYD2QZfI7vUQIWYpp5KUK8Hw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795020660;
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
	bh=92TpG9zCctCFOKtwCwkzxzAcEQrp0TzWGaoalUkdx9I=;
	b=bfIGiQBKU0hag7jbztuizjeJBxxDyEfpIhb5SQQ2e/wH8npPD/LqUrGUxX6vIvcPfVpv
	 0gVpDJ2f7Z9wEfvPN3g/irRnhPdFW/sJ4ll046PFDG3L0Mk73aelQ6Xpy7qhB2qZwv1Er
	 56NFL8tEI/zdNYbItQipSj/60LxHUDCEBHxDcy4NqO0vXQLuKP4zemDSQyDEJY4xpncGQ
	 lUGmH7eBmf9WgBayFqefgPC4rv2+KMP9WKcpJDPTTSm94vWpe4N8jThUmoXDfJcJqbgy4
	 ec7ONfqWPeRdGmRnXksuyl67IwlukUqNKVzARwnoRkgZDsmYbpvaxQPDTsPjYWFgklA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Bx3vhv89;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.40
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011040.outbound.protection.outlook.com [52.101.70.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07402606A31C;
	Wed, 18 Nov 2026 16:50:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07402606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Bx3vhv89
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bKLV0l6zWz1E+wZzOmRrrPZTfR3EAS8q6X0yZsV+MfY5q4kFKJO6OaYZkUjZn0+9vCpZeAw+I2CtTYJ8yDkKNCo5IZtVMB06v3B/uLAAPFAZWV7+IGIba5u9S7xYJ/e0P7Lq1tUxVXxx1zY/vStkCRp7E7hCRTV0g4C6pqUwIcHkPNHZYBXereWAzXigKLjtIx1l4RfZqqfbUpOSEwz9cDRi1xkMN+7vq9xHXGnGiL7WotmoH/eBKW/pJU752TfBwUWijbP6P8bFLHBhREIdv8lqaFJ7ByXI/NzA0C/UcFeDfCLLLl+KQDSV+iUXhfHCFX/r+zs/IyvCS3a6eIiIRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=92TpG9zCctCFOKtwCwkzxzAcEQrp0TzWGaoalUkdx9I=;
 b=D4LyB4vw2FxFMleRUJ3Ftw3ZttIp/2ptCcsVFX1se9pThPJvmIFRjTSGjjBumbT2EtDSw8vl7PsM3NZpPl395ueTWw6EaQFPS02ZxKxzLC6KicoYUbQPtDvQk0KVv8fWsSHWLHfOSWCjHXqU4FgDjzyiWtKXj2DaNflPCXMmqp6yI5DwNyATwDw/fU/cfd22MNA2YoA/nK5OVkFDOIIayxuyCP6cKQXmKewrh+z+kVe034ygz2fs/XTjSS3SCjm+UdaAL9zSoODyC2fLrW5r4Mkg/+CThumhCiAjNiA0zaNtA8lLK3yBiFKSdzJ1euafFV17WLhZLTY2+lvihKizKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=92TpG9zCctCFOKtwCwkzxzAcEQrp0TzWGaoalUkdx9I=;
 b=Bx3vhv89utapKlu4BYn4gZuDQREjVlF/F552ASBoBCfRrArj2xu+jBjP7SVmRE41tZO6nZM4Fg8ZXX2nO9fS/UPlkoxxIPJ1Sa0TdSDLIlqJSSsEh/Q72vCKELSUgLGC0k+t0jc+IdDKKgLTwMa6vrzo1jJPSkHoi3yCTmiMFqUrXWxqLc6LAbu8C1Zc0/Cq2sHyejKP2ZnQfPCo2A3WEBQPWX1XSPoOsmwzmm+ychVEaKaVqVwBu0/sHdtb6tjh7WsAOWcrr5wDbkKmk9n80G5WAkfaAxMr5UF8s52giSJcq/1wcTmFB0dfjimq1vv1kXyKTlx8N9/rVCzFhQzsog==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by AM9PR04MB7601.eurprd04.prod.outlook.com (2603:10a6:20b:285::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 16:50:57 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 16:50:57 +0000
Date: Wed, 18 Nov 2026 10:50:48 -0600
From: Frank Li <Frank.li@oss.nxp.com>
To: Ziheng Wei <zihengw03@163.com>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] dmaengine: at_xdmac: handle empty transfer list in
 tx_status
Message-ID: <av3XaJkZzWxvxFZ5@SMW015318>
References: <20261115080245.910534-1-zihengw03@163.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261115080245.910534-1-zihengw03@163.com>
X-ClientProxiedBy: PH8PR21CA0023.namprd21.prod.outlook.com
 (2603:10b6:510:2ce::20) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|AM9PR04MB7601:EE_
X-MS-Office365-Filtering-Correlation-Id: 00232c0f-4e79-4a28-d76f-08df45941dc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|19092799006|23010399003|366016|6133799003|22082099003|18002099003|261009223027099003|56012099006|11063799006|261026121527099003|261102123227099003|5023799004|261028144727099003|261026140227099003|261021121427099003|261022105027099003|261021123027099003|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	bZ6jDd0NHjRV1pCWL0oMMTYQsf3hUrVYAIlPIlcR8MBIyUrYLQ92AIi0PAwqK2API+7qPJ+frzb49jpHLHSn5f6le/0jM0N/YFiCJz4hETlB65WW5jIzBkb4hIfSgOVmTeT9UkRhZTkV45ka+ZhvuU5Dk6eOHFMoEVpNP+I53VxlMixyFqSH+/xs0+fnOgtPJArDgkXhZE04rhmIq9tOsNcZt8PTx9sdRGnrgSb+5Lib9iYOIGJEeGOpWcZ5GSSeMQxgPMe56x8PoJLVzSilze+YahyKMuOzbhuVnjcGW2ybo9zS/JRs1qWM6xvW2XdAI7vPa/FcCN6bvE9+neFo+jUamKJSjeG7I/S4UBb40Om+oV6HyTnNUcrMP/XchgZuFbOlvxSPk9Saxz2L81ZsCi22+qpQZXiQUsnV8NhCmeMH6Jw0RZ/1iDOFuSn2KjIu5RQlyABzW/qNtExCxCEDupo9QuGx8+iZDGncDpp3opgVmeRHLqaKsIaXcb5eHUwjKraieZ/83/IythpkWvO12gwc0q4VeRLGsFDGmt4FT/xpFawuB4rMBSRraKYIHLoO3AwlixMJivGW/NQucXYIZ/NBtzCC+sU4EI0yeCcy7R0S7yJqM2aNlLOL8b83s3EgY/CFb/AHZ0eiS+jzWMJofmASaO3qRXSKWuHafnzeP8E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(19092799006)(23010399003)(366016)(6133799003)(22082099003)(18002099003)(261009223027099003)(56012099006)(11063799006)(261026121527099003)(261102123227099003)(5023799004)(261028144727099003)(261026140227099003)(261021121427099003)(261022105027099003)(261021123027099003)(261022075727099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vj44smUUTQk5PMfn7Q7TemJjydFcGQCz+AspLCMyWGaLN8nvuQh+tqbA4DU7?=
 =?us-ascii?Q?jLhxXkzlZScGRUeGJozv7em2HKuXcT1j0hrf3y9yQqBcRsLZhUyf6fHZevQY?=
 =?us-ascii?Q?dICtFN1iHrLGtE9D72z+6nHcJ7paCCpbtiWR2XK5RWSavW3rV5c/zsfIm1Z+?=
 =?us-ascii?Q?IV850xj/aZ1aFvtvKV8LCjk8Z5f0dNeVObnfa1Njon7hD/zEged+MPa3FDUg?=
 =?us-ascii?Q?93HgOmhoQJrsc58cBL5xzxvw7o+hqHwnnROvtpU/wRYSevbG6Usb9m81K5hY?=
 =?us-ascii?Q?04phPfrlZqN+/oSEGFnZbsBbq5rjTJV8P4lS9aHWEz2PSREP0DliXt6HDjaF?=
 =?us-ascii?Q?OH541zDJXW9JT1D94wik7ns2x9F8pFFsar7b540ji0VGx/Lv1Lv1PrIpb8IE?=
 =?us-ascii?Q?yez827umAI9jO4wpmxi4rEP2zBRhelb5LWZ2fQoIdd9lGSMTLPYJQCsom1gJ?=
 =?us-ascii?Q?toAY7LE1F/EEP8ocR/XapXUAmLLVpuasvgtkDaW7QN/764rItlNfE2vxJqfC?=
 =?us-ascii?Q?fmaEpb80GZ9BfVcOGaieoPRzmeGHR5MoI0JWyCcJhG8xEPdl4PbIRd9bJ+8T?=
 =?us-ascii?Q?EvO99GDkV8lOgvfLHn2VDpF52pJp0RIrptKgA02RQm7QZ2IS6G+k++3QjxS/?=
 =?us-ascii?Q?sUypoHx8hRokOi4wmhwcYwiHGOagVlOVkgdUBJA548o7p4HTxDqaJX5ZkXHo?=
 =?us-ascii?Q?Yxf9YNzsWRX4wRIIbdX7dubO09M7hPHVxmJTQgUGJaWMk6qMO5nIhJeOCvF5?=
 =?us-ascii?Q?MPazm+EZacV9FadXGS/4UPzuJH+dDFUTbN1ASsbG8XmhFziLvU7CbwDmutBi?=
 =?us-ascii?Q?FamrY0/1zm/WNMYl3jXa6iGrOBuVSnngK3OF8Syqr0xeQB+EW4mZ3QGg9mf0?=
 =?us-ascii?Q?Eti/xjHEXQ4n2n6rnWdByxWm+hoZ7tCo4UiRp3EBe/JEvtUUFAAxxPgvNNiA?=
 =?us-ascii?Q?fGGw5KlNvGTY5FhBjQGsNpTXk4jQ/j/rZ/4BvdeKfj4CPWSv9+WVkBnWddf2?=
 =?us-ascii?Q?IIc8SYmZqFGnRZk6xjJIHPOAlsrwNADFprYWv1DzXyaCtN6ZO7h/97XSAURE?=
 =?us-ascii?Q?kgrSI1Xh891ph5wkQUlJ2x5/fnJ/kx9/NGaoq3uqWdcY8ORu2VV/FBRwyjpg?=
 =?us-ascii?Q?xKPzeaJFVVMEA8jagk2R7ndoqSsdMKoeVLH/zxrukQUzn6Q0w5wy5H7EY5ss?=
 =?us-ascii?Q?3R8WrViWfDYJwYDMHhx1s+FSe84wrIGuBwkFuPsWMAZEDE0yALuLIS1MfEtW?=
 =?us-ascii?Q?fRwVOmFWuyxt4mAeRQtgp0sGb1IQk0YPUWQqECzCidntGl9DrVdQl7adW/03?=
 =?us-ascii?Q?eh6IQ+PFwA7exRoOYN/9FNbN39QpR+dIfPTVGx21rzUqT24tWX5D/oKuI3nG?=
 =?us-ascii?Q?CourBtNEOSGbQb3EBGqQs45W1lObjGXzqhVW4XD894L8SbsSApHnAU1RJkyY?=
 =?us-ascii?Q?iFls3hTwTpcH4p+hd6IUvoJNcGY+ANcuB5PfbbJzzUHby3fgpih7Fn/jXIMl?=
 =?us-ascii?Q?yxC0QKmENx3beYf5JFIYZpl/SFNqvAI/JuliL0VHs00fppay2RrXQNo1pjsi?=
 =?us-ascii?Q?/8TUjv53wu0EeAToAalEvpxCP63CEnUswV9sa/GBgYaCOc3Q96pisYm86jzz?=
 =?us-ascii?Q?sZ22TXCJzCjPX0b5CjxvfJKJdt+vucVUD0KyLY8KU0cPP9nw2yq3wmCOCrjN?=
 =?us-ascii?Q?tTFegIGtJHVGcHr/NOQ7TBM0ymbsHuZ6qCNL2/hj6OHGArmmJYJU32jKhMaf?=
 =?us-ascii?Q?65L4V7k9oFXt4BcHJX7ZmqMbuZQuFoJzIDl7rmdERQ1Ubu7RG5mm?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00232c0f-4e79-4a28-d76f-08df45941dc8
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 16:50:56.9137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EE8suSeF/0MBlNuyUwYryKomQKWaE5yZJhgQK5yfhnLtjwtXQJKdVOL/NgxZnYeOJJyueUbMapgn82mTan6FuqMlVecXfS7Xk5ULILENa1QBAFZmUNbQeSqDFxseINSo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7601

On Sun, Nov 15, 2026 at 04:02:45PM +0800, Ziheng Wei wrote:
> [You don't often get email from zihengw03@163.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> at_xdmac_device_terminate_all() removes every descriptor from
> atchan->xfers_list without completing their cookies, so
> dma_cookie_status() keeps reporting a terminated cookie as
> DMA_IN_PROGRESS. at_xdmac_tx_status() then calls list_first_entry()
> on the empty list and uses the list head, which lives inside struct
> at_xdmac_chan, as a descriptor: active_xfer and xfer_size are read
> from neighbouring channel fields, and if active_xfer happens to be
> non-zero the residue loop walks a descs_list made of those fields.
>
> For audio this is a routine path. The generic dmaengine PCM calls
> dmaengine_terminate_async() on TRIGGER_STOP and later
> dmaengine_tx_status() on the same cookie from
> snd_dmaengine_pcm_sync_stop() and on close. What happens depends on
> the struct layout. On a 32-bit build active_xfer overlays
> sconfig.device_fc, which is normally false, so only a bogus residue
> is reported. With CONFIG_DEBUG_SPINLOCK the larger spinlock_t puts
> active_xfer on the held lock word and descs_list on the owner_cpu and
> owner fields, so the loop follows a pointer that is not a descriptor.
>
> Report a residue of 0 when no descriptor is queued.
>
> Found by LLM-assisted source review. Not tested on hardware; the
> layout analysis above is from reading the code only.
>
> Fixes: e1f7c9eee707 ("dmaengine: at_xdmac: creation of the atmel eXtended DMA Controller driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ziheng Wei <zihengw03@163.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> Notes:
>     The changelog was drafted with an AI assistant from my analysis;
>     I have reviewed the code, the fix and the text.
>
>  drivers/dma/at_xdmac.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
> index ef0dfe9d3..bcfbb41ea 100644
> --- a/drivers/dma/at_xdmac.c
> +++ b/drivers/dma/at_xdmac.c
> @@ -1553,7 +1553,16 @@ at_xdmac_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
>
>         spin_lock_irqsave(&atchan->lock, flags);
>
> -       desc = list_first_entry(&atchan->xfers_list, struct at_xdmac_desc, xfer_node);
> +       desc = list_first_entry_or_null(&atchan->xfers_list, struct at_xdmac_desc,
> +                                       xfer_node);
> +       /*
> +        * The list is empty once the channel has been terminated, while the
> +        * cookie of the terminated transfer is still reported as in progress.
> +        */
> +       if (!desc) {
> +               dma_set_residue(txstate, 0);
> +               goto spin_unlock;
> +       }
>
>         /*
>          * If the transfer has not been started yet, don't need to compute the
>
> base-commit: 97d73c8251226cf27cc6656b4c542869bb8c69fa
> --
> 2.43.0
>
