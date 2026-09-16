Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013059.outbound.protection.outlook.com [40.107.162.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DFA599A53;
	Wed, 16 Sep 2026 15:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789573146; cv=fail; b=KWebXlWmOE1BgmfukGQGlNRjxwpnW+eqvuYkx9OBoP/Sfd2Hn8d7vx3f/2vj+TCIjMG6gzCDV3jSAz9LUFCh+6NwjxjQpXYZhmNJln0loSZku2Fogf2iTekgQhOtjZJA3c41iyVhIHreT9P2egV7zMcO9uY9Q5t0+23+DG2qZLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789573146; c=relaxed/simple;
	bh=Fy6/MzDBzeex9R/htOE9WDw058TVB0VApJIr4flMAW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lmAOJRxxq5iZcT7i0ZwRXHCVRSIgIVVy4mtIWwa4FMTX3wYKf7s+IFS3QmkziUn5NTfwmg1x3KSITMAeNQGkF/u/QIV9jSUqxG+f6GxOB5F3RDVQGp5P+kJiXVnG6rEx0BFxY3JrLS5XZy1dUfhgNFDtNzhKDT0VjUoPxMpFCa0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=A9hyFsjC; arc=fail smtp.client-ip=40.107.162.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="A9hyFsjC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S1PRBXwmGYhIUifl0ehHAlO2rJlT0S5wmax07cnwANkYmLH9g40lgyb1y3H/sN/zaOVmK0TrcN1OGnlPjUBFPAV5IYQiiu9gw9rcPSKF0UbX0rvjNWBis696+KBXINjthVaZE4TEcf5zvq9gwQhoxOF+viJD7ZOtRSLfkSRAiqCQY6hw+D6wsffAVGT0eL2rn2Y0prFVdHNDW29urpTUZ0bzULkW2yAK7KFf6kfiVv+VZarBZcNSapceXcCQaRmio/IUE7jl44VYNGoUGbDk8FSMwmO22wAUqSbIRvGuLL32WlhgM2P/TdCHC5eqxeBRZkEcr7lgZA50RQgEtVioZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jo7fj0OabLD4A0y61eCm5FPcNJvNG5wUYGX28KzvjLo=;
 b=sqMbrWvzbChXRftXerU9XqDQAEkHiPvz41FT7J9cY5Ki2AP8Q7XzKmaEsObWNP6MXwrx3jkFdjKOMmQqBeFpcu6bxN2RgUG8DnN+wBWnoQfaGKt1miLXNzmoEjVwvdFUIxQFVT/t6ZpVfriqq1pSK72ISXL0AZ8SEA4buZNKVi8+c7FmRWOmi4MlyuGgiDavqHJv1M5wPW2cWO22WN+/fDceUgqPu4HXgUxmPksoth4RUR1cuUCspQBPYpCEtw5nU4OwtnFRVXp9DnbjKTsHAKlpg3BpOREgnXIphiz5myuR+8f3E0rtbBgZSQVViPeE/Wxoa0m4AaZCQFT2YRdPqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jo7fj0OabLD4A0y61eCm5FPcNJvNG5wUYGX28KzvjLo=;
 b=A9hyFsjCpfhF9xqaJ7DLSxqy+0sAjjF4JBnGa085j1BDthRRhsAKHdJa0M65jhFSy4mRWdZZHvRME+C+ngP5iLN4HHcNWppL1/28ONeFb761Y8UO2LBFn8Jc6lC4JlgcjTJuaYtocLCD1N4xkh4X1HvsxtuDFjYYZq6L+4vl9uH5AVH3SUGCwJJf0z7LQbDKjphqlWAy6YdsxeWWPr8kF+JKlU5O8KTG/t+F19vUWAjYiy+Cj1EvG8pANsjCg1tLIds7zxxpT8V/sLXGL7+xn1PYb3XPuTVJq7s1+14PqpRs03gNmwGvBGM5e2OxJczbdsaDQdpg3ttTOkeSO4ncMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DU4PR04MB10316.eurprd04.prod.outlook.com (2603:10a6:10:567::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Wed, 16 Sep
 2026 15:38:49 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0406.012; Wed, 16 Sep 2026
 15:38:49 +0000
Date: Wed, 16 Sep 2026 10:38:39 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Joakim Zhang <qiangqing.zhang@nxp.com>,
	Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] irqchip/imx-intmux: fix runtime PM teardown on remove
Message-ID: <aqq3_5QInBbdxAHM@SMW015318>
References: <20260914134211.1734163-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914134211.1734163-1-lgs201920130244@gmail.com>
X-ClientProxiedBy: PH0PR07CA0049.namprd07.prod.outlook.com
 (2603:10b6:510:e::24) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DU4PR04MB10316:EE_
X-MS-Office365-Filtering-Correlation-Id: b499cfd5-491c-4e0c-b9fc-08df14089a64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|23010399003|376014|7416014|18002099003|22082099003|6133799003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	TkQx/rKEjFj7AGBFHzuveHgMHm+lMiMVas4o2ga4JgCvDPvx+az+aktjxKsbSnAag9WeJIAy0BYfvxkvEW96EpyzJecm3UaPSmVU5IXjNmEkfWLL72RiqXMlMfHXBNzHNt0ZnqgZbFg25i7ldponDMuFrO4NOPWszCucB9fIzozzQglwsbtizskHnOC8203+UWE14uptRoIOkkBtjEysYjd5Mw1deh43Q0SggJ1QhjJv9e8nO/ImknuJrI3GJ6PPnZ8HyHIw7vmRst498fNAWb2clukDpp7Ia1oJZKVhpIzc2qhUIz9ABX6iF3GDe5Hxq/XQ8bGaX86N26s7yneIEEkN3u8roJzP7tXe0nRQQDHR7o/oKWa939Cq2zLvQPab3U8qZDcmI4fcnxtaZn1XWRqCHb+OVoFGaZCESpJitBdW0VPgkcoaoRc9gyOFRnt88kNJbzEZYE6OOlNTe9JhYAZUKu2X3TRg6ttZAaixQuI9SveBt8J799RB2GQM+Z/ScAZFUD0Ogiu/ED3BoTJoMbK4XWPqybtqbYCJnTna0ywUZ/QrkKvav0EE67Kv2woMVRQcJr1fz1hM15BNAf6phQC2yFlIVbCI8BrHW+Uq+ladV/cmQJHXoo/fyt8yQtTQ/dFxagDMe+LiF3xEr8EzjCemkNFqX7mu4tV0GSwb9Jw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(23010399003)(376014)(7416014)(18002099003)(22082099003)(6133799003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rePTdUbqcmU+XkJ9ZZ3YVnZQiqsUulsR0bZ4Lcu/sj/JQCdMI0dLMlMSvXbK?=
 =?us-ascii?Q?8e2ajJUCMH9KrR8rW8nrU/3BVDur8/3sKBl/abFN1bECqFSlMNRVEvrPb20C?=
 =?us-ascii?Q?RfdQM9K0UztqC1fss0pVVpc2J8tT5idrLyBtfJL8X7SVhXjTYIkOutvyG7x5?=
 =?us-ascii?Q?e916nocYuQ4KR/8UR9HNFw2hjbTnwA4lwoPiRCZNffjpUcKhiB8lNzwMWPsh?=
 =?us-ascii?Q?abtwzkC0tv/F1O6f+SyVqculSbatkknxpRphYLV/X+285TAfr0cVI5ID1meB?=
 =?us-ascii?Q?/6r0ZF80a8uLAbQXF3Dg32bLLUZbd7GqqPqzkNZGW9f8FUR49Aa4nug6FenM?=
 =?us-ascii?Q?8uK0LSOLx58bdAOsGXz3KMO9IMwAsIw1ZEcF+V1oz6jZT+KVgYFnpkw+fFcy?=
 =?us-ascii?Q?MurpifvoNwkAoXN6DMK591fg70/RvoHXuOnMChzNFRwQhQ/Rpp2N+yQsYPdD?=
 =?us-ascii?Q?rvl5AKf2jRRVaN9vofGMwN2V0+rKT5L7MmrEWMUANHamU/qDWRF96q95LM8a?=
 =?us-ascii?Q?Yox9zJctEj5OFOyIAIcLrUKUBG9oIouOQ3gZ2EuHb91SqVGGf5CMEsOP77q+?=
 =?us-ascii?Q?XMyk57ydm76eT3aP0FzHky/VhPpJo6otEPONOGe13KcH8bxmqAonh/kqJNQi?=
 =?us-ascii?Q?ZuSFoFxSpbxhoJrWtdiRgjKKGrJCQNHs+1THyg50AJb+bzdJHC2J6p3CIhVp?=
 =?us-ascii?Q?pFDfwMTvXOjIze5hsr7zT3M+Wk51uYIREICejluVbjRGGamjTxuaCYzPgJHk?=
 =?us-ascii?Q?aSJ98wJ1zebHpkk9CiDVbmYXB7UfUj4oCQnrNeMoIDzzO74BlYPL+bpWmWpb?=
 =?us-ascii?Q?zH3hF+idALCSo2GlANJICb+RC5neAY5+mereR5VSGPVPuSqlF5kCrmNbniEb?=
 =?us-ascii?Q?MaVdbBHtvLL4tCpeuuBOx7OkIPA43SPvgEDl6hylq+GoLIU7xSMPkFy7utQ5?=
 =?us-ascii?Q?YYzxFhIDQuxr+5QD5qYsrf3FqZgsNXA5IUVxqj+ycXivgZrrmbWH6JNQHdKl?=
 =?us-ascii?Q?i77V4Xex6Rc6ZM6JlQtvtW42VqqfrxjRmNEFqJQwweDkUZyRVDj3RFzEVlRb?=
 =?us-ascii?Q?+lR0pqsbCendBr87GbakxFpe3eXsxvB23MU+ox17PmGtTpBRCExAs0142RRz?=
 =?us-ascii?Q?sgHFpZEjFEn+yC1MZwHhEDrJ7SHSKNyOGiWFdlqX7jGyy8H+sQdij9lRUEo2?=
 =?us-ascii?Q?9LB1kk8fU/Mw2bks5+jyVUmAjd+6r3o35E8SMsT41wKMQDL1d5FErUNerU0K?=
 =?us-ascii?Q?BFcmwtYVxcgtBfWnpRwsFQFb/ooEsZYYpQcA1tTdrjDCi4iIe37f+GIpx8Rs?=
 =?us-ascii?Q?DcIt3GNNLLjVV4/v5A15eKJZ7M+FUrSZpMyXGfs0LZRG4eSP2p3i5JC7xzL9?=
 =?us-ascii?Q?WZltF4Ao/Km4zR9my1ZE05tMYoYJ2IZahMlbjN7cKgRVTkr9rQ4/iHDLK5eN?=
 =?us-ascii?Q?C2NBxQ81eDqcYfEsYyV/2H5m9hDgqwt61+kCb9tfyGZh5xHHiYpXUhBqtnBr?=
 =?us-ascii?Q?1vKP3/QHnh3OumpI5QKGAUFhupE1/ak2GPEP+KeIrxhomroCtQukIMvy8r8k?=
 =?us-ascii?Q?OXmHHQSLl646clGtzpXfDnAvqsYW8BvY5Y0ybIvOvz7TFk0aM8LVSnMopjuv?=
 =?us-ascii?Q?6734InDnO8zcvxAVzzcBpH9xEXebtvepvsjDpr/XJVvG4fx6g0FOTTJ5VPLl?=
 =?us-ascii?Q?VI8INprg6jbEoDX1txScaDn8RLtHG083WglLDAwwt177NXHarTJ5TWn/CSq+?=
 =?us-ascii?Q?yHPN9wBThxs8OlhBaCI8d7LYK4UzuerKEWgGWVa8WLeS12lb6k/2?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b499cfd5-491c-4e0c-b9fc-08df14089a64
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 15:38:49.5510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RE+Yt+EUg9OluWNwI10WGeOqeAFZgHfGdsUUYxQT/JzI1UFmMIfN4iLjDcajvlMAx62hh4H98YE0eVEegMGYzHmvTZcb8Y4N2Y9lF2BnD3wRU9ayC6PnG39IVCyvZ6OL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10316

On Mon, Sep 14, 2026 at 09:42:11PM +0800, Guangshuo Li wrote:
> imx_intmux_probe() enables the IPG clock and then drops its runtime PM
> reference with pm_runtime_put(). With CONFIG_PM enabled, the runtime
> suspend callback disables the IPG clock. With CONFIG_PM disabled, the
> clock remains enabled after probe.
>
> imx_intmux_remove() accesses the CHANIER registers without first making
> sure that the device is runtime active. The device may therefore be
> runtime suspended with the IPG clock disabled when these registers are
> accessed. In addition, the remove path only calls pm_runtime_disable()
> and does not balance the clock enable when CONFIG_PM is disabled.
>
> Resume the device and acquire a runtime PM reference before accessing
> the registers. If resume fails, skip the register accesses but still
> tear down the chained handlers and IRQ domains. Disable runtime PM
> afterwards, drop the acquired reference without triggering another
> runtime suspend, and explicitly disable the IPG clock.
>
> This keeps the clock enabled while the hardware registers are accessed
> and balances the clk_prepare_enable() performed during probe for both
> CONFIG_PM configurations.
>
> This issue was found by manual code inspection.
>
> Fixes: bb403111e017 ("irqchip/imx-intmux: Implement intmux runtime power management")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/irqchip/irq-imx-intmux.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/irqchip/irq-imx-intmux.c b/drivers/irqchip/irq-imx-intmux.c
> index 47c2681d138a..de2a8f98f625 100644
> --- a/drivers/irqchip/irq-imx-intmux.c
> +++ b/drivers/irqchip/irq-imx-intmux.c
> @@ -288,12 +288,16 @@ static int imx_intmux_probe(struct platform_device *pdev)
>  static void imx_intmux_remove(struct platform_device *pdev)
>  {
>  	struct intmux_data *data = platform_get_drvdata(pdev);
> -	int i;
> +	int i, ret;
> +
> +	ret = pm_runtime_resume_and_get(&pdev->dev);
> +	if (ret < 0)
> +		dev_warn(&pdev->dev, "failed to resume device: %d\n", ret);
>
>  	for (i = 0; i < data->channum; i++) {
>  		/* disable all interrupt sources of this channel */
> -		writel_relaxed(0, data->regs + CHANIER(i));
> -
> +		if (ret >= 0)
> +			writel_relaxed(0, data->regs + CHANIER(i));
>  		irq_set_chained_handler_and_data(data->irqchip_data[i].irq,
>  						 NULL, NULL);
>
> @@ -301,6 +305,11 @@ static void imx_intmux_remove(struct platform_device *pdev)
>  	}
>
>  	pm_runtime_disable(&pdev->dev);
> +	if (ret >= 0) {
> +		pm_runtime_put_noidle(&pdev->dev);
> +		clk_disable_unprepare(data->ipg_clk);
> +		pm_runtime_set_suspended(&pdev->dev);
> +	}
>  }
>
>  #ifdef CONFIG_PM
> --
> 2.43.0
>
>
