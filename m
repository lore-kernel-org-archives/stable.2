Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.64
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793199878;
	b=ucoE2VkeK5NisXbIyp90s25XR5ucVdrCYMJE6zklvmcT6kx7ms/d7xHg6WiUGVQxjpTM
	 YEsvgkOnF9G29eVkwL7ZnFeH+o4S55hkK/7zu3LZBRkCsVAg6Qo/El1u59+YzPUEVPRcV
	 gy1g/1LgaFsJ/nLnxaPWfj5/i6w0O8yfHINGgEEjVz1ISX9E0i4QbLDlG5WLBVXmcspHg
	 r2lKkYPODx6PeVCSeK9jYtRxAgjxNfjMwYcG1reXIclwJglTeBSmHE2L7ra0KIPJjULwC
	 9mqq9uOyFgtF82JTGq8SlAmGyRXpqDJi4/9QcNeT3qWDmvCyYEveFYJsWomRQ0dE/ig==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793199878;
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
	bh=eND/ih9hF92FOwG77jgU1oB8HLyCHUpYo2BU5b+eRHA=;
	b=B6C+1eiR3Tv3ZcWED+mI8pY35uAXkmGffUMJFekMzmUkVm4CnEU3Sbr/NL11JB5/gcZz
	 RpabtbBcjVleJmHE4bzezc3gp2nLwEscplxIYA0rquiTebTzgSq2euROvaoGNPZapMtnq
	 N2ziRykac+BI48Pj5KKTCKNG7bu1E9pupqCsGfSlZlOTFsAYiMnA1li+0QN2dNIrx8lYs
	 EpuDQdsBZLI57/oTOVurj9RGl6Yif4SAtxuXbWSKhLnFj0P5orntMrJj9Ap2LWe7t+YY7
	 UqiPHTAv54s5Igh2MCf5hW3kmiatnkK4yAIetwJu4Ku073zGC2gmW7ohH377TTIiz5Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=gSfrQDIU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.64
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013064.outbound.protection.outlook.com [52.101.83.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA9860A2615;
	Wed, 28 Oct 2026 15:04:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DA9860A2615
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=gSfrQDIU
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MbbCKSO0y7BEajEK+LK/OVoiMy8C73WRYZP9Bmj93jtjpIfBIilSFCFr4jhGQGgKmHTRHGD6m9iYS653HphyRm5P4DVTMDS25pn3xeVS8gJhEQqIevzJF2rpFazgVCPesOn6BW7/kjomlExYDL64974J+2Fe1iJDkVSHSp1zLdNjD+nyO2FcV1b7/aFWnvobfpc11JVMXOGEVeKLN6M4B8DxoU2wzk4tQDSq3wIXyc8BEznlTNcnHuWqvgmHtqYZl5rCulhb7qjARNPDAMLw6QihhP2qLhtK7EBRH6NrW0+OPnyAlpVBmQT+j2APnv1P6Fq47YvfFwN+pBoCNCtmLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eND/ih9hF92FOwG77jgU1oB8HLyCHUpYo2BU5b+eRHA=;
 b=BtyU14GSdtTvJhj6OSWB+KrJwj8wPghzHZBEwBF+pkXH5/1lQ0nMbGeHo8u5uqgFhoKbDLPbpI4YPacMumc36zgcNg11xcDtz/umF3SEaXDLJljFCLOTvwz5SOckUmqzYnL599RnfQyxvOtPvFJaSTxzkeaZyG40UGzOILxY4TG2Yi/WKtdkxLqJEhhZSH1qiDhLGsg7yZ9C3AZ4t3OGgtr2/P+pl2MfkXDXmOOwJJkOT4joFuEUby7O+Ejpu/DS5IB9phyz30aEQsiVidK0iI5QVdS4UH70zfGYGmuaCtz0K0LUoLZrlCciYtwAFAgXIEC2V/CqRqof4QvF1iNZFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eND/ih9hF92FOwG77jgU1oB8HLyCHUpYo2BU5b+eRHA=;
 b=gSfrQDIUzBUeT5otGL8zxIVmEjlWa1iuJ2awFfyRwDvCGCN8sW2h8Kdd70mT6rtTjIg3SSDPcaXBGyyuzHtB4oW1Bp6TBfQhzr2p6W5GKPSejmjGJHOZWH3qeyV9rU8Vw2rf0iXPzqocjifbP8E6+r1/q+u16SPF/+0oXGdnytk1nJkKix7tksTxjBZKG0mBpjLk73VcwlV8q62k3OzmMf67ZGMrS3r8E5+s4bioJPPIt5E5HkG5H4doF8+HyoEg87hj++X2VeZ5nQQl2K6doleFRi3xtTCRPSLGTxNmjbiRwUA1yOMuRJiDzTXjWVE+riZIsd4dqzLVtz+2htuZUg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by AM9PR04MB7683.eurprd04.prod.outlook.com (2603:10a6:20b:2d7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 15:04:35 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 15:04:35 +0000
Date: Wed, 28 Oct 2026 10:04:26 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Jingyi Li <jinli@purestorage.com>
Cc: vkoul@kernel.org, vinicius.gomes@intel.com, dave.jiang@intel.com,
	xueshuai@linux.alibaba.com, fenghuay@nvidia.com,
	Frank.Li@kernel.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] dmaengine: idxd: fix double free in idxd_free()
Message-ID: <auIO-g3-ZSU0ac9D@SMW015318>
References: <20261028003708.834341-1-jinli@purestorage.com>
 <20261028003708.834341-2-jinli@purestorage.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028003708.834341-2-jinli@purestorage.com>
X-ClientProxiedBy: DSZP220CA0006.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:5:280::14) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|AM9PR04MB7683:EE_
X-MS-Office365-Filtering-Correlation-Id: bb6935cc-96ee-4134-dba4-08df3504c736
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|19092799006|1800799024|366016|23010399003|6133799003|22082099003|18002099003|56012099006|11063799006|4143699003|261022075727099003|261026140227099003|261026121527099003|10067099003|261022105027099003|261021123027099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	io9cVG09o9BX3OO0KS3lPuxIwbxOA0vITQ+lNtETKwmRjwxHFZoSMEInaFK3L1kGdUvoE4vwDmbYb+uR4nfAkxZGHsqqkSKP+jGzwCd4yTnihiPg5gu+SJ3Xw8VqgKaH/K461rcDjnNxFBrAshcdGhHbuLa/R3UAgqkoYuJ7dUpS1nfDIUhstvP3ILijm0yoplp+epJcVj4GTlhOdF27FyfbCiz6D5AmFkSp2iGXaxs5ktzI14Ml7fdxMSETMn3jOl5F3L1YV+vdezTGLzZoFawLqNaP7EEMwOExTbvVzqDqa1yyoqxdjgvN6vcx6zJlv6wKhyBhGdXLm9iyl0Z4T3e14MDplvYbGdCERA3/x7YmfGpqKg0Tc4Z6kcb01vLsRe4/vMj6bom1xdTL70y4DMOoTtT+bu/WxHQbfFgy2/mbFa5nO7+giXrSM9A1iRgxIgkoIshi3tJvx+PiTL7eFQxyXukHyqPYAyhED0T8v50Xfp1I6XLFEcmrQ76QIddl6ABWuhIg5NB+W1N8ypewUVZtYWN72Pb8CQOthp8//f31BJ6kP8lFsqET9+/M0iwYQEFGj4HPqYMkZWvQNfceus1zCS9gs+P6NIBcGLMCPf00TN2hDZjbr+I8tkBDgF1n
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(19092799006)(1800799024)(366016)(23010399003)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(261022075727099003)(261026140227099003)(261026121527099003)(10067099003)(261022105027099003)(261021123027099003)(261021121427099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v0WgMhkrr3iHFACi/6f7BUG/lulO/KySY9LEwAhdyhvhfjJBinz0Co3diLpb?=
 =?us-ascii?Q?jz/orsoPfrJa2DxD7k1zSiA8noD8F994dj9xoD3dLMXVSiyO3Zfhl+U8eAZy?=
 =?us-ascii?Q?MmSq2idd832EfjrsI5eii7ZD3PSSvGxsjSZgqlfsQ/QtB1+ECxu+Ui15y3/Q?=
 =?us-ascii?Q?SCihfDWMF9U3gSTDFnos+3kl0RxcYRgHdYn5r6wqXvpG/35iZhuBrbsql48L?=
 =?us-ascii?Q?CAOnrBvWMm/K6X0yVDQH9Kvt6ZjsR4SHgjC1iXa6MTCvUdqyqUa1yex1p8Dc?=
 =?us-ascii?Q?HO8sY5jGcy4auxnEnxxOrheXTERJe1ngi/ymTudfHF/XCdxp4TOn9CPXcPCF?=
 =?us-ascii?Q?LX5igf7uXMhs8i/TdAa6MQCHzPKAmfipknsaqABQ/+joeJEXmgu+IscaDZnz?=
 =?us-ascii?Q?n29OD+i4G9dj1ivGSLZWsD7/IArta/ub3bSVHG4dP6mLaqWCblncvqJZgI1K?=
 =?us-ascii?Q?UQdRxvewpQrYa6TzDPF3psUCTjRaTD3wrfdUHv7jMcOhvXI0+uA4azoMGZy5?=
 =?us-ascii?Q?3r5Wsc+CD8rSv1d58RBVyaeHn2G139Y5saYXSXZ7Mq+sgYR/a0yjAvVD19DX?=
 =?us-ascii?Q?S1p3KzxMW6PZsYCGkIGX6KIT57YLD3DU/gJS3McmVdymXTqzQQEJS+w+0nj5?=
 =?us-ascii?Q?JX+L6KfCa8P6Yy66C3kX0hDmnyuVTb03YMol76Nq1P8qDKe7KNhLmqAxEuZH?=
 =?us-ascii?Q?Snj96bp/Ee1/7Ng8zIytVaT5aVo262VdkEcnUWOa7qr2faRnjHVlm5xUmYYQ?=
 =?us-ascii?Q?kDwbF9Ku4H5JCbxHmMqYX9dpEh1jXVITdcqiGXGbShKPqrbTXgWB4+zguYft?=
 =?us-ascii?Q?dnM43OoOzG0GI3apbVnhyavm0OcbqZ+kypkYV8i+nHDScD5t0ezUFX1x4lO1?=
 =?us-ascii?Q?po6F+8f51ZbnKqH1d+sBSfQCUCzzKfKweN0HJDRTjN/cbLCwyek9Q12VwW11?=
 =?us-ascii?Q?Vx9nbQq36DgLzWQejqmQVDAV7GdjCGDh2o/03q/u9NcCRkquemykwe8jcbFk?=
 =?us-ascii?Q?NGFvBqGVtJL1PWNj/3xMNzZ8RzUll5YeObLxrRTj12/Radkm0UiwWahNxBSo?=
 =?us-ascii?Q?OwR8nj7SCrxDAe4yaLdL3W2eM0Qkk9GnjXGvYR4oSZ3CvThwRFrFAfhBVHgS?=
 =?us-ascii?Q?Xggk+CuSZEQSg2wn9AQwu3r/YI/0lHaGcrMX7KbRJ1dmggiuhpWGo1ydiKDK?=
 =?us-ascii?Q?/YqquZrdcmXCfoNxsCRQ+hqOooZHHRThhnjh6RhJzUHmcI3lr4Q0kqyF0w5b?=
 =?us-ascii?Q?NowqQwMXir+L/pZmZ3nVumRPOfGXJEbbSvDSzh3DX9p8qtBze3vH6FkDOHv4?=
 =?us-ascii?Q?uhezmhuRNPmw2TfmItn8t5mcs7ZktTLt6BhUeotNIyTn2V9PN8Lxzku5b9hL?=
 =?us-ascii?Q?J3F7qkEZ6+fEV48kfjYmFE83TZGxkgRLtFsTMQaCWluFp5wFQShL9qiWdtJa?=
 =?us-ascii?Q?1qjuUGqCYrRWgC8h/KG1XOhrFzSvBZ36zA/eXAtbB6AwIEKj3/kc1coUQ6ws?=
 =?us-ascii?Q?fxMfwES7iwkj7JE3k9FazrVhwpzrAELbAm7jkT4HEhR62GWXaW6trERe2YSP?=
 =?us-ascii?Q?pZlO1f0n5lXDw3+Ljz8wrRir0Hl/sFuwkC4dmWZZzWc1mGsYil43HlDtwomh?=
 =?us-ascii?Q?RFr/G9N1ovMv03mXS3WcDn/PysPblP1Y1R7H64+j4txnHtY1evR+bMU0gw6z?=
 =?us-ascii?Q?uOspnP8APiiqKLR4dpM2YACduTZSyfm14m76Jo2PyHyYl93/eoRv+0TAuUZg?=
 =?us-ascii?Q?CBt9Kk+vPYbtu0TxB/sC7RSk+qI57fu0qhKHJccXMPdsQqH3HAWe?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb6935cc-96ee-4134-dba4-08df3504c736
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 15:04:35.0074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kYjJWZNWGOHF8cMNQ6dw53v80/YS4D7oosB2TtZP/ohg9daJJ8rB4NDk5ZqLQExiHeuRkXLLpuFZof4uYL01NCW6PPP6cUtUviw8OQLR6PMK9g9g/Ed7iVb+0igMTgL5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7683

On Wed, Oct 28, 2026 at 12:37:06AM +0000, Jingyi Li wrote:
> [You don't often get email from jinli@purestorage.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> idxd_free() calls put_device() on the conf device, which drops the last
> reference and runs idxd_conf_device_release(). The release callback
> already frees idxd->opcap_bmap, the IDA id and idxd itself, so the
> subsequent bitmap_free(), ida_free() and kfree() in idxd_free() operate
> on freed memory.
>
> idxd_free() is called from the error path of idxd_pci_probe_alloc()
> when idxd_probe() fails, for example when the device reports HALTED
> after reset. We hit this in a kdump crash kernel, where the DSA device
> fails to reset: the double free corrupts the slab and the crash kernel
> dies before the dump is saved. With slub_debug=FZPU it shows up as
> general protection faults on 0x6b6b6b6b6b6b6b6b.
>
> Let the release callback do all the freeing.
>
> Fixes: 90022b3a6981 ("dmaengine: idxd: fix memory leak in error handling path of idxd_pci_probe")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jingyi Li <jinli@purestorage.com>
> ---

Similar fixes at
https://patchwork.kernel.org/project/linux-dmaengine/patch/20261012-wt-idxd-fixes-v1-2-30a35a445077@intel.com/

Frank
>  drivers/dma/idxd/init.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index 4b827a329756..1577d22b299c 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -581,9 +581,6 @@ static void idxd_free(struct idxd_device *idxd)
>                 return;
>
>         put_device(idxd_confdev(idxd));
> -       bitmap_free(idxd->opcap_bmap);
> -       ida_free(&idxd_ida, idxd->id);
> -       kfree(idxd);
>  }
>
>  static struct idxd_device *idxd_alloc(struct pci_dev *pdev, struct idxd_driver_data *data)
> --
> 2.43.0
>
