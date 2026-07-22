Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013051.outbound.protection.outlook.com [52.101.83.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B975443AAD;
	Wed, 22 Jul 2026 15:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784734253; cv=fail; b=RhsOTM1u1tB+3ZJ07ovGQsz8WowKdHPG0fyKq56bOlRWgnd6WCFzLB7Hpk4MdS642lXFCpNIgt96yz3mzyqaGTNyZU3zRwvGkatwi2aeM1ZfBBHGj6phS4mgcK5eYMocUA9P8t/HsqWeJPcE7mbTYH9h4+/I4JLsohKrZWSGVqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784734253; c=relaxed/simple;
	bh=oSnMGKDA/L1luxDP7ZujbfO1/tg0+zoebY1IffVIscE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rlw9zX408H81OVC4T5Y8TOsg2B5xpd7ViApqOY1Ubwri3gq4gMbw88w/fXMklX9why/xFyrZVr0mqIjTXT8nHRKvzejKQdN35IlKj0YAHMzePUkIxDnBNq7/U+8VMdRLVPbC4RSCQxuZdswpcOnND+dzZpbuuRqVBnRirjEtrzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=mU268o3D; arc=fail smtp.client-ip=52.101.83.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="mU268o3D"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c8POvpc84BYROtQnwnmtEZpZ6eEwVyrlEwLa8/PkcDO23SmauhUhX+SHCzpmSIqbS9d44lmKEtzmmyOpZZhBusX7j5airHfxaT3nX0FQFiBcmz3KiJf7EEmhI85+7XpRzoIbUUGJkVpx+MirXjw1Mehk28sejw1r/CaOkKAugk7+yq8MiYSfHjS+VmidUQtfiiv87g6WMn7L9tQwsyzk3zeBXO/pytJZorer8sx/aPZvQZXPxRRVavdqBcioyEK40lU9qcsVhmo+kG17j7e+Ww4iWBz1f4+bbcIw/eHLKs/Zg4eJJoPR45MGjJYk9eYYcVSd5B3s2WGuW5J3Sl0pDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cOCfGAWgbE5McsMYyOnuSGnx0+90LTimQv11BfBA474=;
 b=XhEDXQQzGjq8SpJHaTsBAiiXiAtdMdVU2r5e6zSV/Jodf+mMWp8ebrrMhNEZImP/eohj5zOrY+XIy3eKPTBfeiFexWZzu4vW0oq8fHdTTzy2xMnb8WlsykSjQAaYoLYV6l2DFyJMlvKwK1ujGGk7zPTXQHAZEFXyuu1pEM2JZ2vFg4Aw8elNiN8N1H4j8Ivg09Iaxcf0cqNMzqeXCCiXICtdN7kbBNoqarvZzQ6pKRRWAuIVNqo0vIBBYhJ8BqBlROxY+ksgUSrvuiltfQ7K+liZJumJhRdmhBzjcBt/TudI/+36yWz1CGSX6e20Dxco1Ee83IPKOV0yg/NLco1+sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cOCfGAWgbE5McsMYyOnuSGnx0+90LTimQv11BfBA474=;
 b=mU268o3DsnWboRzqIR9RL69QKem+wY/WG8LLwnML1jNGWP7VrTrBWdxardtl4dZATGF72JKYRtztGhpvuyMQXMMhXlA1S4aEp5zQep3r+2rF14T4M36Jni8dYrJrRMm8KGpabBHOkzO7VMMU9DBVlC2HxroM2uhhga6iq/xxGsD3J8t+fHvtwfQNWCBDhohbzuWKE8I8/MxJV3nC4U5Jz0KJRlHvX52sy5hZCdroYIz4uKmdoPg53yIHW3DAoa9v6wX0e+dAiCcVHA/crrVL0sXdVm9z05nTw5NSQATL2JEvJU7yy2LagcFzTyXUiMvrkNcwREFPr9K6d/wKmoa49Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI1PR04MB9980.eurprd04.prod.outlook.com (2603:10a6:800:1d0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 15:30:44 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 15:30:44 +0000
Date: Wed, 22 Jul 2026 10:30:34 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Can Peng <pengcan@kylinos.cn>
Cc: rafael@kernel.org, daniel.lezcano@kernel.org, rui.zhang@intel.com,
	lukasz.luba@arm.com, Frank.Li@nxp.com, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, linux-pm@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] thermal/drivers/imx: Disable clock on runtime resume
 failure
Message-ID: <amDiGlN13RX9J1rC@SMW015318>
References: <20260722084909.463437-1-pengcan@kylinos.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722084909.463437-1-pengcan@kylinos.cn>
X-ClientProxiedBy: SA9PR13CA0134.namprd13.prod.outlook.com
 (2603:10b6:806:27::19) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI1PR04MB9980:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a9ba6eb-418f-43cf-f8d9-08dee8063236
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|366016|1800799024|23010399003|11063799006|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	VPabih3ElMy7YnokdNe1YusX+JVcDBX8J4ZnPQgV4F6vp4hPhz85HvlPjqotTOO1jeidw8bHD55OckLjHxZCE01O94JUYvh9GcSpM9saeRxObvgchA7VN23/PrmxMN8xhCN3PxO7bdIPKaUSN2XLQnjF/p0CgEl/rxyt2nm52cfWdJzMmvndng3PLYrZYKN3DKT3SO1gX7SSh1Qv8/fbIIETbsEteZboaj2pmhDjxreFX1TDFixUpTXAprti4/eQMPzG/orrp75nwPzy+x3KR7TuQo1MdpTwZWsRnnClu00CFp6M9Uv4iSDRV+y7sZeEpIIE4jK43xYDJktEoa6SiKyqdGn8LdsfuqFHxvOD9eZQ5szykB51BexjfodXq4JoLkZmvBEcJAIXREiyfF9jrzEsmqZ4oSr6Sj83VKFURfuVs6gBr6I9qYacx9/+UjtpwsZuTlHAuuw4VhzxTfcDjd8SFQaNkAYXCXOgPnDG+7IJhRZ3r3UEk6hni2JMjjzdua64kb8brh2ooq++x6nWPd8LVLVEsIQ5Nww+h0iXueKOfmVx5hvcgu0dLlUL7+XuvZFigl+XqGKd1cutmsuJihW96W2OfnoySQlEbj2XM6lZl7JPd8mLeEpsi1dTkBDNfHb7umpHHAJnN7v+Yl+7uywbj8YWNOGiR571uHVtfoM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(366016)(1800799024)(23010399003)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?96MiDxi8WSQTik+mmZdFaO4yxyCh4ubOf96z8rsZ75exZhblMyFaJIa9Aqvm?=
 =?us-ascii?Q?Z9rY4LUrYe5WFRSsHbkOv+JwGuC92Z7C66os2pt08AJxzJGkZRNKMc5KLfme?=
 =?us-ascii?Q?/PQVRAQNpu8vq118RpAWbuq33m7qm1QfDZ2vLwyF5Dcky+JfQru1+SG8K19F?=
 =?us-ascii?Q?U5zd0qmP8oiSb+G8yBCTTBLr5CvYyC3/A2qgnFqRB0wI+O2CV9/cUGvOT3dc?=
 =?us-ascii?Q?aX8cJwpRmlftr0m7shemyhK8VBegynH8rMEMm1L7idRMpgC7DFaTgRSKg0iA?=
 =?us-ascii?Q?9Pv+WQqXOtKzh+RC7gzJOQZA2wtL98fBE7tRklQzVPoTM8n528yjK3bBuClb?=
 =?us-ascii?Q?nY+KVgZkuBJNQDjm2GXZEh5Bq3PkalCaaVUrqipezn2Uap6pe+srReylwItS?=
 =?us-ascii?Q?sXLQ22L3+ajldL7sOX9oNAoTP7PjYCBaHpxRe90ubNnnbFVDwhx+b0t32njh?=
 =?us-ascii?Q?4Cq85mgvILr55Ov1TXShvKyE6cfBmKsRa9Yk+Ir8TY+Ip2XSCoR7U5JU7sLd?=
 =?us-ascii?Q?JtNzPVg4x7zq8ZLe0x1iMWuwl+8B5ybABNFfbt+pnU5heBjX61/kWJgqzvf5?=
 =?us-ascii?Q?tGIAxXV/3ToDhxFsoBCeONaXb5+NAcOtSES29kK8VYRFpU0uB4gC4ci1t+ZO?=
 =?us-ascii?Q?2VcntSyqsPBonY+30I3riiB8f3lwIKZ0jfdJb7sNfZzB86+n0Rd3BCGOSkm7?=
 =?us-ascii?Q?OlO7qvkZArww+ACeqh7qSr7ToGpb4/OeL/s0gfR7Ala0HXZVk+O+79ojCLmn?=
 =?us-ascii?Q?kQl3Ig+9sWDlBdmzbgBTY12j0UsDO086jE+OINuVjsa6Vf3d5EolHSA0J3q9?=
 =?us-ascii?Q?E61gIf3D5WTCQnue2RrbLlXS5UjAditWKagO1Fv9d0PGFC6JEAFCkG205RnH?=
 =?us-ascii?Q?vWKEXZ61llOfps5sG8Yo1TP+l+zcrfqeL23EYlfIU36BoGAVsyM5wgieL6bZ?=
 =?us-ascii?Q?pdaO1YIeKxCfSzHjk2CXnjZmsc2ILqEBmeOpqc5cWwwvMVR/KSk6IZVW+q11?=
 =?us-ascii?Q?js+07n8dXg33fzHV/Nm1RaVHPdQ8+jjS7FlbKAWWPXrHhQljl9SwNa6nni/y?=
 =?us-ascii?Q?NiIKeFTiE4f0yW2lYIgL8fRpekk9wR8E5HV0EAwOPr+ejD5m2DhqvI6+XpYL?=
 =?us-ascii?Q?WsCpUXDxDqpv+IOMfv3XVfrWeM7wBdfuPSJR5M/UNSP02mvbmRWG1orl8tuH?=
 =?us-ascii?Q?zLoyQ1/uzehQgRYumQ0SVB/gg/CZfCSzWF9oq3yK0Rlr8iSeSJ1+XrbQpEEf?=
 =?us-ascii?Q?zjaUoyB2cYpU0YKbYgk/zI5kEfLpT5UNCksVZi3ahZswd4aYr79TgDq9GJR1?=
 =?us-ascii?Q?F/ChuhT2IqY/6Dti09cgE/Jx0y82HR1L9Vwua00OmoBUzRQ4FwPbaEzvJYqB?=
 =?us-ascii?Q?4FLAL7Mccwr7OYFOZpI9YE31EDLgqDabeA4FvqTCU9BlB3zK2BSBtYWCULR8?=
 =?us-ascii?Q?JZyxwq1iTq22mhiIVP2ylGPomJ5fe2iCKI7KgMPZICgxaocyWConi8/vNpJe?=
 =?us-ascii?Q?meoReVpRjh32D4SBwJshT7B7aSjrtzZWx3kcg/hPgD3vECcMbwoKiNlDrH7h?=
 =?us-ascii?Q?vebRs5XiVvLUVW+U1V5Lz6NgZ1k7kiq3tsCQbT3WIiep/jtWF+Xs7z4Plkv+?=
 =?us-ascii?Q?nYjdYN7K3yETeK1gPOM5nxY7FihZw9vJpMLEiArSWguBXv+spjVW7TozDX3+?=
 =?us-ascii?Q?zKrPsZa3VO5e0uPwn5hfGNMACKYCtrAJK83teXTlyZ36paewRSgCl/442n54?=
 =?us-ascii?Q?1i//J2LFUGXF3jdYMXKvIL2iRPH0D/paTxg1p1WS20TGCDw+9Ujm?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a9ba6eb-418f-43cf-f8d9-08dee8063236
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 15:30:44.7609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ur4ih+L2/SmsuYezZ8UQwxeAAg38yfpr0liBFCgb6oHoIa1sDcVvN62oKOPF+bDFJwTTQonw8c00qnRnQaE5EGhZ0E/80iKv7jqvlpO1m57NJEM8soN6fUSLKck67Qnh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9980

On Wed, Jul 22, 2026 at 04:49:09PM +0800, Can Peng wrote:
> imx_thermal_runtime_resume() enables the thermal clock before
> powering up the sensor and enabling measurements.
>
> If either regmap_write() fails, the function returns with the clock
> still enabled. This leaves the clock enable count unbalanced after a
> failed runtime resume.
>
> Disable the clock on those failure paths before returning the error.
>
> Fixes: 4cf2ddf16e17 ("thermal/drivers/imx: Implement runtime PM support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Can Peng <pengcan@kylinos.cn>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/thermal/imx_thermal.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
> index 5aaacbc53478..b0e88b6a9352 100644
> --- a/drivers/thermal/imx_thermal.c
> +++ b/drivers/thermal/imx_thermal.c
> @@ -832,12 +832,12 @@ static int imx_thermal_runtime_resume(struct device *dev)
>  	ret = regmap_write(map, socdata->sensor_ctrl + REG_CLR,
>  			   socdata->power_down_mask);
>  	if (ret)
> -		return ret;
> +		goto disable_clk;
>
>  	ret = regmap_write(map, socdata->sensor_ctrl + REG_SET,
>  			   socdata->measure_temp_mask);
>  	if (ret)
> -		return ret;
> +		goto disable_clk;
>
>  	/*
>  	 * According to the temp sensor designers, it may require up to ~17us
> @@ -846,6 +846,11 @@ static int imx_thermal_runtime_resume(struct device *dev)
>  	usleep_range(20, 50);
>
>  	return 0;
> +
> +disable_clk:
> +	clk_disable_unprepare(data->thermal_clk);
> +
> +	return ret;
>  }
>
>  static const struct dev_pm_ops imx_thermal_pm_ops = {
> --
> 2.53.0
>
>
