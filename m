Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013011.outbound.protection.outlook.com [52.101.83.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499623B4EAF;
	Wed, 29 Jul 2026 09:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785316956; cv=fail; b=jySjJOOoi6jvF1Df6T+FqCTPiTwzYtCAEcmsB83S5/PHudWKnz0BoNtUkvJ9irdCJYwhuepdsJAzGena03JmNXsJVkB/uoWeCHc/nrbR68maoMY1u5XisjPqU8oAGlF2hHUoTguFNkoAkaYIynQ3kPjBYIDSYx5TNEkAW+eT/lY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785316956; c=relaxed/simple;
	bh=Y0+orfRhoc1ElVM8U6r6Lq4OxfUvRGeYVljl95b5mf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=u774bW2VCtUviOeD3bVhJSyE3dwFZs/qGjSsMmNtvTTcOM3jrd8ZPo9Of89OQSimtZcZnq5MddI4qEWpXbM5y01YvFCw2WccDXZAleg03KKlgCKX+KAwCCmWwqekTWItd04/PRbvR10L6zhwd0s/tdFHZe3yFQxVKKkA58wnL5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=R4kf3ySE; arc=fail smtp.client-ip=52.101.83.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="R4kf3ySE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cGqE+It7agUN9r5DEHHE9bOCdUANkLQ/YTCPxdex7G6Daun+LXxvsK2PqYQPMfWuq/XM7Em8Ym46akA0MkAETSon5B/+yrrnmKlS8CruZizO29KKwIZRolhBzUVgz1uF2kHazzJ02A+GZJpA/OcLSd2qxTdt5oAg2YKXwNdMuD/hoqv1Gi84RwNMCKV5/agX/Rk9N1Z6d4hwXkRskB+0/15x4tKN6NQgPK0+0sy3cHUKCBmwqTUd6NUMaHgB2TGcRfWTL0OgxGWqt7sKeKjQzkgcZM0D7fpJLy5ElxpnhmblQlnOaMeshzUN3w86YPfK7UF4x+O/HhzrIknyJtxc7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZIOanLOQwxIQJ5GMRelFt+3fwsxDezNqaZMxJu4Kgg8=;
 b=oFU5LU27EvcxmUwjLUUewYvHHWIIc8XdQLKmvq1RejRkuwI+vUAi5F+B7f/+Oql6L63AdeMriQ0P1Ib5TbDBMKlbfGj6PeTipgeOmENQ7gnn9srrggKUFv4YGJXOHcw/1PsGkmc4XQn2KYpRkKl/qhbFDatvfo3DE+bkjpLohfnZRp2DPpQek9vYaFU8YtsRjceXO0FElbur56Xe4/RYMfXJL2bZKowTcGYN64gO+zzY0u0dlYi/t1ZkDmzwOThA2KjbpkmQ6DllJHITc32sZBjlxwUcc0SuyZw6L78WcNjfzyGHosUgLFEDNzGJaiQtXZVvm7oERDSCZkuaFCeOCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZIOanLOQwxIQJ5GMRelFt+3fwsxDezNqaZMxJu4Kgg8=;
 b=R4kf3ySEMCN4yG64wERYW4JUI+kwc2kQNnA4UX9IlVvUGcee4VUoGfR8RHU3ZgD2p196RBmjoBAu1nN/hlr80shmmfwtALmPzYZEZgLA3yyfsk7Js1a6YJyS0mUml2OyxHZGSCkZZ8Nxv1tqFDmyra9OLNZVYvhVBf4M2buhtYZ5cLmBRM7WbR1ghvzxRcd2kzuqaMFdtSvV5i4zb/+YsfxQaxoqeaI8r5bFQAhDN/yuLuqLB4Kh/FhY980iHlap1gCDqKiGnN+qU2TbZ786wAg8Q0tXfGbcVy3R6YdovfiBcSAxUehYEr3UTe3chmRmI24f57Cmpmgjwc6+u/izQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9422.eurprd04.prod.outlook.com (2603:10a6:102:2b4::21)
 by AM9PR04MB8353.eurprd04.prod.outlook.com (2603:10a6:20b:3ef::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 09:22:32 +0000
Received: from PAXPR04MB9422.eurprd04.prod.outlook.com
 ([fe80::54e:28bf:aa85:d25d]) by PAXPR04MB9422.eurprd04.prod.outlook.com
 ([fe80::54e:28bf:aa85:d25d%4]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 09:22:32 +0000
Date: Wed, 29 Jul 2026 17:20:59 +0800
From: Xu Yang <xu.yang_2@oss.nxp.com>
To: Can Peng <pengcan@kylinos.cn>
Cc: vkoul@kernel.org, neil.armstrong@linaro.org, bmasney@redhat.com, 
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/4] phy: freescale: fsl-samsung-hdmi: Fix runtime PM
 cleanup
Message-ID: <scn5eubbtzqkzyinxbvxrgz33tsm66i6t4m7ffe6u6z3mqqqze@xkb3n7ld7xie>
References: <20260721064752.153338-1-pengcan@kylinos.cn>
 <20260721064752.153338-2-pengcan@kylinos.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721064752.153338-2-pengcan@kylinos.cn>
X-ClientProxiedBy: MA5P287CA0027.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:17a::17) To PAXPR04MB9422.eurprd04.prod.outlook.com
 (2603:10a6:102:2b4::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9422:EE_|AM9PR04MB8353:EE_
X-MS-Office365-Filtering-Correlation-Id: aa0adc9e-aa78-457f-0162-08deed52eae7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|19092799006|11063799006|56012099006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	AfNZBZkQk9eBoIixdCdD/qfHaqAhZFqD5gzShjALnwt6KMpX+bEKnfBkET6UWwf/bbIS0HA1rICXVDM4xw2C6a8oDELsYq3EFclX7jt2I/LxQmJRdobRtTQH2hm0/SA8rPdf9adRVUapMF0PjtYKRtb135gEPK9Cu1c7vCn/a+awBLTbL9dco2bGQcIf0Gssy8P5j1twf1YUXXMKMCJ8ujswIB/KEsVfwgr/xp0+R/V5TmciLller62ac4tbG9U7tEDvfyJ1QFfhsSDOjFr+grf27DomAWUfuESsoR27h10LVvEOV1kNAYBj4vHrvQg7eTLAifTOHObKGXj+NHtbBc2oPP0wrWx49esc9FfLLyAg1UAiCkNpMhVX5iguHuuX4iAb8ONctpIx8lMgkR0HxlB9pism5pEhdbuv36Lhzm/asrLNz4iZ5/xvmzpBFUYX5T2RD+kupif8vsICCgYyWMT9RhCXJRDEf3taCakjvi1YRMd2TB+4NkUWvRQAu0377yGyBX+EaPJ2NAo0E9lj2vmkMxE+e7PWENWjI5pMCZnGf3vI252i/91zFS4LTclG954ZdDkbHmMubiKBPwe/zDyUDzx8l6bSFEzmfhDCSW8uVdGJtpXLIa73drEJQZCmSVsxwtNsSzYSnWsSKZo7E3Gebv+wq/tmffF/rknZ7hI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9422.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(19092799006)(11063799006)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vX6RPp1HZzKA2vsusFG7bE6hJ1n5XVSVSIHUgE/X3TvVSEXSHVt8BGuv6laB?=
 =?us-ascii?Q?fhKQMHz1iYawEGXTmZkX0eeY+yeUN8Qx9Y5xE76wQyR0hu44sVIA99D/VznD?=
 =?us-ascii?Q?06tm42sxNrdM85J01KXsiYnD9O13LfYvxIxpBV7b4GmcAj/FX6LYVavK8Nh/?=
 =?us-ascii?Q?qWX9tIFze8A3wlIHov1C2cAd8E/pGCEq5EkdWqhu94oYtm9J+4p7xw+T7XiX?=
 =?us-ascii?Q?TnnNUvgzzBuElQOZ0as67PDSwqQUl9UL5uREI33IgEKOpT2iyUfaB7G9Ff6P?=
 =?us-ascii?Q?eHWJVi46pyiu0EsWS2RtPuBAMdiOUC8pc8H7+6k3PCqzmi+Gak81VeDUJkpo?=
 =?us-ascii?Q?2oEeJHNzODSzsxAJUZZZhWH+pjq4dHYwX+toUSQTFc/lWs7j6LNlzUfVDSnh?=
 =?us-ascii?Q?WagFjyHaRtUBmIYJmhTZnk5YL0fqX+mRe4dcMYXs5W0onC/NMJ2hUv3hgzFh?=
 =?us-ascii?Q?7JPpbz3hG5SaHk/xZFPW/oRW2Ar5RsuOUUko01D9DDBF+P/BmKTmI+BpIeGZ?=
 =?us-ascii?Q?g6pfjiAZ1FkiRTfhNQG3LDEwZliP9RvlAaCBfBmdBa7gDAc+9yH4nXWFV+FD?=
 =?us-ascii?Q?iWKL2vOLGGchdLwOqCbOlwbNhlAP+THD+uHHCzEEo4KZhwegjHwYVW/+36Vn?=
 =?us-ascii?Q?/xQppVMmmy57JPwKb6onYKBAckF5HT12kUl16265dobXx/6cQAVGo9vmoMlN?=
 =?us-ascii?Q?Hduv5CW5YbLA0tBBejgFqVutG9KqsJBFixyWchsW4lIs3jjmJokIpiGsvZb1?=
 =?us-ascii?Q?qqQbNhe6OsmAzbhwHmc8zrpvmTZB2nP8iJRt2P2WoFrfcPlep95DGVVOmGGg?=
 =?us-ascii?Q?o1MOym3UJVxWIuFLkXbeU2HEFUl979Tog/a+TDKxH/LeoOBMz8L9XKS3KplI?=
 =?us-ascii?Q?b3inomflEt8MRaUAUrMZfQKCv/5tR+oSz6pUIO36uehNuzcSKRRpQs3eTDnu?=
 =?us-ascii?Q?Xg84frs9CUTEZ4ylRLCSq+LeQtXj/BAYosjPsjpIhGMRSTIxuGNL3dP6cXIf?=
 =?us-ascii?Q?+Giq3vQVJBRA3FWcfNrfqogdtRdF5HxVWBJRL6jSJDTXdF6Gp3nLDtRS3U14?=
 =?us-ascii?Q?q8IGkE+M2lLFezzcfcmKzi5FcHOCHKjPm560w0s30SZP1Se5pJLbrPfd3X7j?=
 =?us-ascii?Q?x24o/5MUupzNaBimUg8F3M5zdTSbDN0hv4WCG73pXyPAXaxa00rDhsF4gIw1?=
 =?us-ascii?Q?V5/l9OUoqfDH33jne1CzHTLMMuFQ+Mqetd5yhNDcDi1lVg3HP44bLBQQzzgF?=
 =?us-ascii?Q?Yrrp+aGXCkzegmbUfeQ42TQZDVoQZHsqLB/txED7dyfzpPk5D9BdHChPBsW6?=
 =?us-ascii?Q?1+1KKC6JLJmoLVZsJmdWcpymuaYkVHAOKcvVBrAuaAkbMYOzvonNlP3Luvgg?=
 =?us-ascii?Q?Sh7DCpgtIBIfhjmnDHZobPAd1pSYFlq1LdST31ckzQAWVXQpz8YXXA8aADLb?=
 =?us-ascii?Q?DBJ0SAX872MET1KXpZCTBrb+gOZ2gIig/SGr08LSHs7ZYYzgzvPPDmbIaN32?=
 =?us-ascii?Q?tPnnP4P+Ay6LDIBFmlZJk4QoOM83/Qc+4/gPjA5+zwl/XKDzrCKJ7aBeutA+?=
 =?us-ascii?Q?CPeSHHvX2TNQNbCUJ9b2AmRakwbyBS645Ammyjj2Jvu4+IYocsBjGPCNXlvp?=
 =?us-ascii?Q?eZEa5kEg/Gr7ZJJSt2XC/PXwBPZU5+7QgzPzTsLJzfATD5F69seOVQRsZBFx?=
 =?us-ascii?Q?0WH3UtJ+A/tbC7nhoSiobd1K//f50E9LzSTdlhl1qh7I60sqGC4sm/ShusUc?=
 =?us-ascii?Q?lF/H+VF8HaoymCzDd4BRx2RZ9ygQVHExVCToBiYo1zuXq3/zpVPc?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa0adc9e-aa78-457f-0162-08deed52eae7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9422.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 09:22:32.0533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fOJpURPQE1iCC9ETQTr0Ho+e4A2YQsbbsIKaDt7rNMkh/GVJvWIwYERLapnKgAiNBN4XB0QrBQHAfRR17U41xoy73UCFMfkCwgtvPhKW8rh0MCunknbERsQYIpgTnQEX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8353

On Tue, Jul 21, 2026 at 02:47:49PM +0800, Can Peng wrote:
> fsl_samsung_hdmi_phy_probe() takes a runtime PM reference, marks the
> device active and enables runtime PM before registering the PHY clock.
> If phy_clk_register() fails, probe returns without dropping the runtime
> PM reference or disabling runtime PM.
> 
> The remove callback only unregisters the clock provider, so runtime PM
> is also left enabled after a successful probe followed by driver unbind.
> 
> Check pm_runtime_set_active(), use devm_pm_runtime_enable() so runtime
> PM is disabled automatically, and drop the initial noresume reference
> on PM setup and clock registration failures.
> 
> Fixes: 6ad082bee902 ("phy: freescale: add Samsung HDMI PHY")
> Cc: stable@vger.kernel.org
> Signed-off-by: Can Peng <pengcan@kylinos.cn>
> ---
>  drivers/phy/freescale/phy-fsl-samsung-hdmi.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> index d010fec15671..e7af4f9c7b20 100644
> --- a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> +++ b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> @@ -665,20 +665,26 @@ static int fsl_samsung_hdmi_phy_probe(struct platform_device *pdev)
>  				     "failed to get ref clk\n");
>  
>  	pm_runtime_get_noresume(phy->dev);
> -	pm_runtime_set_active(phy->dev);
> -	pm_runtime_enable(phy->dev);
> +	ret = pm_runtime_set_active(phy->dev);
> +	if (ret)
> +		goto pm_put_noidle;
> +
> +	ret = devm_pm_runtime_enable(phy->dev);
> +	if (ret)
> +		goto pm_put_noidle;
>  
>  	ret = phy_clk_register(phy);
>  	if (ret) {
>  		dev_err(&pdev->dev, "register clk failed\n");
> -		goto register_clk_failed;
> +		goto pm_put_noidle;
>  	}
>  
>  	pm_runtime_put(phy->dev);
>  
>  	return 0;
>  
> -register_clk_failed:
> +pm_put_noidle:
> +	pm_runtime_put_noidle(phy->dev);
>  	return ret;
>  }

If the probe() fails, clk "apb" will be disabled twice:

  devm_clk_get_enabled(phy->dev, "apb");
  devm_pm_runtime_enable(phy->dev);

  ...

  1. undo devm_pm_ ...
  pm_runtime_disable_action();
    pm_runtime_dont_use_autosuspend();
      ...
      fsl_samsung_hdmi_phy_suspend()
        clk_disable_unprepare()

  2. undo devm_clk_ ...
  clk_disable_unprepare()

>  
> -- 
> 2.53.0
> 
