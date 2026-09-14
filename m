Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011059.outbound.protection.outlook.com [52.101.70.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E86448B87;
	Mon, 14 Sep 2026 15:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789400465; cv=fail; b=S17gHUMMQQhVNIV9FK5jUzFQpPHYg+/vjkG5UiYjY9DzGo9wJrINN+M/4I2rk0KKsqPX3izek5Ubt9ZbYQBdiUzAngw8t/xVI+YMFXAfoh0wfMN9QP+WZ8tDEoY1VoRM6T0ocVFFN3gXTicf5l1NKoBhTxYqxbPLMLWrgZf+2W4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789400465; c=relaxed/simple;
	bh=m/L3Qcvwzd9g8VYzHXXj73S5Ts309OicIo7Tzwg9nlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p+5KjzGuOsXOFqrhPnx9SoYoKuzGJO3r81tlcIcEFtkiwFnpJ8SkfkQtAl4ZfwY2aP0BlVvt4ddGGlCMXMfLHpV7vheb5cQypv9R5J80m6yHiTeahI5t3JYTfLjPBcwO8gX/iOHPPCPa+ZhfJt2yAkYHiyUP0ghkiKIVDbnQiwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=E0oWHvEB; arc=fail smtp.client-ip=52.101.70.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="E0oWHvEB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pzzNSbzGAg9tXMxQgeUMiGnptXJ/Ju9BxDjNx3aDZ84yJEI5DRq26tnhJF5BJxP0SpSNlrDlHgThfMNA2B2sQnOKJsLJ/kWX079bshN9P3ihHk9qackJz2ap630PagqsIZKw+bmISgpUInK7VlT+DFYF4mrfjtf1DSQnEis8belAMAgjbf42lvWLc0nlrn3CjD9/dnYh+P7dLDpH8/8HgzoW4ExYAsWW4CCg8gOkEkxd8KrO2tXKSnkaw10/zHVwDzjAvacttRRUktzI7UDdzdepgcILm2tZD/9MT/XLhzCXfC3JewCh8k9EtuHPPs3LbwZ+ujPntntrBm795ieytg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CjFWj3OPwPVbTSTbXPK8Lr5GFGanVuqb3TAMwBr9j3U=;
 b=R7+Qxg4kzfQiHquz56GbBrmC8qrlPNwLecugFGNHM3vckeB38H58BeDiIA/xAE063VkPNvtcB+ZZo5EInwDY1jEWafF8c0SpSVGnvJCCPvEjQLQ0MgUJWrtAUIDh702fSELqWnhokFBjRueeqKk3QRTa059h+aVEjtV/9O+LcZpytzxKde7+THsNJGLBuUeUtXJWDZ77oN+u3pCFoil5b/g8AB3SCVxKcm8T28skoYAgHcq68rIF/763TchN2WB8CjZGig9AeLfcvyt44cGGu4rkvKCmSQ+YoPQ5omZJ+zqcGj6v9Mu168GmIj6gfSTBPjBeBE/Mcn3GRWC/Z/B5Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CjFWj3OPwPVbTSTbXPK8Lr5GFGanVuqb3TAMwBr9j3U=;
 b=E0oWHvEBDs7R/fMwIr7Pdo1CzYFX2BTu/KRyJ4/1j+Ofh1SEHtuClWWNFJExtz0OrKK5XYmN7E/lvfAfO/rrN4E18NO1Cjy2awj3ul2IXQNwsEw/oyQ651ZTZdY8CG4aeTLfi6P587dxnz8NRsPLXfojawr1hE8v4Sf4UgWrUNNcaZhW0J5I3p+0PNOcSNasavBFQuLZTop5vBw2trYG5+XwQXs9pLKUzlwhF6MLEOjz4Wii2jQh2GOjQ0dyisIh+eh4KHUMSkyjNyxrsUfX96aknAJrU+TuPqxIEIjaiTjNnyo4GwPvSGXLKTlFA8iP48m7VVLDxp7jjeoSj4+RQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by MA6PR04MB756646.eurprd04.prod.outlook.com (2603:10a6:250:53::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 15:40:59 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 15:40:59 +0000
Date: Mon, 14 Sep 2026 10:40:49 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Ludovic Barre <ludovic.barre@st.com>,
	linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] dmaengine: st_fdma: fix potential use-after-free in
 vchan tasklets
Message-ID: <aqgVgZhsP6OQ0QvT@SMW015318>
References: <20260912154629.1021632-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260912154629.1021632-1-lgs201920130244@gmail.com>
X-ClientProxiedBy: CY8PR11CA0002.namprd11.prod.outlook.com
 (2603:10b6:930:48::9) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|MA6PR04MB756646:EE_
X-MS-Office365-Filtering-Correlation-Id: 05ab6a52-bcc1-4620-e2f8-08df127692cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|23010399003|19092799006|1800799024|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	CHZDct0rFjJPFEwCzeZS4r0KsXCh+WedntqcGowdCJAxRtPx0SatDAyNswqnGoHhWQPhOWFrcMd9itSVgwto5TF8s+LrYKKV+mDgUiDmGCQYikqOtXo3WLIMuH4W8nTs339CdPoxD20mxtNT9Cxt/fyrH7IgQwK5/3QX92cYydaQqs6GyAQzWkFEJYIcTfsyE8fNLkhcy+lkW6FIqL8DYb7SQByB0wf7n276GCiRFSUBCXAlOQOOsVaEVBK6/OqSQD2ctGsxBPkCZcaeW4pbhwweb2faT6/1ptj5RYSu/qqnw2YlLejlngtvRla2xz5wXURb206yXar7ODzgMpHLRoPiqtOBopHoNaUBF0nmNqUeGrV9STXm0yicGLsC7twCHE2IeAoEn2cnVRKrWgpt7J6ceLpyp2xAoSU3Zrl34KTMQG0Dp1zct110y9AyYc3AYLMyjVZ8EpirqGxEz9xIWk3kYNJCB8KTtGldthRFOzf6/4sDuAZAf4GKsWudd6YClxWHwSCB7USDIOIaIpyrl87slltyR7TWt5ntCCXgkjon/cuDLAfHiz6vxnT+bVoG4rsrG7YgQR6uli0ynSZKcW9S+V4htm1OloRt6c3W94Jf2JZ//92Bue0LtoZmZ3va9FdwVdULr0evqVDQHshz9GjZc18Zhnc1Do0Uyh/FS2k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(19092799006)(1800799024)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Wx/WodVNlwXRQ9icGhUQlifoY4DTMypL1/z6dktQZz6pvAA4EaH8Sl6rGKMp?=
 =?us-ascii?Q?bLRiZ3O7pPsb/tKGqwjOgDfy4JfAc0b4W3OALoomUe7yONhV+xfB11WPQput?=
 =?us-ascii?Q?61IRTX1PX7X/NkDTb+GK4q3Rz4ODaq+GpzfS8THnls5A+rCZ1qckJeCQoWWQ?=
 =?us-ascii?Q?LTEPorJkFCGqP3xKz75ByftpqH7hwSmBKQiqBNKNuXzDyUx1wlQ/4ReLuo+1?=
 =?us-ascii?Q?8CrP/dQJmvhqTkdD9Z6ymCkX/nJ+mr64KbJFCiWJyFDox2pozUW1tG1y0w+Z?=
 =?us-ascii?Q?Bp2Kd8Hjjf9zl5A179FcwhUSa5ly5JeLMQ6HsTX3FeF5LW8EvD8aN4QbawVq?=
 =?us-ascii?Q?EkcE1iUv710gGW8RK6OjNEHGi3fN8yUjQl7bwJNCOeJlRPqtUJiBBPIqpSX+?=
 =?us-ascii?Q?w895xdvspj1KBC2l9XrVtiSlqBZwgoArfPemFEXjZ4S4P5osh0ogkBYZds4/?=
 =?us-ascii?Q?WwJ/Jys1sauQGYY46fQyJmPaaq8QxH+KgUPcxCIQ6zng46QGuvaFLJrJTpOK?=
 =?us-ascii?Q?Q83zwTqj7M6TgmEHeXi/g13C6HLQ1OCp6Tr8R4nUbfj0zxxWVpynnx+hxjW2?=
 =?us-ascii?Q?/JZXeXpPcgRLQHnyTAz4m+lthGnxNuRvlfDZ6Wgwlz1+dj7uXXWAVfsYrNbM?=
 =?us-ascii?Q?wc6iBd1QUErkYgfJWdY/xVa+vtCrO7JGEMjBLf5xlmjb6jb2PLUT8iqJ4L3R?=
 =?us-ascii?Q?5fMNpKdvOEmKQgqkVZKYc4vHKpndK6z0BFPKl6J7c0COj/oWCJQ0VLCpyqYu?=
 =?us-ascii?Q?55SuWUFBxhdOa3gWI6pTtcWWF9fDugJsLuMO0R5ZGQujaZVhSOrewyOLp99w?=
 =?us-ascii?Q?CwpvIN0Y4yASCzRq7l6QTqeYzUHapCUdnla4si2qKVydUI/z1JaHWWF1PuVL?=
 =?us-ascii?Q?ddr2Emg+3hCzp3jchM4CgJ6Ml/EioOf0nTUoD8LGX+VL0GqYN/jUvAIfHd4J?=
 =?us-ascii?Q?ODt5MZnJRRD7KVvJY1XryTAoH7nNqAArrQMhor89o+2xpKcEoVnY2vTO9kpF?=
 =?us-ascii?Q?Ty1LkGSHM8r0i8mm6gHGSXKSxpfKZX6/+eWnIROlrR91n7LG8RL82PXQ1gpC?=
 =?us-ascii?Q?lm/x8l0/jxKmVgqDOuYQ6gQ7Rf5N3pdx3h/J017aDquxEJOw3rStfibsZE1n?=
 =?us-ascii?Q?22lzzFIEuFq/IHQaU5BjuF35Z7muURAQAL8faoldmdCQEOh/iaa6aBSvMGza?=
 =?us-ascii?Q?ImWzgVObcwCKuJ8QnUEPZy8X24GaD/r1y19ZtYbPiFrNDrumx4YHLMKYxUly?=
 =?us-ascii?Q?NLsp63TADUK6+1CYIsjO5NY40VXPyX23qe4aeVfXbn3qOUVA44UyGHHfZ9IW?=
 =?us-ascii?Q?uuN/Rk70ZaAYab5iZAHljhMY7XzZBYmQqYoSduUS8Hpv1rYHfxYqsdssoXXa?=
 =?us-ascii?Q?RVnM++ZdyaIUW3vsivmTELiJvxB5gfZU8DjHFgEjI4jdYdWziICsjEpwjMf5?=
 =?us-ascii?Q?mVV9MxUfbWJLjeU1m9shc79DT2RDTp7YJlExz+6+yZxsvBRzTZXyuuqrF+wF?=
 =?us-ascii?Q?xuho7VHwu9p6RDfZv+QtuheS97DIXASlXb58/W4GODXYupBXiwlaA1OEbz4V?=
 =?us-ascii?Q?z1oD1hlYNyoN++48FR50JYuTcGH1ZP0vCmYJJovTgtlxNugByfovNSPXWQrY?=
 =?us-ascii?Q?oU8GMNGOowD9bp7rEz9vNXgN1Ki4Cr18arKatqDxu8GgSLgWT9XiAo8YG6nR?=
 =?us-ascii?Q?xvrS5w2X5IlCcyuf0+0jzdbvGZjTAnT53C3nRdR2w9x/CVkiA7GGgaoYoxlf?=
 =?us-ascii?Q?wrlnPq3AmCC8vYqp1JJEhlKt26jmvxlJxzISwEGbnxRIXKLfZZ1y?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05ab6a52-bcc1-4620-e2f8-08df127692cb
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 15:40:59.0179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: apapwJDbn1qSp04q+NHLRult/OWSh0j8FQs+SVA3OigrU3iz601AJ96fDAaYZ0OcwPj2QkXeHt4/JCA+/Naj36v4/o8a1kAsSWh39UdHAXHmmN7lmI/CoNE49XmNYhyn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA6PR04MB756646

On Sat, Sep 12, 2026 at 11:46:29PM +0800, Guangshuo Li wrote:
> st_fdma_probe() allocates the channel array with devm_kcalloc() and
> initializes an embedded virt-dma tasklet for each st_fdma_chan through
> vchan_init().
>
> The interrupt handler calls vchan_cookie_complete() or
> vchan_cyclic_callback(), which may schedule the tasklet. However,
> st_fdma_remove() only frees the IRQ and does not kill already scheduled
> tasklets.
>
> devm_free_irq() prevents new interrupt handlers from running and waits
> for an in-flight handler to finish, but it does not flush a tasklet
> that was scheduled by a previous interrupt. Since fdev->chans is
> devm-managed, the channel array is released after the remove callback
> returns.
>
> This leaves the following possible race:
>
>   CPU0 (driver removal)                 CPU1 (IRQ / softirq)
>   ---------------------                 --------------------
>                                         st_fdma_irq_handler()
>                                           vchan_cookie_complete()
>                                             tasklet_schedule()
>                                         return
>                                         <tasklet pending>
>
>   st_fdma_remove()
>     devm_free_irq()
>     ...
>     return
>
>   devres cleanup
>     ...
>     kfree(fdev->chans)                  // FREE
>                                         vchan_complete()
>                                           vc = from_tasklet(...)
>                                           spin_lock_irq(&vc->lock)
>                                                        // USE -> UAF
>
> The pending tasklet is embedded in the devm-allocated st_fdma_chan.
> Once fdev->chans is released, the tasklet and the virt_dma_chan
> containing it point into freed memory. A later vchan_complete() can
> therefore dereference the freed channel and cause a potential
> use-after-free.
>
> Kill all vchan tasklets after freeing the IRQ. This prevents new
> interrupt handlers from scheduling them and waits for any tasklet that
> is already pending or running before the channel storage can be
> released.
>
> This issue was found by manual code inspection.
>
> Fixes: 6b4cd727eaf15 ("dmaengine: st_fdma: Add STMicroelectronics FDMA engine driver support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---

I prefer defer all tasklet tear down fix patches after

https://lore.kernel.org/dmaengine/5ae73ce5-1216-4012-abe0-aba9469ef089@deltatee.com/

Frank

>  drivers/dma/st_fdma.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/dma/st_fdma.c b/drivers/dma/st_fdma.c
> index d9547017f3bd..23071cbf1866 100644
> --- a/drivers/dma/st_fdma.c
> +++ b/drivers/dma/st_fdma.c
> @@ -846,8 +846,13 @@ static int st_fdma_probe(struct platform_device *pdev)
>  static void st_fdma_remove(struct platform_device *pdev)
>  {
>  	struct st_fdma_dev *fdev = platform_get_drvdata(pdev);
> +	int i;
>
>  	devm_free_irq(&pdev->dev, fdev->irq, fdev);
> +
> +	for (i = 0; i < fdev->nr_channels; i++)
> +		tasklet_kill(&fdev->chans[i].vchan.task);
> +
>  	st_slim_rproc_put(fdev->slim_rproc);
>  	of_dma_controller_free(pdev->dev.of_node);
>  }
> --
> 2.43.0
>
