Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.62
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794944505;
	b=njEcUUQ9wzz2qzWFlUt/WU3FtIgazfbCFuIuD27IgfexMuM/prj0FDYVEyxe+aD9mRLk
	 7uLRPvddnJLzOA7q7FfYJesWUyKutfjucvBWAkDB4cGXftLtJ2MT0UhVgVNYmve5Y3m+O
	 eu6tfxiYTSrPrC2Y/0Z2gyFMv/Vm7VD+rvpM4eb+4565W/cD5EJF/a5PrQm9LHKdwEpUx
	 LFhYkLr7u5uM3IAyivWSsNNL1D6lHzPv7Nqss0Hs2KkjH3vbPTXDZ+JhP4Bk3Go1ZlpHm
	 tYb6tPkdTQePyJ879ndiXaetfjp0+C4XWfG4pUb/IfUXj9DCZb8+znybXEvyk7xPO/Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794944505;
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
	bh=lMD3u5VeB7DUxfgTJtUCQN6SQXad/Ab4lJfoVEi8pGo=;
	b=uK+TFAG3zJ+kCw6Rzmi4/jwy0bZhIlvRghqU1vx+wurah0vQUxHZMMf+zg4wXpuyiDx5
	 dC4Rrjwcc6vEZjC07RKIwRmM3mVf+AAfwypCbf452e2J0+xRk7Q0/47E3JracTSIH8kGn
	 chEuh3OwDV5nM4flMrXKwmtvGAyMLDVyUzMWacpPeK3gJLlhF9uTMfakX7giFNmAmFLmy
	 2BaxpajawKU2PUvhCuLOSw1DaX9bCcViir9nJo2yDc+D6i/TNFyuZb+U/cyKTwxI5qM8W
	 5qzSrTJ7/k3MjcnV/IhmHXBhZVN3qpBZXWC2brvYckzitltlGyDszGzeh3uPkkrvEhA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b="EGTr/QhX";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.62
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010062.outbound.protection.outlook.com [52.101.69.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6363606A333;
	Tue, 17 Nov 2026 19:41:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6363606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=EGTr/QhX
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ryOfxJ5SBu0FIYgT4Vnh08YmeS3XblvuwlWdrwwfEymKIlT1i0nH0lWm+Qy0kLlf9Uo/KcY0Hz7OUxGX/Bpj5v02A9ESUOFnoeGYdI30/98ZdvhNl5i/KuYCyYysYFnRm+6ZlhFsV9ae7yzDVQmfZAzJ8EmJX/9fB4fRR1gkrk/1FSBwct1ZWdhA7st1umfiD2c/upPmahpq7D2u+HCmEXerlS2RKetn/JEdWmHXEHlRR9av+OVtA/Yg2qDOLbfjPUVf392TyNA6ajva6RD4j+Lc7VyB8HjPLURL3Rh+QAMkemVi7jA24UDi2qR8x0Li3By+kBE+vwI4NR4kbx4E4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lMD3u5VeB7DUxfgTJtUCQN6SQXad/Ab4lJfoVEi8pGo=;
 b=kEf5BNwq+nBK9PKfFMeEK8oHeZ1Gytqf5oAD+U7eQxmqlybfnppc3wkE6kz+jOZjUMgBo4PSlaMmAUgHqw1fbKz4c/x3+dhVlUD7YyvoWLCENgjRyXPRON2Th450tv/BTP7I+nH6+KLNKtzpd8W0taJHiPItzYmkL8LRpDxNuwh33Yq9dF1Cq1nuWVvKHUdoCKjBGCF2V+261D+i+gIHh1qM0/q5PyJ/x7/L3U5OdsTRtOPWuH1ajHgsazKwxvwFhpNVqPqna3eEbSiR4+94UOYfzxAXnk/y6RWLyooCPCUhgkKzNY3qyiE6eJXtMWaQn306NL2zmuwNcX0rRi6KyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lMD3u5VeB7DUxfgTJtUCQN6SQXad/Ab4lJfoVEi8pGo=;
 b=EGTr/QhXa1wfuqvMYBpM6R7dIA699h/SU2TSq0E84NtmzZ9us0bznfSTev9rCf0oh6fDctPRqKVNH2wCOyXGOCKxhY4ncP/UjLbcj0U51tVSOMEUSJ4vX99EmSCUJlBaprkfZd5I8grcsxmvvlfHnCk6YkTwJssfI6wYAenKCr1ayXrYfFjVbd49bG+8ZBjjgyduiNcrTtO7E9p2F4v0ad0LFp9D7gJZan5q7e7XEJNH5HMff9bYw+9DleU10+jTCXnqGVtJxKn4v88Ne8PJ0s4vj+mxOiRZgaq7/SJBXyU7e4hU3FasoJRI3q3HP3Roy6h6r3ohwW6TmzRNB3Veqg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by GV2PR04MB12191.eurprd04.prod.outlook.com (2603:10a6:150:33a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 19:41:41 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 19:41:41 +0000
Date: Tue, 17 Nov 2026 14:41:33 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Lee Jones <lee@kernel.org>
Cc: Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Sanjay R Mehta <sanju.mehta@amd.com>,
	Gary R Hook <gary.hook@amd.com>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 04/11] dmaengine: ptdma: Unmap descriptor in
 pt_do_cleanup()
Message-ID: <avyt7QA0K_Q4jh0p@lizhi-Precision-Tower-5810>
References: <20261117163809.622249-1-lee@kernel.org>
 <20261117163809.622249-5-lee@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261117163809.622249-5-lee@kernel.org>
X-ClientProxiedBy: PH8P220CA0005.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:345::25) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|GV2PR04MB12191:EE_
X-MS-Office365-Filtering-Correlation-Id: 26468476-db37-429c-6fbc-08df44e2cdf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|19092799006|376014|1800799024|22082099003|18002099003|261009223027099003|56012099006|11063799006|10067099003|4143699003|261102123227099003|261026121527099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	Lqq7zuO9wqh5QhvDaNhit4uoHZzweNsSg11wx83FivkKzOM+g5fn1W4KsMkRC3QV2sFSFQDAMy4w+nFbhLG3UOkgU600T9tdUdSKvRxqj1WSo2VLsYfqUbVtUeQWYvsFTmuDx5QqNvYlFHzYbn1TVrnbTKt1dMzfLVR6nEnMYMMrfoLuU/i3FOmRt28XjUWsAyp3qTstaACgHAle5LtTJx0opwFHUhOVSz0is8ANrBS5VscGSAUbfEINmR6+c2WwprXSWQt35vPxhhVHG0emAQRzC4KWeUyEgEHbd91V6hsKl6xywYTIXicD4B+dwENLUDDDCWx7PA02hXAjBZwHKC9JX7LYL5l/qwrHsynBWiA7z/8TXlQ4kRoOSRavSmOCtytoRIP+26x2X/Meu+0pI6SgwjrBkO+2qeLwBijnWjbUpFavBrGINvtZV6C1FQu37yFdVZeY84xq/qAfTYKcydDCRZP275a11CMboXW7S9fjfj7cEaGz5HTKFE754F9dtsNVmtN0cAla5OHndmRNDCB65R5ad5s/RWGQBkYmrgtbQsbYB2FnYoxhqnkaylnCDybOB7x3SZuRr+AOa96J08udauwx0WpoP8dXb0EfdCM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(19092799006)(376014)(1800799024)(22082099003)(18002099003)(261009223027099003)(56012099006)(11063799006)(10067099003)(4143699003)(261102123227099003)(261026121527099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hPt+kQSCl2yUfCSMHRG7TreWX5m9/gF71+p8GqQCq+Kh2KlWB9Z/KX0ERKox?=
 =?us-ascii?Q?MFiD6xxDLYqp9cXrk3FRRk1Xer3h7tdhHxGNaLmuwDhHCNNbzvTe1G0Of1oI?=
 =?us-ascii?Q?eNHFCLOJfhyahLECtnSBZ0Ynbk0DIYACrzE1K8ey2dBlpZYDQ6Ao2Yot1mxC?=
 =?us-ascii?Q?9EN+27QO5HzWo6SwS+TzgFA4C90NAOnOcfTB6o85/BN/g+cE3IsUWcYlrY6W?=
 =?us-ascii?Q?xrWj7qu8VijS+wYdwXceiX9RHUTw9wOVM1wZJycDULYkJPRtWnS+vB4C0zvp?=
 =?us-ascii?Q?PBVGv7yOrOb746DajkC6BSvHYNGHqYlGY82De9Nk3j2eYRYqf0ZOs7DDKWoH?=
 =?us-ascii?Q?JO3ewv7pO7xOM4gYE5XNeI094OHYE0OlXEpuAiJuciMXgV3G/G0ZWt2nmE7j?=
 =?us-ascii?Q?y6JDJyad6e4llNJH2IaHUC9MyfKvXguYLkA0OO8Jq/UU2w1S2MEz+mcycH4E?=
 =?us-ascii?Q?BJwmdZeCftDOgihQdBbFKG1x7H0PMSu8vppA/ORTU0Z2xoFbxKyhRYlgJuQu?=
 =?us-ascii?Q?e17FGNJsKl8hPjEgQuZaVtEcv9KarZyOPb8yRJE/veVPfo7Re7L4FVyf5Fs/?=
 =?us-ascii?Q?fHzbuS7edxwpsFz2kaeukGj8JI5dX72U9GORNAw66jESI5aT+rOgBv2jJfoB?=
 =?us-ascii?Q?hiwFaimevuvJHcVtUogHNVp3bf67JGhhVpkUBvSb83+nDiAElzwXXzSWro8o?=
 =?us-ascii?Q?TKSXavbfaBMpuscjOJOfzL/UOO69PJ8cLJgvcRqFSD6fe15uXDA1FP+isGAW?=
 =?us-ascii?Q?Z3rITXMoq0X8eWrRCX+R6ZEgddgxzzFfpKBS5Ny0WQO57hPIy3yXfAJhslaN?=
 =?us-ascii?Q?XLIjcG1VH2oZb4AbxYyb1BuGs8byux5166LhHr+351z9D9S5d2J0JKZCTnJy?=
 =?us-ascii?Q?hjPMN0wjGe3HITH+Vumb31U6qnq+7bIfpTFOilkCWv+WD+eCrethb2A/eYVb?=
 =?us-ascii?Q?/bNgyh6JCIsRcbPxThvOaT3P49Th+MUhPXqZ41zvHtarPqciqpiv6s803C9h?=
 =?us-ascii?Q?e+Y6t4WnNOxzr9/Q43RnEYTlSsNvKtgBMLmEHgD78TtOYMgBWnwsrbR7BGIn?=
 =?us-ascii?Q?cx3t6BPGrrWzUMgdFfgzNifkfYbnFV25+FC0hwVF/9TZn2rQa76jm0xNUqby?=
 =?us-ascii?Q?SoAEa1Au7sWY0EK2xPky2+pV1SQUUX3oyzus9XzJEuA8by9LzHdlr08wVPYa?=
 =?us-ascii?Q?FvgqFfsaomlqKYihf7R+S+JNEbjr30Gi3rhmV3Sy5i+O4Uuun2fH9n3TS8bl?=
 =?us-ascii?Q?ylsV09uca+9HOPGZwKtiS3nJeBs0tr32zptd97eWghfaFtqQS3oqoiVXfxp7?=
 =?us-ascii?Q?qeAHCgaAI8aaTbfF8VpUIk2hrVMZbbzu5MtE0/0N9RoPIXI3zMM4jXf3Ctpm?=
 =?us-ascii?Q?qwh6p5AQ/M+Yiuka8Gj8fnY8g77a91MLhuYfITGdXVfsFiJkOBoIzRWMMMhY?=
 =?us-ascii?Q?J09KPWH3C/MSL8i10XAMMgcNH9hrN6+yAm9DbxSVYwr1Aaz+vUFe8FyV+CR3?=
 =?us-ascii?Q?AkK4v6PDdG/vplx6DHVLU0B3GhdMr2j1dRTWQThxoAtswH2fT+IqCaPMqWt0?=
 =?us-ascii?Q?AAaPpRpLwjc6UadoBLQYBxPWm1yQRjnBd03BQ1Dgre0wJSVCnDI86GVWd99L?=
 =?us-ascii?Q?mLPVbDNdZw5NX5lkJ3K6APKO6fq8WACBwjZxDZiFkL1yWpEeH5haC3cKa1Gq?=
 =?us-ascii?Q?gENl/k1XIH4AXFaWL5u5cFwsnEAbwo+W4NJScnKZ/LCoL3z59h0Ik/CvBPay?=
 =?us-ascii?Q?6vovOGJ6xU1Tk0bcxWf0tVMI7gelPWKqWBzhZTW3ZqTRWTT1ueQl?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26468476-db37-429c-6fbc-08df44e2cdf4
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 19:41:41.9147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uVXdLroUnxglfnx6AdTdFjaXaXV4p7Zl3Jj4FwogTbI6lc1YfB67STZzn2k37vUCAeYtkLpFfjCFY7uvX+lUwAlVNQaON+AooXPuF8jF5D0UxGA3ICFbPq35d/JHzKrj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB12191

On Tue, Nov 17, 2026 at 04:37:05PM +0000, Lee Jones wrote:
> When descriptors are freed on abort via vchan_dma_desc_free_list(),
> pt_do_cleanup() frees the descriptor without calling
> dma_descriptor_unmap(), leaking any attached dmaengine_unmap_data and
> DMA mappings.
>
> Call dma_descriptor_unmap(&vd->tx) in pt_do_cleanup() before freeing the
> descriptor.
>
> Fixes: b0b4a6b10577 ("dmaengine: ptdma: register PTDMA controller as a DMA resource")
> Closes: https://sashiko.dev/#/bug/linux-58b8113b-167a-4398-9be2-c2f3cbf73358
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> v1 => v2: No changes
>
>  drivers/dma/amd/ptdma/ptdma-dmaengine.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/dma/amd/ptdma/ptdma-dmaengine.c b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
> index 628c49ce5de9..a0a1c7ec2ae5 100644
> --- a/drivers/dma/amd/ptdma/ptdma-dmaengine.c
> +++ b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
> @@ -91,6 +91,7 @@ static void pt_do_cleanup(struct virt_dma_desc *vd)
>  	struct pt_dma_desc *desc = to_pt_desc(vd);
>  	struct pt_device *pt = desc->pt;
>
> +	dma_descriptor_unmap(&vd->tx);
>  	kmem_cache_free(pt->dma_desc_cache, desc);
>  }
>
> --
> 2.56.0.679.gc527c65306-goog
>
