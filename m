Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794322288;
	b=14NVPZklRv4XCwk3XvPXMEE+Hq8zwc+0oIif6Zx1khLdeMk2C/EUaXWZ+YIm9qFt7aGP
	 p3HTPLa//cI90TSlBvbWd6XOHPDe5N4YdWgM1bmBJygLtgakSn4sri+3Tz+PvQ7Y9ftCI
	 a1xjENsmDWot2HH2j8LQy2T/lkaA5HHBJjSwF9sQ5xkwWUzFNrKRqU6zgM3rZ/i1rcJx7
	 pPotvz56EV3xZ3OaEm6neruueIOmDhaHY4DNwOdn/KllUPC2VdRkQTHoOITNPWXya+y/v
	 adSAVNnQ7xM+dZFmLoLOgL37SZ3zC246o93TyvGnEPJiEJZG5nPjDjhqcDcPLmKVQpw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794322288;
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
	bh=Kb5aicXyT77g91zh2e/TNNya6++eMCKke5qDKuNWIxA=;
	b=PWWsseXZloZDnLfYrdgIRdZpEBTmBXQDUXcsJD9X7lalwCM4cwBi5JqkL4Wi4DGLaafJ
	 42PrgkEyyGtTWaFyK9lLwFviDGNovx0C0cR1DltEYRLC5DnRmVGaEpmhxIg1UC/2cbW1B
	 DnV9ZpspmKcjWkNIM5rtnlEqegmmN0/PI1UW49WrQ1Yoa9vMI0NaQ9aw+vKzgASdT3FF8
	 johT1NtNi5JzHiA2LMQuoqLqDFHHXHYAEfHY7TEMo4V3rDiccDRZN2a/nZgG5W2xvdZeJ
	 WqIY/7tcspyl23aShDlI54IZ7KO9UbHrK421C2XocJaYnuxzgpGYhowGOiLt2+VAVZw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=v8O3KEcR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.44
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010044.outbound.protection.outlook.com [52.101.69.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C084606A337;
	Tue, 10 Nov 2026 14:51:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C084606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=v8O3KEcR
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fcMgQkGOIFkerW8iNR/cgeGslbIM9le5TQtqIiJFxNWy6D1gZbnL2oDF6hi2SUKjKBn3b1AejA13RKFlomSYOxm0+cT9qTZnQ+i3AfDFnPmbULbezqyUwZuUAnRdUytZd035TsbNMYMtgChfWzE6JjTFOlELCTlPqqNc424SWjyQ86RNQGKM9X5H5magC5ZUHIB63mxIsIelF9V+9GWyjHOvS9dduADT5+et1WSoJfhlZYssDGpks4rvKRdV7WGS0iZOeZtZRk0fvz7fA7o7uRUZdYcRF/ifDjHLiynSrkv/yReTYmUDhArZC1ea/P4y3k7ZD0sD8q5ZEGcZU+effw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kb5aicXyT77g91zh2e/TNNya6++eMCKke5qDKuNWIxA=;
 b=i+SXdLppUtjWS5At2XmbKQh4vZohxTY4ejTcbbQX/90Iaum7jp7a0w4Q0gfC+qXNI0c7sx3bqt1Gy2TOMRF0vtt8trX357PvSV3+mrjgup1m6Ek1/8AvMoew1nB8guPltcZBbRPiebfVvTZq47pdH2IndDEVoo+p+wOOnfC1bJwfjbefbM6Fp2CY+JzcghO5OouM3iaeQQQir4Cogv2saDihwgR9Aus3IqkLl5elORNplognAsHKmwYkG10ApDrgpTmUzl64v5HwmaCjCARG954i8rJLYz36EJPq9wQ33KSwIarBbCvGXLNccFUFIKtbHYVC/ymaENenmkITtYYiPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kb5aicXyT77g91zh2e/TNNya6++eMCKke5qDKuNWIxA=;
 b=v8O3KEcRT+4ZvCJ/yK0zSh0IoVRtdfdxPzWlvh3M+eS9uRsVkzWxZ4Sqw4pS9tYNEgLWYGQbTtPW5OnSxZfpKLIF17+i0DkBGKkstmMGbKmBth1KGnXGImsKVQOuFsK3hvUZfJgxjbbxw20jwQhtF6alLR7u3/ORhSl+jw0no8uXlhXextn64j6VpqBOnU3n6Y7E0Z1jQQF+5/tORo72YyzZD6RCRnfZDulhMPy0r7maa20uz5MDViFEGjgDmjmizq7Th7jeaIB1VyisFEUmJVhQiZOlw91BCi8b63SypT8vDKL7PZS8dHkCnob1wgaw1SZG+sTQbC9UQfqMCwXK5w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by PAWPR04MB9935.eurprd04.prod.outlook.com (2603:10a6:102:387::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 14:51:25 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 14:51:25 +0000
Date: Tue, 10 Nov 2026 08:51:17 -0600
From: Frank Li <Frank.li@oss.nxp.com>
To: zhejun_huang@linux.alibaba.com
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] dmaengine: Free channel ID after device_unregister()
Message-ID: <avMvZbxgeAgWEZUP@SMW015318>
References: <20261110101607.13784-1-zhejun_huang@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110101607.13784-1-zhejun_huang@linux.alibaba.com>
X-ClientProxiedBy: PH8PR07CA0021.namprd07.prod.outlook.com
 (2603:10b6:510:2cd::10) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|PAWPR04MB9935:EE_
X-MS-Office365-Filtering-Correlation-Id: 075fc264-9a1e-41d3-73c9-08df3f3a17f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|19092799006|260925021911599003|260925021311599003|260925022911599003|11063799006|261021121427099003|56012099006|261022105027099003|261026140227099003|261021123027099003|261028144727099003|261102123227099003|10067099003|261009223027099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	7aPVSRtB6JRJqoRI49RLTZs6kIbWQefK3ghquGEB5NVYFxi3/a7iZNbvHkP4uHWFN2loKKKDGbtmMXGW73i5X04cbRvkQqBBEcHb5Z1CugLJIUe7eaq0E3dIo3dW8SSgMa2LGqltssKZUCyl4f0XHnIk/eD1GwFks+bc0x+xBl1+pJ21LpC22vKS4CojKEsHVqD7OG9LsZIeUNFwSWGZU7sgSv0SbbnSjZ7B78iknOEXNfVf1a4DRcS2HSal58pArkeBAgQUSZFsfL9O12BJjp/AlR+Sui4qAtGczz381Pc4QeJfY1rkV2830/iFEyv9TI12+rF5fdTjf76BASs0cTgvuI7kMjbIngmdbmaZUH/CY21sinoSrAjuGHWirifrZ0wWKMpR3mMm8UinPFoSEkrYoOFovrEhmQPomen2h5w5ucpMdUslXNcTAbrJ/N+KEqItwGs9BRYdhnvPqxplNLPZOg0AFNmIc/wzpRJli/rKXuzfk2cX2CkhvG88YBqHZhVbVCxP2udoRapOkliKaNf3vAWi1qskuwETIHdpM2DPmrqiZtSzHDd0XD85Ubg2WE//bRh2HcmNMv1O3+y6RiI7xOVlUU4UeCiJAvuuEYG3Ek3GAI6ss03BlQvV3WRPwvBkr+/PuMMhuHLJCRSL5ewEf5WCgrsm0FP2svq1roM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(19092799006)(260925021911599003)(260925021311599003)(260925022911599003)(11063799006)(261021121427099003)(56012099006)(261022105027099003)(261026140227099003)(261021123027099003)(261028144727099003)(261102123227099003)(10067099003)(261009223027099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E9ws70iRc+0DovyzLW9PKmVeK7dhQUrbd7dm51FUmrC/Cc2shJc/7vFxvKYV?=
 =?us-ascii?Q?VLgIZIwBb1O9Hhxmh31Fb8MDIwWORrmetGDx+42WkeMda3kCvbdvCFDYa3Q/?=
 =?us-ascii?Q?nLShrRRLnBbpkd3aEiAB7fDT0DaZ5+JsMd1VynoVcrF6ikH777M8CiK7wjHs?=
 =?us-ascii?Q?m4Eu2CO+TqOjoGEpwHhKLjpEYGVYyQrunWepV4XfA553xOEFpsltGJOXqSGM?=
 =?us-ascii?Q?Xjw5rLI0U6LqpgBwTiCSwyOekdUCtRExsr0eOR7NXOnL/dTKOMWJusBghdGW?=
 =?us-ascii?Q?HA0AYJjxd/LcNOlNxOPI6knxAsGA5VGsPyGavS3Mq9nKZJEROEEMi0nAU2NH?=
 =?us-ascii?Q?sWoBWDy0Gkx2j+265ESr8L8RT1FR3gFn1DYJInfbh31rmpQi44FUhlcDsQHz?=
 =?us-ascii?Q?iiKx67QLw/7RH/6aOD+uKi+DPD8rqiTfV9ueOAc8sqtOf53T1fkyh2ZrJ6AZ?=
 =?us-ascii?Q?BYVIQE5hG1BGyL8kJckU0ADSc7jjAEmwwpW74lOxC2yhoAiD2oK2rulfd7kV?=
 =?us-ascii?Q?btMun12TwFM5Jwt1mpsKLh9Tofx5HqATnibS0Ajpi7JMuUymxt41AssCdqCg?=
 =?us-ascii?Q?NptccdQKVOxF8l0jWtAu2SBjooRi3Eo6CRhXJL0k8xbkD3xNlUNXpkYijfoI?=
 =?us-ascii?Q?pcv74hRMds28N8gcE/2Tr5TJqdbQKnimM681sJTlxLVLx5SbVNz28nhfsC4d?=
 =?us-ascii?Q?PWUDRlfDbCp88ufZqugkuBKp2bhjyELhUj4UjM35tsL5D09JfnCA9ULVGA5J?=
 =?us-ascii?Q?3vvxYInL+uIcZmrof+VKJp7mz8YJ41//3TtLlP/rBFucola6Ga10P5NqpwY3?=
 =?us-ascii?Q?4Awtl655dtLhQQChV6+3kgCooAZabVsz+ijGUey2tJBUmRC3GoWYaXVjOn4n?=
 =?us-ascii?Q?1vXuNuC6CVJXyr9rfiGRvlZEZpRWOLV/1sVBAJD9e3mHqOMD/o5MzW8puZH5?=
 =?us-ascii?Q?CPAPCBgelPv/ZeabiwZ4r1f8pCQ42G6dpUBOKq5+ncl8ez5rNZ9kKPDHIaDB?=
 =?us-ascii?Q?yX37tqsFsPI9Sh3rKxBTXmWeOmAYjxRiQEnNaJEBGnTkqYX5ksHQzOiMITYa?=
 =?us-ascii?Q?dw+gy8lOtOnyve80tdcA/qCCPprMNo5Ous+rK5wowOh/Z4DF3pU4J9i4ycCA?=
 =?us-ascii?Q?ki/dFC5z7FTxZMkkdlLbXFZZbGbLbIEJF6ZmGGylIjaYvcHLvKxhFxoC+bPH?=
 =?us-ascii?Q?LDtGjGO8eF9A6K4MybQhEzCt2WIiuVXB80YEcP6fbhquc0PBbefk2pNXPINA?=
 =?us-ascii?Q?cTMYgHv2h6bc6OfF0WxJ6YqDrmNuK1ibwgBt/8fJ9RIWArhiXKnfknXUwRjb?=
 =?us-ascii?Q?nzLk3WYCy5l5WqZaT1uV88hBsWRwzqN/rVM5gmhwld88yFoXEAacoRVyhNGm?=
 =?us-ascii?Q?BEBQNDeC0vNWubu8Zqxrpob6WXP3pr+j057IWjPLep1mn3PKOeblLawaqQc5?=
 =?us-ascii?Q?7iAVA3afkzow8fIBVkXA0wFk4Sz21qS4PCQ6o5xsFvR2M7sREYpohTPki/vL?=
 =?us-ascii?Q?OvLWKA5b7VFhVcmpfKPZT67Dfgfk8BK35Pqth1vWAQpc29VpZ4oP9ABDrv76?=
 =?us-ascii?Q?8aAvLZL2YwT/2teRAmSBfDUPTpCkd4MfRbpTK5yiOk+1794J32aJV+LDiJ5A?=
 =?us-ascii?Q?X+9I+muZggvE0ULYvcXUHFjF5WGxmSe6HzwEhCQSEUPbm/IkV5CNF/SNWlQn?=
 =?us-ascii?Q?sOso6Lb3o9zjBqbp/NrzamMQSKXrQaID+634eem1KSbp7vt0nr25/DElFO1V?=
 =?us-ascii?Q?NDTtbEH0tN3fC3QBg1plXJC0buWL/YqFxy5aasaCVID5ZS3VwVde?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 075fc264-9a1e-41d3-73c9-08df3f3a17f6
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 14:51:25.4723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rfZBOkyjAnkz9QI43CxObsdYSaTX+ghWhzzVvjieelHVxlgWbHZmG+x+S877TTxlNhcld0dGj4S7f2YYjJtaujFZvAsE5HxjfcSitegK1hQl9kHiDpSx0ui1aDyY1cyN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9935

On Tue, Nov 10, 2026 at 06:16:07PM +0800, zhejun_huang@linux.alibaba.com wrote:
>
> From: Zhejun Huang <zhejun_huang@linux.alibaba.com>
>
> __dma_async_device_channel_unregister() frees the channel ID before calling
> device_unregister(). Between ida_free() and device_del() a concurrent
> __dma_async_device_channel_register() on the same device can reallocate the
> ID and try to register a device with the same name while the old one is
> still present, failing with -EEXIST.
>
> This is reachable in practice: idxd calls these functions from its
> per-workqueue probe and remove callbacks, which are only serialized by a
> per-wq mutex. Enabling one wq while another is being removed therefore
> runs them concurrently on the same dma_device.
>
> Move ida_free() after device_unregister() so that device_del() removes the
> name before the ID becomes reusable.
>
> Fixes: 0821009445a8 ("dmaengine: fix channel index enumeration")
> Cc: <stable@vger.kernel.org> # 5.7+
> Signed-off-by: Zhejun Huang <zhejun_huang@linux.alibaba.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/dma/dmaengine.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index 34be53487a21..2642abf105d7 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -1171,8 +1171,8 @@ static void __dma_async_device_channel_unregister(struct dma_device *device,
>         device->chancnt--;
>         chan->chan_dev->chan = NULL;
>         mutex_unlock(&dma_list_mutex);
> -       ida_free(&device->chan_ida, chan->chan_id);
>         device_unregister(dmaengine_chan_dev(chan));
> +       ida_free(&device->chan_ida, chan->chan_id);
>         free_percpu(chan->local);
>  }
>
>
> base-commit: d48723711bae9b8cdc56719c448ba42fef28cbee
> --
> 2.50.1 (Apple Git-155)
>
