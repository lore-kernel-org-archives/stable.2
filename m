Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793897460;
	b=PwJPXPHPlOn9jfUXXN61iSkHC0sx3Ztj1VLHd3vXOIogCxHDFnozC9Ga0GBbiK3+zfOI
	 CRgTR4G4ZluGaN0VYuRLx1YIMNNLovu0FWR0sJvM1Owy3k3LRXC+6OAeKEP7S7lZoY+Oq
	 Baj92bNd3Uazuw60InZ9832UUwToWJnXI7h9wcsgS0RokqwvczeOVeBcV6TZuzRqJQxMN
	 +4TcKVUEY0PMMWODkdr6sWVt7RpjoKZqEOIShk7/Zo9dl728Sk2Zp6is/6xO6rjHoZtLc
	 5vUgyazo1dLys2KpAO+BvrnaGOaSGGzgUi3jSuKY/XrZQAqIrXQh/hCirjM+utSwhtA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793897460;
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
	bh=ewSR+KD4DJ90iUYVLxQT0f6UAWQ/IoojYctCXpQoeDU=;
	b=L5izx7cbcdMCDW4eRggRzAbmxsmuXIV4yA8NK4SHnnfEHaam9uU40Ry1i+jY37I3unPc
	 fNOjXoSLZKH1yB3VZWTEFmPxTrckcz32YPlBtXshHhfDYAxGyVuP4a9RZT4nj8TxbzLJw
	 DiSaVaEE0P6chhspmpTpDMA3MkqmE1tJu/j4MFSNA74PE+yF1PVs1zbhZfY8AMgXH3QcZ
	 GRreQ7YEmctx6aVN92J2o+ubKDRrbvkjnD2eBvSMe9mHLb6VhYK7cmG4jY37nxwFL/x1y
	 0xs5EfwCoPJbrnWSI6bzrfCLbpsG/ui6HjwuQMdB0rab8lF6zcml+r+uSiqXsljsrSg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=bLsSRjr3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.18
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013018.outbound.protection.outlook.com [52.101.83.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DFD606D815;
	Thu,  5 Nov 2026 16:50:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16DFD606D815
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=bLsSRjr3
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pjrUuNgfVEXr7ppbVpXBI+aSHZDnoQL+rhKNsIovoAxD5l+zPhgks2Jvix5RU3M80ga/mSUIE3f/D+SLQsak8S7QpwFq+I4HTnBCJjVN+sH2A/43OIgvfp6oelXLYvxBnhNmbVYP6bOChCS6/M0HU2Nu8rgqPpsjxMXmAd47l7xT+rqvXf1aOjn2spbcCuMLLhVuMMn9v8bqkx8zDVw/6SPGweIHEU2c1vHm0q+gGe8qyYQCdUaqHphw81ilrgnU6y1NegwKHFoJPWT7VbrobMCHOTIpJIfRODQstFfKKhQXov7KRKWzy/KmCawDl9c+VLfy6wTp+105j1rMCBheiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ewSR+KD4DJ90iUYVLxQT0f6UAWQ/IoojYctCXpQoeDU=;
 b=G1SptAf0QAhOSFxlng6VsHGOmsRPJcjVG+zx/4rBJjkiC2+TzXCClfOYtC59xeSidP7M25oMkrc4QsTlQP3qYVYFUb0jY822AR/fUOzrKBUW57S0OURhrzRw0Q2mfM9PAWwoBv1X2EM30f5EruN6p/QzCAlVWnZhIaQ+82zglxc3yaqQY5JrINKkS1zANTHp2C+8PvX+OPqJ1UFw8GF5tBHNhbDoP8DZ/A00hHcmP1+3SM3j3op6JTP82bVUIHQlInit6uzl2zwG5KZxehKi2joKHTM4i0tbyGSd4dfcgI4+8yCs4lXAihWNRzZqsFiBFZLdXGZ3JVF157yo0KbI0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ewSR+KD4DJ90iUYVLxQT0f6UAWQ/IoojYctCXpQoeDU=;
 b=bLsSRjr3ZXRDk0uejE5Y9HhYLVvnIlEtEPhZukNkh/bMPAah2hQKwMzyddzNUrcFEZLebh9rPfOQrpnPwzG81YfZ/hkcbm+98Ge1h8VWZ3K+LTDVgFWEzWm8IymvJm+QWUVndF80bcQMV16hjpWIewKeUD8DGsU7UXrMHLemyBPkEBxnqDt1bp6+Ci0g+oW5Lrxr/7h7Xy+KtqKEj8SyE11rbckOC4zUEyPq16z73t9phOJtnYGaLll7tHfkptBw9e4ys+lL3AUs3RF5M6egDwLqW2A+vogmR/9iJmDEWHepljv2U5z/JRX5LuPzZj+1itrAYIYpHMZ4PBaFQ6zYFg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by PA3PPFF84116FEE.eurprd04.prod.outlook.com (2603:10a6:108:1::b6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 16:50:57 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0592.007; Thu, 5 Nov 2026
 16:50:57 +0000
Date: Thu, 5 Nov 2026 10:50:45 -0600
From: Frank Li <Frank.li@oss.nxp.com>
To: Lee Jones <lee@kernel.org>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Shawn Guo <shawn.guo@linaro.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-pwm@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/8] pwm: mxs: Return early when disabling and fix
 error-path clock leak
Message-ID: <auyz5R3mMF1TI0Lc@SMW015318>
References: <20261105143847.2559586-1-lee@kernel.org>
 <20261105143847.2559586-3-lee@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105143847.2559586-3-lee@kernel.org>
X-ClientProxiedBy: DS1PR06CA0013.namprd06.prod.outlook.com
 (2603:10b6:8:458::7) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|PA3PPFF84116FEE:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cb4b806-87c6-442d-22df-08df3b5cf678
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|376014|23010399003|366016|1800799024|22082099003|18002099003|10067099003|56012099006|4143699003|11063799006|261026121527099003|261009223027099003|261021123027099003|261022075727099003|261102123227099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	aMjX5skGw1fi5F78BauTi3S+i/cgjxpe9nsUSOcORdtAZVWR/2paw6Kj7JEkoBuy63+41aKK0FKp0CA7TjsaZTH72P7D59HXljR4E35zg+FGzLiCCxpPGPBGkameeuZSmlXxG0yMKCrm1cRP3i/kAsCdlqSniHdoVV0EezgCEkdL82lcuuoV6ZSENsh8sOyXsBSNr6MdX7nDH1wP/FeJtVVgNeST+ymoaMZDxDYQdXk9Z5f0Hv6MMzwbqmbLlvNvB6MUIcU8uhxfVpjfHePfOW8H0rGNL7NQJ7JSvA2/lD3oEsx9v1oJ4StcHu4ANlTfm6t9KN6wL25A42Cv1ysKWSUpfhltpXVAgHLxOq6azqnkZ60m9+1VGICg7qMjrYYD27ZjQ13Y7mZCToeWV6wRdUDP+zr4ttRTvMfS04WovX359Upx4kZsqy4QeH5ygNwjWKUShy2OzlmyCpDwgy9c1L0No9jgO5+J1tpLIVasP70TJ+1FhwZAjikbjHvgt+WxeMJqUhaibnc4UKpYXOCtloJXVAE1hrpOL7shynSgHOkI1d9HklsXvdbIirA9a7i5+RXaguGWkrnF4BQaD5TTBjjoIZzJg27Qc2GXLoeHjGk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(376014)(23010399003)(366016)(1800799024)(22082099003)(18002099003)(10067099003)(56012099006)(4143699003)(11063799006)(261026121527099003)(261009223027099003)(261021123027099003)(261022075727099003)(261102123227099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JC+x+JqNLuaV+kAM5jYEuF0z60F/fUTGTgDE/nsNRSQuOWIIvohWA9g7FM/t?=
 =?us-ascii?Q?2pqnHdo1DY0nBzzYlP33EyuWCGACkWt8XSyzraWp5+WVIu0jouwjo1vgLLi0?=
 =?us-ascii?Q?paC0FdghkrfF7x8xKT10kP1NEKk3b5UEKyI+LQTZMKQcv39g66ZcNGJvhFCC?=
 =?us-ascii?Q?HoT6pRtxXQWdKnRn0FkkZ5JnmpURrjaadivWgr0FaopkFIdFe+wOJpZpDsQ0?=
 =?us-ascii?Q?W38SGR6vki1KDFb48JSKPvsAug2gta3Vj4kx4JLYb8InQ2RusyGs8DhMyc9A?=
 =?us-ascii?Q?iMN/hHEPByxApC+Ra8Id77hpBXwGGgbyULiAq/Xb+Di+IvDkQwH3PHbstM/R?=
 =?us-ascii?Q?AAJkRwuheUM1BA/Vt13meT26W+3ITlCoaw1U8AEHeb2IeJuZApj3xCEa+ZR2?=
 =?us-ascii?Q?Z3fDtydXKL+4Y6tdC9KqRGNg3Nx+sccfFT0ygMXrXSUoRqd2jxwnE3J3nlmh?=
 =?us-ascii?Q?TQUCeOLBAB/351n8qDQ1ItRav95D6t7m7wOIypu/L3B7RrVQWmX096luVeyR?=
 =?us-ascii?Q?rX+LW9ABl2FF6LQ+Udbk6WZjAoDq0rDZIRVbR4Iy2x9E4jtGMPfmP2lJsYwM?=
 =?us-ascii?Q?dYajYJRCiuOunQVziPJCnSyOX/qG8uO8Qu7Zm+XpWGvPJiNaFfyDrSEhMU9N?=
 =?us-ascii?Q?WfHh4Kcl+vgkk9sBpkBoAw3m7sK5zUdPLDLfQSa8sh0CWQrdvBZIoaa931Y6?=
 =?us-ascii?Q?irbIXUiQrIOvI+OPY8cesJac0G7itip9Nl8GjIo5QtOUtjZsxom6G4do7DWC?=
 =?us-ascii?Q?ziUf6At3Jhk6SfJYiAKmfehT+TtOkPQvChNF1NWHjcWPnDWKnJPjEaxIjA9K?=
 =?us-ascii?Q?7XD1BU6JK6ofkNM5y8mQ+8G8bLA0Ael0E2726FonetHxUjv7/twtXKxQTMk/?=
 =?us-ascii?Q?0quTpR9PrQCDIpTMboltGKfh3DjjvpdcISrBAlNkx4e/L0qfNagOjR3sFpwj?=
 =?us-ascii?Q?BiYBAX+FvFphgZlq8XW8ExSpWIqhaWnRyBAMDr/L9QANKzLBI/lOHVbSUCJQ?=
 =?us-ascii?Q?rDhn1VF3o1QFne7LpKu/nWmmyCrUO+mZDgCID6XI0izWHQd3LZAo6FMI4SdQ?=
 =?us-ascii?Q?DYG1cfYmzQfJopSbU6XJODgKljX3QLvBwc8EV28EAeiRAYo1T+LOu/A1w2qt?=
 =?us-ascii?Q?goQ83PYJ+Q4esoh6XhJq7JK8iedP8k0KteEhzpvRWMi4LWtwD6IA3bbaijdF?=
 =?us-ascii?Q?GIWPVsPkYoJtq5lI8SZowOROc1cNjlbEjA0deJZm41UqMcMmhR8F6l+PHpgE?=
 =?us-ascii?Q?gPdNaO+H9yVh0Ddl2Aok8hFqlnii7eu/z29WbsnNmOL0mFRmuZk4xVaDJcDE?=
 =?us-ascii?Q?QsXLlXbCbccivwTiIyaNA7f2dj7cN/gX7oTn4pZeJQWRlOoE4umlgQpY00oV?=
 =?us-ascii?Q?q2YVDmcEDmpMwA31FKJpaWdM3gfyQ+vjLo+KA4rnYdX8DUM+bJNFhDnfrs4D?=
 =?us-ascii?Q?cMC+J2AL4z+C3h+z1lyMW/9+ksnOMgPSN3nctUf1WQTSKTkKscYh32eZ4xh5?=
 =?us-ascii?Q?2y5CP+FJBEN+rGBEcc+VmmfCYMbY2065pzIZ7rkJm17tcioc59e+VDDxNe5s?=
 =?us-ascii?Q?BZrHYVprAXQC6kgLkXgF0iLmLUEPQ8ePi1R6RCVRterlcDZBjwXzI7nQU/tq?=
 =?us-ascii?Q?2cbwkZ675p8DG0pA42CPVbh+A53aCZY+XjvUQoIVoygDRGTg+4GGhvGGOuEr?=
 =?us-ascii?Q?BM5U2+xNpcw1g2mqkRp0oYfwHX2jeR18CETgZmYIk4a/d+Ub+Mi9HDdQyvg4?=
 =?us-ascii?Q?3v/s6hW6CLKTIfUO4FrtRqK8EpieZz2GkJKrlvkKvaT0LWAnOmju?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cb4b806-87c6-442d-22df-08df3b5cf678
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 16:50:56.9869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: unAJSCXQgEVDe+UgFcCPKX7AMRnUBwWncSbhQGnklUW9L8+05HNslgB8JLwhztao6VzMXmbg6qlbXyd4mmiE1aHn7tUJ0Oezyfd6PlNwnwFCnCCJjRXVW8li54Ei+4jW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PPFF84116FEE

On Thu, Nov 05, 2026 at 02:38:04PM +0000, Lee Jones wrote:
> When disabling a PWM channel (!state->enabled), the PWM core permits
> state->period to be zero.  mxs_pwm_apply() currently falls through into
> the period and duty-cycle calculations even when !state->enabled,
> causing do_div(c, state->period) to divide by zero when state->period is
> zero.  In addition, if the requested period exceeds the maximum divider
> (div >= PERIOD_CDIV_MAX) while the PWM channel is currently disabled,
> mxs_pwm_apply() returns -EINVAL without disabling and unpreparing
> mxs->clk.
>
> Handle the !state->enabled path upfront and return early, and balance
> clk_prepare_enable() on the -EINVAL error path.
>
> Fixes: bf29c2ff82fd ("pwm: mxs: Implement ->apply()")
> Closes: https://sashiko.dev/#/bug/linux-710f863f-6964-4e4f-990a-e5043dbc1a87
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> --

Reviewed-by: Frank Li <Frank.Li@nxp.com>


>  drivers/pwm/pwm-mxs.c | 32 ++++++++++++++++++--------------
>  1 file changed, 18 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/pwm/pwm-mxs.c b/drivers/pwm/pwm-mxs.c
> index e1a3df6549fc..16233764fd3c 100644
> --- a/drivers/pwm/pwm-mxs.c
> +++ b/drivers/pwm/pwm-mxs.c
> @@ -56,6 +56,14 @@ static int mxs_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  	unsigned long long c;
>  	unsigned int pol_bits;
>
> +	if (!state->enabled) {
> +		if (pwm_is_enabled(pwm)) {
> +			writel(1 << pwm->hwpwm, mxs->base + PWM_CTRL + CLR);
> +			clk_disable_unprepare(mxs->clk);
> +		}
> +		return 0;
> +	}
> +
>  	/*
>  	 * If the PWM channel is disabled, make sure to turn on the
>  	 * clock before calling clk_get_rate() and writing to the
> @@ -67,9 +75,6 @@ static int mxs_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  			return ret;
>  	}
>
> -	if (!state->enabled && pwm_is_enabled(pwm))
> -		writel(1 << pwm->hwpwm, mxs->base + PWM_CTRL + CLR);
> -
>  	rate = clk_get_rate(mxs->clk);
>  	while (1) {
>  		c = rate >> cdiv_shift[div];
> @@ -78,8 +83,11 @@ static int mxs_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  		if (c < PERIOD_PERIOD_MAX)
>  			break;
>  		div++;
> -		if (div >= PERIOD_CDIV_MAX)
> +		if (div >= PERIOD_CDIV_MAX) {
> +			if (!pwm_is_enabled(pwm))
> +				clk_disable_unprepare(mxs->clk);
>  			return -EINVAL;
> +		}
>  	}
>
>  	period_cycles = c;
> @@ -101,16 +109,12 @@ static int mxs_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  	writel(PERIOD_PERIOD(period_cycles) | pol_bits | PERIOD_CDIV(div),
>  	       mxs->base + PWM_PERIOD0 + pwm->hwpwm * 0x20);
>
> -	if (state->enabled) {
> -		if (!pwm_is_enabled(pwm)) {
> -			/*
> -			 * The clock was enabled above. Just enable
> -			 * the channel in the control register.
> -			 */
> -			writel(1 << pwm->hwpwm, mxs->base + PWM_CTRL + SET);
> -		}
> -	} else {
> -		clk_disable_unprepare(mxs->clk);
> +	if (!pwm_is_enabled(pwm)) {
> +		/*
> +		 * The clock was enabled above. Just enable
> +		 * the channel in the control register.
> +		 */
> +		writel(1 << pwm->hwpwm, mxs->base + PWM_CTRL + SET);
>  	}
>  	return 0;
>  }
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> --
> 2.56.0.398.g882cbad275-goog
>
>
