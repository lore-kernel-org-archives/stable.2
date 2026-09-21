Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011014.outbound.protection.outlook.com [52.101.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31B82DAFA9;
	Mon, 21 Sep 2026 15:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790005540; cv=fail; b=nb9GqOUnItIV+jkYitZ3pt7+3CdoYOYjlZIqVEu7Z8rN32wMl+4+yyWAY0NRQZbUZfivkbfUH8yRX/2NOEs1RJxeX5QMVY2s/w5YB6RngXHwNIbNTxIK4Rt3ZFAhY+8AuuHlVB6PuKpr7dltAnMW4KYt8aTXDhLmx/kGHN2TFrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790005540; c=relaxed/simple;
	bh=NV00hHh2v6OMPfUFrS62U0eYz23CwlHiwWCkrMmPfr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iOjtH2DNy2Slo5Fsx/urD9prF703p5VE2qeTvV35udKZcqt8kr+laFQnAA4XH8Xeoed4yqEYbYnZgIRFIJZbo8DBQtavVjQlH+NVI8pFkHADPoBu2HTzHk27ieMwAMayNgUMx5JVw/9h9Qp0fm87h7z+VWXn23rAsRpMt75RfzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=G3ySTLue; arc=fail smtp.client-ip=52.101.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="G3ySTLue"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bHewaVZ6YmoItAFD+fxg/Z4aAJCbexAB+doefn6QabTBR9gE2Ec3uHWIa3cX6W7oY7NBP5Br0n9k/ThUFb6AyzYm0ycJSIQqbZqpN+7jthUP4AvqpqylLCZpwf18msP1FQeXHrjyArOGfGoGoLaqcIHZy6kiBXSPlMcNYZX6IkoW6kHPApiE0YksDmhaXr2h0ggU1KolNkW3qq0TrYzHFxWH26+9l+KA55zgwPX7a1carQN2dxJuQnEhKKAv0aXRduR/ZDPQU2uyM8PAqw/rP0HGnZ0Q5KJqrJCPktCIiw4dMKSRaHY6o8IAjkYs2FBWsj2oWEoLF7A3xvCxT9Bukw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oVYFq75MII8lMqQZ7dbmqHacuDdlu4aNpxhJ/aelGlk=;
 b=cCjTvW6b3/EO1XyMWRy4KPPFkxfhkTN9foEadXbRzVV7cn68C/4ef43W+HXQAN3ZsdMNaQQ6jbNpINaw+0f/aNwyzco7yz1zClOlKTSv6DkVcAf8tELiEQxO+nusbA8xBYg3olvDqrchS8L+HYdKxqQvxgEhnqZzmWiGb7ZdBy1Zud/WPNG4lB9PVpKoKj5Nr0I8Zen5qmPS7o5GqrgZzecQLG+SeTQ0G/N3Ei/rM2cmTQ8cFct+/N/KePMGLcOlKkv1cJbPS9jk8Uoco8bumhvUHlJUH2moYFYYx1RIoWB/PmqvC7JiCMJSB1m8oQhJVYPr1SsVXd3MCDTE71uFzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVYFq75MII8lMqQZ7dbmqHacuDdlu4aNpxhJ/aelGlk=;
 b=G3ySTLuew2e5AdwWj3+IldZZ6yifocK9FhQQAUnuwPHyg2h4z1SOCgx+xy5/gLPzyRVQCOaaveC/WUixdbu6fHZNdF4fNCSWUGBeuVsGwcDdfJAToc1XdvMaXbpO+SiGFWPQY6FigjKAgNFPeB8vJZC+quUgF76VG4YK0m762qiHf8nm9XoeNeO60H+GVL8j1OJwYS76uSpQI9SGBWzEy3YkQJqbsvHo+N0r0etry3JKY3/N8cF19fVZOIwlGDOyuVg6i5qDcVBmviZOVcCnePLJZNwngJFKFcvZFNVSmT7WrFeJdhROVLey58Qi52kMADX+1P3bpTQNTkLiLUoJmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by MMZPR04MB481271.eurprd04.prod.outlook.com (2603:10a6:190:28::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 15:45:35 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 15:45:34 +0000
Date: Mon, 21 Sep 2026 10:45:25 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Kees Cook <kees@kernel.org>, Peng Ma <peng.ma@nxp.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] dmaengine: fsl-dpaa2-qdma: fix ppriv memory leaks
Message-ID: <arFRFXaWdVKyMyDg@SMW015318>
References: <20260921111424.378477-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921111424.378477-1-lgs201920130244@gmail.com>
X-ClientProxiedBy: PH7P221CA0034.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:33c::11) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|MMZPR04MB481271:EE_
X-MS-Office365-Filtering-Correlation-Id: cff8330c-f921-4081-7e9d-08df17f75fdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|19092799006|1800799024|366016|376014|10067099003|56012099006|6133799003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	LI4h5XUSpw3MQOtexRdWKGRd2DbkjtRe67nSxDouqaAC9riWgMwJg+l7eIYFw3gaNjZiLkoagAaruEGMAx0mr4JS8DU4npkfJECBQn/57N2Oxs/fU/g1qjfC9izsFF/s9vmAOtKnnGIur45Ysz+ah24Ivvn09ogo3JQpbPXC/m4ghCLWdYbOiQyQ/SklLfCjeRpvCX08R7t2CYWC9CwZf1VkGiYLe1FPtRWx/CcZ/qYkRQ84zzyX8feUHPYLY08tRiLiFLj82qwmgxRvFEoKirh5l9j0YUDyYXd3b2w+Uy6CQk7kYQcchKFwgTMsOEmcHMEwYz2LGurl2NnmuYPTkPEhOOknIwLYv0EVh3N7P21mGeM01xfiMitBJre9psNJZg4UY9j6sbSic9aX5FRAQmwerxV/mQ+FHuEOjyPMSuiZOTXKqEk+TUvUEzEFHD03Mul/CtUtoFgBRcVghi02oywpOZ2ZWt4LWs58fg6V4y2FTlsNR2BiKX3wfiz9x7fktevBEm9O3cz6fTJxBeD6W9iIJOpopVist+vbDo3gcDoW1hSImJMl0D796Q4IhwTdhUPSbkRxI25zdxWOnX0Rf3bcQdOB4axHAX9NmmoX52/lqhVV2YYfOkTUzFJnx786Dggxv/S7WY3Ftnz6L3G2toNAApvss9wbS1U+wi60jM4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(1800799024)(366016)(376014)(10067099003)(56012099006)(6133799003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+VIh+ey8/d+AWH+bmLC55Ldmy7T1ZoIiJmsYwBig3a9RfKtMzwZhYKH/dG8C?=
 =?us-ascii?Q?o/5kqXYfcpCpIGoIhcMz/G2Or9ExgXSCFkiQLuFMhEr9FN9pPT9iLCf8UZNM?=
 =?us-ascii?Q?j82lDJJFRjrpXPtEGgnVp6xjETl4ucqlOSjkfLuNKNC8e8EMqWERH8tMFnHN?=
 =?us-ascii?Q?WOL1w6Q0rf7tsUol5X7fE4TUa+JIV+2+srYIHEx3yrm5pcfAVewkDiMpAJL8?=
 =?us-ascii?Q?jXirsV/hOC9nWd6twmw7N40pQLPkqmpxMqPbWZlGWNorto5QCI62dYP2BLMi?=
 =?us-ascii?Q?hCVxM48o1UVJvaub2riDLQqdbGYFFl6NgNoBRWat4qROIXkAkcDp4TUZII9I?=
 =?us-ascii?Q?EJ9xnZO54e6ZmCrFYKMbSzHUEUjZ+1Vc2KgLBOnX8UBf/7oZQSusJVIZ+ROU?=
 =?us-ascii?Q?/wwoxwXTIFWFr5qLIAda9NT3bbCMRGtjSibUm0H/Z+GEMBi0WYwnz8sepERL?=
 =?us-ascii?Q?FyLBgzroBTEk3spzIukmHXDvkNVAD9y2HX9QzGUYnSO0M59D+Dz2bbGer8IV?=
 =?us-ascii?Q?qa7SzlLJJmofYnjVFrkTD6rxjjsOCNHcEOLP+wH+v8KvPFUb5MvAdJhNsiAv?=
 =?us-ascii?Q?2U+QA4CY8S7/Kn+tASuEeoTwvTRdIdsDTpxoqj7P3c++jtNksGo5iKKeRoIW?=
 =?us-ascii?Q?BO/IkLBhU/DihC+42tCvIJzHrl5mz2Guk7oDTpAKdgXsMKcQr59oFKrSLCfN?=
 =?us-ascii?Q?y6/5RCF793BghAor/MBJZizIWljkquptCTkNI3uvzuJM8PojDmVA19s6p3hg?=
 =?us-ascii?Q?wmeIA4cQPhvxLHDz+gptEvA+ErFOc04++RuKVbd1gf+Bsv+5KvUrKH5A5atZ?=
 =?us-ascii?Q?5asM2rdUl9R1Zzb7QZQ8B0OLdJTxiwpI5SsklqLjd5RVT5G8D9LMfO5PkTBx?=
 =?us-ascii?Q?TgB8JNdVlSi2Q7qtA5q2IqsWbK6hEU0MDoLNSwsbcoqIqjpONYxK56Ibkntq?=
 =?us-ascii?Q?flOxUObVcTsatKCz0AAovt0qvf14xasyiJLz5UPIC7v8qr3o18RS6I8NrqKn?=
 =?us-ascii?Q?BZeB6HqkxcevQWDcRMCm2ImCweovTGRIunpY2/o1dywFQSn5/59zqza/iLGQ?=
 =?us-ascii?Q?9WPzIGSzfz5ymeU3wmPg4R8QL4YYhge02l2fpvhII8yl0JwtL27LE9q/Fh4X?=
 =?us-ascii?Q?ggxSBctL04DNGR5/XKQtXFFnCZQc/28HRRbvqgHD8d+/OHskoisgDX+zK8jB?=
 =?us-ascii?Q?4EkQyrStBu+/ABJI+YONClhqZrB5qPdG/yyvRF54i/CRfKIjpRkYseuUwpKO?=
 =?us-ascii?Q?anf9Iozp8UIFdzVd7useg2xt1A3VjY2VxBpwS0+HYxuADL7KfyLqwY2WyVku?=
 =?us-ascii?Q?y4sD3XDs/GktUluzScqHVWDhrytcIFGHjNKhEB2ZXhipyJ2bKDQBzMVvJdc3?=
 =?us-ascii?Q?Winec6Kx45NhzEZucWCnYQ+Sis/e4I8Lk3KSLIesaeeZMAJpVx3J2t7U8Qbx?=
 =?us-ascii?Q?+66bQt54Ak3XcCbsqW88BgGmhZKvIxlY79JuO1wWgfii2h2Tl5IGtvegqONR?=
 =?us-ascii?Q?GsW6MCBx8mQV9/XXiOCvXfUKkUE5mDxVRxbowMaLJkRm2wqQUi61cJ8elyeE?=
 =?us-ascii?Q?4rNrLlD/StCghmKLC2nOm2KcPbnNOTATm8znYlHgFgBQEH/cA/VAcrSC1jkO?=
 =?us-ascii?Q?vtNg9pZuLRNoE8y6WrLa/FVVPNkqIdpok8PuFzxDCzBjizfxQydP55V08Fky?=
 =?us-ascii?Q?lZvNumKdOaOHW4Z6KubA/njY7CO5jLDWXQ8XuPuewTDAKijcZGhdkzDk/w7a?=
 =?us-ascii?Q?MIw1pmAkG5kTvOVgHr7LItpVq+IUgXejeBXljfq74Y7xWBY+63Fr?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cff8330c-f921-4081-7e9d-08df17f75fdd
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 15:45:34.7480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kP4J/cHNw+DXz8n1Yfb5P7VRZtizITQnviSnECF85hXksmHhOPBoTumEdty3BSknjwuWiZgQGbLtPKdGWxhWXJio+BgCZVY4kB6LQsgDNyIhmMGANqZww34pPILmNcj8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MMZPR04MB481271

On Mon, Sep 21, 2026 at 07:14:24PM +0800, Guangshuo Li wrote:
> dpaa2_qdma_setup() allocates priv->ppriv, but failures after the
> allocation can return from the function without releasing it. The
> existing probe cleanup for priv->ppriv is only reached when a later
> initialization step fails.
>
> The normal remove path does not release priv->ppriv either, causing the
> allocation to be leaked when the driver is unbound.
>
> Since dpaa2_qdma_setup() is only called from probe, allocate priv->ppriv
> with devm_kcalloc(). This automatically releases the memory on probe
> failure and driver removal. Remove the now redundant manual cleanup from
> the probe error path.
>
> Fixes: 7fdf9b05c73b ("dmaengine: fsl-dpaa2-qdma: Add NXP dpaa2 qDMA controller driver for Layerscape SoCs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> v2:
>   - Use devm_kcalloc() for priv->ppriv, as suggested by Frank Li.
>   - Remove the now redundant manual cleanup from the probe error path.
>  drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c b/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c
> index bf771251264d..d6843da29122 100644
> --- a/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c
> +++ b/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c
> @@ -353,7 +353,8 @@ static int __cold dpaa2_qdma_setup(struct fsl_mc_device *ls_dev)
>  	}
>
>  	priv->num_pairs = min(priv->dpdmai_attr.num_of_priorities, prio_def);
> -	ppriv = kzalloc_objs(*ppriv, priv->num_pairs);
> +	ppriv = devm_kcalloc(dev, priv->num_pairs, sizeof(*ppriv),
> +			     GFP_KERNEL);
>  	if (!ppriv) {
>  		err = -ENOMEM;
>  		goto exit;
> @@ -757,7 +758,6 @@ static int dpaa2_qdma_probe(struct fsl_mc_device *dpdmai_dev)
>  	dpaa2_dpmai_store_free(priv);
>  	dpaa2_dpdmai_dpio_free(priv);
>  err_dpio_setup:
> -	kfree(priv->ppriv);
>  	dpdmai_close(priv->mc_io, 0, dpdmai_dev->mc_handle);
>  err_dpdmai_setup:
>  	fsl_mc_portal_free(priv->mc_io);
> --
> 2.43.0
>
