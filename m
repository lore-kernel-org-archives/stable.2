Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013030.outbound.protection.outlook.com [40.107.159.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4777E4028E8;
	Thu, 24 Sep 2026 21:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790284676; cv=fail; b=ASCAYLxWEX1isuHkrQVeZ+dciiR2s7YDnUzT7dPeOpeaF9WsQJAr73cRiAIYZclYltOtgPvb6bf9bjoU7M8GEDdHLyC7/Kl93M7wYlSPdLSGtKJg8oRAz5veVHLSgoFECcaJigxuXEbEVHv4WRKG7unbA6098Hwfr8sCpebot9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790284676; c=relaxed/simple;
	bh=D3bWFdwfINFYXeIqACOKqf1wfrlGbFDrUsXAKdNXclI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EAHx0wKuq7GacTYJgUJ5ZTjKUK6f9fvnVoFiJeC1IOyjFM7CgJScmdncpUtGlKwzb8s/s2R8Hv2ywdtaV9/ncPDlUtneV6a2HLWrL9OEkh4/PS/nh5jPlV/6R9lhOZjLPtgGWqUdXbvCcLBVzG3nzk/1CZNCDbBiApL3m6H9Hjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=N2pZD2RX; arc=fail smtp.client-ip=40.107.159.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="N2pZD2RX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JWWcizvcL2Yvj/XkClb7U+w0mBXbOmeSaTIru9VOgdsEvfIPmJyHPQ4B8xdueNWz5ICeI6BAhlx45c5ul7hI8Cn2+3aeA7LrmwbTrqZJLQOlx7TE54css9c3Hggkix9TmCoNFNrV8rKTTfy1sRpvG3O/P5ylrZCBGyxIDalESwn0vieWFjFiRmx1tGTVYQVB9Jj1So9yK8HCst051MuCpxWiSVVAHVzjNewJ4ilrH4xj1vajN0fg/nkTs+lCPg4m98n34iyrzcJmZRXD/bM1dQ8Q2YUXKHEbRffnlcEqXbuN4RhKcP8x8htCJR84bv0ne7k2ghmPIiBsdLkuRd6Mtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nTP/ob5DqXbFtEORQSF1xROnwkJsf8nxM3/NszPcKK0=;
 b=HUqa3izoW7R0feixsiXJsed0tYx47K8cuHwqEolHXsRW0wa2YrSYZRaOc41aFbtBnZkYsMBl2Y5RWkwu2EXP511eFv2xzS1a7uec2HltMLv9j/cfMZo5+6C0RlJKB4Z0z2TpHvIJLh5q7K5kbxxtjhwP8pBrL6IFTFdjMNZuzh7S1JacolHEcZjZdhSFOKt1KXYAHueLWaCFGM4O+fKsNCWo7fY2HH+wYz0fBOO8QgNv3PJ1N29ShRj2HV+aQukBWdPeMLNWQhqJXR1G0wosepZv5XUnGY0aBUDcOZLkFuY8pRDYovN9A1SjABfiU8XE6f3U0qom/VZnzWfM+NxXFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nTP/ob5DqXbFtEORQSF1xROnwkJsf8nxM3/NszPcKK0=;
 b=N2pZD2RX+vtjWE/YwiC0H1S4V1Y9X6GolaYXDB5z7KQ6mebd1/G0PP4UzkrsFv0G9RygLgQT7+PTYhPNlicCA5oDFOMhQEgEtUrJNTLbDc7eKfyYpxH2KzZU3G4WRvKIklbFzWgIetnHBzpNnV47j3tKty1vyGhZDg3VZHB78dlH8D4360m1zqW4pcoN3Tmfs48wRYsNvneMY7+DI0yve2KjGznbfUGZwAdPwqpQM+4t/ZpG1cEaCsuEhm6lgiwgoXEd0C1+tWZe1fjmTQXWPf1ErcKBPnd3tKtJ8fTXb7AXCuNculoeDHqeMaEcw7IDV4tFnHmYuKf+RFFugL9c0A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM0PR04MB7123.eurprd04.prod.outlook.com (2603:10a6:208:197::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 21:17:50 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 21:17:50 +0000
Date: Thu, 24 Sep 2026 17:17:42 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Claudiu Beznea <claudiu.beznea@kernel.org>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, biju.das.jz@bp.renesas.com,
	geert+renesas@glider.be, claudiu.beznea@tuxon.dev,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
	stable@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH] dmaengine: sh: rz-dmac: Fix off-by-one in residue lmdesc
 lookup
Message-ID: <arWTdpFikA2brWXq@lizhi-Precision-Tower-5810>
References: <20260922092037.224884-1-claudiu.beznea@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922092037.224884-1-claudiu.beznea@kernel.org>
X-ClientProxiedBy: PH7P221CA0044.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:33c::14) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM0PR04MB7123:EE_
X-MS-Office365-Filtering-Correlation-Id: 09211d90-9f07-47fe-f814-08df1a814a12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|19092799006|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	oowqxB9iM4OlYmZo1F5QKV5LFsbs04Bb9CVucntJFhlYOvl4FUH4g2xDhNut4PP/AjAVKjOVNfDx8eBOkkDASwLGq1urr3CyVwIb1+BCdzUNyAlf0Ht8zG0w8CqMml3+OTtlazozyl5IRUO+sxQt8RvUi6a+D0BwiMs67kzITAYkuWxlmj0RXesKoYbGLxqiGilrIFM+/NSOk1UryRrZOw8Fk6UjKux0vAESUtO1SdCBB2Hjjssrxw2T/LkDrD8Pjmu7rlTPPLrQroWa6uIF+1n2sJs578dOy8zaVDCib8Ba1AYGGFJNVy44YeZg4YgrM+BLTcXGGW7MltcuTCCuwckLzH1wkDg6TefSdHLprMV6A/fDPdJsyW3JFu8RBFelOFHfFVI3gHY4i9MpktU7Umq0E1jSAaijBckWOtxrAj5/ZV3rfPLk6Mv71R6CIw8k9ror79o3Ylo7yqsE8M7gIdAJUeVA2tb8ektAb3pJCHZLHqk7475FzORN8xXAQZZik6p200/OzNb74MgtOoIVfYl5b2qdZqFyAvgjqP2rrb8sY8/rNBg+5ny9kTspg9xGmtWZwU5JJX5TPy0S3JljfC1CcE8skeAWiBtrtcbyxf+16XmJShOTejJ2P2rAysx3qjFM6AvVGVdDxdLesStrksZ5Ym6pKpdVxZ7KjM+QiwI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(19092799006)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pKdC95cRtBfizyqaacPxfkCxngR8+0MX+ZqGVxba/obnV+uZrv1glMUEXzYQ?=
 =?us-ascii?Q?GFguZoJUJopfOn6V/0wb/xitjZjKxmBKsGDEc9ZArRijPmiM8g9i8JilUOcv?=
 =?us-ascii?Q?h6V+6zaB9/UJ4JblrkWucSfXTnrfAW0DbjiJqEBioO6YRqUjrVmH8RiD/ig4?=
 =?us-ascii?Q?r63xLkdI3DV0xxbvDBLg0kwTlNBA8pL49hnSSJo9w7JQu/QtS+FPhpoUz8J3?=
 =?us-ascii?Q?zMO0v9i6LBuSlvHR5cDCJs+PgoqR7d7LT7sRXVqW+4F+vAoC0KJ9lOA/Ru3+?=
 =?us-ascii?Q?lumMvHVU9/y8s9fGYF1EoGHsOdSNsDNQeSuXw9Tq4TAS4nOydBavfV3/u8B4?=
 =?us-ascii?Q?hywfSSfN8H1t4uGmfSqeZRZe0islRgbv/r3TpvQ65/V7VC5SJ0iFzju2OLpE?=
 =?us-ascii?Q?eDEGRDo/hbNwh7ua5pPuwvXX0TSOzMmOxt4rWnE4eqDbfSEwx5whnvEWcMHQ?=
 =?us-ascii?Q?1aCH7vo6UQ8ZwazwCeV5Mzld62sn+449Fs2Lr/lvNHo7zUSiTE1TChHgsaWf?=
 =?us-ascii?Q?8MdOsUjiEGMH+0gcNZpu4W+s7AaT4SpNYtgftiozVaEpK9A0ktZ8JJBqn6jo?=
 =?us-ascii?Q?2pRvGYrKHUZ0njaxB2Ims43qbYG8KGYbbi29tVTacWKCOkDVOqzuaANoRdJ8?=
 =?us-ascii?Q?SZKgzLHGvsgetZ/bCwUZyDkls5ZSTkL5NqR/fyZhgqyw3XyP5IawssX2Pdsq?=
 =?us-ascii?Q?CnfRD/XOnVVqoB88DSySKfkSIyRbbgEq0t608uypXExdpTbljDJ6D2jsAyGV?=
 =?us-ascii?Q?vlyr16HmcN7aUgggqaOMm5jwXauKmvTUrAUxiWVO7Gg4R5FKtqWrueu0EETF?=
 =?us-ascii?Q?bVLz1DhV6u7SECMJxw9FKgT//ydCYtMaWsfM4I8JcaE8EePgoFJZtoCUmcKH?=
 =?us-ascii?Q?YAiTygu0zk3FUHZNgwORJnBStY/vqvU51zn+LfRZPrQ9WuVEpzUnS2Ok7Vsp?=
 =?us-ascii?Q?XYx1yANJesFaq+Jgai0HgIL0HGNAJiVNUamov/xmKiN9AVIHMI32K8agBIys?=
 =?us-ascii?Q?zmayvH2b8gkhLhGe9yH9vDIvLmzLM5SfLe4lEg30PPM+vRNVqt4/JXMfGvsK?=
 =?us-ascii?Q?FQC03cU7RwwV3xRl7AljcJ68Zlo/tCpIzDTV4HtHtEdqLPGKfO+xT2j0ubtG?=
 =?us-ascii?Q?Oc+xt3YSwEyA3agvevOhe3591PxSZuJOq8KsvdioE0mIpgC2STBFBFPEaVMc?=
 =?us-ascii?Q?+7XpOlljk+OYWKsPwrvKbGSBMr168tT1ii9iYpmFM6mgRV12BEw+LG4BjF30?=
 =?us-ascii?Q?lW3fMRVO2546hwj5ZYIN2IS8oIrBBJQSOmOeoUMOEYWm2BmMYK2SJA4qGa72?=
 =?us-ascii?Q?AL6cY0d4HTMF3v9Xq0CDjwRVNN4VZXCf77dg9Qc+Z9n78XqGEMcC5gRn1/fC?=
 =?us-ascii?Q?eLNtcVz+FCUz+scYDHhgCsdy2YtCAhYXPLnnvD1bpEtqyx9l9kClJB0GxglZ?=
 =?us-ascii?Q?jp2NiT7WHh3KAxjVXt5JLN5pMQabKjVgu4yM2HMX0sC727yPR8wMloCuRDqE?=
 =?us-ascii?Q?QduD6VvYXf0gRtVmLUh7PBpaFL3MaJ6sFwdYX1dIdbr6XicIfwspJ8emywvF?=
 =?us-ascii?Q?U2YJ44teA4D/r6aQm106/6CYRbijo2ptKaPBRzeZ4TCEIU2G+MGs1jM2DX2u?=
 =?us-ascii?Q?oPlf5jFCba34q+imWGOBq3OdFzZEmQHsywkqWX8wVGN+1Ax0T972EEhfR7Vx?=
 =?us-ascii?Q?DUncUHnhDvBr1ZEQRu/CGrd2fWR725zdfepfUtiievHkuqgV9tipo2dSX9La?=
 =?us-ascii?Q?T+CoHsawkoMg2tsKzI3PlkcJufi8z9lfaTUb8uWv9fKHPC7SNQPX?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09211d90-9f07-47fe-f814-08df1a814a12
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 21:17:50.7598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3jua5Zg7eEtZqU6SNPDgyv39NL0dBdfevFfEHKjKAl5JOG0H/w1C5vuizVh2eKQsuDEr0yO4u5PeJV0Dzqr38IeCWMffP2TrrnIs+s9F+c/wYuD0HpU6uNqC4vrOleIe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7123

On Tue, Sep 22, 2026 at 12:20:37PM +0300, Claudiu Beznea wrote:
> From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
>
> lmdesc->nxla is the address of the next descriptor, so comparing it
> against CRLA, which is the address of the current descriptor,
> finds the descriptor before the active one, not the active one.
> The residue loops below then summed one lmdesc too many on top of
> that.
>
> Compare each descriptor's own address to CRLA instead, and add tb
> after advancing to the next lmdesc.
>
> Fixes: 21323b118c16 ("dmaengine: sh: rz-dmac: Add device_tx_status() callback")
> Fixes: 172bfb57481c ("dmaengine: sh: rz-dmac: Add cyclic DMA support")
> Cc: stable@vger.kernel.org
> Suggested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/sh/rz-dmac.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
> index ca76f1bb45c4..fdd7131e890a 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -937,7 +937,7 @@ static u32 rz_dmac_calculate_residue_bytes_in_vd(struct rz_dmac_chan *channel,
>  	struct rz_dmac *dmac = to_rz_dmac(chan->device);
>  	u32 residue = 0, i = 0;
>
> -	while (lmdesc->nxla != crla) {
> +	while (rz_dmac_lmdesc_addr(channel, lmdesc) != crla) {
>  		lmdesc = rz_dmac_get_next_lmdesc(channel->lmdesc.base, lmdesc);
>  		if (++i >= DMAC_NR_LMDESC)
>  			return 0;
> @@ -948,13 +948,13 @@ static u32 rz_dmac_calculate_residue_bytes_in_vd(struct rz_dmac_chan *channel,
>  		u32 start_lmdesc_addr = rz_dmac_lmdesc_addr(channel, desc->start_lmdesc);
>
>  		while (lmdesc->nxla != start_lmdesc_addr) {
> -			residue += lmdesc->tb;
>  			lmdesc = rz_dmac_get_next_lmdesc(channel->lmdesc.base, lmdesc);
> +			residue += lmdesc->tb;
>  		}
>  	} else {
>  		while (lmdesc->chcfg & CHCFG_DEM) {
> -			residue += lmdesc->tb;
>  			lmdesc = rz_dmac_get_next_lmdesc(channel->lmdesc.base, lmdesc);
> +			residue += lmdesc->tb;
>  		}
>  	}
>
> --
> 2.43.0
>
