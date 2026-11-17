Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794944938;
	b=FQE7I4QKIqSuU37gBuAtreQzo0aYljcS32snZUA86kFLABjMFVWZgJYjP5BA1AabDBPo
	 KkifQROBxPMLUkotG9bzhEpAU7pW5EBjLkhwTGsNDBEZNzx17l2A11PnOxoNaIQCTug4o
	 o1t/iZxhCbRONQiFZacyCqtVGhgm5t51JajsbtcEJwkBLWfn8CHSbc2SgMVmX9LZOtj83
	 TJkaVemV4wNa3h8I752EswnZnei8MncqmJBTysWsLdOZIbLChbc8Tmnqau0UJyxMFVZCo
	 kZdNn3E0OKPopJFBcjxNPvSHZcuq7VW3tZQ14YkzJBGZuppxtvfX+2DYVFEqc4qeQfQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794944938;
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
	bh=AMVKSKC8+CD3sB2xb6bjZtndf1LEXHBhXPO1LDO3/dw=;
	b=npCdqA7pCsI82c/Yd+Natzx3mCBW/TmQU85DihJORKR/Ud1XfMVTmqXbhBboYha8b8vt
	 FKzIeDrD2Iri/6LleYs5aTCPzZjX2wmBT43VJAG0tgxj8I09CBOOKk3LYI6bQTK748NRW
	 1rg2159tiTrloq6YiF9JTIRxJxPYt/Nud8oflEvvzwG+HSM8J/xFGGyfHVgqEk0IsBd0x
	 2x3GFozd1tQrjhYg/l/qUq1V/1UQz5JFpNztHFu9pqCvbarebPz0p3eF7DeQKHM9WYwK4
	 PUPfS3zYaGM/d/gQEfJ940/+gjP6NEod+pupJorkFtaBN+Eazuxwn4fOEviBKehPW7w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=VG7kJlIQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.13
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011013.outbound.protection.outlook.com [40.107.130.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED70606A31C;
	Tue, 17 Nov 2026 19:48:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0ED70606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=VG7kJlIQ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TRn8XaGi3W044NVuJF0ZMThmEBjlbT5gQpA0Cu8OFwdq2ouyd0wM8AGEE/72nU2mSM4lkMdNYn3iRB5fiJOCH4wDWtjxB6mi03jYdw6nSpZfQZU8DlwKBoYzD+lqolGyN5BBxovQ7a9TY++kKjLeJLqQ+c3h1l89EchV33/oeKSZA5IUMACSDtOdMrl9P+k6bQs/NrEOP0auBupUY2U7rYWwkFC9iQ4moVeUqlVrXP9B3OmQJSRwQeqZidVqELt5i61hLPsdy7B2ujw8pB0JCqln6hYJ+36l8BVzgFFYbuzvyodl7KDcA/zqOp+vqREWOSi7jyAbVx/xnsthz8Rabw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AMVKSKC8+CD3sB2xb6bjZtndf1LEXHBhXPO1LDO3/dw=;
 b=wcSw8agKblZQGDXehL4oYiaZ+l7etbyCwpKmTpxphgepYDoOUf0UOptubM12QxjKxhtTlrrKaZ9lhDpCE2guyFtklSM+T2DRC/aWGmrVyJK+OpKPXkMf00yK6FQmAsqr3ZlL5OQbudNVM0v5mjnihOZ+T7ITC/poMSVm6VZqQu1dWoWNWO0raTnBnBpXm+O6r1XBrQ8K0NVlHMO8bgk5+8P4TzI78Zwd65A3K1VByO8uEz93x0wt8Yf8nsugcOSBTdMJjiHIF0vFlkLiMZf6L3A9YpnSp7yKd9/w4NvVMT8rjKTaxFZHnrnbJj1f/lIl+BDWK6UYit2iDxH4BKIIhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AMVKSKC8+CD3sB2xb6bjZtndf1LEXHBhXPO1LDO3/dw=;
 b=VG7kJlIQ7sQpR6QgkXfQG0m0sbub2zMXNc6gMB/UW7wgh7+K6N1U/AIGj7YK7ljtUYiCDYLDoSkdxcNXOGQkWxByuK55yz5whx8SOgOf5uo29cTnMxm+tdz2T0nos4OOwEkEANhvYVk8uT4zuc8ZnbQe6yRi0Xqe1Qfhs4D92kxLmOLM/9MzlIrU7XK3zK6SFPoN809qVw2klxi4QAYJR6NUszM+WfidEvAK8vWtO8bWWfWFjzDhncgnZiB7k3I+s4CosYTwDiL/KCOXGWcOFZiwBlJoYnFco96h23lfFvWzBVXUzOt5vHKQcDdGX4X/mhxjVgJ8BIPPHSftwDqBAA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by VI2PR04MB11051.eurprd04.prod.outlook.com (2603:10a6:800:26f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 19:48:54 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 19:48:54 +0000
Date: Tue, 17 Nov 2026 14:48:46 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Lee Jones <lee@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Sylvain Munaut <tnt@246tnt.com>,
	Andrey Volkov <avolkov@varma-el.com>,
	Dale Farnsworth <dfarnsworth@mvista.com>,
	Grant Likely <grant.likely@secretlab.ca>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 08/11] dmaengine: bestcomm: Defer publishing bcom_eng
 until initialisation completes
Message-ID: <avyvnncbrKjdibG4@lizhi-Precision-Tower-5810>
References: <20261117163809.622249-1-lee@kernel.org>
 <20261117163809.622249-9-lee@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261117163809.622249-9-lee@kernel.org>
X-ClientProxiedBy: PH8PR07CA0033.namprd07.prod.outlook.com
 (2603:10b6:510:2cf::20) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|VI2PR04MB11051:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e64484e-da31-43af-1e8a-08df44e3cfe0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|19092799006|1800799024|366016|376014|7416014|22082099003|18002099003|261009223027099003|56012099006|4143699003|260925021311599003|261026140227099003|260925022911599003|11063799006|261102123227099003|261102124527099003|261028144727099003|261026130827099003|261026135527099003|261021133027099003|261021130227099003|261022113327099003|261022075727099003|261026121527099003|261021123027099003|261022115727099003|261022105027099003|261021135927099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	Y1jfMltQDgM4cLPVUK5hxBz65exzCNtbnAAY/vs1riH93puBmzU1YtMJ0Rtj7eMnop/XToGNJZSyWSENr/WwItrIyl7sDsGWdcMt+lskoI6kUjr0JaWsnuUbaNmXOkJ5CdMh/9kx+3q2qDumZJwWg8HlzDosjhl4Oix7tW+BFgdvPqgxtsegWFzwcAHV/St+kgELg2xmksYfkbcg2FxI5pneSdrh0X0tqTzBg24sMgXXIMELYBhzaZG6l6dUvDGuGWC21TP5rWOwEjDKNOEQkBsS7EXioKRf3xLE9bv9IGBmKEUJhQl2Mkd3WfEtVF3tivVj1MK+Tbmr2vh/zKKcwFBJ6xrpddzwZQbIMTzaP0vWpVcLDjMssE689i74j+4MV4QLDWjJgyAr8DZSVqpJUuULNoqcFkOxwMlaI5P7dwGXel40BivzJStkF6iQ1u+PEOxRn89SBic/jBL2zlMZN/H+vDZTEOSF6Dt4342QbbsQe111tVwIJlRkXxIVw8SCulu41HM0/KR/TuBLAaPWdHvGwGqVup76geGnK5b9oO5ZDk3liDpvmgNGup/hNGri0cRHPvp2QrVb2gSYKS5IgZXzA+JkRYLXm2DsMxxyjtY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(1800799024)(366016)(376014)(7416014)(22082099003)(18002099003)(261009223027099003)(56012099006)(4143699003)(260925021311599003)(261026140227099003)(260925022911599003)(11063799006)(261102123227099003)(261102124527099003)(261028144727099003)(261026130827099003)(261026135527099003)(261021133027099003)(261021130227099003)(261022113327099003)(261022075727099003)(261026121527099003)(261021123027099003)(261022115727099003)(261022105027099003)(261021135927099003)(261021121427099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oziyTAhAoWpLf8qAONI1K4Ow4KjaIqGY88GZqh8LJZDVKWXdyhe2zCTSBCyb?=
 =?us-ascii?Q?tX34IeSsc8Ps2qBBUyI9CEbKpPHPhopAzSfDSn/Tl/mjHVwKYQxlfdiZk875?=
 =?us-ascii?Q?2e8zrMLKfYOWSAYip8ed7azlOwpwqEzY8QtxuObByIxtwkUtA8EblTgjD6dh?=
 =?us-ascii?Q?0aj+svP91WX7n1lGfkAQL6H4XT1uJSqzwXb7xijngF1oxM5+xIxbQ0bpn5MY?=
 =?us-ascii?Q?gLvhK8onRQE42tpzkQL1nif6tS7xhShZP2QBbyoWIpejGPFCiUsEccJNnPG8?=
 =?us-ascii?Q?NnCWoMx4XoZbyCNxYwW1avjw29MO81tRasm8MgXIBUnU/uwuXiA2dGpZ5YUD?=
 =?us-ascii?Q?T6o6n1O2odqTe1jNsgm1BnnnZL0UHZniMlNfli6bZGRuZA41yTq3zpWD2K7D?=
 =?us-ascii?Q?vAooKK6QT8sU7g53AKrxGebuHJ9P29XxPNStmU1pb8KXMNHS5Ua0bYdgm6Wu?=
 =?us-ascii?Q?1kZ/g79Ze2ZUc1vxGc1itCvO2ca+WDNIdjTbc7O5fF9+GuRgYTehFlNqOcyu?=
 =?us-ascii?Q?CzYPlkphStxVqvqTFiUKipTQ0YtZi7UoBrWlQ7ID1elxuyJKFuS9KYUgD9S1?=
 =?us-ascii?Q?LRO6eOFZ1GFe77HliJqRwR0zgLK9rI/1wVpSoEh5RW8mvnFY8moNUEVbePNT?=
 =?us-ascii?Q?Mc5R2urp/UfR1eSav1dy+BORSfDr8EWATSxsf/8LdRdhy5Mx5U5gI1My4FOs?=
 =?us-ascii?Q?+YDyRa8CEMuoDmpIcdN0RhaYX1W7IEJDD+0FoGrg9w8/gOCY4a3nLIYwYy8P?=
 =?us-ascii?Q?NknkQ7a1FQWBELXqUg4hz5sMrvtCq9lXKRzaLtZ2qjAOdF6nWX7KvfpodoAR?=
 =?us-ascii?Q?2OjCK1XxXu7UITw1UrtPG3i+aWnUPccAS8r1FyKb4Sj2xRbetxgqG5eAE3ZS?=
 =?us-ascii?Q?7mo4MSvRJ3K4VWK2tXTwBMvFxlTpoDXir5RHZcBzgVAQ19eePj7U55OHiNJk?=
 =?us-ascii?Q?XUB+E1awVMsl9M9uT5DbrieppN2bNkHNhmhK3/C83XaM4UeHVYwd3idAhEmH?=
 =?us-ascii?Q?bw3ggZxYvDf2BqSfwcNJVw+XgXH0Cjkg0zi73fCnETNN/Ffm0k+lcW9S/CY2?=
 =?us-ascii?Q?C0AbKAEMYuEEe5CPyebBiVMIwJVWIZJ038n2TL/+aYuQmiZRqPxggmx/xWV4?=
 =?us-ascii?Q?2OlbJvQK6gElIad+cBcS6F4iRtYPqck8iblwCU/aA3uaQNMo4IrCHHbIV7Ra?=
 =?us-ascii?Q?ciZvqpGuwrJQtDdZh5daKmtj5dgMSM+YybEMQzgWGVBURflJfOzRiQpfxaW7?=
 =?us-ascii?Q?E1ubmDtpYBDkpVMaPLJjcDqBqXC44+LGNL6+B/zXdsN/vlW4zZGfvKgEfQvn?=
 =?us-ascii?Q?0x8m3zU5tFQ1BG14LsBIuxpSHoX6bmEySvddRjAM0wVrJqkSQM/0jqdmctzZ?=
 =?us-ascii?Q?pMU8vUQDjrXCA0MeyfkOMg2EfTRPrJzMw3mxectYKRI/2M3hOh18fZtck1Ic?=
 =?us-ascii?Q?MM8ATcYG6mUUaUuV6BrJ3HPAuC2vNTxWVlOAenHVpn7DjmXoI5fLN4UZWUer?=
 =?us-ascii?Q?n6cpSWsNPE6OuMpHvsrjJ6jYcNjUHjxdToYul5PFK+2Nb/ZZGtaPWXtgBK2Y?=
 =?us-ascii?Q?IRp3imQxyHJV2VpKQvVxrqysRLBMeY+00LXeEKoVHQT4iyIRdvSTked929Se?=
 =?us-ascii?Q?xhwzT6mSbdqYkwkeT/H7F1TJCqAmMGf3DVE1HrnReu9YxxHDTlr/dTJ4lvJ0?=
 =?us-ascii?Q?Ay6/FQ5HyQU7jvJTtKi8pETXrkIuxGDCtuUaqaXhyySlDYhwuRQZXI49cUr2?=
 =?us-ascii?Q?BpCa+WX8itpHEL5h83IVk9zO1vZ9K51XRLthRJcobSxJJPPBNglB?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e64484e-da31-43af-1e8a-08df44e3cfe0
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 19:48:54.6488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RQaJiMP2yWW5DiIjJ0SAu8UvzuECZPkw8zW4Ex+wM3CQOjXn7BTSbOA3Bj1elXFdlKHjFDOpdmlDi14DTvmVvZCx46JfHB4CxmFdGE90AEFR431DrjYDbfTj02aANmbi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11051

On Tue, Nov 17, 2026 at 04:37:09PM +0000, Lee Jones wrote:
> mpc52xx_bcom_probe() assigns the newly allocated struct bcom_engine to
> the global bcom_eng pointer before calling bcom_engine_init().  A
> concurrent call to bcom_task_alloc() can observe a non-NULL bcom_eng
> pointer before its spinlock and task descriptor table are initialised.
>
> Initialise the engine via a local pointer and only publish bcom_eng
> once initialisation has succeeded.
>
> Fixes: 2f9ea1bde0d1 ("[POWERPC] bestcomm: core bestcomm support for Freescale MPC5200")
> Closes: https://sashiko.dev/#/bug/linux-0a202799-4946-44bf-b035-fbb2e329e666
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> v1 => v2: No changes
>
>  drivers/dma/bestcomm/bestcomm.c | 69 +++++++++++++++++----------------
>  1 file changed, 36 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/dma/bestcomm/bestcomm.c b/drivers/dma/bestcomm/bestcomm.c
> index 241a91936fe8..dbc3ce5fc446 100644
> --- a/drivers/dma/bestcomm/bestcomm.c
> +++ b/drivers/dma/bestcomm/bestcomm.c
> @@ -270,7 +270,7 @@ static u32 fdt_ops[] = {
>  };
>
>
> -static int bcom_engine_init(void)
> +static int bcom_engine_init(struct bcom_engine *eng)
>  {
>  	int task;
>  	phys_addr_t tdt_pa, ctx_pa, var_pa, fdt_pa;
> @@ -282,56 +282,59 @@ static int bcom_engine_init(void)
>  	var_size = BCOM_MAX_TASKS * (BCOM_VAR_SIZE + BCOM_INC_SIZE);
>  	fdt_size = BCOM_FDT_SIZE;
>
> -	bcom_eng->tdt = bcom_sram_alloc(tdt_size, sizeof(u32), &tdt_pa);
> -	bcom_eng->ctx = bcom_sram_alloc(ctx_size, BCOM_CTX_ALIGN, &ctx_pa);
> -	bcom_eng->var = bcom_sram_alloc(var_size, BCOM_VAR_ALIGN, &var_pa);
> -	bcom_eng->fdt = bcom_sram_alloc(fdt_size, BCOM_FDT_ALIGN, &fdt_pa);
> +	eng->tdt = bcom_sram_alloc(tdt_size, sizeof(u32), &tdt_pa);
> +	eng->ctx = bcom_sram_alloc(ctx_size, BCOM_CTX_ALIGN, &ctx_pa);
> +	eng->var = bcom_sram_alloc(var_size, BCOM_VAR_ALIGN, &var_pa);
> +	eng->fdt = bcom_sram_alloc(fdt_size, BCOM_FDT_ALIGN, &fdt_pa);
>
> -	if (!bcom_eng->tdt || !bcom_eng->ctx || !bcom_eng->var || !bcom_eng->fdt) {
> +	if (!eng->tdt || !eng->ctx || !eng->var || !eng->fdt) {
>  		printk(KERN_ERR "DMA: SRAM alloc failed in engine init !\n");
>
> -		bcom_sram_free(bcom_eng->tdt);
> -		bcom_sram_free(bcom_eng->ctx);
> -		bcom_sram_free(bcom_eng->var);
> -		bcom_sram_free(bcom_eng->fdt);
> +		bcom_sram_free(eng->tdt);
> +		bcom_sram_free(eng->ctx);
> +		bcom_sram_free(eng->var);
> +		bcom_sram_free(eng->fdt);
>
>  		return -ENOMEM;
>  	}
>
> -	memset_io(bcom_eng->tdt, 0x00, tdt_size);
> -	memset_io(bcom_eng->ctx, 0x00, ctx_size);
> -	memset_io(bcom_eng->var, 0x00, var_size);
> -	memset_io(bcom_eng->fdt, 0x00, fdt_size);
> +	memset_io(eng->tdt, 0x00, tdt_size);
> +	memset_io(eng->ctx, 0x00, ctx_size);
> +	memset_io(eng->var, 0x00, var_size);
> +	memset_io(eng->fdt, 0x00, fdt_size);
>
>  	/* Copy the FDT for the EU#3 */
> -	memcpy_toio(&bcom_eng->fdt[48], fdt_ops, sizeof(fdt_ops));
> +	memcpy_toio(&eng->fdt[48], fdt_ops, sizeof(fdt_ops));
>
>  	/* Initialize Task base structure */
>  	for (task=0; task<BCOM_MAX_TASKS; task++)
>  	{
> -		out_be16(&bcom_eng->regs->tcr[task], 0);
> -		out_8(&bcom_eng->regs->ipr[task], 0);
> +		out_be16(&eng->regs->tcr[task], 0);
> +		out_8(&eng->regs->ipr[task], 0);
>
> -		bcom_eng->tdt[task].context	= ctx_pa;
> -		bcom_eng->tdt[task].var	= var_pa;
> -		bcom_eng->tdt[task].fdt	= fdt_pa;
> +		eng->tdt[task].context	= ctx_pa;
> +		eng->tdt[task].var	= var_pa;
> +		eng->tdt[task].fdt	= fdt_pa;
>
>  		var_pa += BCOM_VAR_SIZE + BCOM_INC_SIZE;
>  		ctx_pa += BCOM_CTX_SIZE;
>  	}
>
> -	out_be32(&bcom_eng->regs->taskBar, tdt_pa);
> +	out_be32(&eng->regs->taskBar, tdt_pa);
>
>  	/* Init 'always' initiator */
> -	out_8(&bcom_eng->regs->ipr[BCOM_INITIATOR_ALWAYS], BCOM_IPR_ALWAYS);
> +	out_8(&eng->regs->ipr[BCOM_INITIATOR_ALWAYS], BCOM_IPR_ALWAYS);
> +
> +	/* Init lock */
> +	spin_lock_init(&eng->lock);
> +
> +	/* Ensure all engine fields are visible before publishing bcom_eng */
> +	smp_store_release(&bcom_eng, eng);
>
>  	/* Disable COMM Bus Prefetch on the original 5200; it's broken */
>  	if ((mfspr(SPRN_SVR) & MPC5200_SVR_MASK) == MPC5200_SVR)
>  		bcom_disable_prefetch();
>
> -	/* Init lock */
> -	spin_lock_init(&bcom_eng->lock);
> -
>  	return 0;
>  }
>
> @@ -363,6 +366,7 @@ bcom_engine_cleanup(void)
>
>  static int mpc52xx_bcom_probe(struct platform_device *op)
>  {
> +	struct bcom_engine *eng;
>  	struct device_node *ofn_sram;
>  	struct resource *res_bcom;
>  	void __iomem *regs;
> @@ -398,20 +402,20 @@ static int mpc52xx_bcom_probe(struct platform_device *op)
>  	}
>
>  	/* Get a clean struct */
> -	bcom_eng = kzalloc_obj(struct bcom_engine);
> -	if (!bcom_eng) {
> +	eng = kzalloc_obj(struct bcom_engine);
> +	if (!eng) {
>  		rv = -ENOMEM;
>  		goto error_sramclean;
>  	}
>
>  	/* Save the node */
> -	bcom_eng->ofnode = op->dev.of_node;
> +	eng->ofnode = op->dev.of_node;
>
> -	bcom_eng->regs = regs;
> -	bcom_eng->regs_base = res_bcom->start;
> +	eng->regs = regs;
> +	eng->regs_base = res_bcom->start;
>
>  	/* Now, do the real init */
> -	rv = bcom_engine_init();
> +	rv = bcom_engine_init(eng);
>  	if (rv)
>  		goto error_sramclean;
>
> @@ -423,8 +427,7 @@ static int mpc52xx_bcom_probe(struct platform_device *op)
>
>  	/* Error path */
>  error_sramclean:
> -	kfree(bcom_eng);
> -	bcom_eng = NULL;
> +	kfree(eng);
>  	bcom_sram_cleanup();
>  error_ofput:
>  	of_node_put(op->dev.of_node);
> --
> 2.56.0.679.gc527c65306-goog
>
