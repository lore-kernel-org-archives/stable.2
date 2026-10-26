Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.34
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793033259;
	b=SOnuAellxFQd80iqLWLlth2tWz1krCizPACFUaLZyRj/WlAdJW7SQQ41YoU5/hyXqof0
	 R9iGGdkibCexCt4UBivNz5vZM8D9P2hBzpi93SDv0R2ezYsK9C03D8p/7PWW2PuNHQK9F
	 ddSTu9y3Af5Qtq9la1GsQJT0xeOy3U9OeuBU7cHlsL6WN/0vKMXiUjXBeBPmHMGWBLH4E
	 ixDpiq+AaZECdZRmpJv/oKSX4PufwSu59iKWs79jA2rvzmFxvW5v9gj1GzZuUuMjEYZs6
	 4hRd2JXc8TSg4Px1aqfBQiCFIKv7ofp9Wisho7e+UpaE3ys2OVgb8MfYWklOX3MO8+g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793033259;
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
	bh=F2NYMcfm886OZe+D8sPU4LJaiFIUUSrBGz780bUDdX4=;
	b=p4YfaFL7INk1SGH6Ccjy/02Owgy8MGpxW60aPHI7Jqidq5hmRQiveCyY0P4iwxt2vKzE
	 35VzMyHWJspKGZHwEpJslgEHZ0DJg1x4FDmB9NqixtIfslYeYuXdvW8Dv+a7d2OvkaPK1
	 3nnWCAMp8fZj3eyMCC5WP8T4FNkzgltAQmhpmBhAUdMZD586xBZ7YeT79KzPvdf0x/Ecf
	 7wLidx7gv/iuEtBhI9rpAV/aANPSiXqWxkPgzyDIuemZJ2nEc647ochljDF5DGq7vItCA
	 gihX7rU84YFwTdCQTPU7jWr4paSixsFZbOacJETJ4lrllcr92fZzQWojDaKOuwwBdSQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=E+m5FobF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.34
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013034.outbound.protection.outlook.com [52.101.83.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C60606A31A;
	Mon, 26 Oct 2026 16:47:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08C60606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=E+m5FobF
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rcvc7BegtHbbRcGF9wEcdJ5jVHUdg0U8tGvwrZS/E+WDQzmNM0sPTpMhb86AKIBGN3fBNCVn80PcntjmWpUxcX2sS0UMTj/iRPGl20Rtfq2qL2GzcoAe9OSyKSMlLjJalCJ3wDeLQGm2m8YbBcZHCGy/i5fZCm5BKKjlInkdlcf6IXVZ6qtOikWz6IXxARFAu0Uhj2FHp+vfAlLb06pst3DgpZKQYO2maefriAW0mMBMBO553vDFqspCBPI0Lmk5j/+hBjy0pAuc1vPRqqzYh2eEgEGT/PL48T/c4fobgvoaqRmoZw9OBn2UTK7wC+Yp+sU7CY16HaPg6HkRzB4V1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F2NYMcfm886OZe+D8sPU4LJaiFIUUSrBGz780bUDdX4=;
 b=XPcz4rGdUifRXZebj9COk0aXaHAOal17BMEIokv79vJ3G2s1Uf1AFQyUmJA1hxi/8BGd0u8/3d2qGp6196hPB4H/V8U6p6NoaC+XDhv3G+zPKOYPDQURaC44kpz4wmRo/Lo2hE2tpUpArOK+CAVBRgX6iN4NUMejgeLg2/Z87OL0ve5BOM6rKqbs5zRgwVID3ksh+ov/WLoroL6fZaCgT7rMlu9yGh9RRDvyAv6RvmbmHp1pgNqwTYe/kVVBV6CCj1cw6m7+6z8RMA6u7X7n1xG/AdGLO2S1aCNMKn2k1DVEdvCLzhxdBncdQfeZjrQvTewSV2VmaWlXK8HwQ7DYiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F2NYMcfm886OZe+D8sPU4LJaiFIUUSrBGz780bUDdX4=;
 b=E+m5FobFSBRkvan/rGw1cqg5F4EnH2eCLu6+RpKpDJ5VzD3j8PdAOB8AkLwkCXrEHQBPo4sc9/JTWtblDBnPN9lg66ho4J3CweWB+KiskPLNJLRoBfD3+p7zgdQ1600SCW18xI4FjD3DnnhuJNCumvnS7V1pz3U7l1s3D0TxbmSlGlmLPE510A4DYNW7yZmxBlyc45uJsQxRZYlFkJxkO67rDk4V+gsAB+nofCKK1NXdM7uIROnUESGj6ZBxoeBFwdS9XnDQJ/rnJpOPHGMmJ5jFtN9ekLeW7EazG55dJnoEzLTn7kwYzLZxO7/EUtPf58QQmwaJvb9P3+1EgNy/Gg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by DU4PR04MB10340.eurprd04.prod.outlook.com (2603:10a6:10:564::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 16:47:34 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 16:47:34 +0000
Date: Mon, 26 Oct 2026 11:47:25 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Xiaolei Wang <xiaoleiwangxiaolei@gmail.com>
Cc: aisheng.dong@nxp.com, festevam@gmail.com, Frank.Li@nxp.com,
	ping.bai@nxp.com, kernel@pengutronix.de, s32@nxp.com,
	linusw@kernel.org, s.hauer@pengutronix.de, sudeep.holla@kernel.org,
	cristian.marussi@arm.com, peng.fan@nxp.com,
	linux-gpio@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] pinctrl: imx: scmi: replace custom dt_free_map with
 pinctrl_utils_free_map
Message-ID: <at-EHbO9KntKl7jY@SMW015318>
References: <20261026040230.22338-1-xiaoleiwangxiaolei@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261026040230.22338-1-xiaoleiwangxiaolei@gmail.com>
X-ClientProxiedBy: DS1PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:8:233::19) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|DU4PR04MB10340:EE_
X-MS-Office365-Filtering-Correlation-Id: dc9b8227-87c4-4ca0-fe45-08df3380d5e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|19092799006|366016|261026140227099003|11063799006|56012099006|261009223027099003|261021123027099003|261022075727099003|261022105027099003|261021121427099003|10067099003|261026121527099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	fAZABalk+SJZXBsvAgpm3IPYZLs0ylVrAoURAelFZmZv1nyz1Ni7KWkbAWV4XNU3v07GlepN/rhbSMg3BmzOzfms2B91XHKbmAfOuCQ167Nex9jfCPjqhv/tPW0bK/cx0VFlx60I85dqtNTaZSabLlnBb7Qt236oEt0NqbwKEP5OJ5j3YMrCqgUMA/KpE52IUuhI+DKwFjc7rWGQX2TfkkuDZXxTvin6MJG5WR2gTn3do8E+era7KYaJ+exfngKVhZ+GVV9Coqdj2rRW4ZOJqv8G/G46kHcywS9OQ5HbVywZcWBUHXFKCpnE0t6IK+kLboMwSICHroLF/03ukX8ozRNKwGN6FqqnMml9WMZS1msdl5zEwovrBbbvNv87aHmlo5AxERC4EzVlZ5EIVUT9K/2NqFsGV4nyOyez3rRdvqYnvSBv+XUnECs+jrWQJgiKNGuX+0eci9DgJ0VLF9FQ+D2MPrrfO1HjAtvuuE3XVznLX7N6p4bVL8mnEDeEIfmQDtgqlf2rsAxn59Nw3clikvDMqhxT+hUre1PPtDK/Hs6jfeNZj1aks562u2t+sqpVmmVcQQst+sXeKQW3gxlH8lLX7sWFls/AUZcnKJO0dPBLRkuUEVwzKMjzhK8N/0WBYkR8jVurbNeYRwj6kjDHHcAkXmBYyh5BUCcS6l0kyOc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(19092799006)(366016)(261026140227099003)(11063799006)(56012099006)(261009223027099003)(261021123027099003)(261022075727099003)(261022105027099003)(261021121427099003)(10067099003)(261026121527099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zO/9n/cXX/OfkCX265xx7AY+1VXN3YciEBPvxQkmL9i4yuRAcucMDLQQbbTa?=
 =?us-ascii?Q?PIoroq+kw+x5x7UXbNedSTPak7X7JVBLKPtiB6b38HsRYFGgGj7OjzaAfSbm?=
 =?us-ascii?Q?eAC2L+gbLCOzz6ybecW8LvPE4XBQC5Qw70jsrfuRdn5W448zyTJjdqSkBZPe?=
 =?us-ascii?Q?Uf27qLHyBSyT0X6uxFtCzPe6IYMmT7p6m8poPqOHu+qEnACbvE/2QrEJZBYb?=
 =?us-ascii?Q?GCdJfCBtXxYY1cL0QTkiresxlaAjb7wWgfs27Wadl3GpsVfUdeze0LnSWDK9?=
 =?us-ascii?Q?F1JgEYByLb5eKPb8BSpGuN4TsFAquCu8flOJcrzKhDZx9ZyZeudJ7jBKjp4c?=
 =?us-ascii?Q?ZZjWfCbP5qlKdGAMEMtQt6YABR5AtHh4ywqta2J1/NOyO+X7rxvPOi+wIWAI?=
 =?us-ascii?Q?7L7/H2bN2cBJNOhW59UnQyJN6j8AFXppXSx5Y4cW1EuM6rBy+hByGdLb/Egw?=
 =?us-ascii?Q?f7yR6IKOg0R1QlzE6AbwfeGDJzRDOjA0CUlgqsyAsTtYOrOWuaj3Kc1i0WQs?=
 =?us-ascii?Q?2aGkRTxzdSUeHASsurJhCpAB76I8pDzwpGPFNqCTt43Rf6IHnGQyqDj2bOtp?=
 =?us-ascii?Q?JsXXXPPDuYwe/9dDwzzD8IFj7aI6bBFFxpXG1WEtI2Nk3rQQZJX471cUfhtu?=
 =?us-ascii?Q?EYDdvpOPejDgSHD8LxfiO3swS9pP139uJkg6Niypi0HEK9s7eI+w0OXbqyib?=
 =?us-ascii?Q?lMq+HfQ1kRXbZOR/qkNvHT5YYCXZihrSPdpMP2kDz9P8epfIHVZhKUnOKDK4?=
 =?us-ascii?Q?FDEt0k2o0WR+wbTcBIGnsTUaDAYRPK2C0RFYLbRwOrhkZ2I6mbaJF2ZmiKFn?=
 =?us-ascii?Q?Iwk3D85OcT40N92adLFm7sofYFgWeusZMGZQNeF8lH75ERe/sOMpiEp6OBDA?=
 =?us-ascii?Q?WPUVq0v2v7onTr20jufzwSvcIvsBzHuCHmMCe5x/50SQfLy2oGuZ+mCkWUOP?=
 =?us-ascii?Q?wgxM9uMe25xHwR7GfOXjKbeQ4+B6h8LwJXPsEAf5duVaNU8mW/2BYNpx/MY6?=
 =?us-ascii?Q?7bwPPSF1X4Mecw2NGuoQWCEClM23kemtiIZXIZPaE0f4lV8YXhuD1NxacYE5?=
 =?us-ascii?Q?8zZlYi/KXbe4j530D8oV0rYk3L0ShK869KhVi+FSYQKGMwx4F8WPcSjIO8Gd?=
 =?us-ascii?Q?KnkOF7xaKTqTbDHUjdFamk/rXmO1nMEbwt0VHzxqp8CsGL3x8E9QOtdMuFkk?=
 =?us-ascii?Q?BUh19RqfD1vB7YM5DR/SDhJ9gp3ljVj5NeusG1jN67AYEUVOeqgzLEdsxd1J?=
 =?us-ascii?Q?OI0dEFa2OtlMJeEnRxGpxbRqD163aawxIrq8zCxKkuCTH7aqwwrEwsnRpHOm?=
 =?us-ascii?Q?hCf38zqUQTrowD3xIt964VZbBZZ2KyjLvvV4b9LD4EaB6yhTNXYfgW+PaKVo?=
 =?us-ascii?Q?G3gbxSl37CIKk9vo1dQbfMEqbSQcPwOOyymLCFpjG9dcrTJQsbRY+9NEeGJO?=
 =?us-ascii?Q?/5e8gIA2PHL4XoTQ2Nnh/5DEB9IlWKQN4AiG4BzbnmPgEjlk0fqnDOZCxdK6?=
 =?us-ascii?Q?tEGAmlyrrVIdwvXoecUBEsarh6w6DPQZVJcnFsDPpYDRKSqvcOfgTbbA0ULF?=
 =?us-ascii?Q?rN8UwmgtsKHpc9Xe/MuBMhCA4Sjp4yjbaVANcFlg0aRsl7F7ixprfz0MRNxy?=
 =?us-ascii?Q?Qn4d9CLm1PPHvn+eXG78X+TyLjQSSlZ2L6dxa75GhJR2+44gsOHToM/D7jaQ?=
 =?us-ascii?Q?QHPWUoP6EurmKPxC06B1e5FJUAOLJbM6od8B4pqz/BktkLJyaN3h/IXukB4n?=
 =?us-ascii?Q?UaiRq+KpVPTJ/GA8WI2mal7XQEAZrkXgUyvLm9eO7yGUDzkEHM9N?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc9b8227-87c4-4ca0-fe45-08df3380d5e4
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 16:47:34.9064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lLSgN8Z/eqvEx1V/hGYL9g0HmekuUrYqJG+EhnJUN07af8tHlm2m9dEtqtLx5/2M/1jJ6N0KnWRlVXm5pKtfoTyZ0pzMVdxmnrZzUGPuqQWjjvOIRbSI/Hb6yr8kzD0o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10340

On Mon, Oct 26, 2026 at 12:02:30PM +0800, Xiaolei Wang wrote:
> [You don't often get email from xiaoleiwangxiaolei@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> From: Wang Xiaolei <xiaoleiwangxiaolei@gmail.com>
>
> pinctrl_scmi_imx_dt_node_to_map() kmemdup_array()s the pinctrl configs
> of every pin into map[i].data.configs.configs, but the driver's own
> pinctrl_scmi_imx_dt_free_map() only frees the map array itself. The
> pinctrl core releases maps through pinctrl_dt_free_maps(), which calls
> dt_free_map(); the duplicated configs are therefore never freed and leak
> every time the DT node is parsed, e.g. on each (deferred) probe attempt.
>
> Replace the custom dt_free_map with the core helper
> pinctrl_utils_free_map(), which frees the configs of each
> PIN_MAP_TYPE_CONFIGS_* map before freeing the map itself. Its
> signature matches pinctrl_ops.dt_free_map(), so the driver-specific
> implementation can be dropped entirely.
>
> Detected with kmemleak on an i.MX95 board (FRDM-IMX95).
>
> Fixes: b755521fd6eb ("pinctrl: imx: support SCMI pinctrl protocol for i.MX95")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wang Xiaolei <xiaoleiwangxiaolei@gmail.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/pinctrl/freescale/pinctrl-imx-scmi.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/drivers/pinctrl/freescale/pinctrl-imx-scmi.c b/drivers/pinctrl/freescale/pinctrl-imx-scmi.c
> index 613552e35070..8cbd66950848 100644
> --- a/drivers/pinctrl/freescale/pinctrl-imx-scmi.c
> +++ b/drivers/pinctrl/freescale/pinctrl-imx-scmi.c
> @@ -153,18 +153,12 @@ static int pinctrl_scmi_imx_dt_node_to_map(struct pinctrl_dev *pctldev,
>         return 0;
>  }
>
> -static void pinctrl_scmi_imx_dt_free_map(struct pinctrl_dev *pctldev,
> -                                        struct pinctrl_map *map, unsigned int num_maps)
> -{
> -       kfree(map);
> -}
> -
>  static const struct pinctrl_ops pinctrl_scmi_imx_pinctrl_ops = {
>         .get_groups_count = pinctrl_generic_get_group_count,
>         .get_group_name = pinctrl_generic_get_group_name,
>         .get_group_pins = pinctrl_generic_get_group_pins,
>         .dt_node_to_map = pinctrl_scmi_imx_dt_node_to_map,
> -       .dt_free_map = pinctrl_scmi_imx_dt_free_map,
> +       .dt_free_map = pinctrl_utils_free_map,
>  };
>
>  static int pinctrl_scmi_imx_func_set_mux(struct pinctrl_dev *pctldev,
> --
> 2.34.1
>
>
