Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013052.outbound.protection.outlook.com [40.107.159.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BCF43E4BF;
	Wed, 29 Jul 2026 09:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785317166; cv=fail; b=LNUeKRrCKZwHfq0EqSOTqnDcISw2bxsDT4BAaIMZgVsm/Xr+8cqEOM7VvmLl6arvoLfWtPchC+pZEhZRrAGxUTZ0t/HBBzcpZm98/LB6wlZnOBDwFsN9Ge6CgxpDnpls6y9F63tEJtFfTkLng15Ax7FxP1eNdrCMJoRhXfLRkL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785317166; c=relaxed/simple;
	bh=f8h/3obQsmIdImtdyNTYJMdWDTl0jEf0qYted9PHarw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=f2SpVriqSGFppyne6Aghxnb/mBJBA4h4n9cf72f57FsGK6KxgK4XD6Pdf/NwhORos0+E5laRxjIyBX2gsL5N6xbj1BXr24HlvNNNPNDvxMZ/GY4rUAy7ek2xT6FYBhzVB8GEDLH6UUcTLDLfIqcFCwhy1KWySHxjreir58zXLbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=LXiRtrQP; arc=fail smtp.client-ip=40.107.159.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="LXiRtrQP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dwpR5txzu4TdeMNk3mwaPbgmrwDZmlyNYPon7k5GyEvbk5XrKjQM8ufOTE3I8lN0+DSHfwgSakClCjZRXgIfYOWPHMP+06aZ6x5V78eCnajpDzVN8LQiE3wOn56IdvVvUSvnorEXgjYhj4uKZzU3okpskQbbVJrHOaxGbskPs38qkO8GeMTqgPdIdLMJwqEhHlCZBHBAb02YbMxoj3mZFb2FMFHGY4EyqZXEWGUpDEJnOzmiv4Ul17upRTlmBR/F0uR9mO3UFKpF5kYd++J6UlWZEoS8BMAAMj4KxDD4yce1ahEK5hhOL40yzIzYNxbSn4ytOPD13qC6AyTko4xfLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lg4LYXAFAsDidMH7mmIX+3GzBhvt89hmFHE29OBg5rA=;
 b=Urzg9IXLqNbA+AM8wIFIq1yEL/7qUMQWQEHGFoSaV4spiCg+lp0Ke6OMW7XC57rKsX4+RHzdZeriEujI/w6RhhUQCmDjpDVqM29TE3fRxsEkf55mKwuvBn1C++zabQaNF0Ia0OLxs7HyckqaJ0N9XyIXZ/+sdZkSx8YJkJS78DH+wj9s9pomyUAk/UF8g9B/wRMi6epTJepga4g3oYRjrX9TegsE7AApzO9NVCwPNnc55tkNuE4jI48DxmCVKDrz8toGvpukxBTmdpqooQIGwctX8fSi+i/6d0z9CZSN8Bd/+6MAYU4OHUB5JsmwhirG3HB4YWYyxBGYXZW/ssXRuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lg4LYXAFAsDidMH7mmIX+3GzBhvt89hmFHE29OBg5rA=;
 b=LXiRtrQPFvIwBLsHqNVxeoGB04qhz4p3mcimM8D1FFn4zSwS+ckCWeIUJB8fTWmhC/FKIBRaJv0Z9phih+Fv7JT/X8SiZKo/brViKFuBTW9aWWk1i/Y0hBmEI+qqFqpPKp3Kry+onc+jzvkqeZFkRZnEpA7DQbu0ZO4xOUuOt5z8dKKDF8NQyp0m3uSQSVfLRi6z3LJnAg8hQKuITflWV1Dk/HZwy0WBd3az8JWy4LEu27J5sodnihruLcZeu+hWf5jd/IHcW05ugLknIIFTB7lMHSwN1p9pzlG4bWqj2PLOnbr2EBsPe06nafQqw2yg5lJqrnjUlW45kgiWDfD9uQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9422.eurprd04.prod.outlook.com (2603:10a6:102:2b4::21)
 by AM8PR04MB7442.eurprd04.prod.outlook.com (2603:10a6:20b:1d8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 09:26:00 +0000
Received: from PAXPR04MB9422.eurprd04.prod.outlook.com
 ([fe80::54e:28bf:aa85:d25d]) by PAXPR04MB9422.eurprd04.prod.outlook.com
 ([fe80::54e:28bf:aa85:d25d%4]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 09:26:00 +0000
Date: Wed, 29 Jul 2026 17:24:26 +0800
From: Xu Yang <xu.yang_2@oss.nxp.com>
To: Can Peng <pengcan@kylinos.cn>
Cc: vkoul@kernel.org, neil.armstrong@linaro.org, bmasney@redhat.com, 
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/4] phy: freescale: fsl-samsung-hdmi: Resume device
 on remove
Message-ID: <2jrkfjwgczuuxiuf47shkdrisymuqty64j6m5pur2brjiobdxh@l3a37o4gkvhb>
References: <20260721064752.153338-1-pengcan@kylinos.cn>
 <20260721064752.153338-3-pengcan@kylinos.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721064752.153338-3-pengcan@kylinos.cn>
X-ClientProxiedBy: MA5P287CA0052.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d3::13) To DU0PR04MB9418.eurprd04.prod.outlook.com
 (2603:10a6:10:359::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9422:EE_|AM8PR04MB7442:EE_
X-MS-Office365-Filtering-Correlation-Id: b8cc7ba0-6a5a-4d00-c363-08deed536699
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|23010399003|366016|1800799024|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	OTbP/4db1x/6VdADnRwfag0s611+j+GSM0ZkYnd4FFJfl506RXYmLE389xCV4CBuoGfEG44075E064sbvwiXlKCbQPMwc4yE4n4RyS7tVeKrKzekWIlX0R27uw0bT+W1BbRDor2LnKVwGe1MTAp+Xj4nDkfcfbR6PFigXWTLWVndQXvFJI45LHvnFTpzhThEsTdngfQHhKb9LdZ59uIbzgYUqgH/6hIcpiDk/SXghYn9Uy9/qAcafI3Z0DlxjqEKGYeHK6RZJWoQ8LsD/LAyEK8Brwy/HUlzjEJti95LOEaM8qpJyyUQ3v0cbMaOZ3qQshCVDFNkMworR7DokUSzmGy1JmBSKKVEtOeRK9l66O9A0Ti1Ljd+Qm7tY8b+NAEtTvDZULdgSO7k7Nsf6v7qJ/SaMMYBKX7ducFAplD4JWjP5iTgvOGie0Bu2MDH38O9ovAHblY4JaG2s8EJeFHrXWt1iMQRdkvxSVnhUrzCr2Gc8m26kHu5TjD9cQ8BGH5NbppYBpG++c+FOVFH4n5mA7WvyodZhkHcIcboCFx6a2sxw4tycaOd/J6j0N666d5mlFdhzLZlr3eB/G/FQyek4Tm5YrGMXR/gssDBeHcc3LaqeKH3b05772w1y6x1/eDZWKZLoDY5v5naQ23dQC9SHCkZnaXh1ETAMxV7kpsSm+I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9422.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(23010399003)(366016)(1800799024)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/c8QAWYd5TGah8QFLSLXaAjUTfn1RJj2h7LJXE1aNko3r6jkErUWxE3h25YF?=
 =?us-ascii?Q?YPA9Ck6tIkGYyLh0jKV6WkaG1LvL5HhmSoHG8geWTTBHt/aZTto69O911a4w?=
 =?us-ascii?Q?TnW3Z0Qezkg7XSRmDULh48Amz+ODHCKVOrXofmNfGWnQyrVqZTD4fvANAb2k?=
 =?us-ascii?Q?a4ftfOoDEp4tA7y02TdbDNAm7xPBWxsC6RpkhOs1E3rw54PjjUV/SSZp2tn1?=
 =?us-ascii?Q?hRBRIaJT33sXnyY2baUWRDqibLQkUzwZeQMi9SQPggv4/mtnhc65NQOb8Pu7?=
 =?us-ascii?Q?fEBxfa6T8NmU9nBSmeBfqsdoAFOMAsIpKxeI/FkHW/0QucUpvi0USPNTNiX3?=
 =?us-ascii?Q?4WuM5IiTOs8FXD0OjLXkvZUjIr4cZrkm+7bH4FkXjWNEe3e9Rn17KUl4FD2Y?=
 =?us-ascii?Q?C2cj3L4NcySbsjJaSAtbj8cREa40MbJKo/uj2OxI8jtkASsMRvkGKy1IgPMg?=
 =?us-ascii?Q?xFSXIsBeabe0gXHOWf4ipi4sr7naf0kPrhPGjorqpULUMJrgtVG9c1fnKdkg?=
 =?us-ascii?Q?hpu8wmPB9bm0MkNk8vRDWyys9LHkuImq6qesyHEZExRNnAGWBxEoiRa6eI1u?=
 =?us-ascii?Q?LWrr8X4KtfTvyLQuihD7WbjXpZt62v0Ulx6CbU+r0htN3ydXqo5BqFdtHVA/?=
 =?us-ascii?Q?j3SwdUuCyF6JdqyikbNJi3A2ftl5/BslXbpylt2YNJSZooCD7JN+iJbh4b34?=
 =?us-ascii?Q?N5Adhf3xdv3luNP/S3s8T4DRKaliiUPxa1yMvnjLyQj5XpEJDLEjiV9J0k0/?=
 =?us-ascii?Q?xDboqeoMBQZZCiRNlXgrKCv6RT7thtBoEmfMHeeaqxA05JSCbKI0kbxtAPFA?=
 =?us-ascii?Q?amB5wM79WiWp59bJy0SvYR3LKniVGkEEgriqts39MxI1UMbCPbe02HSMjS6x?=
 =?us-ascii?Q?w6wV18ylMpQa3F/0q+VT+YMteqZBk61tEoOg6vqDyy4/tINapYpYmB2AAR5z?=
 =?us-ascii?Q?IN9UWkt20tMgSEAE4SvZ1pi6DDESTQXT7383cHV99sJ+weg9kouuu2BPjcZU?=
 =?us-ascii?Q?Grv+ITcqR7K6xRvvt53yYBcD6oF0xffjegFdMiGIaE6zQrz8f7ykQg/eRsE7?=
 =?us-ascii?Q?ZDlALlx8yvm9gRI7I2qMDQd5bwaX4YOLnw+hwLpKazkGEv6w2ww1uPQYuuTj?=
 =?us-ascii?Q?9SyqL5MrwtMiTTBUNiGWyYbi6q3r4PdIh7ZeGO1KbpJuH/WskSPpBPAJXLAv?=
 =?us-ascii?Q?UMlMQucsp/Xutj/Z7vIaYb3BtdrLI1MKyzYB0U/V8vxHCNi1uB3YpG31cDEc?=
 =?us-ascii?Q?7EreL7jpNDhtxGW72gBZA7ah7iEXpPPCWiWMWUWZtF+8rYAyrqvmixCTBfpu?=
 =?us-ascii?Q?tnc03evXxXLZ+jsfgForoL164ZFg1X/IkQqw1SFsa4c44nJ2WlCeylhADQg5?=
 =?us-ascii?Q?cS2hDhupUqO/8GqrS+BnnmjmxtLDbSpUj75rEC2r1j/Hk4LnMg3gf1H8scO8?=
 =?us-ascii?Q?Rr4nPH2gukoLFagwc00ZJATJuAex0ksbj/WCUqru/JWofCXliLnG2y6tXSbb?=
 =?us-ascii?Q?w8LxD/SSstAjIaNJqTK2CMI+H2dsm+WPr+GfWu90tdeNSNseT5qBK4vgIj2g?=
 =?us-ascii?Q?Xx73oxbeal/gbEp8vrIa5zkPSRn/sTsYQ7PtSQjkx5ajxHYJ/y50qFXtoLNA?=
 =?us-ascii?Q?iOFJt86sWm1dhzGxBi9x7QEjRG1xWy0ZRYZ6luJPbWt8JzavljLemRW/V5C5?=
 =?us-ascii?Q?OcdUqjHKsqiJC3taPrHRTPAv+IymbvrcuhxVYhpDxcQJegiAhwbDqtmvLce2?=
 =?us-ascii?Q?2cfXydH26QAAyosi4tYrHqBO0+1QyRBQxlLxSI3qYZwvr5nawDRX?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8cc7ba0-6a5a-4d00-c363-08deed536699
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9418.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 09:25:59.9846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ifQ61j7G9QZtADUyi0O1nNVl8E6T4ZBD51vf2qH2ULA8PY6OygtBDxgbzOMkTNwjPuMKRafuRtMRW2GtimFCclDNXcCe1bEjgaCSq+3hVPH/jXbJNFZrR9xaW+ikqYSG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7442

On Tue, Jul 21, 2026 at 02:47:50PM +0800, Can Peng wrote:
> The APB clock is acquired with devm_clk_get_enabled(), so devres will
> disable and unprepare it when the driver is unbound.
> 
> Runtime suspend also disables the APB clock. If the device is runtime
> suspended when the driver is removed, devres will disable the already
> disabled clock and the clock enable count can underflow.
> 
> Resume the device in the remove callback before devres runs so the final
> devres disable is balanced. Drop the runtime PM reference with noidle so
> the device is not suspended again before devres cleanup.
> 
> Fixes: 6ad082bee902 ("phy: freescale: add Samsung HDMI PHY")
> Cc: stable@vger.kernel.org
> Signed-off-by: Can Peng <pengcan@kylinos.cn>
> ---
>  drivers/phy/freescale/phy-fsl-samsung-hdmi.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> index e7af4f9c7b20..5f41890bd134 100644
> --- a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> +++ b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> @@ -690,7 +690,16 @@ static int fsl_samsung_hdmi_phy_probe(struct platform_device *pdev)
>  
>  static void fsl_samsung_hdmi_phy_remove(struct platform_device *pdev)
>  {
> +	int ret;
> +
> +	ret = pm_runtime_resume_and_get(&pdev->dev);
> +	if (ret < 0)
> +		dev_warn(&pdev->dev, "failed to resume on remove: %d\n", ret);
> +
>  	of_clk_del_provider(pdev->dev.of_node);
> +
> +	if (!ret)
> +		pm_runtime_put_noidle(&pdev->dev);
>  }

The clk "apb" still may be disabled twice on removal for the same reason.
fsl_samsung_hdmi_phy_suspend() may be run after fsl_samsung_hdmi_phy_remove().

>  
>  static int __maybe_unused fsl_samsung_hdmi_phy_suspend(struct device *dev)
> -- 
> 2.53.0
> 
