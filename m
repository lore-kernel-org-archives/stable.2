Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.14
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795105174;
	b=bQjxhP0XSYjfQz8YLUmBLmIYrwx4JFdeJ762K9AnS5r1v4eL1qwVB2965+x4ufDK8B9F
	 MdE6fCmW18YiqL/nCXDnwdGaP047YUM4Rekd/FKvoOT/i7UCihQZvpnaVlW89/KQT3H2B
	 y8BW6Dh7iP3tFzi9zauwwqdHh2jEWBzU0ZssopAPjqVaEz/08a2a3Iny7e/XKv4z7CfMr
	 OfX2Y8HWAS9ROYIg04cP9PgDK4VaReKtANmWKw7/BTdTfMWvAR3gtkKrQLDmyrQOLdjok
	 AXNXmaeUxUzwa7iDJrDTDPlZpq2pCKYb/Cg0fiEnAVPtHIzUz5W5UNOpwqwf8CwlwOw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795105174;
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
	bh=EN5IWS60KEYOZXkc3Vn32Y35NSCrLK3AsI5IrdVOTEQ=;
	b=tSlT7mgGA7Or8tNNJPG11GnVOFVTPRBZPekdBQDii1dEYvxfykDK834a3ViBN3Ryh/AY
	 9hIDpJshYUmwPJVHYLB6ZB6bsyQlMKrxCppfAiD28bNEe75UGPnpRDlbDuNqYEu/T5O78
	 krJGwkQNUiL9R2qyazwFqppla7I8UutJhlalyhZUfs/yEjR2dKuGIkhN5/yPxJpL4GeWl
	 K4JlyetZM33Dpy/94PXJfAAg4wWqDagu+BLlqB3ayRaiTF0NxhiuWRUZYbgyyrioZYcir
	 A+7AsCN3UYszAS5yWv8uprGEhADlF2yjTnnQ7C2jeBNc5rt1gbcS2sZegyB3N731Jpw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=UzJEm5xS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.14
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011014.outbound.protection.outlook.com [52.101.65.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B0B606A326;
	Thu, 19 Nov 2026 16:19:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7B0B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=UzJEm5xS
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OamIwOWlbP22H8RYJZzIHKNGYqJHnhdHX1UpWaDIpcPgYx0y7u9EkjW5yC/YCeDVNq/4Mu1qjAcsWmqeTktNnmt2AQw3KIH5CxUmj90NoLBkPEbyMnUsNTrFZxUjQHShNj/xQHdSwlKvBPa8Rsm7F7wv6t3Z7/tIuRV3suDxbKA6oKKnktxBciX/Cpa5fJi2y+kXiOZzmvLF9n9AyCt9C3+K2TEEVTXBbWA+P6k+ZX6+x22MC/cyCohFotKpindB2715leF1OUGZ8TTxr7w+2G9WGd67ak2quuq1C156bnUayWtSUUgW+mHOinh0nzOMn8b6d0PDiR+PhLbS2GdJ5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EN5IWS60KEYOZXkc3Vn32Y35NSCrLK3AsI5IrdVOTEQ=;
 b=gycBWh7wvx1eUdrTqYH914oPktjKKXdonAY7MOXf0bBy8KmakQAkhiKHfELYLW9C+OC9cShDhadeoySU6v5JjPNKFS08lM+8z5Z7c2VA94CU3lGhawgg5OayFrZstUPdGtvHpj0EMC6Pxo8hZlAI9+UdhOhHJnZA73nheDYL5nFbSqRv0q1hgRgs8TRKdPmFK8aic8/RVpsZrEsuJ1Fa2jJ+EOo+f9imZJsyVJMoTnNZrryGPLvP8bdtKfBvf0aUwwtXIlDiI72gNOZQ31HrROnJwc6YZgOoJavv6ul1qaXbnYK6AK4Ksg3IPqiO4AxoIEh3W0rI28Ka9RmGUK/A4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EN5IWS60KEYOZXkc3Vn32Y35NSCrLK3AsI5IrdVOTEQ=;
 b=UzJEm5xSkPAiFsNFPk29XtB9ovHc0Shg+jK6CT3eRlO1lwn2irahJw9p7g46qB+V6U/yBUhwabuqrwgpql8rabRlMZk/jMFrfjFZwSyAyQhzp+CYTVPopXRTdu704tw2OhtEf4Z0FQwC24PHVtNL5PeIlAv3DEWBzCLKnmCAYhzX1qnKk4V5WqM/FzuCzZkiJ7+zd4t4XBUsq5iu/5ArX8MvnJaxwj5HXEudh+HlhcnJouHVF48PPiOGqd7MvTxGwjZO/Ea1bsgMpR+yPT3uAEivN1UxZNiO8rXEFZpH6g5iA4nZ+VzqrE25uY5ti1HspGAQlRYVgpfNvKG58Oqs0g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by PAXPR04MB9231.eurprd04.prod.outlook.com (2603:10a6:102:2bb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 16:19:29 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0639.010; Thu, 19 Nov 2026
 16:19:28 +0000
Date: Thu, 19 Nov 2026 10:19:20 -0600
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
Subject: Re: [PATCH v8 4/9] dmaengine: dw-axi-dmac: use atomic polling for
 suspend acknowledgment
Message-ID: <av8hiM620kNc9CFd@SMW015318>
References: <20261119-submit-dw-axi-dma-stop-pause-v1-v8-0-f8e7fe60594c@gmail.com>
 <20261119-submit-dw-axi-dma-stop-pause-v1-v8-4-f8e7fe60594c@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261119-submit-dw-axi-dma-stop-pause-v1-v8-4-f8e7fe60594c@gmail.com>
X-ClientProxiedBy: PH8PR20CA0002.namprd20.prod.outlook.com
 (2603:10b6:510:23c::6) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|PAXPR04MB9231:EE_
X-MS-Office365-Filtering-Correlation-Id: e3d6d2a8-4164-491d-e1f6-08df4658e2db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|19092799006|1800799024|366016|7416014|376014|261009223027099003|22082099003|18002099003|11063799006|56012099006|4143699003|261026140227099003|261102123227099003|261022075727099003|261028144727099003|261021123027099003|261022105027099003|261026121527099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	nSXyBsM9zijx7u+cj17Ayw5gwOUGBl6GR4hCBrPhfsCAc1pvL2+R557xg5g9MjFjDuHAqQVZ0zmFq3xMOV+uJ8+6fWBi96g5BFPPU8VAtjQyPIOmY0FXDaNaYDThx2poHqrpUuNyL2tO0IcC8x8SB3ADm+kljFa0wy6+TiyuAdWCJ+dpAC3yDpLEUIpACzNbK9cIjudyHoytwVon4UPjAvZzrrafPX5xGPfhsjs9OcMjYTkd8N9+q+rABga9Q1xD0FFuFVfMpYdyI5vJlQQHzzQ0tlnZPCdebSgsh/E4Pd3iKuDQhJGWUYnTW58x0OfHJ642CSA8ZSOMMZkRKOEWbCQJHqxxvtgh+wcENn9moj5G8GBVEukO9kIYftFffX1HiKiNC/fFYlPdk9DCummXLOyMizSJAoSqFQ1wnSyvNSlJ2MF3yTuNv9nsXWWGHmyHKHuAIaMKUmajrIq/kMgcAOk9bvKNK4CaBAnIb8EM+WKyBIoo/Zbj1JJZRpKVjKbE8XOMVJowebuC0q4XtWUn03PWHDCAIo8U8EvGIH+3Er2hfOwAhIpc0w0GeK9/deODwwkMhYl8mtAYNkOtgtA+UQVch940KC5n0ilQm05ysdAtvwdtCWMAQjJwwfVP4bkgOmmKSHU3fAjX7NjG9w/nqC4gU6mWTW6Oj3OszXKQkAk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(1800799024)(366016)(7416014)(376014)(261009223027099003)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003)(261026140227099003)(261102123227099003)(261022075727099003)(261028144727099003)(261021123027099003)(261022105027099003)(261026121527099003)(261021121427099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K7gJnqW+7USqfUSxgevhfvIUdygeZw690QQ4tDWOPpDRVZR8VIfErV84PWmt?=
 =?us-ascii?Q?Lp5TXMY4tjFsySSgSriyoTUtECIX5K2KrKjfTuJV/waeg7KmyYcLqv5vwSZ2?=
 =?us-ascii?Q?Zgex+ZaNU4+vxQXqAVfXzf2J8fBaujfjVGw7PJG0+EdLNpqwSQfuevRTMD2T?=
 =?us-ascii?Q?Lk/c5JAG5oOhXQ6rZzyZzpx+7EeitwcdXnLa1dFUGGhmn8qpGlYbKjIwxjrX?=
 =?us-ascii?Q?hMzbYmB1zYpeeLAeGx3/aeXpEoy1ciocJNi68+M5YJF/Y6E+vkJDm26mS65D?=
 =?us-ascii?Q?O/H5yGrBiraCRRFpTmyw5Dmunwyi2utSMZf0d2SxWwV+Jf2iE6cWGvphq0hS?=
 =?us-ascii?Q?mjoVFN1n5KKv1VHoBu/w6hAdZny0+w8fcMDk200cEXQNAgDPvz8KIrqIYCoy?=
 =?us-ascii?Q?T/23VQkPCYVY9SkJRjqgg55rC9rFjdNAQTm/C3efqG9GyBBSQAGVbHYIBWOt?=
 =?us-ascii?Q?acSqH74bPdPBWDHz6qctqPO+ErtXj4ygzfSA4sDQ2xG/QQfdlE6Sg/r+Vc4L?=
 =?us-ascii?Q?sRv9JVjw1SV64pAk53KJ6cf9ZX0MTIbPYeKXgMqrQC1aGun6aIoTVHb1flJK?=
 =?us-ascii?Q?YAmcMYFI0oQNYYsTUkyQ20oMT/7iP/o/mnbNkpJ8f6Yq+cTvH75wX0b3QhAH?=
 =?us-ascii?Q?KnQZGav+AcYBpvjWNDtL1InPtGBmDTIkCIHQwl04v98cB2m1yAxMv1m2Nna0?=
 =?us-ascii?Q?Spk9M7kNyWvjxiedMcH2nQ5kVwLPBKcx0G3jjNgI9gXAa4PUtP2UqCzE+gvf?=
 =?us-ascii?Q?v7t4cVTvjc8QUbkODL/Oy3rQOIr/MZ75Lfsk3nNYidbyL6/TEOC/+Ve6YFQt?=
 =?us-ascii?Q?ayeDesujHbSjSA+YUW0lLiu6Iia3MeKkkBDBxIfJXDu/QnFaeyaOBqydoFpK?=
 =?us-ascii?Q?o6fKoxi8jUcGw1ooy/BrOHAQeALxBmWRCCXGwzGyWJun7GSVAAFPKJdMpEjf?=
 =?us-ascii?Q?9VXkxNDSEB06JoV04oZ3nhnUImCK90sK3Fq/BZEUBEP3GA97Hs1kOiY/Yts+?=
 =?us-ascii?Q?T16JLozngxgW0iAPficChxANoVYpdUJKlMlJMV28JQKQ90loSNe87BVR/VW9?=
 =?us-ascii?Q?JzbDa9tq73kdJePE51RTMdW/HOiv5QCOuHwcz+F74M91YhgP5eAuOfy/Qx6Z?=
 =?us-ascii?Q?btlhw6U4z7BVqJBjZCEmMriwbcHqrMaO4dGgv6aVMrh0KHspKfILybFdiCO7?=
 =?us-ascii?Q?zbUB+3pdhnQ+m3r2Fx7isI2D+p/OUH1iU/AOCDuZRSeGJuRc9YNuEFLetgKy?=
 =?us-ascii?Q?Ov/Dj/Wytl42Jsz5LEs8g1H27ENLvCR9ikpGgrBDHm08fRfeRyQ2ObhzzWEP?=
 =?us-ascii?Q?KzifVQRKv0ZRa1woPvWD1lHYKhF1Z8OsgH9Y5xZwupyNFaBoOANae+tc1J7r?=
 =?us-ascii?Q?Nw4mjlH7dES0qwivCoJw7loKaxiaUMcycW8lXCgsWnDt7JO8dmcJrEJNBLj3?=
 =?us-ascii?Q?pbm7ZBFLP8FZQFt8B7oqnB7Pa66oC7UfJ4S49wob3DcM7fqW+Xur74uvIiNx?=
 =?us-ascii?Q?C4RkTmOLBnheDr5A0ad39nYp0p1Ln/LefSK5280wNZui2jmePQppMVC+QtjF?=
 =?us-ascii?Q?klfqP5a6cSHIPJ2EdbxFEbOI3IOymGhQQh5BwIeweq6hnHSkQhGVKrLZWyMK?=
 =?us-ascii?Q?ElcJ5o7LpRq39QWKAGElfR8LvWnFGOTA3AiMpd7J21t8pV9HtJ6oCvnxNRbl?=
 =?us-ascii?Q?8BeJx4vZFscAY0/JmJ1UuAXAPg1h8ttoPkGMlD66h3pB9+POmSZDQ8BNeZm8?=
 =?us-ascii?Q?Esfy3fAGwulFPuqnKcZe4K11mWtfBhzw+HKvWDXD4/maO5ddqlZ1?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3d6d2a8-4164-491d-e1f6-08df4658e2db
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 16:19:28.9179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iwv5dVNom3aoAssG8RuOsyZcf34jyBjVSGLw1z8BWZdD34lx8tqJ5NCre/gnjEwdhIq44HeaPI24L/YgxAgWntYcjcx4GtA4FjCVdP9l4qqynpoM8O542PO8XtYg+/gY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9231

On Thu, Nov 19, 2026 at 09:00:59AM -0700, James Hilliard wrote:
> The pause loop delays after its final status read, so an acknowledgment
> that arrives during that delay is cleared without being observed and
> the caller receives -EAGAIN.
>
> Use read_poll_timeout_atomic() to check the status after the final delay.
> Keep the two-microsecond polling interval, 40-microsecond timeout and
> -EAGAIN return value when suspension is not acknowledged.
>
> Fixes: 1fe20f1b8454 ("dmaengine: Introduce DW AXI DMAC driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> index def591fc75ce..8c115d20728b 100644
> --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> @@ -1219,7 +1219,8 @@ static int dma_chan_pause(struct dma_chan *dchan)
>  {
>  	struct axi_dma_chan *chan = dchan_to_axi_dma_chan(dchan);
>  	unsigned long flags;
> -	unsigned int timeout = 20; /* timeout iterations */
> +	u32 status;
> +	int ret;
>  	u64 val;
>
>  	spin_lock_irqsave(&chan->vc.lock, flags);
> @@ -1250,12 +1251,9 @@ static int dma_chan_pause(struct dma_chan *dchan)
>  		}
>  	}
>
> -	do  {
> -		if (axi_chan_irq_read(chan) & DWAXIDMAC_IRQ_SUSPENDED)
> -			break;
> -
> -		udelay(2);
> -	} while (--timeout);
> +	ret = read_poll_timeout_atomic(axi_chan_irq_read, status,
> +				       status & DWAXIDMAC_IRQ_SUSPENDED,
> +				       2, 40, false, chan);
>
>  	axi_chan_irq_clear(chan, DWAXIDMAC_IRQ_SUSPENDED);
>
> @@ -1263,7 +1261,7 @@ static int dma_chan_pause(struct dma_chan *dchan)
>
>  	spin_unlock_irqrestore(&chan->vc.lock, flags);
>
> -	return timeout ? 0 : -EAGAIN;
> +	return ret ? -EAGAIN : 0;
>  }
>
>  /* Called in chan locked context */
>
> --
> 2.53.0
>
