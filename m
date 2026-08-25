Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011005.outbound.protection.outlook.com [52.101.65.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790C2369D64;
	Tue, 25 Aug 2026 01:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787622987; cv=fail; b=i9ibtZDmctnFP1JsTFj2WSLSgyYrM5+Dmp3ApebDBrrFvTlWxxhMKwR44nMB0YR1QZPL2y3+atgPhouKcXMQXGSiXC9/fUz7RfU8ShPQ7fKOfYvaQNAva8r5tXmsMTa7Yw1GUppNVJPgosu5SUez/rBUnzLzIppFNpb3l2GQQVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787622987; c=relaxed/simple;
	bh=gtgQR/5yhnD6Bk3GuqGENf33R1TT9Vk7pclEIgTuDjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cNA6beftEW5sa9wZyTDAOxzeSJdXMqYYDGcpnQ9krB9057o93zbYfq3kdVSii7tqWza2d34J2DWAbT+AODN4VEVXV9W/ExkfDUYq+vyGAS2v/8iTEGQdZlKHDrcc2LbeggBz8Z9Bi/BID2jxvGh0pSlq4BDluhsd0GJHAjZpuPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=PRf29jzT; arc=fail smtp.client-ip=52.101.65.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="PRf29jzT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FkIpcpgVLMYmkzhHZoMM8moVIaIS6772syhckdXC+X+HahizWnZgDShaHH1ToQY283PIlljwuvbG12VDFxJSAnMM3pELA+NBnr1nZArPlqzJBwWniWEp7cg/0+Uuzt2X088HTNeLGq2Ph+bSzqAs7hCvO+wbmSMe+s3WY9NyIXQlpWO7C/cRe4o9ktibA7kp1shUfi047nx1V1zxKJPCwg002/dw4z3dW6BtnvRz26fQJzLQlvTmmJSIQ/qQ+pz03emY3nzeqTt6Sw4hg7PK7gmtmRnJxMNFkW92FSCvjsqFo0+ShKLmbmivUws9Z7BiLPfnUV6j7CJh+OmmvOe6QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+v5cy/H89kvCQEdHI78GCf4wJubjuMMLOk+Whx5RPQA=;
 b=hJHGFw2c9F+hpffyC8B4EfsR0x85aYg86i2QgBtWOCiRsqOjUXXwVfYTcbnigpsW4OKA+B4L2Gc9ME1FJAl+C8F8xnjjpon/2tZsWICYOtgsSXkk06aEWyPkSdk+aVeopo18J/vtT8c4KLEFLgyr4ect9Z0iHDyP57EdQk+mXuBpiIAqSXmsPWo0Imww442D85FyQ/76FR0ynsv6GmBwe0fyGk8PxpIxccJxfp09MG3V/fSxFwSX9bmS+IqJ/pzzkL7n1mespNjAPryUbxt1BjKpw4UONrvXXzv96itA34SXy65FbpwtymjF9h5GlYocyJ9Af70hRCy6Rl/JaDHFeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+v5cy/H89kvCQEdHI78GCf4wJubjuMMLOk+Whx5RPQA=;
 b=PRf29jzTwdx0ADRkJ0PQXTLO8/7yQvv0ZUVQ7grmuD18qfHgo8+6zk2u9vx5XG6WIF4OJ3BSx3Ua4B/mgmAOaH3ayic0f9bN3k+JowMc53rXUNv/Vm103zlX42AZSE/zV/FKH+J+JvbsbU8rCCMmj1bgJOO3IjrDX+Kc0nQngthAEC78nGeR332FX+ai5WNFYH1zZmrvTWbzJjI09pKDKg41APOtTOKTzFp36NgREQs2DSxtRtT46+sieKnuxSR2eisMaXE/C2wbPmEFRGYjQMzvY5PVOkKL/yrkrlbNA+QFp6tVnqZy7l3+p/JQ9IhhbGMwanjnbYsM3MgIlyR5ig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB7PR04MB4698.eurprd04.prod.outlook.com (2603:10a6:10:1c::21)
 by PAXPR04MB8957.eurprd04.prod.outlook.com (2603:10a6:102:20c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 01:56:20 +0000
Received: from DB7PR04MB4698.eurprd04.prod.outlook.com
 ([fe80::c571:bdf2:afe7:c03c]) by DB7PR04MB4698.eurprd04.prod.outlook.com
 ([fe80::c571:bdf2:afe7:c03c%4]) with mapi id 15.21.0339.007; Tue, 25 Aug 2026
 01:56:20 +0000
Date: Tue, 25 Aug 2026 10:56:07 +0900
From: "Ming Qian(OSS)" <ming.qian@oss.nxp.com>
To: Shengzhuo Wei <me@cherr.cc>
Cc: Mirela Rabulea <mirela.rabulea@nxp.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Hans Verkuil <hverkuil@kernel.org>, 
	Ming Qian <ming.qian@nxp.com>, Nicolas Dufresne <nicolas.dufresne@collabora.com>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, Bin Liu <bin.liu@mediatek.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, irui wang <irui.wang@mediatek.com>, 
	kyrie wu <kyrie.wu@mediatek.com>, imx@lists.linux.dev, linux-media@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] media: nxp: imx-jpeg: cancel task_timer before
 freeing ctx
Message-ID: <aoz1dUszJJv80bkj@lsvm11u0000189.swis.ap-northeast-2.aws.nxp.com>
References: <20260825-media-timeout-work-v1-0-ebfebbeb6c31@cherr.cc>
 <20260825-media-timeout-work-v1-1-ebfebbeb6c31@cherr.cc>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825-media-timeout-work-v1-1-ebfebbeb6c31@cherr.cc>
X-ClientProxiedBy: SG2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096::17) To
 DB7PR04MB4698.eurprd04.prod.outlook.com (2603:10a6:10:1c::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4698:EE_|PAXPR04MB8957:EE_
X-MS-Office365-Filtering-Correlation-Id: 53ace764-54f0-4ef7-898d-08df024c0ed2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|7416014|23010399003|18002099003|22082099003|11063799006|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	hTUeSg0tsF47yrK9SQK8mAuNub6vZ1aVM7k3b/YMO2wsaEjKk98Ov594IB/YZOPXGc2PNQWSo7nFhvT8HHpNus45IuMh7VlU4NGw8xIc4onJCYDwtHFmWFP/d8qsVj2gVpG+wJW59Ocpao4MiJXL9R5PkPXN6kcdwI3w6UDPQivytEx+8oJOOq1ftynY1Up3dim9MzuisBez21sFtW2BG2uzfSNkVTsocRGwzOEFolw8iOLtescZZuRyogKH2SI4gZuYfLyvGDA3pv2QC+ERMxNrEXdFO8BMQ5dDdR3E6mqOI2AztZU1uBo9qGdKu2DA01kLDVBPpb0d613O3YSP31BfCVzY9nqpeaJb2TEadEsuJIq8Bk/PCAg1l7erGDS4Fflcrax2IGjUWK3sq637xqopc3yQuNqsv9vm/OidllQb/YcypTOGns3NB9dKBfBqhONcps+UScNSr/nOJLtZtZGVN5+Ei2h2fbVun2FZ9Omb1USfTScQVbXaEaSkfnJSwUbCLWNXgRCVZdQfMq0CGgFFjValtmjsHDRU3zZt1caVsUyRcBbV+n9nHKxLK8ExPnJsxG1EAVXfyh1Y9FD6EEbnHFufpiVsF0ZwedzLpzpJ5o0ANg+7bqSM3Xb2l+X/qGhmrStFB4E6AFmnfFYl3dEMcLDBCTsrnfQpHYId3rg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4698.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(7416014)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4jGnqBdEJdNM2lsYtOE7ClMky4qNa4XGlgdZ5T5d6ZyBSEIEBjIME95pzyDV?=
 =?us-ascii?Q?UUOjITdfDTE7iai81Z1L/dbEapjszRB8ixJdm9FcfLaqv9fcgsOWvATYAzyp?=
 =?us-ascii?Q?WyQTvyCmEzcxR9nf/LGCOU6SiIO1Vv0gTieSRklSlAd6F/QY/6TFSW69KKWK?=
 =?us-ascii?Q?h78oEhPHJjQ0X6Y7QyVJE+3auv8PnNcE/BHpm7I+xeIMF0utx2SLzTWlFCBY?=
 =?us-ascii?Q?wE0A+C5NgqlQwjWWFiTuGxqUWvFS0X/6C+QW2Cz9Vt+izHbF/BF1hlDMND6I?=
 =?us-ascii?Q?OMkBlVwER530ng9Q82lgP90ertvGvoTP768O2/nTnRKeV5l72zYYOmkqepP/?=
 =?us-ascii?Q?8SJ0uYMZuR5UzYoYPqfedfkmtq0Ty0CA0TmewSZgz2yNePe7yrHVN1O+OvoR?=
 =?us-ascii?Q?P6oHFv8cG2jnBOJREXgcTtzkHAdVwDSTbB7pl2sLvpoQ/zT/zNRX4p3fbAJo?=
 =?us-ascii?Q?kHxxYT7qct6e5VUoO2q8T6YHtHS80hgBh4GGW37cnoLYIp0wURPjsbaEz2ir?=
 =?us-ascii?Q?KrZo5yErUMy5fwU+zA+xhCs5YRNVJ2oYHLl8pZeo5N/2LQY0OaWqEdWVbJov?=
 =?us-ascii?Q?7PrmTm8ey5pYba/pl07aY3wZHjhfINcaWeIPqCB67qph+SfufTTfqKqiGZfC?=
 =?us-ascii?Q?2I8B7bS+Nm7fpYKb1wXQuDpZI28kBzemlPlqJGbH3S8zreSIEAJGnAOqIvOy?=
 =?us-ascii?Q?B1m5aUZyB62BkOCBL4LtRWtxeOoGbCi59T8+zI0OJ3h4wlegQPQ9Njb9kgx/?=
 =?us-ascii?Q?nlITZWXVr8AbG6XkCR4H5c10Ha+slR/JHbYj24kFp2ojEdrDCIwItH8QSBhl?=
 =?us-ascii?Q?vQobl8fjnfyfqxJ6WxO3VY2vn6ZTzcjMgcTAgbh5Q6H83NXQKVeJxZDeBrWi?=
 =?us-ascii?Q?rpmXeejfPITtG0wI7fVRv5jyk7HtjgC/n8FkBW+PkwxbHOSyEJ4bUv7Rusmg?=
 =?us-ascii?Q?qkzAZgl/dAQ+03XdpERwMfJjL2j5skauJ3QXiKVRhvcICWIkFhf984MhnKia?=
 =?us-ascii?Q?y/mRVPYg5URNZzur5GiVDNAcXobzh6vJZxIR7WC2/tOt3XVkgjIpXmk48fSS?=
 =?us-ascii?Q?YWTwFSTkWqRBlf/KN/GHtG4UoGiUSl2TNEVwTme7NCmfB0Mhhw07FiREmq1q?=
 =?us-ascii?Q?Wn2TpTKsPkL/+u/G6CxqFLTtAGBAidoU+4DCh5rrUncnYq2QGMUFH23Ke+NI?=
 =?us-ascii?Q?N3XjKT3MrFExlwArP5Hrm3j8NxeC8M3DWdL/LAlsWzskhOJTLLQQa5ShLnDJ?=
 =?us-ascii?Q?ai+en2tlPjgwoWErqiD7yL00hlMGBFl/0TallbxB1/7ORf86dD6FEVgsZ3kE?=
 =?us-ascii?Q?Obmt9TnNgSLzt6d1YUpvNlKdcUZimXVjVwBGJ/7vasSC+BelVJBunsJeTV63?=
 =?us-ascii?Q?FYFRWSkfqyDylRRgeZ2T1UIV2jmHjiYD/U2Vw/H+MaDkysrRjzeaT1nvvWUT?=
 =?us-ascii?Q?gxF/c0U1R+9UUf3oD8uWrtBzMyPsiA5z8JdNXVpG7dWOaypu7bTirWZu0sJY?=
 =?us-ascii?Q?VfJQX9lf7uvfQKiRZrXGpmrpap/gJDA9H6l/qxskKB5bg2sH043MxdOVSTWn?=
 =?us-ascii?Q?Q3LJc/w72HP72aof2jxg6pubhzkNU46Nah12ZyI9P6in1JBf3dnTgkKJ4HrB?=
 =?us-ascii?Q?0NGujfTJlUI3gNkY8Pl3XFYgjJhxoeUxdT5vmMMHxrKD72yQQRGa3D+AhoqK?=
 =?us-ascii?Q?Kzzw+zCNfgbOYRntyDz6FxDNBJ/n6cIr9W3JIeU1nMc3cXYyjNzxio+R8D5Y?=
 =?us-ascii?Q?OjgP3u/jg5gP6abXkiWL/YvXPbPQR+KOHXWra0h9RTGnjNtTIhRp?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53ace764-54f0-4ef7-898d-08df024c0ed2
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4698.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 01:56:20.1687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fy5Q73rU7M8MNOWSp5tu2OKeD7lzQLqXbL4kpAYp+ekdSIk4n7Al2Ojj65/NmkXVTTS6CrkOJ8+LeNBT93ycT6jkpgI13hH/UgYN9lWfB3VA8qx/BwfkFZvre3CXULXU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8957

On Tue, Aug 25, 2026 at 03:34:30AM +0800, Shengzhuo Wei wrote:
> [You don't often get email from me@cherr.cc. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 

Hi Shengzhuo,

Thanks for the patch.

This use-after-free has already been fixed by Fan Wu:
    https://lore.kernel.org/lkml/20260623103031.3051-1-fanwu01@zju.edu.cn/
    [PATCH] media: imx-jpeg: cancel timeout worker when streaming stops

Regards,
Ming

> mxc_jpeg_device_run() arms ctx->task_timer for each job; the only place
> it is cancelled is the job-completion IRQ handler. If the hardware
> never completes the job, mxc_jpeg_release() frees ctx with the timer
> still pending, and mxc_jpeg_device_run_timeout() then dereferences the
> freed ctx -- a use-after-free.
> 
> Cancel the timer before the ctx is torn down, before taking
> mxc_jpeg->lock so the cancel never waits on a worker that needs the
> mutex.
> 
> Fixes: cfed9632ca8e ("media: imx-jpeg: Add a timeout mechanism for each frame")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shengzhuo Wei <me@cherr.cc>
> Assisted-by: GLM:5.3
> ---
>  drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
> index 725e941528848e8f224fe6a96ba7f746fc45ed63..fbb64a1ecb5189d2d7b953b99dcd7bcb54e6e20e 100644
> --- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
> +++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
> @@ -2796,6 +2796,8 @@ static int mxc_jpeg_release(struct file *file)
>         struct mxc_jpeg_ctx *ctx = mxc_jpeg_file_to_ctx(file);
>         struct device *dev = mxc_jpeg->dev;
> 
> +       cancel_delayed_work_sync(&ctx->task_timer);
> +
>         mutex_lock(&mxc_jpeg->lock);
>         if (mxc_jpeg->mode == MXC_JPEG_DECODE)
>                 dev_dbg(dev, "Release JPEG decoder instance on slot %d.",
> 
> --
> 2.47.3
> 
