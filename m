Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012020.outbound.protection.outlook.com [52.101.66.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FFD332EA0;
	Fri, 28 Aug 2026 19:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787946109; cv=fail; b=S3rUWhhURWlXNAy0L0G8hYSB6sMNArUYqF4yV/clXN89Cw8tNW9ocIgUsEjYrdL+Aa/JKW5sEygnpqHChkGC00tT80Rvs9tpgWj0nFYI1wt480vcZWTsDqINQU2anNDT6A0x3nT3r0O1kRymI+AcO+AScJA+6iqwWbwOIXtNhoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787946109; c=relaxed/simple;
	bh=p/BhY/RPPEMiCjUKMml+sTuDc5DeFsCyf/OFMFRPsFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NFJvYtQVmM9OQ1IQ9C6MEYUkZU9xH0+6FHuV7UtEbXyZYQlRNRJCKY7M4HbCwclhnrIQPCiIeXgs2LZ/BGVEvbtCrFilrhG2D7hTDFF9N3CFCXk4YITWMtaYwiIgDqTVwGPlvTVAjJoZnJ20Dbi2GFAxJpJh6sxvu/+qohjBgbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=aq7HjwPi; arc=fail smtp.client-ip=52.101.66.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="aq7HjwPi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F+1QtlmfdVbRqjL6zaccNZdlvwUVFPfNLAPljdMO0J87nOsB+u8RSjoBPzTJrftcan04PW9qyFvbrdD9xq8slhqBL3tlSpITKavvHW9H4FBiSV1jM/4udq1MPmvujgZqR/xy/pEcGOjiVJM/o/Rm25QixTEu38QwuIdgvvEUP9gHxT8L8yDDiWFJb9j6hOpwsPW4HNjZM8ZngfZO/tPIbn2ADuzKKTz9HyWoaWtGEBi4arDNCosgvMzd3f6gn6EQr0maTxcdfLe3KNDZICs7dasuBd7jCwXUiBVJalFcmrZRqvaX36c9UrBk0J8CerjwFH0IrLDIZojpTuv9GG5qRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n/ccGS26cfXwn+ANwR9crQFBSgsGa6Mlg9QWZckx5iY=;
 b=r8nWGqOFeXjuCpk4IISSMhdTZ0i211AeWxdSHXeqYWBHfDOQI+ur8I9K2SUspQ5h8pL91QkYdcgCVIvnU2lNqEV8ROCgvoipQf7fT5r+nMo/Hqo+TBJGJD2WJ9hbKhuDLammY4DzOjJgYpoNeBznEiG3kG5vGQyt7JTBRWc/xvDMO4qBdGz7aeQSql/CZrsaBVx4sGvzLCqGmj6pAAfswaGGYJMYkgDK5zu5mQpOr1wd4VtPApKavl9P4hpUstB0LHGOXn+oqogIWp3LPHPjCJnfODtECY1YS+hYP7bc5i70Sb6IUbZ8x8nvnIrzOK12bEs6qREXt3xK18lRlSGHYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/ccGS26cfXwn+ANwR9crQFBSgsGa6Mlg9QWZckx5iY=;
 b=aq7HjwPi0aOtoY1dOAi7MyE3WyNnzTM2DDHDLve9ZNHefF3nhGmePq3UjqUe/U+yI7/+oQLb2wUczpfmWsMvackzbBgz+w/hnZk3BZk8savSGNlaHkJG/HfLU5dkwMugHm8645dtptmmrq+bfNioHwU9HVIjoMZaGSdloA2EEsejCFk3CY+P71vUAE1buNKdoYBclbLKp231Wl56meUy0iwh/jQB57HYmvhExV9/u9knkP/H4vQowuxVO0c7YRGlFC2NQ/CCpjMXqtg0rGoEKWNBzI+YPOwnkz0i3IdOaCIpfOCoQRnKVfCtMjOJk2qc1W2ROqFOvZjGPC59JlsAwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by MI9PR04MB444628.eurprd04.prod.outlook.com (2603:10a6:290:85::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 19:41:44 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 19:41:43 +0000
Date: Fri, 28 Aug 2026 14:41:34 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Kazuki Hanai <hnkz.64@gmail.com>
Cc: Mirela Rabulea <mirela.rabulea@nxp.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Ming Qian <ming.qian@nxp.com>, Hans Verkuil <hverkuil@kernel.org>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, imx@lists.linux.dev,
	linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] media: imx-jpeg: Cancel timeout work on release
Message-ID: <apHkbiufONKjRcHR@SMW015318>
References: <20260828051452.1940559-1-hnkz.64@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828051452.1940559-1-hnkz.64@gmail.com>
X-ClientProxiedBy: CY5PR19CA0035.namprd19.prod.outlook.com
 (2603:10b6:930:1a::11) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|MI9PR04MB444628:EE_
X-MS-Office365-Filtering-Correlation-Id: 9faa3692-26c2-484f-0794-08df053c637d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|19092799006|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	2SUhCjILY4BnAE8TkqLDFXHXMOt1wwRAzu6QLGI+Ame+y4CXo4YKGT8advYUy1VJwg1iNz8H1MjNHu0xSy2mMPIwANoqjxiDlJWThjdXvu988b/cLEsbZxADUf83j1yUK0Zv1Qt2wU2OYI/+MIA+O0eD8z7YMv+gM6r3t1CDmnUykMMFnYS21d7utddOFCvCha+py/XjGMpLTeEJFkI3E/fGjOQZupAtwMfOckqQTdfqntqjCkdCJ00OnG2n4BXNjsvGWHb7wvMw3UeLMKEcAQphJIbBi2JHtiszWsmvkqM7bwbxEw3ah5Vgf/kPzD1m3wKU58yBgIGVAxcFTM77YnAZeMZKQn4dZMVwGqHBQYL62dfd1hlTEEd/78ANgb33uznctoI/IjFoi7/Q1Zk9M7UhvJziHDUSF/uuuNLRcq1DoGep+vdyQs2GTtEQhfohhfjqxoycGAA2P6X4Gimb1eFmv/KCAtGORdDk40EpvuaCSgIKA2LbUsyoioDsdGaKV9nYr9q6FGOsmoq777p4Rv5Jcp58Z+wobNi/lP2v6HWt/JzoHD57ihlgIGW8XBGbHwy/6oUUs2JI7Ny4UpKlY32pckg17mNdz8wUZgXFs5y1MAUhnvAFE4VtukttJssoyTmhNa1pc1R7QsfYeI7k2X1mrE6jS/AXTPte5txAd3I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(19092799006)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B7pNzZzAPicdfF+gq4fPM4Z3ZULE0Ebl2vRuRdbyMp/hw/U9NQA5CPGp+WMa?=
 =?us-ascii?Q?/TE/TcR43nCVAGADp6qk/F2iJJZaJ0TyB3sSPW6v6FiI39gA72sqIhC82JxV?=
 =?us-ascii?Q?tUXa7tj5sjVvhTZDHwe+Qm/RxhSx5lYRvHsJM7YbU7PxorE6LyuKqP4Fw4Bq?=
 =?us-ascii?Q?kifPTlg2hqkhFIkgdnXIPmA0L5TmXEWpQqvmegEYwjxUiCam7zHT46ljJUet?=
 =?us-ascii?Q?nebc0zqUWD2tCxGoc3u2LhNNooLvx2yBp7N3/OnxEZE12VsGHA3kKlWzXqHs?=
 =?us-ascii?Q?oG1h2sROMMXOQD6KVdVfv16q5oH/6yLCIGrOfEdr+/Xly7IQTnNOKJaJX0Yo?=
 =?us-ascii?Q?SFqrwVUzWFprrzjRtCOusTKBJuFB1L/Ten8lWmmsGrfrydGLIKcE+Lk2FooN?=
 =?us-ascii?Q?mnRoVBUeG/uwLthQ8VifTuzgPkoiH3T/EngBY/MXMV92XsJxoCZGSLW8bSTl?=
 =?us-ascii?Q?BqiVkux9KzK0EnqJcJfruLYBSv/db88NMwFiv/oR9fHvHkdcFwH8Ul9Ft+ex?=
 =?us-ascii?Q?Qx9FF28yizWINXdt2nUAbozB3IG8wvcZhvdg95RukikRI2bra6pAQdf+SWxi?=
 =?us-ascii?Q?Ri8E3KyF5JOdZsDK6T8mE6awxngRuLoWd980ThfNh2s5JEQ4Mya9mTR6f2G1?=
 =?us-ascii?Q?S1W1y8MdT5sJzJ3fLkmsLbm21ZBX5RodYEmvBwlymT+Cvu7f9DU3bcdl3vYT?=
 =?us-ascii?Q?XXMMeDtMo94aOsj5PTKORPLzan6HdNK3okKct8iLSlcoAFuFX8DwRr1DZA/i?=
 =?us-ascii?Q?/oJgzDsSZKBfpkxyO5VyF0ekmwJuhGFob48hVBojl4PRP4bg25i8762YVJrq?=
 =?us-ascii?Q?/NiodRR2voxS3SF8XfJYKyXmyy/Wr5d7K5AkWRSZ4qGMtwdtHx6BE5Nbs1Zl?=
 =?us-ascii?Q?Fn8Xfggp1r0uGWVUGic6jl5f+Idd6Z/rSMqLvjeZDFIxzoKMf04Na6iyYx9M?=
 =?us-ascii?Q?hT925AJEYSsKxAuGvT6wFaSIEQaeDTB5RcQ7jclHbE1aK1Gy6aLStZKnB6+p?=
 =?us-ascii?Q?lZZRPTbGX/BunpW2CqgeEu5RPis+5x91Fm3uHWYcysggDGkJOxmEaLOy+iIt?=
 =?us-ascii?Q?qznXNnYZ8gBky9/Pj3GxiIBamnq5Bfd0tjWD+Yiq9SMNOmTM7eHCsZD72MaJ?=
 =?us-ascii?Q?5+sBn9NJ71OS2g833hT3Hw8Hy7KeBRTz6HUx0I0L4QoheKhpShKV8nYKlNlO?=
 =?us-ascii?Q?xxkuCLkKESHzloPbVL6JlipU9VLKeLDwi+/P0+vFxf87jyh+2Ay1KWtRiS75?=
 =?us-ascii?Q?AkaAfOsrUumn8zftdYKJAJ1sWusMZHCk9pOLGbyhpr/qPwYwhZge0SeFirtc?=
 =?us-ascii?Q?euM1YkNv1+FD9PPSA113/gzIaejcWaxal+Ml3M3Fvr1+PQND7Jh/scVJDCs2?=
 =?us-ascii?Q?btwMybxht5rIvWbSKKoU1rWrm/usYnPhtibiWYB6/4V9BYsSuWVces3yW3eu?=
 =?us-ascii?Q?+1Vq/e3JBJGgJxOJHSnyusesO4HCA+8JL+zk/R3QNsfc3oK1sTQFsgE9FSy7?=
 =?us-ascii?Q?QOJmFxik26G0f6vdrrcFvKMv9PYdNRFOIMjwAXHlSyOXsAodb90xyBr4hLdy?=
 =?us-ascii?Q?ayBxVFc/lDJxEp5eE7C5oFe22UKOL+6M/Ug52Baqzzkv3kmvvmXXE52uKU99?=
 =?us-ascii?Q?Cy0/ejeUgfF42PuBNNnLNnLK82lOJx/MJ/pTeQavJMJyh8NxRQoNSF8uVIY0?=
 =?us-ascii?Q?kpqq1TqRtfDDFf8jMTwBYtZ3Mey4hGRCrDCSnB2YpPa9Z5QvOeh4pNuKZJ1e?=
 =?us-ascii?Q?+VoPRCxH9HzN77mfMoP/oQx+TSiA3uE4KGkIboPuQDmO1KxZ8GGP?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9faa3692-26c2-484f-0794-08df053c637d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 19:41:43.8422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yJXpPu4p24W5JrTJ7JWyN4GeuVHi3HuOwT42tjFDN6DBrpm8ASMge4+J1xdun7WTHcGSSOzPjYTJyZ8YvXJ0buyJRtjDeDSwXgxpvA9U3bxPxmIqWepqLQobHBp8U8SI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI9PR04MB444628

On Fri, Aug 28, 2026 at 02:14:52PM +0900, Kazuki Hanai wrote:
> [You don't often get email from hnkz.64@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> mxc_jpeg_device_run_timeout() signals job completion through
> v4l2_m2m_job_finish(). This clears TRANS_RUNNING and allows a concurrent
> v4l2_m2m_ctx_release() to continue. The timeout handler then accesses
> ctx->mxc_jpeg once more while releasing hw_lock, but the release path may
> already have freed ctx, resulting in a use-after-free.
>
> Synchronously cancel the timeout work after v4l2_m2m_ctx_release() and
> before freeing ctx. The cancellation must remain after the mem2mem release
> because the timeout is the only completion path for a hung hardware job.
>
> Fixes: cfed9632ca8e ("media: imx-jpeg: Add a timeout mechanism for each frame")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kazuki Hanai <hnkz.64@gmail.com>
> ---

Suppose it already fixed

https://lore.kernel.org/lkml/20260623103031.3051-1-fanwu01@zju.edu.cn/

Frank

>  drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
> index 725e94152884..dfe3b1ea6bb4 100644
> --- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
> +++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
> @@ -2805,6 +2805,7 @@ static int mxc_jpeg_release(struct file *file)
>                         ctx->slot);
>         v4l2_ctrl_handler_free(&ctx->ctrl_handler);
>         v4l2_m2m_ctx_release(ctx->fh.m2m_ctx);
> +       cancel_delayed_work_sync(&ctx->task_timer);
>         v4l2_fh_del(&ctx->fh, file);
>         v4l2_fh_exit(&ctx->fh);
>         kfree(ctx);
> --
> 2.53.0
>
>
