Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.37
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793203621;
	b=C9KEyHmgPQKwD+bYAc45k48MroSK0BssGe4vpLsPpEHFKz3vOquM53WTK0J4138GMF7+
	 7GZkM1+B0Pl6EodCOGmHbgSTdC6FdHO5F5Gq0L4BCj2XCtAHm3j9ggL3vYlHjNtWrnGct
	 xVhI4Jmrp1jicyg+o0yUAjsSDuSpFrw5oXerUMxwowxjXCR31RFG1dDCHAZV9eNhC0+JT
	 N8oQKC8lO57phBXUM/Mrnmu56Mu0ppmHIOKeTIiiTfB1TIvu84D/ELQcnzCQ3oK1UgmnH
	 Xg62ue/GNchFooGdUP4mAvEfYGIq01hIekhY/35SDRfzEIApZMnXRuOxUAtR0wf82Kg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793203621;
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
	bh=G3xez6l6UmcmjmiTXS2jjEVOasCGigrtkIzLD00rUJM=;
	b=Sl4oi8xKdh1gxVbzofk+sQlDS8mpvj3jP4jOU3lkNyP2qhmhzuwrIsqsYXiRnrKHobP5
	 ZgpuLBeVGLL7Pg34OHYn6luZnwkANbL3GgNR67Am8w504abrkSR63uF9yIFjHlKgKSJaY
	 lyAy+wziHk0BwcCsbn4rI1Nvcp/ktVuRWc4J1E5WUFP47k0xHcdqnMNBHBaBub8LkUZVm
	 1BUWqoAAr2k1ikkuwxIbRHedjmy77oUF1Aj+XIrEvfUiSRgcrWUDRQ8FjwHCZNt0Php7x
	 LTDwa3pCkpOqvNB7SxX/fsYzcTqVem5gG6rKEbixAWRnZ58CwyxLPNH+w0eWrrRQCVw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=qQuQl8ls;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.37
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011037.outbound.protection.outlook.com [52.101.65.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE12606A323;
	Wed, 28 Oct 2026 16:07:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DE12606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=qQuQl8ls
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GDUBFu9QjbXoyZiv7K5PJObRJ7eQ+Iyw8beXl8SwezK5FMfCgT5yLjnGgv/OSS3oBra/UnzbJykXrk+nOIMNOyWdTlX+mltyZTAOxrWV12CdwYYBjfmq7Gw9QNfYxdXtoxoQBRkhtjh8v6e2lvqj0Nxi0wHBdSpt751jldRAZN+T5M4vUwJFPhqoE9G1IBf/WIm4SS4WD/MW8X4NcSWSkIHFVeQfGXXNo+gdG2cnovt9OB1P9jbml+vgBgP4mlq/SuaG+982qpbOhtBgX4fk2eVkkKyk1rBuTJgcFOi8WscnJzwkKr1WylYW9vhimogbe9NUwYUiiq2mXDiRSU6RyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G3xez6l6UmcmjmiTXS2jjEVOasCGigrtkIzLD00rUJM=;
 b=VvhWfAMoG85Lvphs5FPALHWZ+Bk3EYLYMHY6ETmnftQADxlB5mv7wy+x3wa/DEr/063qs3e7rsHR+kafSUYl7Yl3vdNgaUDjgCyvG/1Mf4UhYnO+7tIi/zmOJhElvEDA14hX7zqix33XB1r8zu4sYH8rrQEtCvexdcsLjZe9oQ1pi5nNDjfxDi3F/sxTXNQJQCUgBeIy5gNFkR6EyX1Px1j0zvK8wk4RJef/2nvy4ouEspx5tjNkk78YsuSLHOE5SpZWpTz3gaWEPf4C9G2ZdS9DRaSXtZNXTu33jIMNL6iIhV1p2gaWfQl3Hl08RmRdfZLd85VqKsAim0yJBn67qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G3xez6l6UmcmjmiTXS2jjEVOasCGigrtkIzLD00rUJM=;
 b=qQuQl8lsznDRZlHl/3B2Lr10mTSn1N5kiSg7DA+AKOaA+AozVdQ6RbBPWxTkPvqK/536WcnQsqmdwrJUkUPMJpRC9UOcvleb9RWB+cltKJqP6dlUYJGg1MuBTZQIgSJZ/aDjV04rbIPvz10lQFF+NB2RVRys0GLzpUKnt1iAam7k4tOwlU3KsmIIPAmSma0SOukjdC2hDs6pFd9THHVIUVHNi9ckHoXzXSh1Yrsw0NCUm0UVJh11sSiB3lfD3Iaya1EKkqE2QPNuCA0Mcmxaq7MTM2TgSAbf6QuXM/2Ryrp6B7T98rlNP/uXP0Wz16BpKwE2NnBaThRlDok73ptPNA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by GV2PR04MB11921.eurprd04.prod.outlook.com (2603:10a6:150:2f9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 16:06:56 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 16:06:56 +0000
Date: Wed, 28 Oct 2026 12:06:48 -0400
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
Subject: Re: [PATCH 2/4] dmaengine: loongson: loongson2-apb-cmc-dma: Fix
 residue for queued descriptors
Message-ID: <auIdmAvMsz193TLx@lizhi-Precision-Tower-5810>
References: <cover.1792988985.git.zhoubinbin@loongson.cn>
 <bd120f2c1ab291645a21b1cf9babdfcc0412cac7.1792988985.git.zhoubinbin@loongson.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd120f2c1ab291645a21b1cf9babdfcc0412cac7.1792988985.git.zhoubinbin@loongson.cn>
X-ClientProxiedBy: DS7P220CA0113.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:8:25f::15) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|GV2PR04MB11921:EE_
X-MS-Office365-Filtering-Correlation-Id: 25a6ab4a-24d3-4b9d-ce81-08df350d7d77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|19092799006|376014|23010399003|261009223027099003|261021123027099003|261021121427099003|261022075727099003|261022105027099003|10067099003|56012099006|261026140227099003|261028144727099003|18002099003|22082099003|261026121527099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	bG8QplTp+dsUzohujHNPOQev6yt9DggxWMotAkCbHIynlQBJO4wgWKcEBLqcRfiRZcHP0vqf6WBUDlP96FCzlnuqgGsV1IWSIuoMbPNIVVvrqvaHZsPju+cgcyQ3vSCk+OMS42NN8Fi4YdLg3HrhCVRjtwaFvMIM+opfMj2VOnZ13uqSnUDHWjcRLdnIyJ1wAtJxp0oeQQx75Ohyzc5TbS8j/ZzWf8LhxNTsCUhP5O+xPFSM9XUbb5OJPlLZt43fWS7PLFzsqkQdS2iBRgxCjHd/NCtbB3niHf7K+WNJKhFeEna8qIrRZr3inO5BSnWYBbFMEYGCrO87j0DikSqmaYN2XSn9Jc3b1I6jhrDrIEwLtZhmFR3DATJeri2MMgci+lnnj64EXyD4dfIRCvbNcXvyFKx5d4sJ8lL2WylfEvSKGk03LNTH1tBkqnFFgIaec1CqF6UfHaLex0pSVfV8zwuzyWP7Tk8QK2ckDePS4OpY8NIzs7SS7aGyacmUdbWVaz8OvlWReCCwlsDG4puiAszR/agelRxzPz81ICK63WA57WMr4QxCkIt7j2cqsijqBnwfQ4eQsgzWNNamF/5gjtdJTFJdWslJ23h0AcyfEuC/1YrguUKFn+QJ3+8+sMSAw1r6TCKebAQczIzRORQqMMWqq60Ku7s9VPhzdi7sTWQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(19092799006)(376014)(23010399003)(261009223027099003)(261021123027099003)(261021121427099003)(261022075727099003)(261022105027099003)(10067099003)(56012099006)(261026140227099003)(261028144727099003)(18002099003)(22082099003)(261026121527099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Vn87ZHnQP4iEbYjQatGowTSQr4s279ZR9dYocCIjOVaeKb5Y6xGJYYb/vJ9i?=
 =?us-ascii?Q?H4agBNdQtNwPyun71/4Gvq7SPdkSmz3KPHlkgD67lckWrXkNiVbtLjnpfZGn?=
 =?us-ascii?Q?7BXaXUSOd30+o53TAjFMZ6foWfi9X5mQc48MuyG1Yffwer0i7jUKd9NWs66p?=
 =?us-ascii?Q?dQ5+3pxFrrkzHQKMWcRQzeGMlWm9Ygt1Vy7nN/4QSo6Tqoblv2d9S19NwAaC?=
 =?us-ascii?Q?u/W6uILBLykVHONJQdWzWo5X7kf7YAnPJLxbWdNIR+dfucaxKJWyv1u+BlM+?=
 =?us-ascii?Q?J2IFJ+w5NtTDMQ+idDwNfCAshEXyFnl3XjSeiYEbDAZ1Ii5ZZzJh+Wp33erF?=
 =?us-ascii?Q?shZkY4Uzm0Amc22aTh8RweN8aE6Q0NudClRxUbP2kkS64w6N6YYBts1wyu9G?=
 =?us-ascii?Q?+rd303V55dMJcSOBzS8DjMXNPPf80mIc5rORcsiTz5OfbRbwuTzzDthmhVGc?=
 =?us-ascii?Q?GDgIQiS0+Brb7V/qP7yD1mc39RUMPjS4D4LqtqmPzkXLSG7J493JnoImieOt?=
 =?us-ascii?Q?9jNAYD3V6yHdk+piJLs02FnJ4gIIAY71PY6g/xc3jPwKH7kemxNcIKUtEe0p?=
 =?us-ascii?Q?p5ZJ1VgWd+X1oB5dXMqOvz09U96qd6dzedqBvJPvGIGeykOFb3VT//lQLOFI?=
 =?us-ascii?Q?dKexQjMr08YZ3OSl4CX8OjrfqliAKUA2FDbFoJ7qitCSEMteY7lJII44hB7Y?=
 =?us-ascii?Q?EFlSDDjohenXkmKeWuOBkdS0gBo1fV0ogKRV98opRu5OB0tMV+dznK3UubNr?=
 =?us-ascii?Q?+qPVEkJ5DgNAwLShPvb8EkaZncTST6h+gICOp/xrGz0nG8bTGDiwOKpBCyi2?=
 =?us-ascii?Q?72OqgKrsJ/qlvETpubvYuXyhgXsxKH9rE+Wvbl3yCgbj1hd5M2nYuwSxpuhy?=
 =?us-ascii?Q?XTSvp/jawMxzagaPIQh9yeVNI5H8IfVJBWzcPennqrJz0VMqZ/C/KZq5sq7f?=
 =?us-ascii?Q?OocfqE6tc5qo3/Vf/dOqx4yHR9kDF9pjZyq0TUB29jUdy+NekL5OoRUoopan?=
 =?us-ascii?Q?giSv4QxYtypBbZmenDqSc6LaOe78ORx+eoqq6dnZOBegz8biIplh6hYeotzt?=
 =?us-ascii?Q?0GFz07kJs67EdGPdC026lupi37gRva2G+RWJADPrVsJX11u9LJTQkEbtsdyv?=
 =?us-ascii?Q?mM+lnCoeY7cC1eQy9TQNtJu4uz3kZR3KXMUXGoObnS4iqT2kKBIV3acEpQNv?=
 =?us-ascii?Q?mHh7k+jdPCPtMt/TxctQ4tHR8yk4tNFoEM9ZgtV8nVUPMNZHn2HWfWL9SS13?=
 =?us-ascii?Q?uH/kq3fk9qYBIvUDKvUzW98W9vOyprGqno0842U0KD0AvKv9j7sonnMMBTSp?=
 =?us-ascii?Q?93oUsRsHErrcNxBfij12xsPaYujd5IIFG6Y55l+qgyVe4R30ouxj5KI/0YoM?=
 =?us-ascii?Q?5IX0WsW0Sps12asKWZXL0bPMxuJdZjiboO5GO2pN18wAHzxLLPzCgmiWtqOx?=
 =?us-ascii?Q?2iew6Uh9petpBvU/9i6SR+vHyhCcrriadwGdFYQMLliY/z6BjppdjpmPRxdc?=
 =?us-ascii?Q?5gX9aOIURwxPVF4AtCe+QEeKMiOndF7Ng9fxArVEKB1Wk5kBX+LzE8yebm5A?=
 =?us-ascii?Q?H7kUHSlF4G6iXFAy0U5ZSZLXkwDyZo/Xe9XX8CCWQkX7uMPj5QBI3lfJssZZ?=
 =?us-ascii?Q?hNq+vAYNqwiw4JG6mMT+MaDNZ7KSGdFuW2GzknljC4d9v4fXY0uWsz5bbkxS?=
 =?us-ascii?Q?c2PIY8zChbnPUujmK3dyl3nFT2SMP1NDBWN8Zl42/0Dn2OZHOY9ZcdSUu+1m?=
 =?us-ascii?Q?MBxZwGciEU/CjyJiiHtjH5oqp2tknGjKvP1Do+ZW0dxb63cABQiS?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25a6ab4a-24d3-4b9d-ce81-08df350d7d77
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 16:06:56.6435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t3Qe+iUEsbM93p+g5gD9k/WnoxoYyDn9JbBPSDCTSnDnYsAeOg21/Lvcybj5zMYnmehrqUqOJNSUkMZf1bk3cjk8ifb5i4U60pSe8nwMe+HTt8gnLHq972fWyghuVG4G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11921

On Mon, Oct 26, 2026 at 12:31:21PM +0800, Binbin Zhou wrote:
> tx_status() computes residue for both the active and the queued
> descriptors through loongson2_cmc_dma_desc_residue(), which reads the
> hardware CNDTR register. For a descriptor that has not started yet that
> register does not describe its transfer, so clients can observe a
> residue that does not match the amount of data still to be moved.

why this happen, suppose write CNDTR at loongson2_cmc_dma_start_transfer()
when issue pending.

Maybe there are raise condition, between send to issue list and start_transfer()

suppose loongson2_cmc_dma_tx_status() should not find vdesc by cookie id
if issue pending have not complete yet.

Maybe move loongson2_cmc_dma_start_transfer() into lchan->vchan.lock, you
will not see this problem.

Frank
>
> Report residue from the descriptor length for queued transfers, and keep
> the hardware-based calculation only for the active descriptor.
>
> Cc: stable@vger.kernel.org
> Fixes: 1c0028e725f1 ("dmaengine: loongson: New driver for the Loongson Multi-Channel DMA controller")
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---
>  drivers/dma/loongson/loongson2-apb-cmc-dma.c | 23 ++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/dma/loongson/loongson2-apb-cmc-dma.c b/drivers/dma/loongson/loongson2-apb-cmc-dma.c
> index f090fbe0b8a1..8b8d530d60c3 100644
> --- a/drivers/dma/loongson/loongson2-apb-cmc-dma.c
> +++ b/drivers/dma/loongson/loongson2-apb-cmc-dma.c
> @@ -472,6 +472,17 @@ loongson2_cmc_dma_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr, si
>  	return vchan_tx_prep(&lchan->vchan, &desc->vdesc, flags);
>  }
>
> +static size_t loongson2_cmc_dma_desc_total_len(struct loongson2_cmc_dma_desc *desc)
> +{
> +	size_t total = 0;
> +	u32 i;
> +
> +	for (i = 0; i < desc->num_sgs; i++)
> +		total += desc->sg_req[i].len;
> +
> +	return total;
> +}
> +
>  static size_t loongson2_cmc_dma_desc_residue(struct loongson2_cmc_dma_chan *lchan,
>  					     struct loongson2_cmc_dma_desc *desc, u32 next_sg)
>  {
> @@ -518,12 +529,16 @@ static enum dma_status loongson2_cmc_dma_tx_status(struct dma_chan *chan, dma_co
>
>  	scoped_guard(spinlock_irqsave, &lchan->vchan.lock) {
>  		vdesc = vchan_find_desc(&lchan->vchan, cookie);
> -		if (lchan->desc && cookie == lchan->desc->vdesc.tx.cookie)
> +		if (lchan->desc && cookie == lchan->desc->vdesc.tx.cookie) {
> +			/* Active descriptor: compute residue from hardware progress */
>  			state->residue = loongson2_cmc_dma_desc_residue(lchan, lchan->desc,
>  									lchan->next_sg);
> -		else if (vdesc)
> -			state->residue = loongson2_cmc_dma_desc_residue(lchan,
> -									to_lmdma_desc(vdesc), 0);
> +		} else if (vdesc) {
> +			/* Queued descriptor not yet started: residue is the total length */
> +			struct loongson2_cmc_dma_desc *ldesc = to_lmdma_desc(vdesc);
> +
> +			state->residue = loongson2_cmc_dma_desc_total_len(ldesc);
> +		}
>  	}
>
>  	return status;
> --
> 2.52.0
>
