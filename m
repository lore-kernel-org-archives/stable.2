Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011001.outbound.protection.outlook.com [40.107.130.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967A034A3AB;
	Wed,  1 Jul 2026 14:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782916855; cv=fail; b=WVFCHVRD5RVyj6JUBtCfax6JlXQZEcSxyRCTEjmzES4NJOETaLQ40zr9WYpbcM/uyWjDf7Jqwia993MDvribkkjmjekeDcRIo+CEVEMHlOlmCUlEz0/0SeIT/LGhEmWIVuzEWZDCxeu/BJeHVyrzjSgAPzFCXkBFsfCQBHVLpOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782916855; c=relaxed/simple;
	bh=77NDaW7VVgN2CVkoBMZNZNzY62+ZFp1WSppmDALCCsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IdT4nr+EUa5KLL2rGUb7rP8t48e43qw/ovMQ5OxGhAX7lt6aS6+zr+j2YLBEVzG6+BtnKlqSwFu6boS2k8zTbN+yE13Ag3vnuwfgWc9+aV1VW6HHaggYhAaAt5OaW3aE+/rBbZgtQpMSpKsnc62QwEuMlmYsCjI2k4Q3WaWtHcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=OAV4t5Sa; arc=fail smtp.client-ip=40.107.130.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="OAV4t5Sa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lJHlS/l2W6sWPHserplMbBT3UvH2ae074PKbd6WDdR1e2D1Saz39NtD/RZAf6GJfA8wJdiu0JCbTGCjeCzz1mcrNrdVFOeZmtxGwuYNH+vfacOSeCmwuFBWhgIbuZItB8sAqL3boJoC01tbqI2qSzO7KWZRtkJcWV8MpJe3EhywmOCJ81i2fn8lY63GUXBalTf9MgHt8Jla0q99hQyv9HzMz1rFTkYJuWRyLXA6e6mZzp3xQBlhTGh35tQSB/FkzLuzfNkZPPH1yOc1UJxJ3HDccHEyR1M632XuVSgmQVIKs6injjMKtUNe3yJsSqivx3rXI4QR4Q+lxUxysF7exTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BHLVISdzurZic7l7i2k1INz/1p0kYk6YH6IRHv5/J9I=;
 b=PjlX40QM9aBs5rKHJrhmKUYlAoSI9xHrANYTbQXMIOWRpXtP1d5V/PuG5+SLP7PhFYXOsP19s9pb+XSnxHzm0VzHwrmAazdXPwkOWF47PFRBCuLPthQfRuCSjby95SM38Tcu0ABYclq0VjrLlwtPdjMweQZw+SZD4o1KYYQ5+aLrQLUM1tCrHCF/joG1fjpddb83aGLkrh5flOWtJ5TocoUyT1BWLqFLnTbeQZmGHx5nXK2kfWmgD3lUK+MS9dZ+tcDY3O4GAS+Ovo4t5iJBEHLIRsPEIJaawTf05VRsn/XXRUJIbuf82Z/c9+ncDlsVSxJ+ndDZLUd9pCsFowDgWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BHLVISdzurZic7l7i2k1INz/1p0kYk6YH6IRHv5/J9I=;
 b=OAV4t5Sai8RMChhIaguhf23IpmEhiXf2PPDTB6JTTm4jbal39ATe8xyFD2S+38bOaYnB3wLZhDjGrQKA/37qDRiGeqCKG4VsK1Yi8SIHI35r0wZOlie7TREj6fVf3O9nkBuxKMvEOXdpRny91BZlxZ++eSQCz1TZtPUl6VHxc98qyrg73tknrxE8rFfpaQD9G7sJc4JZdACN+geG1Pbg7yamZ53wOu+dtcbCH8O5NSfPJEBX++w2YpvAL1msMbZb10quLHSws0Uhb0585ljleUJ9PZ6/PviGW+ne1p/uj7YwMFwT38Nvy77bLAUMRKr4Urxq6SDS+5P5afhmI/dalg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI0PR04MB10710.eurprd04.prod.outlook.com (2603:10a6:800:260::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 14:40:50 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Wed, 1 Jul 2026
 14:40:49 +0000
Date: Wed, 1 Jul 2026 09:40:36 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>, linux-pm@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v4 2/2] pmdomain: imx: Fix i.MX8MP VC8000E power up
 sequence
Message-ID: <akUm5AFBhzNwuA3r@SMW015318>
References: <20260610-b4-imx8mp-vc8000e-pm-v4-1-v4-0-ea58ce929c84@nxp.com>
 <20260610-b4-imx8mp-vc8000e-pm-v4-1-v4-2-ea58ce929c84@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610-b4-imx8mp-vc8000e-pm-v4-1-v4-2-ea58ce929c84@nxp.com>
X-ClientProxiedBy: SA9PR11CA0007.namprd11.prod.outlook.com
 (2603:10b6:806:6e::12) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI0PR04MB10710:EE_
X-MS-Office365-Filtering-Correlation-Id: ddb4c4a0-b383-4c29-b980-08ded77ebe09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|19092799006|366016|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	nO2/zkoFhz7t5941ChBkGzr51qNlalGZnDlWXT6RGJk+SkW+ZHmxX3iMVVzE5Boou/8WFppA+tOhLA4c0HLfPcTfd27tzIw3F5nTlbC2Y5G58qTFaRK6tgvMwnPHaXGPLAf0DVK9khaOfWL2YCfl8S1oLdYyNBo0Ur5hASeohQGO+alNqlOs1GN3sd5JB+grpra70N3NZrScMccSiP/4+33CUYV624z5j0b81UWYnPLgGDbeDHafHPpnnasdWWpqtdDLi/PfLc25QLLJ2epQCyOhHDw8pPgx/fnMlR0qiFvCaUsH9hiaO9wJ6q+kG1gOCW/YhYKE+qLbtXyI/yvx+udQ4wPO5Zv+qLFvnGSbzkas6UCseHFJecYJd/rq3r0qrcvrTZyRUBQuW6uMVPaD28oCCLRQTV305m7uA3wGUVOrWHayLoX+xPc9gu0Y6vLjb9Lj3NzXyraIRjBG1w8Wqou6eGDAlWBP7OPCwS6vySgbJt5XRulJC7Nvbsy0U0OWlhtbAsQO3YsnlGAGiMJBwJzXhRoTKlIo0hnn42QLGE9A5+mSVvf1xP2wkrQnL6r3Dfyu+qjNolnTvZl8j+Go2sf6W9NgYBPNK8dI1Qwm+hbkHoTprFkCwxQFujXc8YT7pIDWh3WJq0SEVG4U7BbAZPh8t1Zysef+h+AK5GTkjnw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(19092799006)(366016)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?08HqyORT5F7yQKAivoW4AanVk9mdfFfcrPbqJWqsYYl0LYX+VKwHOhdcyWB6?=
 =?us-ascii?Q?ciYI8AclWEU4CduRf37a7FA16s2w7JJTyqCLz9Ac77zQtDGUuZr4MEKZrp7d?=
 =?us-ascii?Q?y8Nn2G2rMS/x6n0T6LSHoqH9tOjsIqdUl8XEMF7/DPnKhD27uH+ZkwXHMy8V?=
 =?us-ascii?Q?T11Rjvx1EWM56lF6TExWyvJONqwxqb1o+YkG09W7PmBJJ069lymK7qII2hHV?=
 =?us-ascii?Q?k06XX97nnt3eYpep8uk3/I/H214s6X61Z2IBMA/pdF8OIdfFiOAEExKzKT2N?=
 =?us-ascii?Q?O8w4XU+qj8R9BXg854fDty6wjEU4hsEZi6vaDJKSu0ThJUuflQXn9ThYRQWj?=
 =?us-ascii?Q?2bTqytj0u7v9+eRJLuC0BfvPPT6yOO5+xENFkJU0h7/3nmtod0hL5MnugnZC?=
 =?us-ascii?Q?2ZlEQkoyqn8uDQU3GRmXLBcgx7aze5Q69zuozwBy3JwgTKNYzG5gXzIwtrCM?=
 =?us-ascii?Q?GgnVHE3I/zJn48cOsMmkM0c98S9Jr5qpS+9azrb4NH6FHeLil+RVvChPqJEU?=
 =?us-ascii?Q?fRdJ6sxfFzRKCOR56TyrrjHXEnwc87D/PXADuuIOgkNc+ZiSGlQVtn8kj8/R?=
 =?us-ascii?Q?gHRF3fUgjrYkZKLHQYmYc5QizyWU9npumiU6ywwVMoK/W/Csg+naYUEOUSHr?=
 =?us-ascii?Q?H093CoVQwzFf6ZG5Po/SL17wn+J8V93PJQay9yYbYxJO1jPJVDSMsgi8/lje?=
 =?us-ascii?Q?hEpRghFLUStFlIPy+igeHzVWM8mrksmMEzgC3MVgvqSsF2rH1QdaLEWWOEEE?=
 =?us-ascii?Q?K2qNTBPckJg29GRI4vR9xIN9DOHD6RErFZx+M0AqBB1B8Q/63s2RZc84kXP3?=
 =?us-ascii?Q?2JVLSKBuYQUgosyPc5vAKh2wYOUEbEG8uYHR81Gn9+3ys1y7bkJGtjv8nh3l?=
 =?us-ascii?Q?4R4G+ENx7kQJJ1vAK1LLGCXgwBoNFwdw4nj4XH/S5EvRIqQfA0VCrqY2myat?=
 =?us-ascii?Q?ERb+rzkwasNzUKV0yrr0bHfFZ2KFEvYiQwdY0zXan4KqU1RagiKyqjje+RlL?=
 =?us-ascii?Q?KioanP9WtQfE2eFPs/ZjXiJu/YCqHgT8OmOLL4vq10CFKY/P5nSwN3tW/RDz?=
 =?us-ascii?Q?8HFQbVCHrla1dSNkRPLWyw2pqxjzGH2HY3g8TxAFum8+nE7XzASkn6bwRvRr?=
 =?us-ascii?Q?KRh3n1J3NrfwEQI6NNjsF/AQheh8BA/UWK3t4b9YvnyyIvpywY4hg0u1zeyj?=
 =?us-ascii?Q?bFqAAN++iu9B6TvcWqnVrRSNojnHjXCDmNgkRq/rtKjcRdyLaeYxKR5w8TC9?=
 =?us-ascii?Q?1XEDhgt+lFi7BCOCxft1xHl3fvbVjYSTyg08uREsT2NlAsA5q3dDD+tfBl5X?=
 =?us-ascii?Q?5udbVsxDBdzgiAFXfHB8a/CMzgFDTmh9N7CCzU4GrcWESRbxAwPHup4YWNB2?=
 =?us-ascii?Q?+AmOD9RqUAmLvIp/MFr0CUYDAO2LLIag+DPYwlN6ltkuOPrM3Qwh5ZzDuPy2?=
 =?us-ascii?Q?8x0F3yx/Dr7JamRyihG8fp+/ABdz6mg7DCFhBmpRt7CeYH6RQ86aetPxYFw6?=
 =?us-ascii?Q?pJ+2IgwespFDgGAmojSbYMSxIu4IZQw5fw7tVQt7GHLDLz9JVa2YYBwCPdza?=
 =?us-ascii?Q?TXZJPSpHmjeLZkpeGcs4sJIbGh8rX7CzWGMM/U0FVaTd1x4DvMCM14yBnmKf?=
 =?us-ascii?Q?tnDHemnznbsrSR+6k8rLTmwoZILOWkcf93Im5hwHnQH9L+u3lntGefri3W+M?=
 =?us-ascii?Q?/v2PB6pE1XtbKF6zwHEM56T1BSgVwdhod/YTb8mC8h6Ur9WS2QVU1cmVEM+y?=
 =?us-ascii?Q?z0MYrOnX5/bNpDKGGzlLTOwVGsCaAVtucpw6ZjNsScdzxNM/gUao?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddb4c4a0-b383-4c29-b980-08ded77ebe09
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 14:40:49.0732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Yh/yuA9lC/goHs/c+5A5JP9VhQwEeYhVH8hQwKn6sVHIdRu5JsmJGGigfVT45fojUc6vamNd5DivtKK0GZyENHWtmRiCr4LkZViP14pKirSvw+SErfooeVwuRpfBQWJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10710

On Wed, Jun 10, 2026 at 10:39:11PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
>
> Per errata[1]:
> ERR050531: VPU_NOC power down handshake may hang during VC8000E/VPUMIX
> power up/down cycling.
> Description: VC8000E reset de-assertion edge and AXI clock may have a
> timing issue.
> Workaround: Set bit2 (vc8000e_clk_en) of BLK_CLK_EN_CSR to 0 to gate off
> both AXI clock and VC8000E clock sent to VC8000E and AXI clock sent to
> VPU_NOC m_v_2 interface during VC8000E power up(VC8000E reset is
> de-asserted by HW)
>
> Add a bool variable is_errata_err050531 in
> 'struct imx8m_blk_ctrl_domain_data' to represent whether the workaround
> is needed. If is_errata_err050531 is true, first clear the clk before
> powering up gpc, then enable the clk after powering up gpc.
>
> [1] https://www.nxp.com/webapp/Download?colCode=IMX8MP_1P33A
>
> Fixes: a1a5f15f7f6cb ("soc: imx: imx8m-blk-ctrl: add i.MX8MP VPU blk ctrl")
> Cc: stable@vger.kernel.org
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/pmdomain/imx/imx8m-blk-ctrl.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/imx/imx8m-blk-ctrl.c b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> index e13a47eeed75..99d100e1d923 100644
> --- a/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> +++ b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> @@ -54,6 +54,15 @@ struct imx8m_blk_ctrl_domain_data {
>  	 * register.
>  	 */
>  	u32 mipi_phy_rst_mask;
> +
> +	/*
> +	 * VC8000E reset de-assertion edge and AXI clock may have a timing issue.
> +	 * Workaround: Set bit2 (vc8000e_clk_en) of BLK_CLK_EN_CSR to 0 to gate off
> +	 * both AXI clock and VC8000E clock sent to VC8000E and AXI clock sent to
> +	 * VPU_NOC m_v_2 interface during VC8000E power up(VC8000E reset is
> +	 * de-asserted by HW)
> +	 */
> +	bool is_errata_err050531;
>  };
>
>  #define DOMAIN_MAX_CLKS 4
> @@ -108,7 +117,11 @@ static int imx8m_blk_ctrl_power_on(struct generic_pm_domain *genpd)
>  		dev_err(bc->dev, "failed to enable clocks\n");
>  		goto bus_put;
>  	}
> -	regmap_set_bits(bc->regmap, BLK_CLK_EN, data->clk_mask);
> +
> +	if (data->is_errata_err050531)
> +		regmap_clear_bits(bc->regmap, BLK_CLK_EN, data->clk_mask);
> +	else
> +		regmap_set_bits(bc->regmap, BLK_CLK_EN, data->clk_mask);
>
>  	/* power up upstream GPC domain */
>  	ret = pm_runtime_get_sync(domain->power_dev);
> @@ -117,6 +130,9 @@ static int imx8m_blk_ctrl_power_on(struct generic_pm_domain *genpd)
>  		goto clk_disable;
>  	}
>
> +	if (data->is_errata_err050531)
> +		regmap_set_bits(bc->regmap, BLK_CLK_EN, data->clk_mask);
> +
>  	/* wait for reset to propagate */
>  	udelay(5);
>
> @@ -511,6 +527,7 @@ static const struct imx8m_blk_ctrl_domain_data imx8mp_vpu_blk_ctl_domain_data[]
>  		.clk_mask = BIT(2),
>  		.path_names = (const char *[]){"vc8000e"},
>  		.num_paths = 1,
> +		.is_errata_err050531 = true,
>  	},
>  };
>
>
> --
> 2.51.0
>
>
