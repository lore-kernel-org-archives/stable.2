Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010061.outbound.protection.outlook.com [52.101.69.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17E3399031;
	Thu, 30 Jul 2026 16:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785430015; cv=fail; b=X07thLXhzPdtgIIQpGeW/1XIlqpA9NxW1kDyAiTaGioSoZz4j+DqvEpp7ug4a+iOIOkTcdjol+LMDXWBL0DNCVVhHsOS/RhXhwRwtu+t1T7A3/QENVbfZKCjTM2fI4sYIm1KPbWk9uqCyhzMsHV71iHtdr+zYRb1zVvHcV4+9/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785430015; c=relaxed/simple;
	bh=66brI4//0EqARael02D6T+Bz2FOxpxhXT7/6i10+6Q4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PxuMB6PpQa5a2SrZ2E/WrJzkQGpYdwjB95x3DeA0wfzCdKDgSwwUhrDs2An7nr3vjJABcA6AzeFP7KcKys+qt/ri06Gd4rcDOWr9f3k67pvggKU9cIrXFbWQ7W/vd/DzqbnWu78gtSlpDNHzWRqEW9gswrTeYfmkYEEpvI9ollE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=KPBb2Kjc; arc=fail smtp.client-ip=52.101.69.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="KPBb2Kjc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RfqSF7kpQVKUVAhoaSj2a/rxrg9eGPVdPHvQnOENHBwqO8ywf0U6bLKblIpvWPo+kbT4hIDcJ8kX1Pgt93Z0PIyGDwKMeXeFyysXsSGyCp1suZRpMYvRS3zOA26RxV6ynLbvMKZNSHiZbNOZWF5ud+B+vPu9MmbX1O7RByiYMV1HJWAxD8SiIoWWJRJ2eRfC75MoOvN4Ssv1JQrEfrdRXL83YiQKl9PUGbWLkhv35xkea1dFPmpTAT4U+nM9VFAWMBo2OgTxg6jKVwQeaaPxCBZvrKQFlrAOKBAZH069IVE1sTVZKCwlNv3XdyAqrgzz7R0U+vGZ6lzTaf5mhVzV6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QIluidOmjNVN9OA04D6hr7VJJ/PlNYoAevOhYYcOPm0=;
 b=CUC9veFwx60DiaXvuZNhDl3yUyFe1yJd0stOYmqpIYjLVDUoksiZQzE6jMqHgHBo9ryMqj8X1vV9xw4k2jKLid3VWlP5TVecw7SmeplzNzxn+jfwg/fU5N0v3nd6Yv/iZAZE1WTJwqsuSNjILsZ0qN5LNeb6noby4+QLonPk/MIncpHjojAmR+y3tnDH8yYqvIe6fnumRB+XrFH2g0plcFLnIpo0PF7lmF+KcbSYGJhGDoY86Zj4C0bqpQw+Duk4cycPckWLq4FWj79hXjEm30yYfGySjXXxg2X1JGlOC3ijVV1+dlPZeKFqsE0qGivdd7/hBq/d0tQwGrWYpgNpzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QIluidOmjNVN9OA04D6hr7VJJ/PlNYoAevOhYYcOPm0=;
 b=KPBb2KjcInAt0uu16S421eLWHrkQQoaEPpUcHtKB7WelglSDqUylMpg+HamjSLYHAdppkFzvjuxskdmLo1cEviG/TJ6ZFwousgpnnoZx2i3/NIcZiZ98NOg3+kxQbahjh4UyOYsjdu5qeI1lvOlIVPdzyK8iXpIaUiUcXY9qLcWW+qvOOLUWngZe3ao+X4ZBVGX4ogc4SRIERRFuF+6yXjgWE4B6og5bnZhOzRYAht174CNTE5Pu71VjCcmXnAJXxd3et9Q03UYe8Tk9TOXtOJVhjwq9cDJiLBx+5M8n39pk0qlVBuq1XDxx7Qrkl5DNiVl73gF1yufEiP0Rek8wyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DB8PR04MB7164.eurprd04.prod.outlook.com (2603:10a6:10:129::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 16:46:48 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 16:46:48 +0000
Date: Thu, 30 Jul 2026 12:46:38 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Dawei Feng <dawei.feng@seu.edu.cn>
Cc: mchehab@kernel.org, laurent.pinchart@ideasonboard.com, Frank.Li@nxp.com,
	martink@posteo.de, rmfrfs@gmail.com, kernel@puri.sm,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	imx@lists.linux.dev, linux-media@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn, stable@vger.kernel.org,
	Zilin Guan <zilin@seu.edu.cn>
Subject: Re: [PATCH] media: imx8mq-mipi-csi2: fix memory leak in
 imx8mq_mipi_csi_probe()
Message-ID: <amt_7qnk5X-vQ30q@lizhi-Precision-Tower-5810>
References: <20260527080624.1717938-1-dawei.feng@seu.edu.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527080624.1717938-1-dawei.feng@seu.edu.cn>
X-ClientProxiedBy: PH0P220CA0009.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::13) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DB8PR04MB7164:EE_
X-MS-Office365-Filtering-Correlation-Id: 05c6f3e6-c307-42aa-2e98-08deee5a257f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|19092799006|6133799003|11063799006|56012099006|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	b9e8k2qrrMq6898HU+YlrU99UlkNePQ3AqkA0+qIFGqWnyOwjyHoM+BaRX9/62ZdvcnYHCzf5ajlNvrws07I8m5AniLxRN04xRjxjOqRmNhpGuIU7gJpOEaxnemJOAo+5Nh9sCyaDhqTJExlEPFnM/X7fY6yxfnRNOdQDfrGH15U7PNrdMaSet8KJhjXBspRKB2e6e71iT3NRhx7XfBv6KVtCdza+yuJJlzJcanMm5mCrheU7zD1lRwFzCkUGtpcV85q3ipCIzGRzv3RvTit0UOnO66cu/qEeiWi5ln6A0qQV/49rVkEHrKlF2Lj8oho83V6D7JkkuG9CPynehlac0P5jGuioXIrUI7baIT1bmLHPLdnWCSFZcLtRg8+rmxiR+4CNfyGr5M8kuolS0dHUzxg7KvYRsAqHMoUBDEHHd/QeJFFPpTuH+VHASaqPiaC7D25njoQC0246DaWRozYIJ+zQJr7qNrcMcW6RTk3gYB8DXnykA58fpouDlPexh3vsDLy1lPunph+jHUQHCuxmbcdd47caeeErUVGo7VPu0z1WUn09K79mP/CrY9LWsHivru2YjKWSrcuy90FB1+LILUr8X7fD/YihVe6rO6TeaJqcdS/8WKTNReP5xyrmUqxUTM3AGix0CoKC1YsnbCcFP7QbKKtv7m0cc6jVmLr6pM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(19092799006)(6133799003)(11063799006)(56012099006)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wm52mBMPiCV9i1C7ImaDIWiIXRDZuNzjz/7Z7wAGdI7bEmyPSjep425iFos4?=
 =?us-ascii?Q?rdx5QgZ/WWb9FDP6U5Wc+Z4nw/sTbElfUuYCop15plvz+sOmZak72+IEmSFs?=
 =?us-ascii?Q?t1dVsd2I8Nk3vJP7jFA1D5XkYCoiwF+1mFFwc4PAUKguJphvsbecWB20k8dl?=
 =?us-ascii?Q?sExz0nH2I5cBPdIxuep4UT2y3BaLQpFZ6/Z3f4mI3OYypk+fi4piAMepTRtV?=
 =?us-ascii?Q?rJI3RtZpRBdjghNsTLnpAXiNTF9W1SEqrCUZVDavQ/S4fbZjGGe/phNAMz1c?=
 =?us-ascii?Q?AmwF6PwrG/kVbrP8nz3j7guCSq+NyiZthtlpf/Yb4hzZTgLwHUT+u2cX8UMK?=
 =?us-ascii?Q?piGog9uEcuN6SuMm16/ZrHNstiRCIRblY11vh+wyfK79aIIuAIk/Tov/kVsy?=
 =?us-ascii?Q?ldXFctSU0bCpCwYZeo/yRdkvzyqvATCzJThujHDmTCnki+rc7XO9V7VY+MOY?=
 =?us-ascii?Q?8TfRYTGEuzwWS/BRpZcji/vpX3nHUlwF/oVGX6Rxva3Cjm/QlGek+GfIHwUa?=
 =?us-ascii?Q?eD130TwOhBej0NkpLqAxlSMQ7NWokGWKhqi3fwH5cCCwdioY7RxsdZlONzPy?=
 =?us-ascii?Q?ZULXvCScmcAfaDyaLuv4zHspxVW788vzN/6bIcf/4C5B2ODAIrpukzGBqlfP?=
 =?us-ascii?Q?cuYx+VHoOmyEFmj8of4coGcvfy2TPXX5AGm7pQ/MsYLjj/zZJCDISeNe+Vg1?=
 =?us-ascii?Q?ftYVa05d47WJnLPsKEMtsBD9wKyefKPiXzWAUeVaeeC4nxs+usqqlSmNGxvI?=
 =?us-ascii?Q?/ceCap8z3+80VtY93E1LFBY4EcKKm7K1RM4RBUd0cr7oRuCp1C8QZbg3mI3R?=
 =?us-ascii?Q?vzniYEbQELmaOqQtHPvnXUwRXzexk8x5xve2gNF/Sy2a7p2g26vZiruk52/6?=
 =?us-ascii?Q?b+CB5ko8wmNfPZRtro8xbGqbrxa+1C8K7XZ8roXIA7ItmwUEBY/GChp1RmU7?=
 =?us-ascii?Q?fadVV3m2hUtqgxYySdqe7pon8eDo8ln0tOU94dTE1H+zk4Jgd0fII/byBb2Y?=
 =?us-ascii?Q?oJMOP2TCsRqUbsSbgm9pTAX/XK/aqQmthyH4NbSMiVzR2ab1gI2SqmEga/yh?=
 =?us-ascii?Q?We1wWa1etYuTioQWaDKoEiS4h9UktYFkH9z4b/oGE6zQcf4qInehidVSLi3c?=
 =?us-ascii?Q?leSOpvXTwkn/BRzhRR1rd1wu8ppFhvh+cwmbCe44rhzXcBS8yZ9GRNFqMrI8?=
 =?us-ascii?Q?VQWJSCTf6zdU9LqtpD9zkQIC9YjsrdpX8NUSIq0OCM2OAbTV6DCpT4hwSSx4?=
 =?us-ascii?Q?GvodbQMz5T6WyCAzgrFNGxTkv4VVo4e9fQvSR2h2nsgfQP+8Nx+/gDkkBU6A?=
 =?us-ascii?Q?OGXfpOCGEL4+2xrMoTTwPRaOxZ352xON4+KuGd1+d6GlChsGg5XUyXpwV710?=
 =?us-ascii?Q?lABOu6q9hGx3HwzE2MyOiR7I8dPhDzdCkNqaCnUxm0Ynwn6lT2qEvPsXUUa9?=
 =?us-ascii?Q?tdETby/Mr92Ty+lRlxmRtwIDxOmqioJBVONrPM2dFukrK/vwLhHlQpA2rT/e?=
 =?us-ascii?Q?ypoRD2qsMdcyiSeF7TDBdT/9jjw9j5zITpGZAZ9Ez4xVzHrkusCIMhTZcJoG?=
 =?us-ascii?Q?+j7Cqbfe25En4k68PrnEh+jZUGEzydou6QUEWEx8ObowbiUYjbtenNJRs7rg?=
 =?us-ascii?Q?xMI2T7agJ9fPYjSWv9RHwXFal/ceC5HSEoEIgEhXYdLvbbM5blyK4g3uODs1?=
 =?us-ascii?Q?XeVEkB24/rC9A6sn6cIx0RwwmwyXp5tsdQPDXGVhpiyE3+JQoiE0pefT5LhB?=
 =?us-ascii?Q?g/eeCLQi/2fZPSe3UASlSPz9zhTeClB7vYhUTrf+Kf3RmnA+WfDc?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05c6f3e6-c307-42aa-2e98-08deee5a257f
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 16:46:47.9959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1neQEkoojGA3k0g20wcHQkLNipQfnQVRt89gFHflmzm74MDBtEZGfCuuNTCNLXQd+CMZ0ljBrJDyg81rSb0dsli6GG3IWN+M5kIX/vWJYbGQaWfG2KBnwhpfZwT7Nfep
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7164

On Wed, May 27, 2026 at 04:06:24PM +0800, Dawei Feng wrote:
> If imx8mq_mipi_csi_init_icc() or imx8mq_mipi_csi_runtime_resume() fails
> after subdev initialization, the function fails to release the
> corresponding resources, leaking the subdev state and media entity.
>
> Fix this by introducing a dedicated subdev cleanup label and routing the
> affected error paths to it. This reordering is safe as the consolidated
> label chain preserves the correct sequence without affecting other
> execution paths.
>
> The bug was first flagged by an experimental analysis tool we are
> developing for kernel memory-management bugs while analyzing
> v6.13-rc1. The tool is still under development and is not yet publicly
> available. Manual inspection confirms that the bug is still
> present in v7.1-rc5.
>
> An x86_64 allyesconfig build showed no new warnings. As we do not
> have suitable i.MX8MQ MIPI-CSI2 hardware to test with, no runtime
> testing was able to be performed.

Sorry, I missed this email at first place. Thank your for the fixes.
but last two paragraph have not bring valuable information to reader.

Can you remove or remove these when apply patch? Or simple said the found
by static analysis tool.

Frank

>
> Fixes: cd063027c304 ("media: imx: Unstage the imx8mq-mipi-csi2 driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
> Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>
> ---
>  drivers/media/platform/nxp/imx8mq-mipi-csi2.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/media/platform/nxp/imx8mq-mipi-csi2.c b/drivers/media/platform/nxp/imx8mq-mipi-csi2.c
> index 04ebed8a0493..e5a062cc0788 100644
> --- a/drivers/media/platform/nxp/imx8mq-mipi-csi2.c
> +++ b/drivers/media/platform/nxp/imx8mq-mipi-csi2.c
> @@ -1016,7 +1016,7 @@ static int imx8mq_mipi_csi_probe(struct platform_device *pdev)
>
>  	ret = imx8mq_mipi_csi_init_icc(pdev);
>  	if (ret)
> -		goto mutex;
> +		goto subdev;
>
>  	/* Enable runtime PM. */
>  	pm_runtime_enable(dev);
> @@ -1036,13 +1036,14 @@ static int imx8mq_mipi_csi_probe(struct platform_device *pdev)
>  	pm_runtime_disable(&pdev->dev);
>  	imx8mq_mipi_csi_runtime_suspend(&pdev->dev);
>
> -	media_entity_cleanup(&state->sd.entity);
> -	v4l2_subdev_cleanup(&state->sd);
>  	v4l2_async_nf_unregister(&state->notifier);
>  	v4l2_async_nf_cleanup(&state->notifier);
>  	v4l2_async_unregister_subdev(&state->sd);
>  icc:
>  	imx8mq_mipi_csi_release_icc(pdev);
> +subdev:
> +	media_entity_cleanup(&state->sd.entity);
> +	v4l2_subdev_cleanup(&state->sd);
>  mutex:
>  	mutex_destroy(&state->lock);
>
> --
> 2.34.1
>
