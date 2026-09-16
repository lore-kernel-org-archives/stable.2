Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013004.outbound.protection.outlook.com [52.101.83.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F144C225B;
	Wed, 16 Sep 2026 15:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789574179; cv=fail; b=I0602AVRJnNbehvmKHfTMnsEbPc03oe4FOTn6B0jtY2abwlDdq2rnZlcFys3Und4ajVy/XtVYbAAhiLkh4fYZJcaIRkmLJTD+sp2nP914/K33UzF4evpP46+SHQF1Ggn0FH/i53ma1Z7MgeHsIn9YjLViBZYaBkcV/HyRWZIt8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789574179; c=relaxed/simple;
	bh=sYkH8z80cqCkHA/f5EjTiAnXbA3MJnLYYeNscYGxFiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XIS0Hv/X9+umrZVcrdrSFlFpOaqZ+YtL8lioBpXpeSMCXgJcGUkRrUBs6Syl97VnMCn7hABaWdoZeo/u5k+XDSPYCLXberN/BopaxxbgISU9pvyH9MBxBMLeLXf1taxjsn0VZoR3fHF8OoGROBjpchoIToWbniJt5ARodrAGLS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=gI44mYul; arc=fail smtp.client-ip=52.101.83.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="gI44mYul"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hefXjHmsCINkc0rnVLPxxR8r+R4AsI66IqBbtZm8U39kXRS8NVxz3bsnMDFikpHzDdQCSF0jy12FeYp0MzcK8lAkeV8LriBMV34qNUSZgVmW39vaZQHxrUABJwlCrdwnED+Qsk4m9DWSoJPD/sXsCbvseklaSopJYoqTdpSya6p3R/3Qx0y5krxixcN/IqNzmr+OsuFYOfxKylPZpMLXYS7IUpE/rUhKxWLbzWigRw++JFgP4Acoky9WkhnMtRwNQ3Bu9lA0tW1uu6GyG3BuUxDLbP1W01SfEIEH68xvlpHKYShPkpqaIodvjVmfVQOcOIc6OZhqyyDnyGYNjht3Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YNbyEy/5l+x2pHZ/vteOnkSOQvEAB7hYPgk9ZKHJiS4=;
 b=hKiJaOOmPwqfXorgeZNu9FNdyIXsINmeTgvnkt3kDYLBcnjrIykjTB5rOyjy0LPXKehA1WBiie7x4Xo+TlkfbHU9/sbxzlgkB9O2J5BaNZuLfzPbOux8ozCEDIKRmJr1Ybgpx1WN/YEkjfcaeTPbfUjpgDV8wL9fH40rG6on6v1LSpSwAheJRqvwS2pD/GgNLop9Dl5/77puZpbo1fH059ZAL0UfJ9wRLRuKPW2wgJiys38zTNcZvy/z4kOP/WmPK3SDd3f5KdHILHXmYS2e3hRaFfZ9FLaSDL+y6D2K6R5IBFjca9BatKe8Yc2AHlc2OFGFDJ3FV/nmbTZdxmm65A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YNbyEy/5l+x2pHZ/vteOnkSOQvEAB7hYPgk9ZKHJiS4=;
 b=gI44mYulAD6l/O8bm1q0DXgK3E0xTqOp66WUOfGorshcA7JL08PndsbbMSYOo9GJ+woKSTbgh84Z8rjnQquA9BiaitjNgG3oH7QFrs4VDQP0rurfiBAd/gmwZiwLFR1O10MDiNugWCiTHK6HIFj3QA2n3waSuhkfpfv4mrmcnpq05dL2QBBtfA2CLLgo03z6cKoz/CFXvRxmZRc9mD0i2nASxrMi0nsfq3AhZXXZ7TbhpNQfl/OzNd65F2OT4OcTVuad6I7EZyIV0UuTutsNedekLyERyBJkXXHQAszcjIuHu1j+qUtGeOq+1INj71KK2dM6LNabsLHVnvi87zCKGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM0PR04MB156053.eurprd04.prod.outlook.com (2603:10a6:20b:7f4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Wed, 16 Sep
 2026 15:56:02 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0406.012; Wed, 16 Sep 2026
 15:56:01 +0000
Date: Wed, 16 Sep 2026 10:55:52 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Frank.Li@kernel.org, andy.shevchenko@gmail.com,
	dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	okaya@kernel.org, vkoul@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] dmaengine: qcom_hidma: Fix runtime PM leak in
 hidma_issue_task()
Message-ID: <aqq8CIu0vJ2CaOf-@SMW015318>
References: <20260916093032.2003397-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916093032.2003397-1-vulab@iscas.ac.cn>
X-ClientProxiedBy: CY8PR10CA0048.namprd10.prod.outlook.com
 (2603:10b6:930:4b::14) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM0PR04MB156053:EE_
X-MS-Office365-Filtering-Correlation-Id: f331407f-b244-46a9-97d2-08df140b017f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|19092799006|7416014|376014|10067099003|18002099003|56012099006|11063799006|5023799004|22082099003;
X-Microsoft-Antispam-Message-Info:
	QOUDpR21HkxgL1h229LflxKuZcZF5zq7MXhIZHrUCA2zQ1WBHy/0/02zm6OfV+lAG1lkQGsLmSU4lEi2joczW+7jKCnGr27lMSuvuATs+43a4vU/XHJzB1MreTRUJUzNxquTJFek9iUZTJsYS52k5o0H7SQ+JXiV1/wTrTLv7Vp9JYvKPPn4+kUU7XA37Js6EMQnNDVxIdzFrkWeBWrEvgDn35v/zqIpIyaVMhcoBhAuRomm+GBa/UWqE7ri6FXFTjo3HtdQNKAYkKDon+rRGnzj57BlT3IxlwPsSiCgwi9Z8c8miTaN3ScucHjIV/lt+negNbk2M8xAH8v6Yuoal9f2Gr1cGAHrrckKK58VYH/iGLtR5m77ySWcsqnqhCBGYXDXH51YBPILp7SGkd/9pPaTHhtfOxDJwcHv0vnCM5L3d8sCbQr2NlaYRSoRZzBqryNhuSNAYzpM7wK9YPSkv8pGLwBkCbYvYA6WETFwnwovVpA8p9MhkX6DnWJB+N8byVivaDq0OXQYfNrIBFG782s5LthbQmAsMrfU+jFM6kW2rY28NcS4U6pLDv1gMxFg4qHOXqHR7ZzSAS5rGLIePJDqpqsKWzGMBCYeeTpXrGVh2Rc3O4zs3ZQNNejIw4ABvTkEYJOaRHM5KeiCn2gSWWbakG4kT0EBHYYAyEt4OOE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(19092799006)(7416014)(376014)(10067099003)(18002099003)(56012099006)(11063799006)(5023799004)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JJ7FnSUZJFyvgzjec/EYrHIQ3QTaYwBAJUadqwGIU4sQWt8N/xkbhBvjKRwY?=
 =?us-ascii?Q?PTkivOXNH+PBQbXyTAUNet8p/sk4iyg0+qmuFxwQL8MoT+1hSF8UhzTM+PGe?=
 =?us-ascii?Q?FY4MWDgRBrA+EvSW079rIYtqIgaBC852YLIVPXa6RsdyT/QtUY3uzItRbWeW?=
 =?us-ascii?Q?WQh1UYq5ABvy9vqbkHZIs1qSLsdVpixfWKQItXEbdxhBB2tKQYq8xqz44inq?=
 =?us-ascii?Q?CCQ3ZAJGxnLy/GSK8eQ6Y8OuVr02iWjCtCyCH8EPogml9iJecywYnGWcP5/W?=
 =?us-ascii?Q?1uSq/z8N1oWT+/igRNQhc6ny2DbGO2rHGmwANpHPsjP/zB6P9ZKWVHUELrTq?=
 =?us-ascii?Q?RDICCu0H+IWX7fquwIOES2C0iLyJyoAFe1UgTalj/EQJiFGQj7MVT4G4rwse?=
 =?us-ascii?Q?5vKMVMIbLGYqlrxVUVyFGz2oqEyubCuvYY6pNO8EoZT7IlbZB+kT5/hx/nNo?=
 =?us-ascii?Q?Ncg047p59MHmSVs9iurY3rbKkkELBLuUUTW12xLRepZz0yv2RC5JdeH6ftYd?=
 =?us-ascii?Q?VlRe4Q9S+e1sXLwugr2SyRxoLjJOtFP0m3JlKQB4dMipEXLzwQDZxD/4viwg?=
 =?us-ascii?Q?EfdIUGyiBTpKCtovJDY2sCIEtfdmkC2sn2dOwg4d9DOH/eB53wwxjaC3YASw?=
 =?us-ascii?Q?9nLIX1BmmBnM6i/WRnqDALT4IWbOUnNzePex1inhpcn3ohE7vLWjdci4pqzZ?=
 =?us-ascii?Q?25hIzn/yvrggz3dSIsVzxxAJkq61X/X+N4T/SnITf9wzxBp9kmy3yX5ycx77?=
 =?us-ascii?Q?ehS/haVz+FQtoTr3x4dv9DRInFYaXkzEBF+34i5IiZ58xv36pbkxLWdvP0p+?=
 =?us-ascii?Q?6+/IOZ6kpoePqCYLOzGPXHFEbkmbmgb2OmqHcwTEj2Gz4kDsr0miDdVcTZCs?=
 =?us-ascii?Q?xkAX2FC7xt+APb2fEm3RR5W3bu8dK2HnwT6xz//WgrrHd9F2NaITcFnpcrG9?=
 =?us-ascii?Q?6NcLvcKrZmJRoXUcQV00fORu6ZlTYvjm0XGJfWbstODVOC3MOfm8d3tL4O4D?=
 =?us-ascii?Q?iOev4wP2M2WVZSKaZlGQENq7ri/xMM3y38rYRh/CO6GmbUzRs/w1fkRjZZuK?=
 =?us-ascii?Q?QGvk3KrJU/uAFRC1O5nZPBRfNITkuIF5A9dIYaWzI5w+vAD5reuzuM+dtLjI?=
 =?us-ascii?Q?gLwD8k8mqDKSum0uYBUUC50WXaPIuJ6B6x5IJa1zSqtcWrmHr+aRcHcFdjVD?=
 =?us-ascii?Q?W+ELd+BpOySdQ02Txxp3BnR1R046NHYcVQcIHkDUTiTbeX6curghZFhVpbhz?=
 =?us-ascii?Q?2pkWeaZeIBHfTjref9ca4AQGIacBDcBANGg1yVwtmfll2xtF4XxK+7LvYbrk?=
 =?us-ascii?Q?8xNAwTUNUJjMzhw4jLE8ttohna+BethrS56lXO9K01B45K93v0bVA1m4CDyQ?=
 =?us-ascii?Q?In+garicqDKIoRcvBe3YWeJbHGN6/VYbG++kJiXpAvyL36Taxc0+M5DFHW1b?=
 =?us-ascii?Q?8pDJvCLg8sAlO9zBRLz9AdyYjzYfNFhHNIfFjJ4KbUoylNuUiMkczIY2SKuW?=
 =?us-ascii?Q?UB4DBpVIOCLs+DwNVgPPZogJaKw+SiWoC8W8Q0sTkPq4smVCqZk0GWMqylNh?=
 =?us-ascii?Q?1E3UYlMhTfF6Yjzr2I0vMRpytUvFDu8vzxcdixEx589PZi+PoXCfMIHlPXG/?=
 =?us-ascii?Q?LR7gISRVLSQc+raXX/E0Kv/UvUG0wNhKNSByVdE7O3a/C+MyKVQGOEca90k2?=
 =?us-ascii?Q?t4VmdRfxXqBlegxdqqFAX8afmtdZeSpfQLEJ2/R6z/b7A+m/FdsKIh4D0bMR?=
 =?us-ascii?Q?RWXxCS/Dr1ZI8iGtWxEkrEp8ehXyyFeBAGD2p7YAFLpadmPew66W?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f331407f-b244-46a9-97d2-08df140b017f
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 15:56:01.5153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q4ihKrVrOZTZb+zvR3bkYxgC8O4h/ykE8dR/o5Z3IlzE/DaKbxyRPqq0RxC+r70LoLwRnjn7fd7Ky9h8ufyWriu4Tf6kJFs2HAYfY2sXNPZiCFZ6BA8jJtk76CdUbqjs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB156053

On Wed, Sep 16, 2026 at 09:30:32AM +0000, Wentao Liang wrote:
> [You don't often get email from vulab@iscas.ac.cn. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> hidma_issue_task() bumps the device usage counter with
> pm_runtime_get_sync() without checking the return value. The counter
> is incremented even when the resume fails, e.g. when runtime PM has
> been disabled or the device is suspending, and nothing drops it in
> that case, so each failure leaves the device with an elevated usage
> count and it can no longer runtime suspend.
>
> Bail out and drop the leaked increment with pm_runtime_put_noidle()
> when the resume fails, and only start the transfer when the device is
> actually resumed. The counter for a successful resume is still
> dropped by hidma_callback() as before.
>
> Fixes: 67a2003e0607 ("dmaengine: add Qualcomm Technologies HIDMA channel driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/dma/qcom/hidma.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dma/qcom/hidma.c b/drivers/dma/qcom/hidma.c
> index 5a8dca8db5ce..03a73dc9b066 100644
> --- a/drivers/dma/qcom/hidma.c
> +++ b/drivers/dma/qcom/hidma.c
> @@ -220,7 +220,10 @@ static void hidma_issue_task(struct tasklet_struct *t)
>  {
>         struct hidma_dev *dmadev = from_tasklet(dmadev, t, task);
>
> -       pm_runtime_get_sync(dmadev->ddev.dev);
> +       if (pm_runtime_get_sync(dmadev->ddev.dev) < 0) {

use pm_runtime_resume_and_get()

Frank

> +               pm_runtime_put_noidle(dmadev->ddev.dev);
> +               return;
> +       }
>         hidma_ll_start(dmadev->lldev);
>  }
>
> --
> 2.34.1
>
