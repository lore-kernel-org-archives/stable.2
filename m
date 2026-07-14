Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010012.outbound.protection.outlook.com [52.101.84.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECB733BBC0;
	Tue, 14 Jul 2026 13:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784037303; cv=fail; b=tFP9n/Q1K8ZDLG54XMwk9jeXsxJyQ5rkYXMfscUYbHyRAZN/Yc/xBMFKTfuNUtnQLmcIahdq/ycYhT53yuNVwjN/oZ1lhJ8ukxKKK7UKMUOSxEF4KR/Py34yIdH+2cfPLqVHaSr8BHuilbc+NPdsYOd1EYAn8+NsDQ9VBLjWFo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784037303; c=relaxed/simple;
	bh=O/VD5rluim3zoB0CGYNPYktHOJ8svsifnOP7S6B7mPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=M1os+DUzMjLjpGaAJF/A1tG7a1tc8dxBkwaw8vs6KijXriugjlDt75YGbUmaP8RayvBO1O4wo+0GH1lJ4W+UaHr/Kkxe5tw6LylRiovEJAVl/vvxVicwELXJgEhVgTuciObBj8O12dFhmmsCVNczlA33w0dsZYxWXDF+jNTENe8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=a0cWP8JI; arc=fail smtp.client-ip=52.101.84.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="a0cWP8JI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v49YIxlVyYwbMVFWiN1zX+n6YQlcTYCfz4ARfk9VRcWhVFo8PJJYec6PyrLbyZBZrSykBGXMe3GWGVP9vEdBm/XDGRunY4E81NyVWqSqVEEyQbkBt+5EbiG9/pNBvsle9XO9MFd/ZEZacbfjvJd6rwjTStizK8IwMG6YSW68S6hcRUu4PfH2XBV131xLNLpyMbMrd/qwHNGkMJTflStS6bKp497kJUVab1OSLX8wxZLrX8XSbmxqbclDi3Ix5XlEfHm5z4hi9dfqGSyBfNx/aNlj92cwKIuzjpQsy+cLYttTBow8kLkH72IaD2+m2HFll0xuI/fvG1mYP3osyZtgdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kgsiL2xSMEHMtUlHZtH7Sn10/NLSQ4sHN33Twgz7Bn8=;
 b=ZwoOjFumA5XsoNi95UgusR1D4T3jQPZ821DcWSji1MkKNtKTk07xYF8k+vBmYP4jvwACGHvpd+2PZ48pBt8vPYlfIw2cxdEGn3j84mCl4f0ewQNWGOnbLm5lDJFnTZGlDmGd9ms522rQFAV7mj5Tg74bMcA5M8kY222D5pEqTU1cisiYvAG5B6yjbtXknTwSSQJ2/H5ndH36pq5XeYZwDjMKMNce/gu1LvOCDmKN7eYa2HjtIAQrhpWkf7x4Vz7IOLIFgYVkZdUOhmhVLii6SKwmOg2nQwE70/PRLRQgh76XcmUPzd6yEusya9dUMIBS8Iei6zguhpPKLq2rx7esEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kgsiL2xSMEHMtUlHZtH7Sn10/NLSQ4sHN33Twgz7Bn8=;
 b=a0cWP8JIi3K2u+a9D0/aiyooPcBvGB2z9raIOj0q5cHU5kdS/OGqUN2LOywn5s4pv7en9CpZ8FvZtIaCsUxp8EimmAHZWxgtzPwXsOsMXnbMP8RMXTtxD6JBra/aQ1gp0UPkzO/cfHKkXfm6RbJz0c84lK1bK4FyFJOs4NzNDMaEGsykHdpa8EQVm2w/hNrDCmgZyGwC8d3jnwvmt+WKM73xFaEdUShq7HlPD8cHXwm4hh8HLtx9PjsHjh6f6/+9kpfk27pWwlkYkBCh/7pc1ylT9gDzpyW21pI+d8SypAOinDdKXZD1cXH81hTO6b31gVERSaeXMAoqmG6OUKV8WQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GV2PR04MB12138.eurprd04.prod.outlook.com (2603:10a6:150:327::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.20; Tue, 14 Jul
 2026 13:54:59 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0202.018; Tue, 14 Jul 2026
 13:54:58 +0000
Date: Tue, 14 Jul 2026 09:54:50 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: "Carlos Song (OSS)" <carlos.song@oss.nxp.com>
Cc: o.rempel@pengutronix.de, kernel@pengutronix.de, andi.shyti@kernel.org,
	s.hauer@pengutronix.de, festevam@gmail.com, carlos.song@nxp.com,
	haibo.chen@nxp.com, linux-i2c@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v5] i2c: imx: mark I2C adapter when hardware is powered
 down
Message-ID: <alY_qiBhG7EMGfIl@lizhi-Precision-Tower-5810>
References: <20260525030400.3182911-1-carlos.song@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525030400.3182911-1-carlos.song@oss.nxp.com>
X-ClientProxiedBy: PH0P220CA0006.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::15) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GV2PR04MB12138:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cd4d4dc-481a-430d-b078-08dee1af7e3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|19092799006|376014|7416014|6133799003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	g4ODdAyoVBWkoVaxGt/3hL8ZaV/Qy2egcLCwi9CogPv/Xapkj/aekUsp2HFJJuOg0wvwVnVyyqEEzhJVHrMFX4Ku38vz5FO6J/5cLq+En3EIUuX7KSRZRvFVRDxNStNTVrwJWW3kx8sgWxCIC8QzqSkD4riuF2TYK/SLgK5WgFylGlQM8lSOTWp+193Gx33rFxXXcIx0oWcw+OgnVbsm2qmwZGxFFb6LMQBSrdg7zIT5wdpgeoFaYwUYBkRk/g23+LODMnFNXa5nDVwZPktEHOVcbg1P4R9aG9+Asm4RguFmtLh2JIdj2JahhJgamOBU14euKlMPj6vV0mQT+/6MCmIBKE/cQPAP2uc9w4YmDzC0jWCJzV3tOPVxBG5gXvX9fjkVupVKi3Najn8p4TeMwAjMYS0ZfFa8Fd0tqTtDmCUG3aYqP1gT8za6Dvh1cCFmmqrsDHwjIoVNCb+O03G2D4EsZi1w80r5TKE56FmBrEd2Q1SB35MuGmsteb3lXFge8KKDcUpu6desCIS+bYxshT865T1kH3Wzo+z0GsxtYuKVNtAuhyyn7sH+oUobP6FfGiKr3wee7NmXNEXBJixBiL5wFyp0xgqsZoaKMs021N/MLDvc9STaJ5lYlZH0gwoyOWuj2wHnI3fBNYDNdO8TXXn1VuaNQMsWFkx8FLIG0/M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(19092799006)(376014)(7416014)(6133799003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EidolT9byhPzPLB5edanrm8ahkc6S9QGslYtQPxGUlyNuWKHhImIah1ZIp7s?=
 =?us-ascii?Q?Bxw2aENt4xfjeGjHDb9f/KT3e50m9Jv98Ng3sYpa7YOmWUQ3DoSrCfJYYAz0?=
 =?us-ascii?Q?cjT+bWNNzYS3/3E5zehORkiWOkEt94istg71YIzSQVRnez0I/ortO0SSXvGt?=
 =?us-ascii?Q?37JWZa7U2sZbQSY0voJW3oj/ZRsLTXM1KMmYbEEfex9MXr/BZBC9M3ZMLYGG?=
 =?us-ascii?Q?SB5qJKEWamcfyJ+uK7hbJ694j9W05eN2fO2bW73MhHLjAsHs9XP3giY4jqbc?=
 =?us-ascii?Q?FCjSEMHRgjlqAaSEWLhzn50GI5j0Ej75SHXcw7+tj4N1CqBwC2T6f2jKiGd7?=
 =?us-ascii?Q?sZwBNBcUHXG8TVBEdSBuER5K0f6Ph/aSlxYMVxpFMRKHYhtDExcJdq5X2I6J?=
 =?us-ascii?Q?XZjOvci3OisUlHY/RgjIj8qKcyOP43vYlH1Xoba52GagO8m0peeA3gwIKPHT?=
 =?us-ascii?Q?I0IM3GhJ7mEnpp7JGeduyRLk1pZXMYA+VzvsaemWGj8+GcH5xqkiYXFQDB1n?=
 =?us-ascii?Q?mShcBjufO+UXdu21xwEPXMCR8o1MQ+fucJILYBVgtj1UOp5RGCMwF2zyfPA7?=
 =?us-ascii?Q?TlKZlBt5vLmjXQTL29m/Zs938qpS4dW/8KlXVb0LhBwfgMkvUmrnAv7+SkKs?=
 =?us-ascii?Q?rF5Y6dsNtmaUSY8URB0o4g5QHmtlw0xJiFYURid4EUyoC0LHSoDWOyT8SIDV?=
 =?us-ascii?Q?kIWmIps0OWNtFx0MHzxyGbAqrotk1+AKybi92pRorXcqHHIt5idEemp3QRLJ?=
 =?us-ascii?Q?EXkoMrnzEnVqH0LnHDLaiiTgkF9ulRpisdrnlyIiNvCHyjNVY6SpZ40I3wId?=
 =?us-ascii?Q?0yaedsWIqKRyr1vYWbmN7j61DWrb1bssbsNQ3Vzqi5B829J97UTDA8zcKcTd?=
 =?us-ascii?Q?sjIpuYydNX9moVjS2U39YI8gwGvz3jQq7nGlvORwoe+Ygp/nhJ9yOptS4JRz?=
 =?us-ascii?Q?hL67nha2wdd/2Of1ASYrnSZlc7lVgv42oeYudfpBWEFyDw6q1NQKKetwbbjw?=
 =?us-ascii?Q?U+HXSdLYpCcUqEjf/R4asnzVKZeBS240UY08oB45Sifz/7fC17W8q650OsCm?=
 =?us-ascii?Q?nDACeI/Dtje2KAocicEk6zMbMfuDueg9EIzZHma0cTKyBGlQJBpnUAqP92lX?=
 =?us-ascii?Q?gjhf23hgVHZx9scinYdUwrR0LAkEWYNEaqFxyqlNYObKDfbDvKq1nwctG8e0?=
 =?us-ascii?Q?WxlzsPGGW3lvUQfzGJPp42jkp24iPI08LVWQqJKfGID5enYN3Irsf0cqRfxN?=
 =?us-ascii?Q?AXIpEYEKADfRNrhZraCsWR8uOHYz/nVxB40Br7yB2q8MJcTPmYueGb3yjtY6?=
 =?us-ascii?Q?z4BLpbq8O1t/evt0EVnHwu1CW39qziUfwWslfdE++m3V73h99VwIo3yVWGsf?=
 =?us-ascii?Q?TsG1wYowhQDBTAz8RjAnbOJDeVByOaIkMnPCMsj52V121DPaTOlM99R3hAgf?=
 =?us-ascii?Q?XqKa3SPwFdzSKVU17e9w5ZhOXO8b0S3s6BVmRm+d9HgNlf252VQelGDOsMrK?=
 =?us-ascii?Q?OlWpTOnQ4SAbO0YNWEN18oId8Cjmr/wPWA7LC1ce9BBv2sQvVnvbjWg00lcI?=
 =?us-ascii?Q?rwdqCzxU22ayM0lEW8Ik8FZ3Ss+cxywokxf++b2moAnIad+HPO4HdFMJNF1b?=
 =?us-ascii?Q?zpbjo0AgNDsUn6nIpOahmJ5kNAnIJdeV0wSeblcaBiGBhu7uaYAogVTqogNo?=
 =?us-ascii?Q?t4togBLuwBpaZrI2Z44YucVO6PUc4WEeN8XaUdkRWT3qxRkHlDZSlPCN8/cW?=
 =?us-ascii?Q?nqIoFmfezQoFPdn3uafemypVbu/5AgJUOEdP5DheHUBarovB8X53?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cd4d4dc-481a-430d-b078-08dee1af7e3d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 13:54:58.8547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KTYfsXPFd43wG+r/xyALaZynQbH3lRidMIsoZbZ5iNuKiYEOjn+M0KFpB+2ZVnb9qtEuBd/ttEEiIsQUDAz6pi3yoXliP5jhJ9KuQ2hnG/lDoDoYmc+c0Yg6xtOyg0XM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB12138

On Mon, May 25, 2026 at 11:04:00AM +0800, Carlos Song (OSS) wrote:
> From: Carlos Song <carlos.song@nxp.com>
>
> On some i.MX platforms, certain I2C client drivers keep a periodic
> workqueue which continues to trigger I2C transfers.
>
> During system suspend/resume, there exists a time window between:
>   - suspend_noirq and the system entering suspend
>   - the system starting to resume and resume_noirq
>
> In this window, the I2C controller resources such as clock and pinctrl
> may already be disabled or not yet restored.
>
> If a workqueue triggers an I2C transfer in this period, the driver
> attempts to access I2C registers while the hardware resources are
> unavailable, which may lead to system hang.
>
> Mark the I2C adapter as suspended during noirq suspend and block new
> transfers until resume, ensuring that I2C transfers are only issued
> when hardware resources are available.
>
> Fixes: 358025ac091e ("i2c: imx: make controller available until system suspend_noirq() and from resume_noirq()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Carlos Song <carlos.song@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Change for v5:
>   - Remake commit log including the issue detail from Mukesh's
>     suggestion.
> Change for v4:
>   - Restore hrtimer when pm_runtime_force_suspend failed when slave mode
>     enabled.
> Change for v3:
>   - Add hrtimer_cancel in i2c_imx_suspend_noirq to cancel slave_timer for
>     safe suspend in i2c slave mode.
> Change for v2:
>   - Call i2c_mark_adapter_suspended() before pm_runtime_force_suspend()
>     to prevent potential deadlock if a transfer is active during suspend.
>   - Roll back with i2c_mark_adapter_resumed() if pm_runtime_force_suspend()
>     fails.
> ---
>  drivers/i2c/busses/i2c-imx.c | 45 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 43 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index 28313d0fad37..73317ddd5f02 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -1922,6 +1922,47 @@ static int i2c_imx_runtime_resume(struct device *dev)
>  	return 0;
>  }
>
> +static int __maybe_unused i2c_imx_suspend_noirq(struct device *dev)
> +{
> +	struct imx_i2c_struct *i2c_imx = dev_get_drvdata(dev);
> +	int ret;
> +
> +	i2c_mark_adapter_suspended(&i2c_imx->adapter);
> +
> +	/*
> +	 * Cancel the slave timer before powering down to prevent
> +	 * i2c_imx_slave_timeout() from accessing hardware registers
> +	 * while the clock is disabled.
> +	 */
> +	hrtimer_cancel(&i2c_imx->slave_timer);
> +
> +	ret = pm_runtime_force_suspend(dev);
> +	if (ret) {
> +		i2c_mark_adapter_resumed(&i2c_imx->adapter);
> +		if (i2c_imx->slave) {
> +			hrtimer_forward_now(&i2c_imx->slave_timer, I2C_IMX_CHECK_DELAY);
> +			hrtimer_restart(&i2c_imx->slave_timer);
> +		}
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused i2c_imx_resume_noirq(struct device *dev)
> +{
> +	struct imx_i2c_struct *i2c_imx = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = pm_runtime_force_resume(dev);
> +	if (ret)
> +		return ret;
> +
> +	i2c_mark_adapter_resumed(&i2c_imx->adapter);
> +
> +	return 0;
> +}
> +
>  static int i2c_imx_suspend(struct device *dev)
>  {
>  	/*
> @@ -1955,8 +1996,8 @@ static int i2c_imx_resume(struct device *dev)
>  }
>
>  static const struct dev_pm_ops i2c_imx_pm_ops = {
> -	NOIRQ_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> -				  pm_runtime_force_resume)
> +	NOIRQ_SYSTEM_SLEEP_PM_OPS(i2c_imx_suspend_noirq,
> +				  i2c_imx_resume_noirq)
>  	SYSTEM_SLEEP_PM_OPS(i2c_imx_suspend, i2c_imx_resume)
>  	RUNTIME_PM_OPS(i2c_imx_runtime_suspend, i2c_imx_runtime_resume, NULL)
>  };
> --
> 2.43.0
>
