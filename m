Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013025.outbound.protection.outlook.com [40.107.162.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23E536E467;
	Wed, 30 Sep 2026 20:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790800534; cv=fail; b=joNFI8pF8w2tDVcY0+lEH1/mxQx7You3kptEeensiU+Qa+N1iAx+1a9Vp6D9aUoNHH33rXXIhTEqW5sEeQxElWgDd4lM9TLKkY/PL11TIi+SD+c35XAF1NK/rGF6EE08cpbEdfRI/nLwRupCdOVbH5s6mDtT/FEKGr3/QbWlyOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790800534; c=relaxed/simple;
	bh=lW8VUNckLA/stk/7BPY6+WLOO682BTcRxfHEzdo1r3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gF7MPl07HfebO/Yaxv0+aUOnPV5VzJFJl8n5yuSXu3lq1a4ho27TKtJ6G0zi8Ds5pd0EfRbss1T9LsSMULsPejW3fjslY8vvGeu7zr16lEQPmGy2FXR9Coq7vHcPC2TTAtk2UPhgjfY8BQ2MmU/p1YkRsMB7b3tUgp2MwZWipzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=SPwAiV9D; arc=fail smtp.client-ip=40.107.162.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="SPwAiV9D"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y8ZjRalQQW/bLxRY8jf5Xstrd4vfGF0e5iyHYKLh58GW6nnT9szuQzPsQboatPS884nIQgB8RH4EB2gpA/EI0gq6b+TnpTWIerXqBuP40BU3MCExDRdAhRCaFRpe4eGOLLBImoGalydUioAKf+bD5XqTcbUhgdcBev6MvZPBN9Zul29afXs9n9qf1V0+RTek6MjYIUL+r1tkFXXzQDGO/ejyoZEXaBQQqxChxGM7Mto53j42J61elBgB/n7N0pBC/D+9ql+K/XDe03pDGklQR0za1Q1Vi/NbAcWtgTRQm8T2+DnRoh3OLjr3BD58n8JvQFENSEAgcQ14II8Ts5l+5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bs9WTJwhzmdnyybDnw4OstqPb4QQp459y8FVr36TjOY=;
 b=HX0FCk8GrhrtUTtU+npwdMKqoWYxDiaqmbkD1Xt5BkSEMQYg6Ofmllery9qJjOUBFFeTvgjIR4gp+vFBuOUueLmoCJyRmY8ihVi/NOudaxNfoBpCmU/minzFS3Tdi0avoeArCWJWyGa6kmpH+RmUM7SuIm0cJce0QpPBrpHvVjR4qsrHBEUcjLh64pp3cOAvmCG/0QjV8zlqNl2eyIvlOBDCOO7/619drG/iu6ODDGiZN7asNhDeiKI119YzzxMqartRjbNu+Sb5EPVAheWLd1csugRSjE2Z56XcHViTDJ8xLNR8Dex5P06XlMT+OvQEajq0tixdu02vGVkDMXfwVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bs9WTJwhzmdnyybDnw4OstqPb4QQp459y8FVr36TjOY=;
 b=SPwAiV9DD34USp+Xy9xQoNk+uivGVTBj5KUyoiVKcwKV2zL6JeRPs7NISd/Ka5aVYqXR2XBcNwjNfrGsBgLoJEbsnnenKTGyLfjljxogzRqEF6kg1cwfscRTPZCk1PYkBJ4ns8qMCtUtNQDNbSUsR+OOI3LmR+yqPZ0tIFraMtmFeeLuZIvehXcUGMaolUdUWYADKQO9KdnTgsKA6Tz9aPDJ41qipZoCKqin2vC5KOFgnNh4C++/F57li3dvNnOLnO6gt3f3Cwy6MeR4FPagYBxiGOzixKQPycJObAiR3LTjp0A4MX2Bf5O2ZOLq5iU1ugLfbftHtisx4rplvIO/nA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by ZR6PR04MB587880.eurprd04.prod.outlook.com (2603:10a6:910:e5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 20:35:29 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 20:35:29 +0000
Date: Wed, 30 Sep 2026 16:35:20 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Sinan Kaya <okaya@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] dmaengine: qcom: hidma_mgmt: fix autosuspend cleanup on
 probe failure
Message-ID: <ar1yiPC1pxx8H974@lizhi-Precision-Tower-5810>
References: <20260808112043.2781244-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260808112043.2781244-1-lgs201920130244@gmail.com>
X-ClientProxiedBy: CYZPR19CA0001.namprd19.prod.outlook.com
 (2603:10b6:930:8e::17) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|ZR6PR04MB587880:EE_
X-MS-Office365-Filtering-Correlation-Id: e47c48a8-cfcd-45ed-1e3b-08df1f325d81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|19092799006|7416014|376014|366016|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	sE25pLuFY1V5vozNLFvdxfrvJWAHWhf85rzr7VmEppmbgN7z9EH72wN3Pc7aoK2kd89DLP9np1Gtw2/gqSYzBflPtLX/EI7q9Q8+6RiNFXt1KE+SGXk/Y6UK9ndI32NWDHdFpmTmLTi5tAV0dix50nd6YUenpSgYXF/z24k54gYQ1ZceUtqMPujd+s94D50GGp18puubd8nB3NvSJq01+LQKyQlvJ5a0hiqbh0uDAO6CN1C//B76PmfLxGJKfQJ81voqFqqs+COI/pG9sR3NeJnXHGC3PYJdD9lwOdnvyOENvkKLX9m9TEJNKnJDPtRq1OjBt1Xb0y94H5fqDSf3clW1rL5CcTFczF9acMM4/Od15uCLEdhZNps5cRw+VCB7x8bLlWdJLXBZhm5t0pl5d9/mjgDhOw4siQrCQYvWelxanSyV4hSPFT8hKsy0eFDcYbxN/Xb3MgwKcy1j1HDkbQY0WR4rS7ZOaLaJJry9mUjUV71qywDAvvY5OxiP9Y0o9ReBpZ7X2SLrphtjEwU8W2K36k6V8/ydvMSPb4F8z3J5fpYzO0Q87yot4Oktc/HlnQZXA6mhHTVJXgEIGa7uPfcaawPDhFqw2pZYtMIjleAh7B0u5pvVuXn6kf4bUohTvU97qYqTM4wPb1BDwyEyaZWWTPQzsvabtMBN6eq3w00=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(19092799006)(7416014)(376014)(366016)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Nq098Su9yg19vF1pUVyXA8feMy5Z2YVR2EEE6bNdWGsI6KYL6D3FJvsWcssj?=
 =?us-ascii?Q?GXbl6aye19zGcQ4NCQ6UpGxNAalVl87dDYp9txIH1R962jCbnbtpICJowj9t?=
 =?us-ascii?Q?NKdtl6mYR1iXgErBUPDxNNows5H+hRlJxpI/FMc4NNLOZJtMoGW4tKpjy1Zs?=
 =?us-ascii?Q?lu7gIYcg9Kv1HCR8OWETFSoZGi442SQvYI8k/w0AIS5OhptBoFS1/ILdxD8/?=
 =?us-ascii?Q?fLm/ii3qyb6BbNfOnmLnG8qrxbVs0cTsav31ONqtlJfGWL0U1+nh94BoZAkJ?=
 =?us-ascii?Q?x0RsBH8v7SDalXvWg0ypGKWo8RZL4YOQJ6Kb8fJuoRh7iwMJ7/nLoXYWWJ4L?=
 =?us-ascii?Q?P/qs59I2UU7EkNSAojIJjrBXC/RUsJmdTaorWSYg6QXNI809OgqukvQC0MLH?=
 =?us-ascii?Q?OG5CgfJofUKQJEPhxB3aT4xQV+jCYwMOwBQjL5NlOQLq9trvexKoXJAAu/jt?=
 =?us-ascii?Q?Pol5J7bnjBZuFCPbpTgYVp5sfVjuGyO8cBHIoBzyXPV8iZdL5/Ae49BR5wEm?=
 =?us-ascii?Q?7OTvnts6HSsUVu+xBagd9tth9xXecoyP8h7g3oMLYPIsd69JkZoeVWyREJVN?=
 =?us-ascii?Q?uoAxn4I6yiTZ/66Dz7qXHIM1/UDCNbbB0jU4Ch29i+yXn9TmU9xiVRwJVxqd?=
 =?us-ascii?Q?42PjKXa25IjD/dLgDS2AEWQjV71UMD9UPdG8igXAGo4/rOLKqRJy/r2+Fvul?=
 =?us-ascii?Q?VE/JmogoWDeyv3YqhXXUB2pXVDGeM1Ga2GXvHuGkaE6Nn3YY8AwlQSz39URo?=
 =?us-ascii?Q?wbfVOiq5SOhuIwGM0vxgd2hRmeCtbsqjn8IiYMYHee04OWU19UnSiA+RmbOR?=
 =?us-ascii?Q?EXah5o6DZiwF+iEERVuKvFy/5FBnIcmcNSEhi7Hk1g3zD0n0Hgllwuv1kX3Z?=
 =?us-ascii?Q?/LyRyrxx4W+F8pnd/wk3Bk417nhsTrEgypDGPYHXetI1ddg0qjfpOfx/O2wn?=
 =?us-ascii?Q?zynZoL+NKtRxY+hoILfVyNtP0D7K3q1KreLRIVgzq9pGWFmO/pQpBO3Ogons?=
 =?us-ascii?Q?EsPWGVG498aBIgUd5642QchQm6K9EAUMK9qR+Cr8cRnKU68BlkvwD2B4H3Wi?=
 =?us-ascii?Q?+NhUzl7dofebyEwIRcEfGG+9wZdghW3tKnXB188tdh5Ghv3EVVr7cFr0r5mn?=
 =?us-ascii?Q?kTEqu1QTVr6N4ODPVKKJUQnW/w1sSNMEEv8mSXW5JStZHNrWItf4a17Dp05z?=
 =?us-ascii?Q?vjwweJ11LsnyKeEVi1GPdZIWcLcUR7Puwnf8kG8ANbCYgX9vrTnvRw8tu2Bv?=
 =?us-ascii?Q?Y4DYneAUKJcMoctgFYyFk3LJPUFkkGryq64DVfvcvwGOzV6podq9KN3zBhJ2?=
 =?us-ascii?Q?Z0MkE5Y7fhMK8/VpU8Pgr6HDoyp5qZf8kDCMwkZHUAIQf+Ptf77mQJWL53Cw?=
 =?us-ascii?Q?tL6KhSF4PjjktbduF7w0NlXxhhkndknUZGoYx78+k8na91NWYi9+czcEU4oB?=
 =?us-ascii?Q?CLHUkP8N/8CljqVkLSW9JvQ2VqlBplMXUQC3Ci+3P6yvk/+8EJSJk8DcyZci?=
 =?us-ascii?Q?5y+UuzNHV6VHiYuLaQhv3LC52LkKlvFVhwYQ6nl6kVhsrgNi2eFWDOoD4Lde?=
 =?us-ascii?Q?uVwUOoflYh7bjcejJmuFYlk21XvnfyzqS0OtwFp8Ut0ntDvN1Ebnn6giH9JM?=
 =?us-ascii?Q?F92+B6+gQd8fpPT8lovpdIiraMIOTNIGkSV2LTkQpyN0gWCXulH7LuilZCUT?=
 =?us-ascii?Q?pAWDTW2xARLUNLHVlmeaN9Q2k4f43sWDkokZ/rl89hLI/vFyi/39dhD7oMDO?=
 =?us-ascii?Q?IP0cXyKw3tZjtx+9c15/GWE5b9bqHvQ1QzdlPtV8k8BJWfODJnmJ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e47c48a8-cfcd-45ed-1e3b-08df1f325d81
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 20:35:29.2178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E1RBvbUkbg1lRlTiM67T/0DFNjgy9OrYVNUNae9twAPncZl42sBGUaW5UNmYXfjylS5ZM3YqW+ZBJZOc/mP8O3kq43IHqJeoUw+gWYgmHj2Q1BkuptAXEXi4tIU/mpGP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR6PR04MB587880

On Sat, Aug 08, 2026 at 07:20:43PM +0800, Guangshuo Li wrote:
> hidma_mgmt_probe() calls pm_runtime_use_autosuspend(), but its failure
> path does not call the matching pm_runtime_dont_use_autosuspend()
> before disabling runtime PM.
>
> If the autosuspend delay is set to a negative value while autosuspend
> is enabled, the runtime PM core increments usage_count to prevent
> runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
> during cleanup, this reference is not dropped and usage_count remains
> unbalanced.
>
> Add the missing pm_runtime_dont_use_autosuspend() call to the probe
> failure path before disabling runtime PM.
>
> This issue was found by manual code inspection.

Your descripption doesn't match your patch. You change change pm_runtime_enable()
to devm_pm_runtime_enable()

Frank

>
> Fixes: 7f8f209fd6e0 ("dmaengine: add Qualcomm Technologies HIDMA management driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/dma/qcom/hidma_mgmt.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/dma/qcom/hidma_mgmt.c b/drivers/dma/qcom/hidma_mgmt.c
> index 4805ce390ffa..470c88f36d25 100644
> --- a/drivers/dma/qcom/hidma_mgmt.c
> +++ b/drivers/dma/qcom/hidma_mgmt.c
> @@ -168,7 +168,11 @@ static int hidma_mgmt_probe(struct platform_device *pdev)
>  	pm_runtime_set_autosuspend_delay(&pdev->dev, HIDMA_AUTOSUSPEND_TIMEOUT);
>  	pm_runtime_use_autosuspend(&pdev->dev);
>  	pm_runtime_set_active(&pdev->dev);
> -	pm_runtime_enable(&pdev->dev);
> +
> +	rc = devm_pm_runtime_enable(&pdev->dev);
> +	if (rc)
> +		return rc;
> +
>  	pm_runtime_get_sync(&pdev->dev);
>
>  	virtaddr = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
> @@ -310,7 +314,6 @@ static int hidma_mgmt_probe(struct platform_device *pdev)
>  	return 0;
>  out:
>  	pm_runtime_put_sync_suspend(&pdev->dev);
> -	pm_runtime_disable(&pdev->dev);
>  	return rc;
>  }
>
> --
> 2.43.0
>
