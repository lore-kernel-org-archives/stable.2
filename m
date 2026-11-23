Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.71
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795454738;
	b=F+v0kLE6blLsKO1DVq7dx9ctcoBENua5y/PoPCSz7XVGBSjALv1R4QbRnMqLgZloT5dS
	 HyrxEZXUo79v3m6WBYbOSgLsWeFVMysmDaxo3cOAnyAHosOwl2d7TmGyc47UlYk6WIQlW
	 8PTyNnzizk8YeoOXdbnETD5ahOBWcP3CZhnRML4eXjntcCqNgyMyBigdSI/V7fBcTzahS
	 1U4cHG2RcAc4CwiwHR9qkGs81YFxboJssYpn081ChcaUVI+eLrbZfGfBqmPGHFodECakb
	 rzwlivc06o3Tb0NOR603991LjyVwg/uGZ4gkLh1MyZeJsrOm15ARbTdd9Pbc7+JW9EQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795454738;
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
	bh=dc8Tb6mFhauNpQHY88UtN1IKiLsK9UgRx4rIm5SsnzE=;
	b=4WyUW37dQH1nnKMyiygq27Gds3B+p+Csd3ItPZ/oXGMZMVlBD+i1FosfxtgW5Kmhzc4O
	 F45QpQ1gmOVylaUa9AhSN4k+CuBpXtOuLfVwRrNcx/thzjgfKqZRRT+g3g6Tvo1bf+90j
	 NAYuwwwOwg7LPrXM8ZfTexji4e6G3LUTMZZgraVyPNMykNvw3IkEbiMISkYGFpQe9GS08
	 I1bnFo5sEWD2t2ArY/GhyOWXA36IirbjybQOKIbEqxbpVzCs6BQ9FA5Egy68OlhX2mi5T
	 wKIpXKv+YgPnazrbiOGbwhWt6xrQLHQpMAZw8hkoMrpeHTWuCiCyDF/JNGsD4Y8IqhA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=GqE0kMXn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.71
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012071.outbound.protection.outlook.com [52.101.66.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D299606A32E;
	Mon, 23 Nov 2026 17:25:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D299606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=GqE0kMXn
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ywrxEFPv0tdSYWxwFri2aPRoVqkb6bZu53ZXru2GM0BLzL6OEpVkcO1c7cqx6mUkuafGl02SDfKTM6X5c1t6SUSVPwsRW4a/yDKKH5VQ3dhfB6RNc69um4j3pG6gADpN4a5/ZNQn6TR/bVsvwjam484vLKzgI2AxQ8xppfQ10mYHltZ8kv9fv4CCIWynNOLXxFejMqheWVpttBGmw2xJDOaHbYhRYWHOCRoN9m//s59hWTFqDWcrwOBryjAa543qBBtDI70AvxJUjscM8zm/m3hnCb8/j/pcYTBpEIa0QwKfL9iNf0g7MMsPA/ZULC3YE/xwyB3QXcy47IGrbEg5sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dc8Tb6mFhauNpQHY88UtN1IKiLsK9UgRx4rIm5SsnzE=;
 b=Rggy0mkykH9n+vAghx5HuUwtqcOkt0VZWTft2SzupB7SCPZg4MaVR68DXPtdybq5Kwzf+wv4WXDF5k+8VawAGohaesV7Ql99+fuqzMWVtNpWChklFX6gUdWD4Wb9Yd0NUfYhaBVKfaVppLRNzzc7BTeaa7ZSIzf8arKv5hzbRaZzG2F1UKV15KiDJ3w7FyuXn3C0Wpng6IYWNBYbUAC109DLq8N+7IhqLtqN2tY84hInO2tSVam9OMikdnGND1Z1OjK6VYtXMsHPKQA6abL2PeS++MV/tOvtjXl5/C0C1O1HQ31+Nes+0fzQJqNAX2F9V3sJ3RGChsSs813hNiHqXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dc8Tb6mFhauNpQHY88UtN1IKiLsK9UgRx4rIm5SsnzE=;
 b=GqE0kMXnXXQ8HTxIVZfI9v+aFborkTOZ6R5oSkuFjVqXG5O3H+39QZjWkFaukEExH/XYYFwr+If54Mz3JDWysDbXPIDc9gEC/7VhIzmlEFl025FX1R/xMIDNISbWv83tJvA97vho7Ej9RprUJJ0C5vFO5+bUGwe33VPrMWOmG75NSgcnXeU+HyOXnuty4BDD9i0oNsJ45JOnViwj4Yk57ZzIUjlwHU0It7wdJFyzBhS6EWHBPMJblxLNlKa9AsQbiYOX15zBrq2KTLTMK5r1h+ooX1/+tWCpPspfGxIgB1TAsr8TXgoBJgylaHzS4CZ6a2yYfc3x5EJJ6rjYOM+Niw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by AMBPR04MB226274.eurprd04.prod.outlook.com (2603:10a6:20b:75c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 17:25:35 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 17:25:34 +0000
Date: Mon, 23 Nov 2026 11:25:24 -0600
From: Frank Li <Frank.li@oss.nxp.com>
To: Lee Jones <lee@kernel.org>
Cc: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Dong Aisheng <aisheng.dong@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>, linux-clk@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 01/10] clk: imx: imx8qxp-lpcg: Prevent stack overflow
 when parsing clocks
Message-ID: <awR3BI1c7j7y9bKf@SMW015318>
References: <20261123164834.3330320-1-lee@kernel.org>
 <20261123164834.3330320-2-lee@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261123164834.3330320-2-lee@kernel.org>
X-ClientProxiedBy: PH3PEPF000040AC.namprd05.prod.outlook.com
 (2603:10b6:518:1::5b) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|AMBPR04MB226274:EE_
X-MS-Office365-Filtering-Correlation-Id: f0a4855a-7667-43ee-f143-08df4986c869
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|19092799006|10067099003|4143699003|5023799004|11063799006|56012099006|261021121427099003|261022105027099003|261009223027099003|261026140227099003|261028144727099003|261102123227099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	EvUAaxw5NSWoh4Lcn0laHnbBuKVLcXYi599ND4NlaTe/KafuSulqPsmHVjC+/Nh7YKNLGIChfs0kRwPpI+cC3xWz+FwHxmT1midJfJlvBUaTIw4dEl2RZJ74gc1RxhkY4YVxycKmSjsGEpIDgEv+jF0NdxljGA8YgD8H+i37ICDv4iPEt1vRA5udMTUZ1x8T/28dlpns7O8xLWZdVpQ65PgLy4xMrm4J43dD48jgMSIa0swhJAIPvAeX/AUUPjivWdcvB7AvhxZeKsKkY0CDAfD/KiilGM/5a9OA6BbhmwjNiDwVkCD+TFB75sgxu9TG7hG4Q5xTn94ZOCmeUS1jjO15dW7p+3yy8UClxJJZid5xfKjdonHQZ+2QNezjfj/2KemBiXZyWUt1h0cUIUXg7bBQ/pbukl/83VJX7HOCD9p5ZxV0mT+8dtG0KoWrf6qMs5IUQFjDc8RupaoIoR96VUhASySD2lvDGBMjttu2kqXCTiyjovbbhCJVnj/12xuuHRTsSg1ZiUxKaErqvkj6JQBOtJf+D94e/G6jfEViH0U5omw3456LcPJO3no1a3LrrX8mJMlQ9besiqjJaOmnqrM4MWPSQmPVkLKit2K6t3Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(19092799006)(10067099003)(4143699003)(5023799004)(11063799006)(56012099006)(261021121427099003)(261022105027099003)(261009223027099003)(261026140227099003)(261028144727099003)(261102123227099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wEHl1VmyexJxEa8Y4HjEBGzSE0eyLyq6xzEw7GTD/cXphkLOMFxgmSbhrJvm?=
 =?us-ascii?Q?lbo7GE6Vpk6oLBcyc44EXlRPVCutFdp/OBNz06w/r8iQfuY/15BEGpSSq508?=
 =?us-ascii?Q?QNAK+sLf2euqsJBp7adm1h9TqF639qQUrCQLvSSfjlGZ/6fkkLUxLIO+Uziu?=
 =?us-ascii?Q?hOHU4xSYkhJS4H/1ojhVexPDtUS2qS2gVr5DlX0lKZZ1UPV8raxm9v5W1fxz?=
 =?us-ascii?Q?L27c1l4lUejcQ/2BUMR9/jsWFWcNNeij2KZxVMch74daNUnSL2SlsnaMrnkL?=
 =?us-ascii?Q?Tw3bsy51ce9uO7BBndZ/jfYvh7QwCM1UPHClpSFvz0k1MLUonbD9ZbSqckVR?=
 =?us-ascii?Q?GgQp9N1Ca0MRHNfKklyF9KA76qrDaAmU4KQOcL5lEucnTnqO9zAQGLeyRTie?=
 =?us-ascii?Q?X+IpQFhDdcE30346haZefw2Alw5tXk7iA2IejnnSJAWeonFMrwptJFI5vlY5?=
 =?us-ascii?Q?IE4/ub3tEwW5QZFfAUqW97TTTRU8oeZZ3acFGmugWPPsBAQeh4uNwOYDCrrr?=
 =?us-ascii?Q?LpLCWWX53oK1Jz3coWIKaL1Z4VvItNiKjJoY7j8l8v9jBqPy0Gr03V2IwMim?=
 =?us-ascii?Q?AJWCGzDhTqa8u0xvDKMFkOrzHz3tcaIH7iQAwS81cEQS5TyGhiK1CHB+Xp3F?=
 =?us-ascii?Q?ZG4zFUu3EPSFCPIEVfwzemwDQCeiv9eR2Xgzmf5Yh1rdoPbBeERTYL1WfY3U?=
 =?us-ascii?Q?5WmZ+S4GFuhC9ChR/pCBveXmT4T8Lj/UbjM1CEGv5kD4uQQKMXW1nz7QwIMy?=
 =?us-ascii?Q?CsYwZuAyv2+uauIIn/VNVr04cLs/5uzNtXFK9mPbo38jAGGYw0BZZfM109pg?=
 =?us-ascii?Q?jmAV64ZWOUPRpc3ai0PkbrZYyv2TzQ8UrbvNMS4pR2r4HD/vSRCAFirANGZo?=
 =?us-ascii?Q?g78TPZ7AU2yuWadDDiIDNDiDPpM5mIjlnAVzfFnIjl5dbYSsJCB0ckx12EaV?=
 =?us-ascii?Q?n15+Fg1SzYrqh1SHzbVKT7piEtQSHtlSDx2WWAHKV0WQqs2KfLQOUIbw2SoH?=
 =?us-ascii?Q?u5FNk8DyT3GRYTe+/IcVEbsmh+lwb421Bv+jTb4AkanOlHIZlkvnU4pzM+HX?=
 =?us-ascii?Q?h235AD01Gagu3dEf9vgsn25B3yH1+1cjnnIC1r9fCTWnuxFBkEMXKj7UkeFN?=
 =?us-ascii?Q?eIswICJgn+s24jugT5ZkHMPwFQxGginis17cKvSHU6zPpVSPiBUHCcT9Cgw6?=
 =?us-ascii?Q?m2eomyXo3UDQiKUK9lV5WzS7kakDdcf7DubBpN5oFxFPVGxanivGNqEYybRd?=
 =?us-ascii?Q?bf+ZuLh8g0yb1bGFI25mq+RlQ2WqheFYbsSmT8iJY60RFJhw/qgELcUJZZt9?=
 =?us-ascii?Q?qoR+zqltrGwvQafRuiiWozr0v3JSWlIR+KcHZuAmJ0pOkXwVF8+46cstnv9f?=
 =?us-ascii?Q?J2qb2B0txFyrDjaBIFv3b3w9zb3PD5nSo+kmNQzYJn3dowRXXzR0EMyzr8HN?=
 =?us-ascii?Q?r9TsSB1lB8Pxq/KzP7uHYg7dVWNhrTd/LYh7i/9I5i0dIgrPrGKROMsx6xgx?=
 =?us-ascii?Q?1hB5vgtjMzE+rEcqBeT2k0HlnPFko7Ned68TYbmUXLFJi+M5g/S72XwkorcX?=
 =?us-ascii?Q?y3PskFMfDZL7v2qBoBLixRwTEIMg2rBT5XMPYIT3DPE0/1tah3KrKMI4L5Be?=
 =?us-ascii?Q?wmpILvncI9f0XzH1RQmeimRsBm2W8ahwpdUGk4AWndfvTpdMmchTLSDJUGj0?=
 =?us-ascii?Q?L21RYjNGOeK6dmO3Wptw8goZEgisFVihET1tvspP6QFR9Am+WeOI/mKlTLyI?=
 =?us-ascii?Q?JXtYl+dWIi7tuDdZ+/og4OpTm4cEo6uyhS89hKocPiNdk5DdC794?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0a4855a-7667-43ee-f143-08df4986c869
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 17:25:34.8881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gQ9UG5XoE9WECGM6ZUpGd7qvW7fZ76CyIINy5d/Tv7a6kOlGuT7+sbWhHhXGk1QQegweZIZYcHgZuY+o1+eKjtZFMG29TyvGmq71rjb1KcEZIYvEsM/Ze0/76u/SJM6a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB226274

On Mon, Nov 23, 2026 at 04:47:34PM +0000, Lee Jones wrote:
> imx_lpcg_parse_clks_from_dt() allocates output_names, parent_names, and
> bit_offset on the stack with IMX_LPCG_MAX_CLKS (8) entries each to match
> the hardware limit of eight clock outputs per LPCG block.  However, it
> only checks whether of_property_count_u32_elems() returns a negative
> error code and enforces no upper bound on count.
>
> If a Device Tree node specifies more than IMX_LPCG_MAX_CLKS entries in
> clock-indices, subsequent calls to of_property_read_u32_array(),
> of_clk_parent_fill(), and of_property_read_string_array() write past the
> end of these stack buffers.  Reject counts exceeding IMX_LPCG_MAX_CLKS.
>
> Fixes: d5f1e6a2bb61 ("clk: imx: imx8qxp-lpcg: add parsing clocks from device tree")
> Closes: https://sashiko.dev/#/bug/linux-22dfac78-f44b-42f8-985a-995308723fc4
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/clk/imx/clk-imx8qxp-lpcg.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/clk/imx/clk-imx8qxp-lpcg.c b/drivers/clk/imx/clk-imx8qxp-lpcg.c
> index 9ad016106b1e..5eb4bdbaf7d8 100644
> --- a/drivers/clk/imx/clk-imx8qxp-lpcg.c
> +++ b/drivers/clk/imx/clk-imx8qxp-lpcg.c
> @@ -199,6 +199,10 @@ static int imx_lpcg_parse_clks_from_dt(struct platform_device *pdev,
>  		dev_err(&pdev->dev, "failed to count clocks\n");
>  		return -EINVAL;
>  	}
> +	if (count > IMX_LPCG_MAX_CLKS) {
> +		dev_err(&pdev->dev, "too many clocks: %d\n", count);
> +		return -EINVAL;
> +	}
>
>  	/*
>  	 * A trick here is that we set the num of clks to the MAX instead
> --
> 2.56.1.750.gf70dc682cf-goog
>
>
