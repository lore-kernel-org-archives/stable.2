Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013036.outbound.protection.outlook.com [40.107.162.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7943DD85E;
	Thu, 17 Sep 2026 18:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789670360; cv=fail; b=aNMY0rd47d8rTYPq5oa2gZaG6iwjhpu48QcpKPNwaX4JJz3SHLO1pRAI/3Hf/1YKLFibl/savWlxirtXnIdjAtaj2fosyaTUXDcLzBrz3Qe68TO7Hc/XunMm98QN8xSI2IxceAeCkdtBlUxx0O8cGloQAZ/toT5gVjotZ0BxhNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789670360; c=relaxed/simple;
	bh=Ya/0+CIyk0S3wWXSlqsS6zWi4iSP7yp1Mub/jK5oZiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NqaiKpNG4ot0Fv99MRpGFhEFitLeP5Bpq6HZwBDMlV0Y8lpZSXE4ZmIqbuc+5xDu7+jzo+41ZLWgVoNaekA6ubrp/XSLAYLfA6YbIqhom2ofokFjq+uLxipFCZImwktWENu8Lvx9tVA3up9pSpYM1deOqeY5evomUNrFgCNXJQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=NHz9knxu; arc=fail smtp.client-ip=40.107.162.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="NHz9knxu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jOOTtjCk8k3WRHkVsaJ5mSbhmc39gqMozDY+ivxCCGgVEmdE/fFg1x6RCMw3aBbqzh1OE5y0E4sPOzZ79ZRLJwtbscnBmMi61tanzKieGZUj2Gpg0/3tIgI11Z/dxgGnAzw6hI+RrpeS82h6Sc+TvvJ5/4IE3l9Fvt3k455EULQxdO3ZMbLL7vc+izoMmm1ZWcR0YrQHvTAO75yIPCdNIxRX5339HmbyleWB3xHMv7FUu1n1neZwpiKupNtxjB0fzyoWpjGytpyS500WKKMaqv6kPQPpQebNs58MR0O9Mj16kuxSyi3S0fzLFY6M3G6vVM9+ZofmPhCjylzTiXs8Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nunh38Th2PdBodaZ/99lYrDafMRHYtN6/PKB5UW6Y6o=;
 b=aBXBjOLaQC/YWmiu7KWCSECoDFg896uSD1mAq6UY2AzH8O4dFrh8Bf4L0urRFUQLf0diS066rmTmn8Y6TsLn/AlehGxAmo/HR17dA50hk3tX22/SrLSVAJV8gypjiy64urF96WZnfZFOZcC+VIWoF3Th2Ok/2gDJbiODP9evwaZTMh6MolgbbQBnHxrS8COQ3Oe3KValDxEIEkRPCeNIlVcMuU+RXSMuvrkKXvGl7QWspvI2pxnnoYJHfGUO2dHCmxysIpsphWjQrrINagfCRFeCo8JUe2KqdO6ayl4QLNE0klr20NaA+CFPvdHd5qEWrhpDPUKizkR8vVh8FKqOqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nunh38Th2PdBodaZ/99lYrDafMRHYtN6/PKB5UW6Y6o=;
 b=NHz9knxumyBRnfnqwvVJXQBs0PFkjSJkLsQnv8sEa7gmO5c9nKge2LYEC+me9FdYYgH97inewxQuuJEQSG7aKvc7Co2erUOYEXoM/NQ8cQGeBOBrhFMhYuxt9jCG9M4jXllKOpgSBYlwui+fxfgcP+SzDCUZjTcwHMrtWjvR6GW1kldqji56Ao5ucHdKfa9BTcsqbNcA7wNWIYbgQAi9is4CpfMzypagofvB6xs2LqdZzmB26pO/IoOYv/K4rzCdhtu4Y2A/LyRjszWdCkBoNqNVCxnvOcAYmLlCCM5PpVGPuGSE6CDdrovz7mA2+Ql5AOmGRcnUYK3YJnSguQL6qQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM8PR04MB7476.eurprd04.prod.outlook.com (2603:10a6:20b:1d1::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Thu, 17 Sep
 2026 18:39:15 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0406.012; Thu, 17 Sep 2026
 18:39:14 +0000
Date: Thu, 17 Sep 2026 13:39:06 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: broonie@kernel.org, haibo.chen@nxp.com, han.xu@nxp.com,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org, yogeshgaur.83@gmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] spi: nxp-fspi: Fix runtime PM leak in nxp_fspi_probe()
Message-ID: <aqwzyjKASxfxtxTT@SMW015318>
References: <20260917153713.2160743-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917153713.2160743-1-vulab@iscas.ac.cn>
X-ClientProxiedBy: CY8P220CA0042.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:930:47::13) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM8PR04MB7476:EE_
X-MS-Office365-Filtering-Correlation-Id: 14682ef8-d6c2-4212-bc0f-08df14eaf936
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|19092799006|376014|1800799024|366016|10067099003|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	c1YKtsgp58XMp2xDVIMvnlrjHurGjaam9nrXuNdBEL87q0QPRskemBK7/hIBF8i2W2KpSMaSc/3QmD/qCsKmTXIlERXOgIqnSl2Zx7K7Cb56zS7SLVolkZyWKqRbB6KlShnlkt1Q90SMZgbetso4wmeBxlHZ3WwplZ8N6cUNOt4fy+zohHVS0olP7jQlzCEvjajE332yDc3uutfE+8FquytCf7UmW1eVddzD9le1cjB5a8djUKtNzWHHfVO9mPbgn862c6i5V8RdTTOGlE+UOMfeSnnXi1qUNqOB/pZp/YAJKeM7RiXo+FwUw1tfDxnl8lkUY77IXOGK0O6fZ+5wYbWRC78thJvL11rBZyqGXrp4DDMtNh+QLJl/kD50tccODniwuFqZiWzRCF2Dri4yys4y8O7+6wUAA3kbYxKkKUsDKW+/gogL8QrpDlYj5jRIiWY4arHRwdXyFEFMBB1+zFLxyWU0FjS5OOmW1BiCzR8GfGdwFvKbHXm8ph+ClwX+z7epdNlogCGPmq4KBJlwa6/YW80vLmgdz7QI1nd6WSvJ4+7YA3bvUEUPyMzli3rzqHcunAmgmckJqQ94nYPsdIR6Qc4KcfjSFHWCS3k7PxTPPxubyO9fDvuTFNoAnzLs6qTUF9qyaN3ipu5S+OtMPcm+6nMzaNOe7S7EX+0roX4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(376014)(1800799024)(366016)(10067099003)(11063799006)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ytwk0sYxvlv7JwbuXtgC8nV6A06SsG+uJITSW7Qs1y7hPZuCQGux47+Gbya9?=
 =?us-ascii?Q?J2n6OqVWcSaIfGYBMaHAm6jetaGMqmB4M+0ZKPUmaor3Um5R2pr5jzKJbhXR?=
 =?us-ascii?Q?e6HBTOHnLBX/3V6HEqLXZH2k2Z2OiMxfrrwne2v7NKFPizSzzNIAeMIGI/ya?=
 =?us-ascii?Q?tDzjiotftuu81CmcaBV3gDpQCD0SuAzRsToh2DgNsgEzyaXN02p2MeiuzpWC?=
 =?us-ascii?Q?U/Luq2Rz+sFFLpZCneAcle91tSKL5TEw8Jgnl3fw2hcHGihAggbOndILdKhw?=
 =?us-ascii?Q?qgGJdZ2HIpoxJNIEVdWb/rjgJw2xNGxlv5cAypoSUfnEU+PXSOV9b3KEug0z?=
 =?us-ascii?Q?aw3Ygf+OFnix0kWDsi0npFh1pSlK1LWK/GQecaBMM4Li9v+ND1vMfYETPoUa?=
 =?us-ascii?Q?wyYdgOImxGaMuBZqrby5IpE9FE62IMnrG6+CZoP/oDsOG+wjcUkuyWP81EBv?=
 =?us-ascii?Q?qR3lbpfJUu0inKRMBNndYvQ5IhmrNOROCZIWt70uXkkAC0I+6ha4Hdxvteup?=
 =?us-ascii?Q?0/HQiUUV27wCP4to1flTqIl4/YWBj0Nj+RWg7U27oV5GvZ1VDccykQUl1Hjs?=
 =?us-ascii?Q?ARnrPkVS7sQUamzpSCAH60NKW/rftn5WYjiGUwtSHPzYfy3F0UfSyiQK5Wn6?=
 =?us-ascii?Q?Lh1aI/X/gkTb6yXlZhx2feM/KtytNvZPdcQHh/PX+qfTp1fSRUMqWfT3sBXO?=
 =?us-ascii?Q?pc4+lsMRVY6eVP12lCmbyxwd1z930r5EBPhk111GM/+J1kRySXch8TdHlNW/?=
 =?us-ascii?Q?9xEA0qaXajdSvifPee6peQdpnI1Xj27WhI3O0BQB4Hzrd9jYKNA3Kb7yK2Yu?=
 =?us-ascii?Q?2nnlXE2WBuzIDU33KUYqlDyF98D6lKEcltj1ggupzkpeu08GzZ1XMo//my9E?=
 =?us-ascii?Q?cDFkR6vJZ7V80KG+48Qq5/VWJOqkppFqxOY+G/3fWeqH4KmEFhXFrlY2QCPJ?=
 =?us-ascii?Q?mWbfOFt9kUgeq+EF2Iwk0RNKDyDP6u8+QW5cNHfZAOachhOX67yaIOjubWV0?=
 =?us-ascii?Q?OQGWdq3uuKEcoH8dT/VstjYE0Pf78+aq4BR7FapY8SIzQkvq4zfwcn50aL8T?=
 =?us-ascii?Q?8afMhlx+xrOyX0+r34hJdLIQFiGH0roroVdGBaUaKRwHRL0jTsPqNKIYGIUo?=
 =?us-ascii?Q?oZSL8sKbuYJY1kChI5Ifr2L91EeSuOHmCnuF4aWts5iE/BnciZtrngGVc3wj?=
 =?us-ascii?Q?ItVxxAa3cWFfFHnL2odEENMN33UCLWYJa3VTRYV/RU8Cn0K62w3u5D428o24?=
 =?us-ascii?Q?6ERnWI3KourLTPlpTmcgx/F0OaZ8KfMbeO2JjVgatr2NBmEtiPTjoklMCjsK?=
 =?us-ascii?Q?urAQcY7DoxnW1/Hvev6VcQJ7x4ruAc+qw4K3uDH2tnR7czY8HNIVCmhYKTJ7?=
 =?us-ascii?Q?F5iifep4kurg7cMRpWwqH7aH1t8y27aDmwuXmfYV+AQHpIou6ethIosVIZAW?=
 =?us-ascii?Q?4IGr9IC6UaAGS+NTkEvGeIF9Wbvo0ixsPG5o4migDeZa3PLSn+C4eaTMf/ui?=
 =?us-ascii?Q?+zhpmwopiPsz3ycd4lsV3ks4ERPqg+2Oa6x5A+j3Zrvn9F4IXbvEL+IHD4tI?=
 =?us-ascii?Q?ogHddCtmpstMQXo/SzEiDN7rS0PYSv5wPR6RCNqg7/bSYxki5OH0kX3XUdXG?=
 =?us-ascii?Q?/Sh7d1+fm5sI22naj7vq+xEopJ9IFBdbCpjyQxgwezq8p+hW2jUWXuFUx4fc?=
 =?us-ascii?Q?fGVpmnipTOhiWW8HLVd51hGyKpO6Efd4ThUMzxRbUPHntg9ixrUD5td3OQUj?=
 =?us-ascii?Q?LERxgLNlvT2a9ATfeJcY3mUxmIF401526fj9AvMTwKsQ8ZIalTPZ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14682ef8-d6c2-4212-bc0f-08df14eaf936
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 18:39:14.8919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 87o8B87DA9Ucvil6TT6ajt+PjMjPIfzQJza2ZianqS60uI1lcF3XyMmX8NZZSEQkqCVPHFkBDYAshIcOc/u2iVTwLflCIYUSpbrWJbQJJ+iOJDeLkQ2/f0sU86fFf/KW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7476

On Thu, Sep 17, 2026 at 03:37:13PM +0000, Wentao Liang wrote:
> pm_runtime_get_sync() increments the runtime PM usage counter even when
> it fails.  If it returns an error, nxp_fspi_probe() returns without
> dropping that reference, so the counter stays unbalanced.
>
> Balance the counter with pm_runtime_put_noidle() before returning, as
> nxp_fspi_remove() already does.
>
> Fixes: 97be4b919a60 ("spi: spi-nxp-fspi: enable runtime pm for fspi")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/spi/spi-nxp-fspi.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
> index 1e36ae084dd8..9883e5149dc4 100644
> --- a/drivers/spi/spi-nxp-fspi.c
> +++ b/drivers/spi/spi-nxp-fspi.c
> @@ -1351,8 +1351,10 @@ static int nxp_fspi_probe(struct platform_device *pdev)
>
>  	/* enable clock */
>  	ret = pm_runtime_get_sync(f->dev);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		pm_runtime_put_noidle(f->dev);
>  		return dev_err_probe(dev, ret, "Failed to enable clock");
> +	}


use pm_runtime_resume_and_get()

Frank
>
>  	/* Clear potential interrupts */
>  	reg = fspi_readl(f, f->iobase + FSPI_INTR);
> --
> 2.34.1
>
>
