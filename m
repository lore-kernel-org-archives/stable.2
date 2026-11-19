Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795106834;
	b=NkXw0+cGSBix+nEjPhliR/VxmtuZxdU8VSJv99JkjZ7PiEKwarARq4LtZ9s4ntaom/Ds
	 MrZjcIFUzJq26J3CucTLNe6PnBCDDUpozUy8a6IbHo6/I/rc8sOBzyudriqZRdAgMmSrI
	 EQQwJTzKuQ25e8EWLfaQ13u371QpBJycj3oqc86OHNuzdpyePvDud/gQTry9f6U63zN71
	 M9lQSNKBGeVwSesUssVR2HUp6irqI+SLrboIshLirEdNq6jfwv5UaExQRBV9oWPbn9ePZ
	 x/LSBdpI8smjxMlO/dH0QtBY3Cbv1eiJTkZzFvDh7lGWJNj2gVkVvQ48fGEdiDQHnHA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795106834;
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
	bh=gAo8ULyYNAYY908k84VdgpVWLTup3VEHr23sPp3ZfoA=;
	b=WOCvTg9I9wDm66PJ3XWx1kXmdboVndLOE/2Nw51DtjYM0yIHgxPSA5P4NyTZv+xocNOi
	 212b5Yex/x22FeSSxCi7Uq38jDbbyUyTY4tqeoGQltWLS8NrGMU0HfeDSLPK+f9movTyv
	 giJZWpd7lA1WHVBZEVp8VRGxP59G5J+KrTPbpbh/o9TPL07RN6otRQUD0GbXGDMR2SAKC
	 mOpSnXrJDBVWBF4YKZH8dbSFvztAfnEWKPvVvp0YBzm/qJFa9mx0rJEmKyCCTnL7hKGMn
	 7BtMBqk0Ys28wjUbQW4JCZ/R4su4m8w4KFwYVdCeHuXG7HnauH2/T/lBVQHN8mbN3Qw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=lfu5VRG8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.44
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011044.outbound.protection.outlook.com [40.107.130.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D87260A261A;
	Thu, 19 Nov 2026 16:47:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D87260A261A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=lfu5VRG8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v0dXFxV/mV7Lum1JV7dfx18NDOdmPJDM74eAGh3vJBMV0FrtlRHTmySGg9O06GYNMuaF4TSwPl8pL/hjSDAjMEdemoo49uL2NYhXSSchIfDNoqS5sGwT9hXv3ybZZQkAD/B1PqiNxcXaEEq7Sywf/dxRQ2mrGzD0oKVue5hc5BvI8kOMOZL+EXnz3tC9/h5HpwNT5IdAOpeHnpzJd8wyw2jybtwgmOwlTLxOgfQU9gDfUOv7ETjM1GleKu+OKFjpnWn7XXnjIBV0ggBqwTiclpL2GI4UQnr8DB/+Y6RWsnX/3qHp3T4xKzegdYn0OjiTSQfHWD7VelqU5BbzmyO4Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gAo8ULyYNAYY908k84VdgpVWLTup3VEHr23sPp3ZfoA=;
 b=wFw8QmQXQI/THK7WKdHDhBps6hWuSbAdUpDdB4h7E5cDn9KetulCGbT0cH83pnEWDm51UPRpSdLX1pcXKtCBzg59dSofyxgiNhLwrAs0cj9fUYPYj09JuJ/LxdLfhcvd15JI71atfnowZDD4ikTC9lxcOqSw2DHQjpA4QmaAsbMk/gCqVryXi0FUt8bTBcK52C5JqvIfqoqjjK012zW7SnuVZnGe8Dt83XhJZbUufleS7ET7ZkqeVmXKplXZAXcOgPzhq5x5y6Ytnn2Aw0Yck21pN2737v8NoNPcHAnu0fu6STHYnJdMd+SIeM/i4eLzFKQEboy2P6bM1lQxOnycxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gAo8ULyYNAYY908k84VdgpVWLTup3VEHr23sPp3ZfoA=;
 b=lfu5VRG8Y++9CEB1Fy6x33QGoqQv/7dKyXrUuykrQGk/atRIjPI6ctCnPGPd7oKwKIEFfF0TzPFS35+gabtRGSsUGyS+eIxnnp8mzPlaby+Vj84U5LUtOm1k4twvY+ltZ/yUqQmekT2kV37O1vU7QsOG1rJM8irSHjpygDxK7zF8cyiNx8AzxfqdSZWUxGZz5jvpNqOVU8pXlOl6Qxfjy9xlOYD9qeFIyfvxLh4EYqJ10as1jzf11Fqia0DWzOi05e0COFnYt60qmb5TbqSgJd2xAsiSjfEtJpwBz+ek3viqt3/vBhWpBxMMWA51oK4haLC3DmAQ1i2sGIz3MonzRg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by DUZPR04MB9783.eurprd04.prod.outlook.com (2603:10a6:10:4b0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 16:47:08 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0639.010; Thu, 19 Nov 2026
 16:47:08 +0000
Date: Thu, 19 Nov 2026 10:47:00 -0600
From: Frank Li <Frank.li@oss.nxp.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Sergey Khimich <serghox@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sia Jee Heng <jee.heng.sia@intel.com>,
	Baruch Siach <baruch@tkos.co.il>,
	Mitch Barnett <mitch@accuratesound.ca>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v8 8/9] dmaengine: dw-axi-dmac: require an IRQ before
 registering the controller
Message-ID: <av8oBJNCYRkTBBW-@SMW015318>
References: <20261119-submit-dw-axi-dma-stop-pause-v1-v8-0-f8e7fe60594c@gmail.com>
 <20261119-submit-dw-axi-dma-stop-pause-v1-v8-8-f8e7fe60594c@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261119-submit-dw-axi-dma-stop-pause-v1-v8-8-f8e7fe60594c@gmail.com>
X-ClientProxiedBy: PH7P220CA0039.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32b::26) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|DUZPR04MB9783:EE_
X-MS-Office365-Filtering-Correlation-Id: 76d35d28-608c-4b12-e2d3-08df465cc023
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|19092799006|10067099003|56012099006|11063799006|4143699003|261028144727099003|261026140227099003|261021121427099003|261022105027099003|261102123227099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	vkZF196d1LHbsa0yg6EwrjH6yIxmnAhPFChRRlZZAO+SCJudS/BrMKqGYPwtel2QBwHOPdGLGaMf0i3hXG1hKMZdeu9Exy4XK/86Qams4TtOcvFsRiincRqn47xTH476eHrn1C0JAy3xNZSuN68lUExT5wXiMRmNTYPAmlUGBfmNH/ERscLvCmcYPs0bapNijTa5ZwqRWXLfhDd5/n8lS/V/xo8zriwkGY9Arrwg6aywVYh2n7OYZcxUsfYzJUc2QQDXbHwQNBUv0IO5nRKIWp2Bg/Iaw/NnLSyZEbz4+v/KlrO8rj2iCPBSuj1iQ0+ixgFdoq2EVZfxUYZAbWrJTzIYatNFMIYW0/tkjOy8BEeLsKlVSkEm8vQidHdEQeQWhJJZ+rpyD/gs0w3nsN2zL+Z3pBM7VyYoaQ26jm4N63ZWG2QdYrSdSP+nBxNC+ytDqMtYYXf/CoF6isYxYc30wlyaSKF57rbN6fvE+vpTyrOtolCiMrQQ2wTT6VMmISmNiB8NmsafdnFoR8TKAKYnZRQ77L2qxv+XjdEclwpL9dF4Zy927mCz0c1lq8bK4Ixz4feQ/+HUEo6jJ4shdCunb1zeuEnHvlGlRM2WYR9cr97hHj/YNmBlNon9wfAy6zYThnyRbPnzHDCXs40zoyE8oa0H/jnM2MLIX119A/8rF5E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(19092799006)(10067099003)(56012099006)(11063799006)(4143699003)(261028144727099003)(261026140227099003)(261021121427099003)(261022105027099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HgNm51iL7D8VZ1lC+IA6swIuwswXBV0W+Zp83hOYrtibwqfpkncMWx/ilTUM?=
 =?us-ascii?Q?bhFkbG0kwInT35VUaQoaZ/kNqWBcua725msPT2PvDZJqVLASLMfM/AlC2oSL?=
 =?us-ascii?Q?iM0/IwxLl6+Lav9+Cbt4NazEFhvTvdwoFkG/bg5LHnqpHiHqLSq98aDRTvtF?=
 =?us-ascii?Q?22XMA6Ac6Es4esWfh6LPV0Y2mHBlivfr20HAWxSon2UbeHMoOlUc9BogMtIr?=
 =?us-ascii?Q?oCvpEdtrjTz6Zfrc0bItzoo5m3qKQoCuh45Lc1iIFv/0UB308WqMlNKk3NEY?=
 =?us-ascii?Q?cfDfoJ9SMzGJPmeWWS1QeNi22OacPaN2Uzaf3MwGJAM7hZrnDDEm+6h/If7t?=
 =?us-ascii?Q?+W7Xb8OjU0Cl/+rmaz9NBju5qBSXLe+0jLeLuo0uOEylMcG8xJ8AWNIr33vu?=
 =?us-ascii?Q?qnHzHx95zI74FUxXu4q+wuCp1LMphJV/yTOCSvPyGk9XgrfkbWYE4KL31y10?=
 =?us-ascii?Q?bvfSfHyiWSIcTzfBwrczoftCwCZsJqDkLi9UNpT3RIxQAAi9h/xOm/RMWgv3?=
 =?us-ascii?Q?0iRG/+3P3QwXT2ImrIn63KdK6Pb4TvLA5e4N2HWXZzPgHwqBBTff1/kZRtPy?=
 =?us-ascii?Q?/p86FULgOUofjTMqzKzm8cNNqMMelRwIniqR4nhLfVMLIBFQBodvQzAHDtXQ?=
 =?us-ascii?Q?OuRxnW4ojMmOhZEULP9rfTFopwRUf/JnTj6z2P3b9D6xYHLm4jI+yJWOYqH1?=
 =?us-ascii?Q?stRTfpoc89Xu6t5JbIcPGB9Ro2Wa2F4TQ0FRVVCiV+gnnUfjnPM49h0BHMHq?=
 =?us-ascii?Q?ZZ5vXIdDnzKw8WwT0xS7SMg3vT+/KzltZESrjaCoCtLcHmee9xYi52ubd1j5?=
 =?us-ascii?Q?YcfXr5H7/0pUriJgHVprIWwIOFFIYazRMiZfTeUIIzlrcJBN7MFuW2GzX8yE?=
 =?us-ascii?Q?fokLJRMEoM2rNO492HnrBf4ytUu4hC0Yo7qlw3lKm5meyBbAyaj9Ke+6L2IV?=
 =?us-ascii?Q?MpeAgBeWNq4mBNDCTi4oEHC33Fli2l6S4DrsFczRs+x80dwbwHwIxLK7GJr6?=
 =?us-ascii?Q?zJSghpAKynAntqyd4ylq5Q3qvce4W5mC/83DvgC3L475pbEs8F+EXdQupVfd?=
 =?us-ascii?Q?5+xKNOK+iwizc+yxDuM7aDUN27TyHH8Oy3Lxuze8niQ+wXq3QYFuNQ+yNyGG?=
 =?us-ascii?Q?WN506P+S51GLsgCgRlIovCUyfhJACq/QKJir+RN7OvSsK00KgR9/NV3UbSml?=
 =?us-ascii?Q?JtgpB8jIyOKGxM0Sc59XjaoejwnozT28w/g+ubm1AehDkdALphrNJNZJOQcp?=
 =?us-ascii?Q?ZC+5YlMVhuY9qHTrcaTJVz1BL+Sw26jAmoRscUGLPkl5ue7TTuNxtRqF4vO8?=
 =?us-ascii?Q?HX/M78BUp2GHfa8CNkTu8G3aQs8+vnRhvg2BLjMT7DbCrJ3gRwJvoWYLgpwm?=
 =?us-ascii?Q?JKOx6TrcFN5P2ZQXdGTtNlbbQt/cBaeENBqrniNPY3LD4xeCyZGeBohixA/1?=
 =?us-ascii?Q?OKLHMiDwjg8QVIoa9ZQyY3UYMCSYv5G6e3Kh4RxEt9n2dcBOAMLiYCdd03tF?=
 =?us-ascii?Q?9x+ihq/ZNLwR/ZuvoxI9vR4UIhSE3S4hkmc9Cv4Gyjpfmo7uP7HZjfUebAQU?=
 =?us-ascii?Q?tw8BFKRlmvqi8u42rWAzd+9a6nW9k2BnWf1SO/Oi+xjMxQAAx413qjPrKDFD?=
 =?us-ascii?Q?8Cqu6+Pq5BgSsxxwcLorXMkbNTTJoLpidtwGU1bT0ZJWZVqNBC7hJ7QkpXzc?=
 =?us-ascii?Q?b5Xjgp4mBj95sslrehwoAuw7ATWmmoSw2j3UTZcTYWN9QjxaaVo6uRghsd+U?=
 =?us-ascii?Q?xeqtN4zw/xkWP3B9TbZTvbYefRka6aFyfLvZUgb4hOwzX0ZUHtUg?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76d35d28-608c-4b12-e2d3-08df465cc023
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 16:47:08.6649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LMjeRCfoOjYpGmM+GyudZqWcfDEye7LNGt+b3wnyUEyeE7jd7A7rdtN56IL25nqJX7ihWff7Wr42lt7n8MX+Yws825s2s9aeEoJfl2v/A1xMIBAKe6Sa3ecku0OZIrlL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9783

On Thu, Nov 19, 2026 at 09:01:03AM -0700, James Hilliard wrote:
> If the interrupt controller is not ready, the DMA driver can bind
> without an IRQ handler. Clients can then submit transfers but never
> receive completion callbacks. platform_irq_count() returns -EPROBE_DEFER
> in this case, which skips the IRQ request loop just like a zero count.
>
> Propagate the error so the driver core retries probe when the IRQ
> provider is ready. Return -ENXIO if there are no IRQs.
>
> Fixes: e32634f466a9 ("dma: dw-axi-dmac: support per channel interrupt")
> Cc: stable@vger.kernel.org
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> index 2eeb902eaad3..531705f8f89b 100644
> --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> @@ -1518,6 +1518,10 @@ static int axi_req_irqs(struct platform_device *pdev, struct axi_dma_chip *chip)
>  	int irq_count = platform_irq_count(pdev);
>  	int ret;
>
> +	if (irq_count <= 0)
> +		return dev_err_probe(chip->dev, irq_count ?: -ENXIO,
> +				     "failed to get controller IRQs\n");
> +
>  	for (int i = 0; i < irq_count; i++) {
>  		chip->irq[i] = platform_get_irq(pdev, i);
>  		if (chip->irq[i] < 0)
>
> --
> 2.53.0
>
