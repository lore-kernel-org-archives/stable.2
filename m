Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012033.outbound.protection.outlook.com [52.101.66.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE5035E1AD;
	Fri, 11 Sep 2026 20:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789160207; cv=fail; b=laQohqQzMt+uUZ9GldvK5/aPhMstJgAjQEJOicyATmqrHKIKrszVdAz2O+SzhIDetGBXbY85NuBz/tEtiwTt2UozQyRT/Ly1VWLtQse19nzXjV3uzK23ysXoCSTHwdYqDlupbYqobQbUt3oggHTAlooEuygVZSM8PCdprpHrb94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789160207; c=relaxed/simple;
	bh=1pCzwJZVXQQr81glOc72o6tR8Cj6K1vz9EQdX+fWu/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=riojnexGM+1Am8moLXAiNMYfQZPLiHxkarPti5O8Q2fX9fiz7FVZ5SkSKBkjZxxAZzl6vmVcV5Ft6OpMotKqB2q6a1zJ2N//jwu7NL/u4LL60Hb6y2rMhNA6K0SLKWkfUPdiGuR0tyGHsCYonz1qltVYducnM6bxkWxPFuCfAbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ERhMxtU+; arc=fail smtp.client-ip=52.101.66.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ERhMxtU+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T/Aa6qNHB2NCLpaD2P4pP3uej6KqdM5bxD++MeZo82oyjk064bBoVc3jkh35gmqWNi+R6IIBOu3n9Mmn67N6ozzbybGfVIPqs2YC7dgmk3jLWVbQ+uQr0nynH14disjAkMbx8GTOvok8wrszZYWapDKVolsbcs5BoIjIKs/BJD+BAWm04CHuZlNCRQv9u8L714hG+D6pBdv96RcL264OOaEjQbtaqKYTd6d2LqVUzYwVfIi9nGbLvW3LSwtSgTV69GW8kGrmJMVE8jeHUMWk+ZGYGe4u10rvxOWIKwzcUNV8COVO1ebz7qI65gZH3iSELaqsE7w7pRk9k7B2BAaoGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZsvxhL5QHRNg2DznB+jC/fE2X+6cscSUNYndryGnZqM=;
 b=Q9Wl7J0/jb6PAFZk4QkHPVs4H3Ggfy2rDi8pZs+/ziZZCyLcIE+lBiBdjNkBsngI6WQ+dSyKoNJ26cQ/e4IeKLvEsHv6z+Q5abCodSNzczBZ+2wXUJWDY6hPvPnFdCcSsLoUb0yYlmJvULXzslyfUzUGizxgJhkauBXj0vKMaX+kYkzKs0j6UDNFv/1k4xeLOy9DpDY+hIKYiBw6Xo/YBk9zwbyJPe2/XB559om3VY2a+SS/virVuTapCzuN2gWZXvzVLKK99LW9BRU52JXCUIjsD+ZVr/HRiI6ewhFhiN610VJdB9mP2xPB6NOKvqwxchuu75vatmkEkQoPK25jhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZsvxhL5QHRNg2DznB+jC/fE2X+6cscSUNYndryGnZqM=;
 b=ERhMxtU+rimng2HsAPFJza0z4CG9l5DjkrEr1dMXMpP5TK8Zu432Th/IJMq8EW2pc3FS0CVAd81o9Avm13+xOmr1moXVJVIYkGZ+Um8ir27gIOkV6dXuwB0durFYN2Ccg0SYejKUWov9T+YVEj7Srsd9DAKoEmhIrwDaNDD75yzZI5pOdWjKF4/lNJB7W1t2S5th75uR+aWoOztgdXeo75P9DoSxQRS1sGNZnJs0hJHjOU3IlVVcrRQvIquIia5FVn6zpkrlCRSIaZtBhV1ncToXyBvZbLaO+C89hRrOrQ1fiYd2/NZ57X26Aa570bPmHO26759fJVC972f3vRiAxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI2PR04MB10884.eurprd04.prod.outlook.com (2603:10a6:800:270::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 20:56:39 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 20:56:39 +0000
Date: Fri, 11 Sep 2026 16:56:27 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Robert Foss <rfoss@kernel.org>,
	Todor Tomov <todor.too@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
	Bryan O'Donoghue <bod@kernel.org>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Felipe Balbi <balbi@ti.com>, linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	linux-phy@lists.infradead.org,
	Krzysztof Kozlowski <krzk@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v16 1/5] phy: core: Fix use-after-free in phy_get paths
Message-ID: <aqRq-xZRIDL1apdI@lizhi-Precision-Tower-5810>
References: <20260906-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v16-0-f7bd68b5369f@linaro.org>
 <20260906-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v16-1-f7bd68b5369f@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260906-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v16-1-f7bd68b5369f@linaro.org>
X-ClientProxiedBy: PH0PR07CA0093.namprd07.prod.outlook.com
 (2603:10b6:510:4::8) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI2PR04MB10884:EE_
X-MS-Office365-Filtering-Correlation-Id: 083a9423-951f-44e0-2c1d-08df10472cc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|19092799006|376014|7416014|18002099003|22082099003|10067099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	W+R981X1KHJ8wIx8j9kWemXLr3rBMI/TaFCmrIQWFkvXxK9LvQZsW0dWEDFZLSxEAkH1paztb/RqlCOjp7aOzhtNRVfhA801Ou33/N90r9BM10urdQo0H30JW3bKhcM9ohmRs+TcQQRyIEP1q2n6++oT3RyYw7YeGh058Be4NGqE0MPDj5eRmWdDjHT+h3+dpkgTittEJWd6LJI0SxdI1TdyUWjfx+PYo5wnYQwnIefkoqmmzsL03Cqg6QTPzwI5zT+ci4tPBfwbsCnMFcBAI1I09k8036/70+AiwHBSUkXPte2HceS5XwITbhYXJGaDaB/hN4e+G0QD5snC2L9XgSes76aYzOEYw7yquy4JD4ZoEHs+qZnyYJnIXoYXhpSmmn4U9AsfIREtgrr2zs2CYbeHuWgxVMqkTmdV/kGbv+g7UBiLzPwMYN2MerkXCBaGVChvy2ftUKOJNwq5I95SkVjPTS12m8203z+TxoLWqgjyR315Sjf8L541g+r4qCpvMO6ka1WfgV7p1a+mLXXzJfWgiHlYI8Uk97RomZb+xY2UxC0GTGnSxtMXRTXCchjOz4jNz/e23X6CD4Wh+IahR8zqa2VDo83xKOZkIPSXepd+rC5Ql7oNBJJB9xfVrDlIELLGTbjZUtwSA64AyAuROZbozm2NHiTMCfESlU6gw9E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(19092799006)(376014)(7416014)(18002099003)(22082099003)(10067099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UAPVGsKJEh/7r6Rz0Fy5A+4KVuTk+pSeVsgIHWfKMnrX40QjZvHS//a8k8zu?=
 =?us-ascii?Q?ebldOy+G5aimxphhgQvoNaKcxVgYJv4Aoxavb/nb5GPzZmOfNSOLWOrwUJEx?=
 =?us-ascii?Q?0MxlfEaE38YK8o0ob4woic8ZArIroKVQo5u8m2SO4b3CraluNLURBpN52rmj?=
 =?us-ascii?Q?BTdnI0JfoiVV65JBlbh4Tjpw+r9b83Gq5WR/BgT2S5jRslkwR5uLnPgaVEx8?=
 =?us-ascii?Q?RrZ7FOopWBvxr5nGnxBoCQScStBFr9C8+Y5N8W8hqLchtQ2tJCEgnA4gJOUn?=
 =?us-ascii?Q?vEEz4EMTxrinIvp5SAnzJMuMpDoT3xKPalvvKgMEPwNEC5b6c8O2PuR2dkwa?=
 =?us-ascii?Q?O0o1CznHQngr4e+nNAh66VLmYP8cpu2K8CMc1/JJa3Pagg6+VnkmdmMfvBoL?=
 =?us-ascii?Q?2UODtKwm+R5Ad1IrKkchj0m0lU+V55EYrwfD6xFl0017BcRWGDfmVJxtwusq?=
 =?us-ascii?Q?8PY8iOgjcCz/+nOAwUPbDG0d2Xt1eIepA76jA6XYnmPvBxAgPuIDKrH/ZxoY?=
 =?us-ascii?Q?IJkOE78g3L70TbEm4ZQk5OwAjLwlzlTSucFUZuz1F5rvKWr5YEsUc9+GuTGK?=
 =?us-ascii?Q?hvoSAz2rZ3Hr4b6K1+T9qlTtlPyjGsct+zL3khjPnOWSXZNp+ctFof3LTsXI?=
 =?us-ascii?Q?z95IwsFmLDXckZiyG54aoag6/sK7YmrhfjxbfZQGi3QBirX9m6zUMFjs02WH?=
 =?us-ascii?Q?BJ//vZLSphnwPPtofUu039dfJbtT074RzdOReRJi9xM8lMynViaJQTpfW4wr?=
 =?us-ascii?Q?w7HD7jGXAdHHkp53XJnTUw/3FliH7Q/zAVfhjztCG0mZhxNxWDPKpefplQ98?=
 =?us-ascii?Q?ZygqUX6VyLDd+/REOV31fQBf45QaErwfGAeiOgIMebDOvTsPn1xB1wDWqhQl?=
 =?us-ascii?Q?D6EROCkeeFgVmn9UVVdyb0ht7zfKd/lR/Hp4bu3b3E4+1cvPR7BLbya6NOtG?=
 =?us-ascii?Q?NXqrf/Rpwpds+OY+dkOlFSKECcXqDTmpz0Ner/KKcfoZ+N3Ar6XmrNERHg7q?=
 =?us-ascii?Q?n52mmnSo4sEjkJns82MzbdGC9O/Oja93BjZvQrNgSBkKWQIi0C2UuPFw0fKy?=
 =?us-ascii?Q?y+7enasDWFMD8LKwDIY2+lRndVSiLFKvc/lCsGkbLOCECcupMr+enw16ipkD?=
 =?us-ascii?Q?d3WrvP8Upr5Qs2PvJMFPWzeRR30FZlP9Ob9holIpr+xBcZOilHoso68czK5o?=
 =?us-ascii?Q?r1QtQGAMTUqITGeRaE7RlAb70UWWeXXtGA8u7fislpij6SpUaKmO1GPLzcYV?=
 =?us-ascii?Q?Jc6+NF20bc3jjaOoFYbpFvsHLfdmJ4L864INrM4zjw1Yjtst0yHJclugymY0?=
 =?us-ascii?Q?L/L2Qv38aQWw7B3Ts/zlEbCtay0SM2vgle5BWcabPxoZPPEoULwGOYG8LaY6?=
 =?us-ascii?Q?zwtHjVsN+1v34yKUDRKkFULKACDw0wGsRmLohxyQTMP6sXELR2ydFgXZMVAc?=
 =?us-ascii?Q?RsNkDKzsnwEEO3M4aGcaknfFfP+PF2gufgCwF8AhY1YvuSe7mxDcmAsPD476?=
 =?us-ascii?Q?gyEnia8UKiJyFFAzxakNOUzns5cezMJfC1+zhK20BQg36VKm69C//VGiZt8H?=
 =?us-ascii?Q?Fkwx3Mu2p86Wj3jrCkdkNna2Ixc5GWeJrOuajrl3t0f5djKeQbFFMs9AF0Ss?=
 =?us-ascii?Q?PR5vpYegxSUHyiSJknN2nA6EHO2y0AaBsEi/NHgV9ptgVtMvfAtx0lrI6v+0?=
 =?us-ascii?Q?P5sJxPwk5m6zxCctxHxlvYLs7yjfe07xtMVSorbCKitTXs8UMQspj/bjmpXg?=
 =?us-ascii?Q?tNryzj0W70cl3AerII3E9Aj9/1u52uIFmKmusEV3fr6FxxfOBDxe?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 083a9423-951f-44e0-2c1d-08df10472cc5
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 20:56:39.1595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gr8yV+jjF5ScTAbC6fplsEgULBiQ6d9wYncIOtV+AkhDGkhd/YWWoy1GSeWGYzOSmw/73kf4tk7YXJTcJM4O9f57gPnmaReYqu1VY+KBsjiAuNdWKvNzXyO4YT5nx3Dy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10884

On Sun, Sep 06, 2026 at 12:52:02PM +0100, Bryan O'Donoghue wrote:

suggested subject:

phy: core: use phy_provider_mutex protect between _of_phy_get and try_module_get()

> Sashiko asked during a patch review if the existing usage pattern had a
> race condition; specifically in of_phy_get() if it was possible between
> returning from _of_phy_get() and running try_module_get() that a module
> might be unbound leading to use-after-free.
>
> Looking at the code this appears to be so, there is no linkage between the
> phy and module under a synchronisation primitive.
>
> Using the phy_provider_mutex in phy_get() will ensure there is a link between
> the returned phy pointer and the module_get() bumping the module reference
> count.
>
> Amend phy_get(), of_phy_get() and devm_of_phy_get_by_index() to fix the
> same usage pattern.
>
> phy_provider_unregister() must take the phy_provider_mutex so amending
> phy_get()/of_phy_get() to take that same mutex guarantees there is no
> use-after-free.
>
> Fixes: ff764963479a1 ("drivers: phy: add generic PHY framework")
> Cc: stable@vger.kernel.org
> Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
...
>
> @@ -678,15 +677,21 @@ struct phy *of_phy_get(struct device_node *np, const char *con_id)
>  	if (con_id)
>  		index = of_property_match_string(np, "phy-names", con_id);
>
> +	mutex_lock(&phy_provider_mutex);
> +
>  	phy = _of_phy_get(np, index);
>  	if (IS_ERR(phy))
> -		return phy;
> +		goto out_unlock;
>
> -	if (!try_module_get(phy->ops->owner))
> -		return ERR_PTR(-EPROBE_DEFER);
> +	if (!try_module_get(phy->ops->owner)) {
> +		phy = ERR_PTR(-EPROBE_DEFER);
> +		goto out_unlock;
> +	}

why no use auto cleanup guard() for mutex lock?

Frank

>
>  	get_device(&phy->dev);
>
> +out_unlock:
> +	mutex_unlock(&phy_provider_mutex);
>  	return phy;
>  }
>  EXPORT_SYMBOL_GPL(of_phy_get);
> @@ -786,6 +791,7 @@ struct phy *phy_get(struct device *dev, const char *string)
>  	struct phy *phy;
>  	struct device_link *link;
>
> +	mutex_lock(&phy_provider_mutex);
>  	if (dev->of_node) {
>  		if (string)
>  			index = of_property_match_string(dev->of_node, "phy-names",
> @@ -796,15 +802,18 @@ struct phy *phy_get(struct device *dev, const char *string)
>  	} else {
>  		if (string == NULL) {
>  			dev_WARN(dev, "missing string\n");
> -			return ERR_PTR(-EINVAL);
> +			phy = ERR_PTR(-EINVAL);
> +			goto out_unlock;
>  		}
>  		phy = phy_find(dev, string);
>  	}
>  	if (IS_ERR(phy))
> -		return phy;
> +		goto out_unlock;
>
> -	if (!try_module_get(phy->ops->owner))
> -		return ERR_PTR(-EPROBE_DEFER);
> +	if (!try_module_get(phy->ops->owner)) {
> +		phy = ERR_PTR(-EPROBE_DEFER);
> +		goto out_unlock;
> +	}
>
>  	get_device(&phy->dev);
>
> @@ -813,6 +822,8 @@ struct phy *phy_get(struct device *dev, const char *string)
>  		dev_dbg(dev, "failed to create device link to %s\n",
>  			dev_name(phy->dev.parent));
>
> +out_unlock:
> +	mutex_unlock(&phy_provider_mutex);
>  	return phy;
>  }
>  EXPORT_SYMBOL_GPL(phy_get);
> @@ -961,15 +972,17 @@ struct phy *devm_of_phy_get_by_index(struct device *dev, struct device_node *np,
>  	if (!ptr)
>  		return ERR_PTR(-ENOMEM);
>
> +	mutex_lock(&phy_provider_mutex);
>  	phy = _of_phy_get(np, index);
>  	if (IS_ERR(phy)) {
>  		devres_free(ptr);
> -		return phy;
> +		goto out_unlock;
>  	}
>
>  	if (!try_module_get(phy->ops->owner)) {
>  		devres_free(ptr);
> -		return ERR_PTR(-EPROBE_DEFER);
> +		phy = ERR_PTR(-EPROBE_DEFER);
> +		goto out_unlock;
>  	}
>
>  	get_device(&phy->dev);
> @@ -982,6 +995,8 @@ struct phy *devm_of_phy_get_by_index(struct device *dev, struct device_node *np,
>  		dev_dbg(dev, "failed to create device link to %s\n",
>  			dev_name(phy->dev.parent));
>
> +out_unlock:
> +	mutex_unlock(&phy_provider_mutex);
>  	return phy;
>  }
>  EXPORT_SYMBOL_GPL(devm_of_phy_get_by_index);
>
> --
> 2.55.0
>
