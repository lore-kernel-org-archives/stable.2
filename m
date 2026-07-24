Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013039.outbound.protection.outlook.com [40.107.162.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535A2397689;
	Fri, 24 Jul 2026 19:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784921676; cv=fail; b=LBUkxCaEMnig7hiJYl4uLVQHzRDjW0LnIqsS0dgTu5D2sUQ8NsXjL0RKJ1Qv1M94OsTG3KgLNn5GU57F0yrOHnDifkAIlYa8aldxQyrnmUzfAdEnLGs8ccz3pIi2ixDgNN6n8WScG4dGkVevNPPgBs0zcrlXVAea5mlbgbFe3HM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784921676; c=relaxed/simple;
	bh=QLaNneOEO6gBxBXjatqGLwh9MLT3EOb/5/ggaCD5vMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PSokUWOdKQPvC5gQFg+IPNyzrlf0cuVBl5xUw2azggAYs4BfF8f1UBNJDPrS8lcgJZIYB++z+mOnirO++8Jb1yk7klOR7Y46iWVR0w798Y3iNmPRhWrSUzVlMHLNYz0qF2no9V7bEF2FH+nO+c+3X10SVu8zTuWEUof6VyRknK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=AkIyDxBA; arc=fail smtp.client-ip=40.107.162.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="AkIyDxBA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NJA4bSv9kOi0c43NG+fUAAzYtK2EZ5bMOtJofzRTjc5KvUJwyHfMx/in24H9hr2py9FdwT8sXICW4ND+RuojdtSx4+DCt0GXk6pU31n6owbW2l8Xrm80c9RZEqnFoMb4HkjT2TlwjOsp1hECAb7si3XhVZsdtCJPjGP8n4N4eSKkW7hk7WZsx2KRKC7EWMF89rYJYwRvL6i7D9ZtUxqH7aXfwO5gkUQ5YdzC2Y9HA/cXSFwtEwdvyisb7+x08v2lOrGsFW2Hd5zytD1kksvpWvTcdGk3hOr/SJ4IrsZLDVA27J2JeSDwfjgfwO1jpILh91pL2dEzErj3PVEBsDPq8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dCJLOkFLN9iT3e7ZnhWjbWqgIHQpj0wJNykCy7gTpeI=;
 b=dW9g/SiM3mOOTnwQ7DQqAY535E3A/8v+tZngEnXGwHtvDoUkxNVv9Rn8eB9ixyRsDtk/E3uYjBDeEB0682r7noYG3ubzD0zOW4EpDNzQab5Mh1l0jaQHUEZDPTXLe9eiSJA4SHGTutnkumrYoH+6XQ1jtu8NQGKfl36b7JM3BQuPRB+/0nAyaTWHf3ezegQgaeqzS1+ii1orZNQFpEmzKmM48feV4vl1lC3Hb0zzhCDyZ5agdpUAEDXRNu5CGWO6mCIhlZYa9QRnHwMJZhb4W0468CCuYtZwUYJiaOsM6LPxciz6316ImHKmzf5oLhhS8K4ZOf8TW0hu+kPiFelv0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dCJLOkFLN9iT3e7ZnhWjbWqgIHQpj0wJNykCy7gTpeI=;
 b=AkIyDxBAbwWAwdJ8/2Bru4LMnNUkSpJ7i4wjKEP6LTL7wuZ4OjGfhDeVKOnHY675qjBJ0x36QoIPUDdrM34zt3QPihmQPAFwr0Fn0d3Nu33jZLpSXpFOcj8WwKzjnegli48UUC9jSSSCW8/DoeiC22He9mWO4bsdvxkFbWUokSWPjLjDNXut/TFgobsRO16ZUjLaYUOW++ZjVr1tl3qxq10ef/8pw6+hgq2JET8BOzL/klv5SJLogj4GAOXQwV241Ho5GI57pnN+/Fc9XGVQkZS6Luona9E5XOHqjennuYBwmHtb3Dqw/g9QsyifDbJxhuiaYTcw3pzTB9f6Qi0QqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI0PR04MB11547.eurprd04.prod.outlook.com (2603:10a6:800:2ff::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Fri, 24 Jul
 2026 19:34:31 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 19:34:31 +0000
Date: Fri, 24 Jul 2026 15:34:23 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: "Carlos Song (OSS)" <carlos.song@oss.nxp.com>
Cc: Frank.Li@nxp.com, broonie@kernel.org, xiaoning.wang@nxp.com,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, Carlos Song <carlos.song@nxp.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] spi: fsl-lpspi: replace dmaengine_terminate_all with
 dmaengine_terminate_sync
Message-ID: <amO-PzRgr1WMWrDA@lizhi-Precision-Tower-5810>
References: <20260519104517.2794390-1-carlos.song@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519104517.2794390-1-carlos.song@oss.nxp.com>
X-ClientProxiedBy: SA0PR11CA0146.namprd11.prod.outlook.com
 (2603:10b6:806:131::31) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI0PR04MB11547:EE_
X-MS-Office365-Filtering-Correlation-Id: a5e1c339-977a-42ca-c276-08dee9ba952b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|19092799006|1800799024|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	+Fl6l0khtPo1BfgL9WyYqKFSIF+2vd4v91F9/dzZ1K0H4d23rHSesdiKEDjQrXT8lxdCZOOgNfsBXOpSrUnzasqQ0YcXGi8bbhjq7rm1zlRhkYVKZaEhLqB6fRgguw0faE/OIbhAiXhBMqlGxZTrEIld1MMPWhQdt9/cfD21Y8/RHQ3xGv+KDuyRtV4nx0XqHhNFhwxqR5xFteZ8/P5trxDQrs/t9Z9i+gtEafUMCzIaKE53ztqILhN+9/3x63HWrcUaheHRa9Djf/mB2IQz+t/XRsKnd/wv/wJxPa1C/tNkYYcVxxHoSmlldOm3NyE/2RsRZUY5/UjIpUWEqF4Ii3vZBt42RHoT8W2eRViThv4yPlGFIgClS2RQWfMzj6TXnRH/N2i4JcAaRXom29gv2ap1bWxalf4Ua0Cwqt+YoeEQEisLUtB4Ij9ZDdmFx8QijdSm2JssZH+BK2VKbE+5dQO7kl4E3jCPA2uQX2HcjPZwVqEWu89qyOhBOJv6IX7FUcGoh8Hv4WNhC6ysQcwRFEGoiKxezp2rJNXXD1GwCTxSkHzTli0PRjpycUh6B0Y9RHtFVJUFhGTOOQa5hpP5qSpu47JEoNWrxbs8TT7EZhW49trXk50lf2uYEgPyf+5Ws4C7sFAIg/YsCwGXs46A5QBcu3UG8Xc5EtS677glQP8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(19092799006)(1800799024)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?abAEl+N9Q608Ree9mnnAaMFqNMvQNaC5AbLB+kifsnNtXR5xwUOpzdSYBd48?=
 =?us-ascii?Q?KkW59bNdqE/jhMjJzRDKwXec+WBkMUPbXp1UVBWmiDZB2QpqVlCbrRfnBakP?=
 =?us-ascii?Q?9AdzgA6IZEgV0t/9GGIuqwoJ0VIUOhkqIWxXWp5mV1b/tr64KzrHXRcNDP6f?=
 =?us-ascii?Q?wFUR2JPXWsmg4/xg+f/vgTcA3swRgdLMQOYh2uAirhLPGuVsAhlf1jTb0ddq?=
 =?us-ascii?Q?kJwjo7EOs52/5JXXma8f1uexNTQHZcGiAIm3ONY6QYDq0uf2pvgCcqK22Zie?=
 =?us-ascii?Q?CmR+WXgujKtCTx1nfvMY62uLNSQdC/OCssYJX18tOyfzhEF7RQ1JP6a4Q3Gj?=
 =?us-ascii?Q?GSjTRVXAc7CPk8tgHgoVzdE1YEQ/Ry8ujfQbYna+sUMWnIHJTIfFgsiyFrdX?=
 =?us-ascii?Q?wYArK4Zt1dp6LvzSlCg+qx2Oa2sa3A57icVYhTS1qvAdnOc+xkd7HiKkh727?=
 =?us-ascii?Q?ESTzTpcU6+0glfVjvTHxIWxYM67EX2x/fqognGOl8/Lw1jCSd2F8d4xy0dWl?=
 =?us-ascii?Q?kNONuoG/WY38xMJeQ9MpLS7V0dCOd5YjwGF9pPN4Rljrh0/cXhNeaXB5nBXY?=
 =?us-ascii?Q?eHIWYBZNi/UNsPojRIOhf9eM84hxiUkXlyu4RfeVHloDlUEc60+1dGW0ERTn?=
 =?us-ascii?Q?SlXHsYPHl1J9Us0SkhPlKexQ1RD93RlUpgfXxC3uesGR7eiRo4GfX/VULwto?=
 =?us-ascii?Q?MEwz+B0TaRfYBEsTAev91h3etjQoNg5bpiFwcqfGg/DEhffp/BrqCKdWzsxD?=
 =?us-ascii?Q?zieBX3q5IVvP4qx5BSM0rHbFpF8g5XMjc87QvMhb8ZYkJSY7pjcAMkxoy9lo?=
 =?us-ascii?Q?DaLHOWZd2smsoHmwCaI8qqxl1XZVxGQx/h6/R5N0FTAB3/zMoGViXpiFWlTg?=
 =?us-ascii?Q?EHpE72x90gDs3WckzxtLKEVNNUtErpweRtCtpIFc2tnuh3Q98nappuFNs1Jz?=
 =?us-ascii?Q?IS1bfcUlLoe5XMSy7YxkljWPoJqKAePKXx0GHyUhcsBFSYTbhxlEIgXCTtsu?=
 =?us-ascii?Q?5GHr+lH1n9o4VQiyfcSouFrX7V+ilkes4N/DF4NyvpoZYbpHPR2H2lrzyuY6?=
 =?us-ascii?Q?/2hHjiOwxMP1orwPAgOSFQRFFi9lg0Yp/UP1EadrVX6+j6svu1OU4MkpPl9K?=
 =?us-ascii?Q?I40DYIExoYPifYwR9WcrtMYzox3mjOGbzyz0KQHyfC6N6q9Hm7dOhFRiYwC4?=
 =?us-ascii?Q?sg2rLLyu1QsR+JUvcRSEC9XsXyheYXEKcPPoi7vT23lXkH0R8b4eTGUAOiB7?=
 =?us-ascii?Q?mRP7uq0UpLgLVuQKcPAlzlQ7WiM2mV6ntJgei/Rcjaq04xgliKa8QIrNVDRV?=
 =?us-ascii?Q?rhaP2FpH+I5XNtkken+pDte24MfkEId0lE2j3k56woY8FBCoNZL15qeY2WZ7?=
 =?us-ascii?Q?SA917T6zoWuD7gDya/cljaS6ZqEGbAtGVTKVPx8im6ldzFgTKVoZoVJaN/uJ?=
 =?us-ascii?Q?HF/ufXCWI3hpBFX31JR5aPHQ8AMFkPvCaneWfBrSkq4ZTrANpTqBem6xiidC?=
 =?us-ascii?Q?VSTvI7sxXRKqxf2KWbug1MDn8M+DvMeYfLFjHFLRBUQ9sGJnpOdrTiGLky89?=
 =?us-ascii?Q?7cC23u+yJbr6juYhTPgWnJuNXFmCLx7S76slRX//IbVJ2KdF8R+TuKS8Yb/s?=
 =?us-ascii?Q?qIqM/P3gTqnJFS71Krt1OD4PNKEnSYiMUbX2aB9dSv10/HWdb/LdhU8U2pJE?=
 =?us-ascii?Q?VdifOsq8bFLC1GtTr+apQx0hmf138pjHkVmI27XxJRDlqjbSnJddLXUgSvpQ?=
 =?us-ascii?Q?Yy0zjJO4zjTVozKwis22hsKYWV/htjJzNuu00sgCE/jAQwUmvy27?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5e1c339-977a-42ca-c276-08dee9ba952b
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 19:34:31.1270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oUQcYnDknrb5Wzum7deMK2Ud0U5qXho4LlV0Ry4AuH6mx768kkYB2B3r8uxMXRRtRY3CVboMYT16U7X5Qvi+M7Ok8RG3rJttxIM1Xll6lWP5UL12hdhiaZFQyP0TgwvY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11547

On Tue, May 19, 2026 at 06:45:17PM +0800, Carlos Song (OSS) wrote:
> From: Carlos Song <carlos.song@nxp.com>
>
> The terminate API dmaengine_terminate_all() has been deprecated, improve
> driver with dmaengine_terminate_sync().
>
> Fixes: 09c04466ce7e ("spi: lpspi: add dma mode support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Carlos Song <carlos.song@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/spi/spi-fsl-lpspi.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
> index e201309f8aae..1a94a42fac31 100644
> --- a/drivers/spi/spi-fsl-lpspi.c
> +++ b/drivers/spi/spi-fsl-lpspi.c
> @@ -647,7 +647,7 @@ static int fsl_lpspi_dma_transfer(struct spi_controller *controller,
>  				tx->sgl, tx->nents, DMA_MEM_TO_DEV,
>  				DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
>  	if (!desc_tx) {
> -		dmaengine_terminate_all(controller->dma_tx);
> +		dmaengine_terminate_sync(controller->dma_tx);
>  		return -EINVAL;
>  	}
>
> @@ -668,8 +668,8 @@ static int fsl_lpspi_dma_transfer(struct spi_controller *controller,
>  							transfer_timeout);
>  		if (!time_left) {
>  			dev_err(fsl_lpspi->dev, "I/O Error in DMA TX\n");
> -			dmaengine_terminate_all(controller->dma_tx);
> -			dmaengine_terminate_all(controller->dma_rx);
> +			dmaengine_terminate_sync(controller->dma_tx);
> +			dmaengine_terminate_sync(controller->dma_rx);
>  			fsl_lpspi_reset(fsl_lpspi);
>  			return -ETIMEDOUT;
>  		}
> @@ -678,8 +678,8 @@ static int fsl_lpspi_dma_transfer(struct spi_controller *controller,
>  							transfer_timeout);
>  		if (!time_left) {
>  			dev_err(fsl_lpspi->dev, "I/O Error in DMA RX\n");
> -			dmaengine_terminate_all(controller->dma_tx);
> -			dmaengine_terminate_all(controller->dma_rx);
> +			dmaengine_terminate_sync(controller->dma_tx);
> +			dmaengine_terminate_sync(controller->dma_rx);
>  			fsl_lpspi_reset(fsl_lpspi);
>  			return -ETIMEDOUT;
>  		}
> @@ -688,8 +688,8 @@ static int fsl_lpspi_dma_transfer(struct spi_controller *controller,
>  			fsl_lpspi->target_aborted) {
>  			dev_dbg(fsl_lpspi->dev,
>  				"I/O Error in DMA TX interrupted\n");
> -			dmaengine_terminate_all(controller->dma_tx);
> -			dmaengine_terminate_all(controller->dma_rx);
> +			dmaengine_terminate_sync(controller->dma_tx);
> +			dmaengine_terminate_sync(controller->dma_rx);
>  			fsl_lpspi_reset(fsl_lpspi);
>  			return -EINTR;
>  		}
> @@ -698,8 +698,8 @@ static int fsl_lpspi_dma_transfer(struct spi_controller *controller,
>  			fsl_lpspi->target_aborted) {
>  			dev_dbg(fsl_lpspi->dev,
>  				"I/O Error in DMA RX interrupted\n");
> -			dmaengine_terminate_all(controller->dma_tx);
> -			dmaengine_terminate_all(controller->dma_rx);
> +			dmaengine_terminate_sync(controller->dma_tx);
> +			dmaengine_terminate_sync(controller->dma_rx);
>  			fsl_lpspi_reset(fsl_lpspi);
>  			return -EINTR;
>  		}
> --
> 2.43.0
>
