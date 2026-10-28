Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.71
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793203938;
	b=44jkSaxv0pV2tXCRSmPsAC9ral1moeYd0tR1/n4tlVGHnVoz15rWR3JWGRK/WgoY3JnV
	 UQ3UcGXFwzO2F+rV6XSaf2Jt5nVe3qEwJ6Kxs2B+nlvFkg7oSKfyG0/7QAVusLakm59iR
	 n7nFtEtaTL/5BaCzMfkkutIAJH+uXuhEmKKUF4fzMwdisPCXRHWT9yQRCiR6115b1HvWY
	 w8aE9s8i6T6UEyRrwRXjeO0l6fWiZ1Onc355MxYyoCpSAmuSkrn2zOTKbnUqr79UdVXEv
	 EdSx1AJGnTPB/6UCBGyDQ+mfUVF3hyuo60p929S5UqOoRi0K6ycqmi6gNrlxgQILd9g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793203938;
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
	bh=YHN448zXuoTGYZeMMIPkhkoK6i1h9S+Wk/caGytdHNU=;
	b=QLtiAffRLZ4nzRGVMfvg+TeKMCbeyjemLkKoexu+XSnf1S3bqhLhXEBfiBCIiZ45E8Av
	 98qlhZPEwvNEoLW/NVFW1Bi4RLGS5ZxmJgAY25aPpIZV0+4+7uG6RgDCDRXHJoTIjbGkx
	 OCt+MdTsVftBHwfpABpc4bdR8PsXt3UUTpZFHOaOoXzdC6NJExksZT9AIVdK8zOda4bqw
	 rqjL6TjkjrblyOgz0t6zXXM2+NqRkvrf+7+4uqmpX8K+q3iia4zkVg5LJwMuZs8hFHBIN
	 TBz1/zwbsjRyKHMqR9GuSW3O5TAgXkjGtqc5gZJzsTBvtE+wrdUHb19XTL5m7j7FfGg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=kU1upY4P;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.71
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010071.outbound.protection.outlook.com [52.101.84.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A270606A330;
	Wed, 28 Oct 2026 16:12:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A270606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=kU1upY4P
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YziWjvTn+XnFSr566/Mxc0cUS85M6Pl3+6h5ib+gX7uFa//n6qbtQs6FyovbKVj0WzI9YFtV3fns+ZOzJAPPUcuMsLJGmnyNSQzXy4ODOS5S5kCk6XlYZ/xX5CwGrLN1ZwrW6L1VZfNglUxBofBXEjbrydmG5QN7UzWwFpfYer1TxvXPQnsYc5tYRGcNOjxR6aoNBoo2q9agD4R8jNQsxXsTh20/6J6XnqFfSVeCfGOuZ9kHvFUPyJklOIs4vpoIAJrr/mvsH+iLhXOjwDMOOVZ8/aicN7c1JR+Z+eivpN4I7CtSXvwMHeZC4eL/Ai1AofmN8g9Ct7BXmRP9vUJExQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YHN448zXuoTGYZeMMIPkhkoK6i1h9S+Wk/caGytdHNU=;
 b=OOvBLiOn2gs26nJMCJLe43tFztOvPW4zPzKKuXpEtHMt3QomI6U1VKFWrOoGqpEBUaLdFieo1TuxcLMq5Bm38lP+Gv5z++jWeYt0+FYCNrsrwMlamMIAlsI8umsenefWT5U4EBVtAHVisKm1kyMhNOWHr0aD6lGcgj56ZiSMyyQyrbo4A3JCKiCdlWWOI7tVHELXBOLulH3TitXAXMhl9Cqc/pW8u+bDD1h6zBy5sanRFvorVPKpBy2sUy+H4uMlCqORrXsWEq2aNc4Ft4rqP6s05Uf3mfMiRgVeEfpV09WEfynoa3AdaI/fg36cvhXsuhYDEhhNNjILq4y8i3AcEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YHN448zXuoTGYZeMMIPkhkoK6i1h9S+Wk/caGytdHNU=;
 b=kU1upY4PTEdosufzGVe8cg3jpzrCwojriB//AAV3XlAfB4N3y/cunq8gnsPVZhWJqR/2Vvd2v+15+Ntrd59aynD7IAA1PnzF3IFluQFWX93pZrw/mewAaSAmtGim7cSy6VrTmqQEbskDDwvTPXi4IPFxwECekUnEtRDU660GiUzQUUoVVF6fH0vklCj2A43GdY4+hUtBBP1FDdN7WZ8S4TyyZGYXivZ71/4NAnFRLCbgZXyqPmW5CsW5ArHEl5CWjH/nr1nA25UiPpWbm4ncTY+5DISMYhXCMNPrZUGLXFfIQZ7ZaSxD0M6+YPZT+P+wFASInVvonW63NH7ihs1Ziw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by AM8PR04MB7780.eurprd04.prod.outlook.com (2603:10a6:20b:24c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 16:12:15 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 16:12:15 +0000
Date: Wed, 28 Oct 2026 12:12:07 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, dmaengine@vger.kernel.org,
	Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
	devicetree@vger.kernel.org, Keguang Zhang <keguang.zhang@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 3/4] dmaengine: loongson: loongson2-apb-cmc-dma: Program
 CNDTR when advancing sg
Message-ID: <auIe15pAb8ZZWbnV@lizhi-Precision-Tower-5810>
References: <cover.1792988985.git.zhoubinbin@loongson.cn>
 <dcb49d67055cc41af3bd68cce01c05e73a7c2787.1792988985.git.zhoubinbin@loongson.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dcb49d67055cc41af3bd68cce01c05e73a7c2787.1792988985.git.zhoubinbin@loongson.cn>
X-ClientProxiedBy: DS7PR05CA0008.namprd05.prod.outlook.com
 (2603:10b6:5:3b9::13) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|AM8PR04MB7780:EE_
X-MS-Office365-Filtering-Correlation-Id: c706e7ce-f92a-49b8-571e-08df350e3b68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|19092799006|11063799006|10067099003|261026121527099003|4143699003|56012099006|261009223027099003|261021121427099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	u0E/V840xbLrUeyG9179gJ1n1w3wbcwWzyCfp/cnJ9DH6k4fvaq7Th1bQXR9JSx2fGFELTiVOMn3DxMUpXfK9p5KNvv/nwWhf43W1v8RwNvw6bu8E5GDWpeHL/MXMW7fE5LlaUKAmdGuAlSY/sl7Edbgq6bY5bpThQqGSkOCKiT5Ult1JFig2XHbctZM7hTpNX97kTCfblFvR5/BclcfZ3hsxG+IDC5O3YPYqJqh+Fc6mEdtO/E8KwogH44Owcka+dnDAhoEZkmoPBsmG96zK9gQ70lQ1X1PyCxqDlesc7XD/Wb8poyFiuio60RfwGotzjavEcx87wsmauvRWhy2/GR3y+YXexjtuL2jXO5wnQKXFmhypiU4fKwHwE9wJ17AfIKz4vzUsECKOP2PjJgIUtNbtHBD0gzMDU+5pcbx18QkCYkabjtz0UX0Xp8NnmytzU63lEU8ABvXyK6BL2swF5q0zH24c0l90KUslzrDwRfHA+ctAwlZkovQf0CwMT3Y/FXsoSNEuBjj5rHk5SY4Qgwc7dfQEbBaE/OyitFLEdKM+53QlwtuBwqk09waVcdb6dswJCJBDt3DCAMWTR6RXvkU4GKwe75m4TZkSGDiKDM8y7FZFtPuOObut/i4S4tSuWAP5QSIBlh2YZ9gCZ5wjgWT4PyI+J2N0w7+H76RKsU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(19092799006)(11063799006)(10067099003)(261026121527099003)(4143699003)(56012099006)(261009223027099003)(261021121427099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PouF9vfuhCgcegKV+SE3TQBDYtlMNuZs7WS4VTzUrefUqYvmQ/2CvdDgg6ah?=
 =?us-ascii?Q?RvbBlMd3mpyTZ4m/mVUpiurRNyHlsncZNZPJDu0XIoX9o5cT9ZKTvFlxb875?=
 =?us-ascii?Q?FSfp7z7UQ1sY2E2uTpZZsn0IigpWqO+Ts1+MiH3NcOvPt+cJGCuxf8m4uYR6?=
 =?us-ascii?Q?c3HY5fUEr70fgLbKMCKd4uI2zLlSesH3sk6sGonC8sPiv6xk6ZdG08iTQpwC?=
 =?us-ascii?Q?nbYlgrm5nSIR9xnASdJKAvh/JPFFsCibL7VzMvCf/V0tfFdkB+Fs/sw9Kt/A?=
 =?us-ascii?Q?UgZxiUuSomxBNEvEMS3GMCxkwVSXZhs6T8cwzmrVU+EBRZQvezMTwkE3xtmW?=
 =?us-ascii?Q?h0g+jVXgjwgSe60FyQGw3s0QDyPP1IfE3AwBqQKOjZCpH9S+WhSuKYXfZ7nY?=
 =?us-ascii?Q?tvoWSaoCilHiCln9o1zNI37M+jQ0yfIzpYTMVlG0OJjdyCdjlf1bXupxTVma?=
 =?us-ascii?Q?DKMKM0DuajuowP2JiOBLvFXFDgziqvpMD//HQyqrWYcvv8bCw+oodEqA3/bi?=
 =?us-ascii?Q?moJalco1QFZki4f+3rNoKhSW84OVRE+8PmnePRCvk3SBRdzPaCgR3XCerQSm?=
 =?us-ascii?Q?vzs/DjCzgfRvz14Y0f3A7lXkpQ3nKO/hR+7+muj2YnhpeWloIaSNVwBhFhxM?=
 =?us-ascii?Q?uFP6aS+fcvLOdtSO2Z3+l1jIvW1wv+DdGSDjzonqtIbPWYmujOUFX0sFu93D?=
 =?us-ascii?Q?5iqbtWbBpcJ0n2QWYtpcMzo0tHm6ghf0bzH/aMhJoqvBawbkWRZWdxf1VjaR?=
 =?us-ascii?Q?hM2ngLh95EUru3P7zwzdrBpB3dLtH3mdvlo4PIkJNe+yvhH7a2vityMoY/cN?=
 =?us-ascii?Q?G2rwWHr3X9zp6RFt2VKjbTqOZBWaRMwpnqIJMsniISxIxejh+pPvWcrJ7Vwu?=
 =?us-ascii?Q?FLhaWjeKKWOFbK81QT3Z7yI46VcYxqodC3q/q8rdauS115O3TFXWBFuQlDSh?=
 =?us-ascii?Q?xRKmViWL2xHM8zX47CqnbIQSiEETelgTwDThj17YQMJ9oGwyl4ZwV6hn1iu8?=
 =?us-ascii?Q?bp2eRb+bDEUfVDWsnvwm0YK8OqUZNKC3nMbGtPuZpQSBK7PRtgRGxG6E4X1A?=
 =?us-ascii?Q?YhTqn2SoN3Y4BObMEt9gtSSqpYOpi4K7QEtYEH6DjknZbda+lVvZGvT9AOzw?=
 =?us-ascii?Q?PIF+sCEmzPk3P8WOqKwCJFw/F/l3Lyuy8PNbGYE/Clh7SARpySRYNL687B37?=
 =?us-ascii?Q?b16u+xaWnQwiudb4y6OrJd6wOLdpkfo5c8MdWzz9W4gf7NNlGMY4yw6CIfMh?=
 =?us-ascii?Q?NebXgl4wmt8er6gqT1MAJIcAy5knllqz08d8TkYpImQz9vNRScJcXK3CK62w?=
 =?us-ascii?Q?7PDJW429uDV/vnJwweEs+14m8ObWSuwvw7dtFFmCGIB77UDOGsLRpgQKyYzr?=
 =?us-ascii?Q?wxZLE9MBa+W47mlz8/JTvh9HGeqhydTgjuYnnaCX8Z99ADlZI/DwyMBueKox?=
 =?us-ascii?Q?t07+VgIdoHLLrXCfoDLumx5R9xkNAxOa0emlpecTMmdQXewk/N8bxeAr8qB0?=
 =?us-ascii?Q?YdHkxnx+nSnf8w0pnPz+z83RoTUdQ6gl0royYofNwF9vTt6uPVwJojlbkt5E?=
 =?us-ascii?Q?AyE7ZsrN3lO6IP6AS5L0ewdWhz3kZ58BrfdEjx9onPyvuGTHg+5lBwnIK1Oj?=
 =?us-ascii?Q?U04aRP8EPHkZKTFw1jhrvkjGQDhH2cvDoOFhvF/DR7vuc5tRUYIXi/AZNVf1?=
 =?us-ascii?Q?UFS0BkbMc07JKrJsbseFhAgQRljY/71lAsWt3EMHn5ewJU9ec38S+ltzdxdp?=
 =?us-ascii?Q?afVJAOPByb8q+zT3zq+VoEvtW9/6FNODwYCmvXKdWYBR54r+nbbM?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c706e7ce-f92a-49b8-571e-08df350e3b68
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 16:12:15.3048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XmrmjAYivP8rpQI/37LGU8UMYJ0imqnH0lcOGe6QhSdmhdAiVJ6Dti9gMePJYOjk6takn3P1wELL5cPEnT7oE2nOl1TFmz3phaz7UGWF3GMMHEJ1AYgQ6SIp3b++WvAn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7780

On Mon, Oct 26, 2026 at 12:31:22PM +0800, Binbin Zhou wrote:
> When configure_next_sg() moves to the next scatterlist entry it updates
> CMAR but leaves CNDTR at the value left over from the previous entry.
> The controller therefore keeps using a stale transfer count, so the
> hardware does not move the amount of data the descriptor describes.

How it works at 1c0028e725f1? not test ?

Frank

>
> Program CNDTR together with CMAR so software and hardware progress stay
> in sync.
>
> Cc: stable@vger.kernel.org
> Fixes: 1c0028e725f1 ("dmaengine: loongson: New driver for the Loongson Multi-Channel DMA controller")
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---
>  drivers/dma/loongson/loongson2-apb-cmc-dma.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/dma/loongson/loongson2-apb-cmc-dma.c b/drivers/dma/loongson/loongson2-apb-cmc-dma.c
> index 8b8d530d60c3..c654e0572902 100644
> --- a/drivers/dma/loongson/loongson2-apb-cmc-dma.c
> +++ b/drivers/dma/loongson/loongson2-apb-cmc-dma.c
> @@ -266,6 +266,7 @@ static void loongson2_cmc_dma_configure_next_sg(struct loongson2_cmc_dma_chan *l
>
>  	sg_req = &lchan->desc->sg_req[lchan->next_sg];
>  	loongson2_cmc_dma_write(lddev, LOONGSON2_CMCDMA_CMAR, id, sg_req->chan_reg.cmar);
> +	loongson2_cmc_dma_write(lddev, LOONGSON2_CMCDMA_CNDTR, id, sg_req->chan_reg.cndtr);
>
>  	/* Start transition */
>  	ccr |= LOONGSON2_CMCDMA_CCR_EN;
> --
> 2.52.0
>
