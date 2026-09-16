Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012027.outbound.protection.outlook.com [52.101.66.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E618A414404;
	Wed, 16 Sep 2026 19:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789586778; cv=fail; b=OQUwfkBXJWx3dDHRcxTjTZ7phdF5O8HsEEe1l5GeDrb55Gx59vSa9DjcTcO0B3ALcT94iSOStGHAeKGA43hkHll58y2g+iGzQhneTK9bDxyC6uBwoOA51ds0YZkzYhvugEiTU8xSWAKaNsV4kW4GTw21MmBzS7SAgl6JqQPzlZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789586778; c=relaxed/simple;
	bh=++cBjmdVvp73C3ofoQK7CTFFjYWK1OCyg5WDcgrAU6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Wneb15qYZBOJb+/CFdKzgiTCgrim9if7ic60tPBD1hjKlJgj/Dk5HOAL11R3VacEoNvvJb/XVlhhkYUg3ENoE59JbF0dfSmH08i7oPEBSP3Ja3QjLS8aGPWJS1v/4XCD+lgRfbjPhPda1Xza7WPETGWlT6zKIJxBQ48ZQL+V5b8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=kGmPuZnB; arc=fail smtp.client-ip=52.101.66.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="kGmPuZnB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=acLea3PigPqeDBoXBDO96ysWLYKhx4/WCez10C0gcZJ/sm0DrzYyhyqawvAm5GvEkltgg0kFEiP+y/gR0tBGo309BhAvlw/2+JX5LerMaFOxq/HJ8Z7PiycCeeiJwc94Pi/adl6KAnaRFi3fU/KBydiLjB5h4mRj74OS8EXT5Wm8krkNtaPOXCwl71wpMHvdOVhfm91db7pFKQRldcHSuy07wBWG9+hh6OOS5w82nzFjFvt4pTV+arcBGRG7BAHn4DCyVqgnbm38CwzVDbM26xp8StOg4EVo0J6HQ1Qrb5tN5YUmS3bp9k4xRMQ0aIbdHDP1Y/7inrLZvovyzBhaFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w25UG7eTCI3epGPiH1p+gMYK6k6El5KE1bvDr0Nm4xY=;
 b=jEonhypX0XRNxY0RnwzAt1CTz5S/g5OzVtKOjJU5HC8yL61h2RE1kpiiwlOArcN7vk8c+4pvP2999HIhrC56SKe2Xa7DKuuIvh+lcp82MjwMCjpcbuyoZ+RX0VPJh/1YypX1Dvl8zEeZ+qdp65DirITw/6iAONc97Ri0BEk1ON6Eg5qAWwHaGUJU5+zjC3c69zmKhNmAoIAtmRfpcCypZLHNxPJVWnfAe62I2KNSI/Ky8L/xIId6qaxKU5uBmIp/cS0UwFs10y/RvGYUUEvNYZGTTH4+2B8qIg5vzG0eujpwekPc1dIxhzShyQUT6iS9IBjKeM6MMxY9cMIJTmJKYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w25UG7eTCI3epGPiH1p+gMYK6k6El5KE1bvDr0Nm4xY=;
 b=kGmPuZnBW1iLRXr2ng6VdrmrnKwOVtvZHuF6/47eg4mzrOaeQT+RW6Rkr82ycB7ao3vCCTzBiDW5FYxMtznfHYaSZo783O7xeN6dVruCrLwOcpwXoeB8oolb5C0lRgEqdzNMsJ5kb0zihlJnB6b0TFlwB73FxtfBJLXNblRlw8dSIvCGbIC5F3VTeL6HQC2B/5GDCFZFOnvk62FikgrHOYLOZrEmujFiIzVWYYpHyvf3mEcF6mhIEVrvl0BhRANlqlI7qBTmeXFtQBe+SQQ9omWYbnWAS9ZvyCj3EFyZ1z0agsqLe/uOudsTGuN3gnGxYQwXrHOxR2Wc6XukLWd2iA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AMBPR04MB457368.eurprd04.prod.outlook.com (2603:10a6:20b:798::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Wed, 16 Sep
 2026 19:26:01 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0406.012; Wed, 16 Sep 2026
 19:26:01 +0000
Date: Wed, 16 Sep 2026 14:25:50 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Frank.Li@kernel.org, dmaengine@vger.kernel.org, geert+renesas@glider.be,
	laurent.pinchart+renesas@ideasonboard.com,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	magnus.damm@gmail.com, vkoul@kernel.org, lkml@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 4/4] dmaengine: rcar-dmac: Fix runtime PM leak in error
 path of channel alloc
Message-ID: <aqrtPpSO-FOnUZZx@SMW015318>
References: <20260915035602.1724403-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915035602.1724403-1-vulab@iscas.ac.cn>
X-ClientProxiedBy: PH7PR17CA0060.namprd17.prod.outlook.com
 (2603:10b6:510:325::24) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AMBPR04MB457368:EE_
X-MS-Office365-Filtering-Correlation-Id: c7042bec-98cc-46ea-5e28-08df14285783
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|23010399003|376014|7416014|22082099003|18002099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	I82+mcWa5doO1O0mKklCmqreV9kvXVJbG3umnma+MV6MfKzoJZVqZt3dsNmuJugfbrny29Y3TZQFZMsiLO4N2k5wAinObw2rvQhSAk7wbYnxDqhJVi2N/8e3IeQUbC26UkCubBQxdWT42gfZCWHn7E+BVyIu7hsUER78840qV/TY5UIiMhCpRk7aOUgGFt29U3X+Q9SV2c4smlYtm804KvjAxcU3HGQ+l+GdfkjN7hW4KSQtDiy88vkFagp2INhI/Kj2KmsjI3wVpO48yxTGJQSca8QTagbyVgaC7W/Pz1mCdF5g7QzHqovNUR2eqa1xdJMar9GAp3fZBbK7CKqEjNcPjJvNhSy8BfHdNZRsJHZwXhNDI19PCDGEzMg8JYbenaspqUIyN4rzcaOmPoX9HcV+O7Ttn7aE/8OA5zmkej4eSfLlLV8At8BysTxYiCFNJDygH7EruHJtCuPlkzgJRwaieI/XYhy63M/OEjzBGNPJRamqcrWOG1sVwNi4KOWTG/IsMwlQEry35ArvawdWm/Nw5MoUOusQ/9JXW/+qIwQfFBJuUkHiqJ1kCx2kXQUYKH3zEzUOrQduryxBiQxayS0yeQS0QpSxZxRQrvbuL4861sfwUo5+AD11ejp2Z3TZTPhUctHEOuwM/Z2r15bAzJ6A7yBynTzn7RkOHEDYQCE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(23010399003)(376014)(7416014)(22082099003)(18002099003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J9CYfAYVHSE0qsheg/2VNaeAx2VG8rwuZzLVOifGeUugcRslqjwo9DUM5fRi?=
 =?us-ascii?Q?mta+ft21Lx3HVu84T3sfuRw50Kg5RNq6fgA6YFiwBAthffY0HABnfhd3LNyD?=
 =?us-ascii?Q?Nd4i4w659KhFYecCJUYqlrTc8gkyLaCYhkUsnsCOnYVji+SPq055dsAII2TX?=
 =?us-ascii?Q?XClngr6/yZSQibi8050yODaCM3Z1IuzlVPSOslT+DVmG31KVzn1RcdkAvkoy?=
 =?us-ascii?Q?OB6hiNsxFx3umwCIaQ3CVt46+hu0WPfL+hONChDPKiUNJlSYMSbuFHVge8GB?=
 =?us-ascii?Q?0VWMiCN1ohdiofmmBPrqSPgTvTXVaVmyewdob2HUz1B1j3nWoTrk5q8hIVpV?=
 =?us-ascii?Q?aG8As7ajiqD3FoMj6svMXXssi9BqwL/kdps/c5R1uipQZ3edt44VhShq79FM?=
 =?us-ascii?Q?++RiHgad22PxznN7oYluQszRk5MqYAqvttrfWLvQZJ9Yu53vJT6uPPu1B4C9?=
 =?us-ascii?Q?vFI0ju+rcMbfkNq9TcG3KOOsGIT3pNi2JuEls+zmVsIr63hm4OsPVWC/pDP7?=
 =?us-ascii?Q?TDcVSCDXgbC8NVlfq//GZngL4WtNQotvgGRoEglKLePqaPAZgWepHRJKMyeo?=
 =?us-ascii?Q?gCDWkNfMda3A+vad7oHy2TfaGbxS5Q5iPrE0vFzKDUf9JCry0qgYnCCRzlGE?=
 =?us-ascii?Q?BZbA1RxyMBuPij5oVPOgkrG036RuJ+rxh9eokIw+jjVRI9qiRaginAxR8Y87?=
 =?us-ascii?Q?pQth5oD7Bx7dE4Q1OTKudN82iRtVvVm6ZWFRW8BRutDSk2LiBYoHLobL3X+z?=
 =?us-ascii?Q?zo1sFnX0c7pvDvmyXpOuFmnrM++hTH5JCqPJROgamhCidzxJYORl228nwdGc?=
 =?us-ascii?Q?/12irLh0OIJl+N9YqXoEIgBojZBPCc8aCnQ3hBvDNMI/+4Tzv7do1uJM1DcY?=
 =?us-ascii?Q?jjLshv17rlTd0UsqYdicoAEnj9mA4+2C7YFelpNxw7pAt+H/nTaII1I+8t3i?=
 =?us-ascii?Q?6KWp0r+UjRBvjcqbivQuelVeIvmhZzFAyfsGhrj3NglJ2wmB1gHXJsDFzwP2?=
 =?us-ascii?Q?EE+Suh1csLBMAyOcMr4dgrOfhzdXJimLxkmIQCLxVyBKRq9NSsA6aqPd23cm?=
 =?us-ascii?Q?o5B2JQjBRFcBvhIX5IZI1MuigefQjDwOJvNwrs7ydTuUXwJuXpvXW4DdGtHW?=
 =?us-ascii?Q?CebcWotQHsHKEhWzgUeYDl/8MqMZWxN1doBvr0UQrx225yPrGRYC5KR/PMWo?=
 =?us-ascii?Q?Xb2z22Im9g0Qg45ducqT4UEn2Unr2qOJDmeKEZS6dknbYAgFqLHMtOMOIoo+?=
 =?us-ascii?Q?UzDrCcFIF7FjyXHJvLNK1+9QRpbSAkq2E+/3/VL4hBHjUT7LdAsXPt9iFFNE?=
 =?us-ascii?Q?qIpc42UYcMCkLcnOGBcRt2eqTcylaX79DNWNWSQNhw73QUHKtycPxmKw2hz4?=
 =?us-ascii?Q?M0SPIOPF6Mg1QLzyZZzJtkmG3Au74KQFc46fhhZaQwIf0W6XGpdnwmv/nl+B?=
 =?us-ascii?Q?wipMwydcrgVj3EshZtipXkCnLtv9GH6xkRXSYgl28xDHjnYth9u6sB2PZhJF?=
 =?us-ascii?Q?ztWq2/3QZfwBBWw9TnsugPDmrf/L+awyyJ//RlW1ekaaIi6aJIUeIHib7rgb?=
 =?us-ascii?Q?dMD0oqQ6eILCoijBV035uV/RWrU33uLeiXwADmHcFNJ17owI9dAwI7sKqIH3?=
 =?us-ascii?Q?Kmzsyx6f8ZmxOHKhrYahCaHCQeZudjUIjDttEe6RRxx4OWOnr9zGzTNdpuAT?=
 =?us-ascii?Q?3nSzSqm0y6XkjYIO0ZEugXMfhqNPSI3qCU7nsvfHgWsa+d2JD9Cz6t78gaRF?=
 =?us-ascii?Q?voa6IUFtbAohCCIwrkKdMw43y04BxEf57InxG+ySUeFgk+pVlHBQ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7042bec-98cc-46ea-5e28-08df14285783
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 19:26:01.2238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qNgrP+RjZ4vfr0E2tuuaQHVOGbSZQaZvl4jqWAGajwfj1ImSfsJt7WsfeeolH4dRR0h+uoi/3sO5fKo3Hn6HVoDlc4elCNBINgheT2XM1da23DHEyXX69UI3EZbo6n/L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB457368

On Tue, Sep 15, 2026 at 03:56:02AM +0000, Wentao Liang wrote:
> [You don't often get email from vulab@iscas.ac.cn. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> rcar_dmac_alloc_chan_resources() ends with
> "return pm_runtime_get_sync(chan->device->dev);".  Even when
> pm_runtime_get_sync() fails, it leaves the device's runtime PM
> usage count incremented, and the negative return value propagates
> straight to the dmaengine core, which aborts the channel
> allocation without ever calling device_free_chan_resources().  The
> balanced pm_runtime_put() only happens later in
> rcar_dmac_free_chan_resources(), so the reference is leaked
> whenever resuming the device fails.
>
> Use pm_runtime_resume_and_get() instead, which drops the reference
> again on failure and returns 0 on success.
>
> Fixes: 87244fe5abdf ("dmaengine: rcar-dmac: Add Renesas R-Car Gen2 DMA Controller (DMAC) driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/sh/rcar-dmac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
> index 44eab2d21d54..2d2baa36feea 100644
> --- a/drivers/dma/sh/rcar-dmac.c
> +++ b/drivers/dma/sh/rcar-dmac.c
> @@ -1068,7 +1068,7 @@ static int rcar_dmac_alloc_chan_resources(struct dma_chan *chan)
>         if (ret < 0)
>                 return -ENOMEM;
>
> -       return pm_runtime_get_sync(chan->device->dev);
> +       return pm_runtime_resume_and_get(chan->device->dev);
>  }
>
>  static void rcar_dmac_free_chan_resources(struct dma_chan *chan)
> --
> 2.34.1
>
