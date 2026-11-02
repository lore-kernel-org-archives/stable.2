Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793654673;
	b=QRWj9AC+4mMQ2hvxGM52+z5PZaJ6dlNHmWX7NlQDGaWrKxJHs+I/7LwX0cgjjw6tBZxE
	 Bb8OxbYXmmEp3yJDKCk0r7wpOnFwYsvvGrgLNaLYJfxBBz47cgU2vgXjoRDaHT0oM0G6D
	 FB7Wsf55RY9J22c3Q8qxvYvlTJY0osrD5TsKpKJl2nr2Sa1Kmm80PKJN2jJes0/r8jt3q
	 V15E2x3yvuKNa+zWMU9MZNEhsbMdbS/w+xsXEDNKeCPrW4NOOCIUa5mRLoH+EijkSDJRy
	 r6KMWcBEHgZALc4/PsMwyO1moF3zwkoX0VrZD6kPRxCV6I674ALZQbBRFXnUD2os4eA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793654673;
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
	bh=jKbcJGbur+TUmGgZaJya1aDS52fZDJZxD0evyr8clBM=;
	b=Ws8JECio1fkcySivSD3JJ0uyymQ3TCO7SfoA6JcfOlDhknZ4mnqZDduwCm5jTmHpimFr
	 NaasYPC7omKDdEX6DJ+kEBrRCs2KKui5PJy/YHy8Pms4PRmFzf3uSH3+dUmBfmjYowmQU
	 8ZbOVSwuZtr2Tw+fQZ91rZz0a0cJrYAP/eUeJOuZ9tyOitGCHK1DaJRFpyQGX/tvh1Gac
	 ZTWCC5a0X3g7HTBglZIGwT4K0+D7RAw8T1cCq1kukhufmYDgmVJ41N7DSEoCahoKScCNY
	 OQbefESbVx7spU9nDad8Uhq5QxrdH/cDsYWeTzhlI2YaJMAzX4nfbLCXpnBehY9ReGg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Rv6SThfC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.28
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011028.outbound.protection.outlook.com [52.101.70.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CB6606A324;
	Mon,  2 Nov 2026 21:24:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6CB6606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Rv6SThfC
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W44H0mGzk5G3ORHmW+mlTZxZv2QgtIY9MtsE+W1YgpeB7I4SQPZWiV0yscRj2UF2VnM1Rk7MnWbYpu75NE+OW2Qt5ARgHOTcvrW8Ro9oltUFi7mx+FW/07Jrt1gj8kzOszWLa9hB3wAmji6VIVmdQqRdmWCJuFyeoE7bWCCEXIBqAi6Ssg3XuTeRHY/fbetAqXQMzXFXjuuQwMlgazA4Oliy4q44H4lNV1poo6N81mo5u45oaa6C6623KACKvBdGl0vuVNOU1om6mqGlKNEHttngQzrBJb2f90wgMtotb9wjax5+2jCMCNsoOsl1Nz0mdPLv5360blGNyhOOjJ8ZWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jKbcJGbur+TUmGgZaJya1aDS52fZDJZxD0evyr8clBM=;
 b=E/lfF8pBGYkAnw9QLwzyBloeX+8M+R9KCerHhVCmZuLUMO01CD+w1FKQ9Gbs0zkksYzNvbDN6kHxm+QZtI4MSvUuWMc7QeM5wbqZ03wT0StawUcBISO+dDCpih63MXaZZj7+s2lw5dL8stCVelsPzgyqGlRVWctIfMY2iX1AOJ9VRaEung1kGxsLdZTkyb7VgB4zeAgAlyRhKLVeFtwTmyGxmDdTxW3CC8DUv0dDK3/2/s4dyadREKpH4dkMyBPU6M35ax2XnEppyFntLIIvM+E+hGV0ujCnF8QWxr7c4qwtd2o8GjJpeU5PtQlxjD+F+HRS5mNYrA70jOyLogIdjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jKbcJGbur+TUmGgZaJya1aDS52fZDJZxD0evyr8clBM=;
 b=Rv6SThfCBXA0BgXoCxzvH+YcuEnslhMssGa+ZRzTFwQsHYgqj5Khy3f1FNLO6NmhY79oFM+HLjnjSlsXVS3tIfQE/iZcGMXHVO/exD2dW3MgfBFiFyBt20kRUhcwLLoMptpK2V/uwb1Ni5UIMeMDXnqQwR1J4Q64j2plh/fVNDAyn0Ajh/RyerBs4lX+C/ujeJVde8f8TP2R+dS8NFSBfoe7g6hNq/SC1Rc7ZUE3QDclz5sZPPcilAiyi2q87U2I72v14lfCGdzjxL1RMEWi5em3oSdBV5tK0PBVAp9nAzOAzvSW6p1nwlQkPIGbYzt2/BInvFsUueZcuMsblvYRnw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by PA4PR04MB7680.eurprd04.prod.outlook.com (2603:10a6:102:f3::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 21:24:28 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 21:24:28 +0000
Date: Mon, 2 Nov 2026 15:24:18 -0600
From: Frank Li <Frank.li@oss.nxp.com>
To: Abel Vesa <abel.vesa@oss.qualcomm.com>
Cc: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Dong Aisheng <aisheng.dong@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>, linux-clk@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/3] clk: imx: imx8qxp-lpcg: Fix stack overflow with too
 many clock indices
Message-ID: <auj_gnc8P-5qlvU7@SMW015318>
References: <20261102-imx8qxp-lpcg-duplicate-clock-indices-v1-0-1c3fc3fe727c@oss.qualcomm.com>
 <20261102-imx8qxp-lpcg-duplicate-clock-indices-v1-2-1c3fc3fe727c@oss.qualcomm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102-imx8qxp-lpcg-duplicate-clock-indices-v1-2-1c3fc3fe727c@oss.qualcomm.com>
X-ClientProxiedBy: PH5P220CA0013.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:34a::10) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|PA4PR04MB7680:EE_
X-MS-Office365-Filtering-Correlation-Id: c01bdf67-59e1-41ac-f431-08df3927ad01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|7416014|376014|23010399003|1800799024|10067099003|22082099003|261102123227099003|18002099003|3023799007|56012099006|5023799004|4143699003|11063799006|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	BiawRst4kRub4wWhM7m0LKyOllzrfcssFpiUw1b7pBTlbUfXtLu+jvyrdUpsmCjYOA1IrC1jUYNmMbq0lrxoaPkkArWvdA2sLIi/sgnzzdyNSZHvxfekIlfuVr/TvBpIiRKZp3PO0941MBbhYAvNcXwcm12VbGh+GRwN9iCXkpBdnEYK78FAmMPD/ZipFE5bkJl2YG6G2H2K2LIfITXnfnaFT53kQFRbH6es9oRnPbqFC4dUrzV9e1L7n52O7CDvk4KmQw2vAg/K0k6ut+X6qhpPHIpLj/DmZnH6Q92ODQkdKGHECwHq/Wp0ZFGf5mbfSsrh8r8EtKzUUuHn/XGjiENZWT0LehzESHKP4wd9K7lm84mlcOjvXw10AbNLAEIXOrnbmJUz8Wb60N51LceL/qIP+26lxqaGYht99GTG5NFmYcc+eWp2zY7bhgXkOcHMeUZFBks0Enifp53SDJ5Mao0Ww5+xBh8n+PLrcLWBTc1lJhlsGnu4ebEgLzbnxSpbBOZPf/SR8bxlc8pCXUPUt6Q8j4USwiUU922LNmSj8GZ7gSGYiDJXbVVt6XyDPL+NM0Il3B65+Riqo19sUjf/wGD86OYWECltphhyEm7NRHFo1LtlFgumscDFiJ3/W+OzraVKiG1LhRwpGoPmIvpsOnGi0vI2FaDI5IDDO9g5iL8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(376014)(23010399003)(1800799024)(10067099003)(22082099003)(261102123227099003)(18002099003)(3023799007)(56012099006)(5023799004)(4143699003)(11063799006)(261021121427099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w/j21hw8tQ3O609QABySaV7yBBoB/l/z5yvubr4SJOhDyYfyRtWwhn0CtBie?=
 =?us-ascii?Q?3cZmHdhow/LZdC/b0Fz/ku7q0vAFoZp0GJDtIHfX8l+gCQzHD56s84dhGkXK?=
 =?us-ascii?Q?DiOAe112Di0O0OU25k4EK6a+qa5Fqv8YTYVbI/YVEpA0Aq6kPvCiQKhLdXAF?=
 =?us-ascii?Q?PVHplgLjQX8u9IekjdI6LIIYGvzp7ngaSFxl5UdYGM1hvM4ZX0vfRYylSI0Z?=
 =?us-ascii?Q?v05W0rb2G3d+zffetwujqTdVMx6uu+4AMRToQ0c0TpNbQZE/6QEqkW3xPcZx?=
 =?us-ascii?Q?RcKhkG7uHTse7R3r6eZWbBkCOL00QzlBmiNSTrqN2KgpPSTIjpO0yEL2Uv3e?=
 =?us-ascii?Q?1kZh/3GyLsqw6EW5KRg2GIzFQqYTyPxwwRIvvjHH+kBXnseNb3vDS3DeB0OL?=
 =?us-ascii?Q?rUsqAlFP8lYyX5G37NEi7eNWC0lHgxd5RhVDZky2AueoTD6XogqFkhxb+8uJ?=
 =?us-ascii?Q?PuangbQyQTsceA9EzS9TLi9Ve+TbvUKTd+4FOWovtxW7+VwY2Vv7/1IFaKVY?=
 =?us-ascii?Q?aWd/dMPEIb3sqPF6F7LA3VBudzphXJiAtQfgM6rC9vhtAiT9BqQpVS6lwZ4E?=
 =?us-ascii?Q?GaST9SrPgOK6FGI8RpFDXPXO8c58kWwuOwUClLCk16cx/h5xf5+Pbi2Jx4KP?=
 =?us-ascii?Q?uSDaclPYQ9umOwWGEj/s5qli/nuPEs9kEnwRokXrqZEgFxPauKR/MzXyqTqZ?=
 =?us-ascii?Q?kHhg8Dv1Z5xcdzADErjwJa7RAsUqcRHIys5XEwdbs3KkWBzubfOsW9m+XRrE?=
 =?us-ascii?Q?rN76YNn5qXY10pQ9mlRjsY8mVPuOf8PwCd9lvqDt2vMbC04axG4n1dslrrJ7?=
 =?us-ascii?Q?GGuO7CLbQlXFIp0XIhmljHt8Kv5GRH3+D7QGau0pvrAwO2YPpwwgyI4krIh4?=
 =?us-ascii?Q?30XzQDyQqnSBkDNvhEtqOcLCK+jsbncyI5BO3dnp+M1K8dHn6EtwgRSDHeN+?=
 =?us-ascii?Q?ZwI3lnO9U1BaXKnEOVJJTm9QjYTbAG7yFGooZVD4qkF9pDKkz4zVboVcJPEl?=
 =?us-ascii?Q?M40dBnjDa48be2iAUsphFxJoLxGTqZEHQmYRZbcDkBv6/4CuvxgN2Uy1d+LV?=
 =?us-ascii?Q?1Ktap/fc+eUBEdTI4gJSP3r4eIgCEQ+aeCAe4htrwPN3EQHJZoFL0+JqxY2y?=
 =?us-ascii?Q?ojt0QM0Ju2OoXF7L7M/aZzKEwb39HnkEkh/q56GiHKi5tP+NeTQqVJr62M6D?=
 =?us-ascii?Q?TedVF+FjghgQHE93z9MOoP3tD8ClPJD9JlTB8xzol6TlFujsyh4b29YOu1mq?=
 =?us-ascii?Q?rRM+eip32qtSIOiBdulnAkmmOGTjG+sdnE/6aEAORuGrrOQCNth3djzGia7g?=
 =?us-ascii?Q?3PFn4hjWbpooIN1cF7Qbmeuu2JU9XrEP9BpKIVd/u5edkTzLa9LceQ/CJX96?=
 =?us-ascii?Q?/eti90D54EGyq9OKQleQUvUm6S+TS76DAQFqdGht7HyDboJg7ek1yccV4tfj?=
 =?us-ascii?Q?NI6gJN5n65OTclIc9wb9qZWVa8IolLyQiR1nF94fKJ4uBONOysVO6wSyrKxv?=
 =?us-ascii?Q?knqscGnTJZVRg4nlvRKcSh9yBRw5AMitbwqh0ByNTqNIPvEjSoCjSAgR2K0Y?=
 =?us-ascii?Q?cR6DhTlKz/u6CmF38qRM2oiwmsi8LUNCTYxUG01w4AJ3Orhw8hAF8ucgUhid?=
 =?us-ascii?Q?sM3aAFFIsCPomqXbEGwphlo92vuilnRtj3UF+iOuxMRaNxdvPjx4gFGd68oi?=
 =?us-ascii?Q?IPqWvCVfDcruQeRVR/PSyTG3lajlP7slrR789fSHgEriRYT4+d005cmnw7Ss?=
 =?us-ascii?Q?2zH4C+ittsgWPBqwHcnxIwOkbeA//Ke8aDM3hQ2d6qRNrO2qqp4K?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c01bdf67-59e1-41ac-f431-08df3927ad01
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 21:24:28.1065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xQU39MBMTFOdPnykttLS9ggEGiG5UKoHglAUok5hOTnX9LKrfjWUWLz67Ep9k5Abqeh0rW/YbBbA/d6kvXK1F7W0Hs9OAU19g8mTl3ls3kivnJzVaB+vc7zhFURDBIhz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7680

On Mon, Nov 02, 2026 at 01:48:50PM +0200, Abel Vesa wrote:
> imx_lpcg_parse_clks_from_dt() reads the clock-indices, the parent names
> and the clock-output-names into on-stack arrays of IMX_LPCG_MAX_CLKS
> entries, but sizes the reads by the number of clock-indices entries,
> which it never checks. A clock-indices property with more than
> IMX_LPCG_MAX_CLKS entries thus makes all three reads write past the end
> of their arrays.
>
> An LPCG has at most IMX_LPCG_MAX_CLKS clock outputs, so reject a larger
> count.
>
> Fixes: d5f1e6a2bb61 ("clk: imx: imx8qxp-lpcg: add parsing clocks from device tree")
> Cc: stable@vger.kernel.org
> Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/clk/imx/clk-imx8qxp-lpcg.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/clk/imx/clk-imx8qxp-lpcg.c b/drivers/clk/imx/clk-imx8qxp-lpcg.c
> index e57e7bc074a9..ae8cb5408246 100644
> --- a/drivers/clk/imx/clk-imx8qxp-lpcg.c
> +++ b/drivers/clk/imx/clk-imx8qxp-lpcg.c
> @@ -200,6 +200,11 @@ static int imx_lpcg_parse_clks_from_dt(struct platform_device *pdev,
>  		return -EINVAL;
>  	}
>
> +	if (count > IMX_LPCG_MAX_CLKS) {
> +		dev_err(&pdev->dev, "too many clocks: %d\n", count);
> +		return -EINVAL;
> +	}
> +
>  	/*
>  	 * A trick here is that we set the num of clks to the MAX instead
>  	 * of the count from clock-indices because one LPCG supports up to
>
> --
> 2.54.0
>
>
