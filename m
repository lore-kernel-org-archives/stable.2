Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011014.outbound.protection.outlook.com [52.101.70.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E754C3F12EF;
	Thu,  8 Oct 2026 09:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791452378; cv=fail; b=GeJg7e1qnvovzo2RNV4jcOQnHiwy+IetalUj+sBP8jmrnTH/M1HpwqHI9I/jPsk75addJ7zQKzdtI+z9MXSllaLbfw7RyQhptmrVWKD1YMZf+UioaDQO0menDh7liKhNSYlv+twLh5f3GItOHRkYMUTzPSS4eKsCQiFHOr7z4uM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791452378; c=relaxed/simple;
	bh=sklQzSvp8MkX5EnaZMFRqbdlCdzUF4MCw37B0JJ/n/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XMAH/Lqch0npJra69i0B01pdREIvdx5PzmnW80Q7dlemcTBeKZ5S4bssPoMaF0AkgzPNA29bhlerLvsxmUjWUSv/Bddq6KWtVtdQHakWN8fcwYJLEbf/ifPdPJLEiXa2iLj5RQRA2kLvX+Pd/pFKBbrf/kf3rWKsRg4LGD7xlWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=X1maxc2a; arc=fail smtp.client-ip=52.101.70.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="X1maxc2a"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X2yDDRWRTtCEqaJ6PAXRWTSr+36LMD4PbqyDIbCvz6f6k+J0eL5xJLx7dSAcYGDTw3KijxWhhqhEnlHYILquFwPVMIIH69jv6ifbCCmPyocV++rsNiwRbZ+k6ShbONnmtVATdjDQ+tqCRyWMtVehlBSRzHNgmbHU1tzxvWw+yYilxpH53bNIPa0X8m95IiFglkZszGwaSPsyD8OT3MUVLLor5nmGFprvB5MfqFeuR+kP7RuBQiGDL+obAurVd7TUH+X20HihpdMF8g6FFqUfHvKaioT8ly9GQCdsidg+5JxQ6JSX0It54GwuU/H6oj3prrI2cmRW4v/djF33BQNkig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4RuQx0aUlQvZQN82Vz5Sp5n43usD+c5t8WWso/Q7tWs=;
 b=NfFThgIyvtmYhfkDJWGz3or4DpNNmy2Luf2QXmIV5uHEIcdTW3OxM7olBccblVWlMw8f64YFuRe25NR8H5h0UuxZLHP/V8zHpE+Ap0CW76Rpqwv6O4ptUVHWI5hfnHE2jDgjvFnyp/bqBKiOQipMKlsF/23z0h1lXbuyBtEnGGm2NGq9EeDC79mL7vbfNEF7YyLy4/gm4punM+J7yTEIv3Y4JYFhQTHukRWv2HvF+HY8PRn6d0NGRlRyXVfl1qHdNXhlDtu/htflN6uoPA5A+8C7Yv+3gbAD3s0FUNH07M0vZG/9y5ih5GZbblUrRDRo0EiZL82pEycmSRNw190N3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4RuQx0aUlQvZQN82Vz5Sp5n43usD+c5t8WWso/Q7tWs=;
 b=X1maxc2ak7+BWm0WFGU+e0OUkOAjI4EWs24lad83M/S+5zSbulaUR9HSKYlNXCIMSp2uAEiJsBWbnDLRLwJeBoCjld2cE8uo2sR21ZxZ5oHGWV8iY9FB08fL56CSDD/lsFBwjMZPiEIO1Sw2v8HTpFMYnD488R+9H0VoAHsqWaUy0DfLcVLn/QrAR62ImUmoLHqYf7PFTCk0uR3N/TeHLkPxELZ53tDXlO3MGJ774lYlSu86VceE1F9j/e5gVz3hJp2ADU1vRdt3Q9hsP3tFL/4TK0gF2qxh3WAoRADN2VRhVroJwb4TEHC6XjMinF5hvhlQFg6lByqfz8Uw30w7jA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA6PR04MB11909.eurprd04.prod.outlook.com
 (2603:10a6:102:51c::22) by GV2PR04MB11828.eurprd04.prod.outlook.com
 (2603:10a6:150:2d0::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Thu, 8 Oct
 2026 09:39:32 +0000
Received: from PA6PR04MB11909.eurprd04.prod.outlook.com
 ([fe80::a4b:fa4e:7fe7:e6a2]) by PA6PR04MB11909.eurprd04.prod.outlook.com
 ([fe80::a4b:fa4e:7fe7:e6a2%7]) with mapi id 15.21.0496.010; Thu, 8 Oct 2026
 09:39:30 +0000
Date: Thu, 8 Oct 2026 17:44:02 +0800
From: Bough Chen <haibo.chen@oss.nxp.com>
To: Ian Ray <ian.ray@gehealthcare.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Haibo Chen <haibo.chen@nxp.com>, Ulf Hansson <ulfh@kernel.org>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Kamal Dasu <kamal.dasu@broadcom.com>, stable@vger.kernel.org,
	linux-mmc@vger.kernel.org, imx@lists.linux.dev, s32@nxp.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mmc: sdhci-esdhc-imx: map unsupported driver type to
 Type B
Message-ID: <20261008094402.hnnfdbca3r44gvcj@shlinux89>
References: <20261007070313.863-1-ian.ray@gehealthcare.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261007070313.863-1-ian.ray@gehealthcare.com>
X-ClientProxiedBy: MA5P287CA0162.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ba::17) To PA6PR04MB11909.eurprd04.prod.outlook.com
 (2603:10a6:102:51c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA6PR04MB11909:EE_|GV2PR04MB11828:EE_
X-MS-Office365-Filtering-Correlation-Id: aa583b9e-3162-427d-f1f5-08df25200d18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|7416014|366016|19092799006|6133799003|18002099003|22082099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	P2qhhHOjobg2y8EkqSDwh9osYBlkG+aZsmXlluj1obEssrPoVEaqBTHzO8QpyJShlnNLjW0tanUm9w8uPqufyES1+j3nfTqMLAllJUlPaGm5jkTFjs80Tt60RAydJ3PFcO1lMTGECnN4+6S9pQFU0qUxyF4dJxut+CVc9npQW4a4k91bjNDm4ROu1ufh/YseHjcsuP5bFmRTLHDvGeYlSJN6ZrNQ8nC/hzGWWG5BnwOsCqW3aCYKYLcNRmStx2XQk9nGuI463TgqtpieMa6qo9yBE8T5/fobZmGCXFv636aEbvERqfCdg5Pb2yoNDN5AUHP0LC+FvD/NDCqB5/LX4L1SuXkooGm4ib82g85kbY+sULscwnt583vPml9dw5w4FTZC7rf/xSYIu8KyV8jQPswAiD/EATXDnsfMNMiQ8MIhKP0yMHnNPpkO/3mVe/sNtPpC1SiWKslEgfqfq2zCEcRM9q85EzywHmvpwZDEdCAVpO1sI1OmtvE1wyj68B89ZgCAvwx2xkgXY6F9b1of634qHqrDXctbfzgJrt7rblbolEsbYzlYCo4aDWPLWpaxo04YL8+ZuEs63tXnCfEEmvBYSysrvWsFxGFTzCOmxBl5132/g3znI2ck/86pXzxYaVLkn0t3FFi/G3spNrB9EYCyeLfOa5zM6llWXa48nZI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA6PR04MB11909.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(7416014)(366016)(19092799006)(6133799003)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vqWFNjSTQ6/E+wpq+HYiJ86cdjgQ1Zio0tih10LVRtk/pMY/49YGEMXNW0hU?=
 =?us-ascii?Q?sRSscM6v8Nvo6u9Ow7+IURlegZhO340PkzGNW6uGBFAb3LNqwuIDJVxSoeOK?=
 =?us-ascii?Q?shemlBS4VwcIBKOuYES2l/Vyl8E361Xo+Pw/qhLxr14BGh5GObvGvArwGSU+?=
 =?us-ascii?Q?WRg6jT1eQyzBHnEy8hciuaSiPqfADl5kyIDtY++deLgyXzF32UdioZh+Lj8S?=
 =?us-ascii?Q?SPL9rrFV6oXpM7Y1FJsrtnMLNEhhzWnVEO9kISMd38NtQByfSUaEO6NBiaq1?=
 =?us-ascii?Q?BzbrPbexwlyIuEZZ1ydf9BJ63P1TublcUVBXcY940crWTmcbNzC3xC/5bGP4?=
 =?us-ascii?Q?45sciFaduAbM2NGHux1uBcsfRLVBIIfNB5Sz1gYafvN7ak/DQVLIID6EvEJG?=
 =?us-ascii?Q?NJd4j16aXPOfybG19/NV1KEe6LLDDNGRqdwcauafGL6uuFQ7LM34IVne7pwm?=
 =?us-ascii?Q?pbu65z2pBE4nVnIYnVzPWxYWN6hd9tPAiWCaGjGM7MIM7OaVfNS1tgr4NXDV?=
 =?us-ascii?Q?ZSoSObjWHcG5Hy4/C/bnRy7hT9RyO5soTucyAUANZR7BlduR/kOm1GCB9g9p?=
 =?us-ascii?Q?+597E8LrnqS/ZifmbVKkVJJ6Z6yiN7oST5Cd8qgxG+japhfxyjG4G/S7legP?=
 =?us-ascii?Q?9YoAwONbdHHAqWqbvmwLodghUyqrMEWxth0Hu5DfxGWbXbz/469JvRarHWEf?=
 =?us-ascii?Q?gb06MTW5cWhNc+kIO4wnm0jp8MmdHu8w24RuwuHFkqlsRlLVFSMheN1TLjhn?=
 =?us-ascii?Q?J269b8Q/GDfHrxHEN76fxY4Lu6OVnoi9ZIR087xqEjgVX3p/aRa414IeqYVK?=
 =?us-ascii?Q?DaC7IGzibjFFbn7UC+kNtfTqxcaLzxosXX/+S0iIeoz9g6dsCi/BJ5s3NmXm?=
 =?us-ascii?Q?aPKvTE4+taB9lAmLOpBPr6ue7n3en2i8pb9E0lng8E6+C+5JIv49HSZWdXdy?=
 =?us-ascii?Q?DyVcikS9tZbkZPWdUAVyqJI8RyACa2JH/ScSlLdGBZYEjIDG8a1JeXPCbJOd?=
 =?us-ascii?Q?oz86Dh8r3BUH/CJX/t+cFv74AfTFkLt+cfabNHFVf8+XL4Lmzjn3RcLuhHur?=
 =?us-ascii?Q?SAHHjZ7rXLaZQF2KbLEWmi7oQkjGEDyhpODBrAPFJVpZYBxSqUvY+plfna1F?=
 =?us-ascii?Q?e9E7yiv7iCrFh0b3XuWBRqMsOQp4uzPEhlWdBia5cyN1MMDmY9BD3J6F2GmP?=
 =?us-ascii?Q?xRT4mL8p79LnI+NHp+GqwRZ2sJyPBi5FuJs9x+P/McZLM/qWcZmjNDwRCpqW?=
 =?us-ascii?Q?AkLRf3HOvicRcFK7Yq+SCzrdqwg1X+kDC2mv0Y7ZEBD1nC1hzYlk+pzZdMgM?=
 =?us-ascii?Q?If8DFf5wzJBOd2YK7g+ZQnRbHRd/DOXccRsW8Lmg/n5NHZ7D0jvEy962ph+L?=
 =?us-ascii?Q?Qcu+ywD3KLapi0mLeJoBNETrCdvdJbH0keNOoUgKF1+HnyPKs9U3qT3wdKm0?=
 =?us-ascii?Q?ac6U+x93s6AxZnos1cZ1hHAiBxXrNLcwgr4ZMBTrszT0m1xGtRpIGr7lpJEX?=
 =?us-ascii?Q?TaricCON61DcPrEFqyMCRPMJrXpbsTtAK780Bc5qLbw6pamV10bIPJQyfKVE?=
 =?us-ascii?Q?m6twotv3Gnd36oOyLlB+nuJmFAf8AUzMR6edTziV779Wr8mThzTto1/JpMP7?=
 =?us-ascii?Q?Mz0MCl02y52U5p1EUS6CjjVso7kGoE2e1eeVT7c1Ep9THhZdZyFGePKlNMOL?=
 =?us-ascii?Q?vLrK3s+lTzAKxkWkowdrRNiCr2Z/9O2sWMQKWlsjG6HJgpuXexjPOVVkEUa5?=
 =?us-ascii?Q?EtjdBac7th4TyH6PBRxRnZGd539DHwu8e0aujM3nTSLmowxTZfDD?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa583b9e-3162-427d-f1f5-08df25200d18
X-MS-Exchange-CrossTenant-AuthSource: PA6PR04MB11909.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 09:39:30.2557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2DGu2rYgGdI+o5QBDtdv9Yu2WLLu+X8NKDdHMogW0TVP1uvE98CciVbyaMXUove7uoGx1AvS9q1HZp3FeR4ST6qAIDkhpoiw6GjnTO1QL4fB4aJTBP28zzsmvussNaiy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11828

On Wed, Oct 07, 2026 at 10:03:12AM +0300, Ian Ray wrote:
> Since commit 5a52c5701a67 ("mmc: core: Fix host controller programming
> for fixed driver type"), the eMMC driver strength is passed directly to
> mmc_set_driver_type(), which propagates the value through ios.drv_type
> all the way to sdhci_set_ios().  For value 4, SDHCI correctly warns:
> 
>   mmc2: invalid driver type, default to driver type B
> 
> The host driver type has no effect on this controller: esdhc_writew_le()
> never programs the driver-type field of SDHCI_HOST_CONTROL2.  Hook
> set_ios() and force drv_type to the always-valid Type B, so that SDHCI
> never sees an unsupported value.
> 
> Tested on i.MX8MP (usdhc3, eMMC in HS400) with
> `fixed-emmc-driver-type = <4>`: the warning is gone and the HS_TIMING
> register contains 0x43 as expected.
> 

Reviewed-by: Haibo Chen <haibo.chen@nxp.com>

Regards
Haibo Chen
> Fixes: 5a52c5701a67 ("mmc: core: Fix host controller programming for fixed driver type")
> Link: https://lore.kernel.org/all/20260926122908.866-1-ian.ray@gehealthcare.com/
> Cc: stable@vger.kernel.org
> Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Ian Ray <ian.ray@gehealthcare.com>
> ---
> v2 -> v3: Force drv_type to Type B unconditionally;
>           hook set_ios() for all esdhc variants, not only usdhc (since
>           the driver-type field is ignored in all variants);
>           reword comments.
> 
> v1 -> v2: Move fix from mmc core to sdhci-esdhc-imx driver per review
>           (see "Link:" above); always provide a valid host driver type.
> 
>  drivers/mmc/host/sdhci-esdhc-imx.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 6ab59d3e346f..931e383748a9 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1142,6 +1142,20 @@ static void esdhc_reset_tuning(struct sdhci_host *host)
>  	}
>  }
>  
> +static void sdhci_esdhc_imx_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> +{
> +	/*
> +	 * This controller has no driver-type control: esdhc_writew_le()
> +	 * discards the driver-type field when writing SDHCI_HOST_CONTROL2.
> +	 * The programmed value is therefore irrelevant, but SDHCI rejects
> +	 * non-SD values such as 4 (eMMC 40 ohm, from fixed-emmc-driver-type).
> +	 * Force an always-valid Type B.
> +	 */
> +	ios->drv_type = MMC_SET_DRIVER_TYPE_B;
> +
> +	sdhci_set_ios(mmc, ios);
> +}
> +
>  static void usdhc_init_card(struct mmc_host *mmc, struct mmc_card *card)
>  {
>  	struct sdhci_host *host = mmc_priv(mmc);
> @@ -1952,6 +1966,9 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>  		host->max_timeout_count = 0xF;
>  	}
>  
> +	/* No SDHCI driver type control */
> +	host->mmc_host_ops.set_ios = sdhci_esdhc_imx_set_ios;
> +
>  	if (imx_data->socdata->flags & ESDHC_FLAG_MAN_TUNING)
>  		sdhci_esdhc_ops.platform_execute_tuning =
>  					esdhc_executing_tuning;
> -- 
> 2.47.3
> 
