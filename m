Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010059.outbound.protection.outlook.com [52.101.69.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A9B428470;
	Mon, 17 Aug 2026 14:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786977145; cv=fail; b=nv1QiSftgUeF/b6QrzTuIdOpYcBiqMOl7t75LywJx4RpCkVD9lFkubJ8WVYh+LLZ+C7Yk3J6WAvEFx86URk1zg7q0uwKUtRtcYex9ROANSj0/Ds17bI5xiHhtpjYsszubnppexQ+466dEpU1u7FzKE6WYk57qUNfc5s8iKgbC7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786977145; c=relaxed/simple;
	bh=3xH2J+5kYlWz8l/bkcCmc7vyvhS/VT16z0nTStA/oiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GaO8nWfGkVQ+g8ObtmlCc0kFVivjUkP7/nadFBgJAXEOj0ESZsgYa7Qfs1q0o0GfNh0xb6/JD35rLL/k0jK9e41UFjN2CrLj5rxSPCGdn8O83TSkbHaFheW9v63AgQVGk2w2lQT9u99B3gCj49HxY7IcLZQywGz2fUHi7m8xWBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=p/HfsrpD; arc=fail smtp.client-ip=52.101.69.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="p/HfsrpD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o2t59hTTX21lL/hrhRKLo08K8Sf165aQEUhcUc+C/Q/vy16Y3DSLpKTlW5pmkb4mQdvsBChyQ9XnHzjeiZzj/YP2fy0TkFs8dq7I8T6ayAqOhYxVA5uMRVj4BbiN9cP8qWprNF7NbT4r+A6akxPyWj7wsEgalKm2JABxjvoFtJyM/4NURv5XKjQowq0gfDl0LNxeHcKEZp5Zkuon3dUwjcrzea5jHLeMP30lf5W3qMsWDUHO7blmN6DpYYesSPEw/BvSoXxKlAQDJQ8sf29nnZG4kX5dVPuNVIIGS4WI1S0swXTtVBJLOKlfdvQG9TqEUq65L3MGt2G8yZXheV2SGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D42Ojai7SvRA6BHXsFYvi5v5Vq3oomHgQunJyacFpKI=;
 b=hhm6cNwiwwXHIj4aBxTl9mwK4kpFkRMsdYQR64Kcw51OFbBCznH93T2nbwlBRdV+7wPX+iV14+Cth/mSvMC+nifst9/LReD3el8drVRC8kLk2xZAFpws4Skh+Nhhlr87RtPFcnFiqwtwF8p56IOvKRvFNS/xFytuZo81gk+fm2+ecGzMD2jX1EZorfLPCU911438wZwlQH1ZRiEp4YfkQWn51zBOe5U/KndKkhWOmG63IcqZ6ZBTva5qHI01acfil2ukO47rOd2GehbCkcNTNeqFqhAV8ElzYec/JXgaic8ldzGy67ghMe7/oqm5Bm3nzIQBPX7XWSGcqPXAqWhf9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D42Ojai7SvRA6BHXsFYvi5v5Vq3oomHgQunJyacFpKI=;
 b=p/HfsrpD9eSzHWSqJTitNcXs0C/omhZ1am7QBFJuvGASNc1h3vBzQuTy6vztqd2oZUx7t1/GrkAaOeAb1cn8+sma9dkSnscMuK03NFJvChmcJxcc7NDIujY6KFYuEyz0VcRJFhjJ+T9BHe1OmFTg5dFpH9sdBHXycctUpxjCNCIsg9//TD3oSR1oks78azRXXxHb5Iw8LT2lrsZJNZRzbM00lR/V4+YRu5nOiuumF0ln5o+FM40y8uwjw1uJ6/jYmIcCuoNCsao/0ERc/BZkpsjgPCt8kpfBphZcbqZXvwz/z9g51+xpy93FVAH0qdMgxqrhjmt88H0/IpIIyVnKLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DU4PR04MB12028.eurprd04.prod.outlook.com (2603:10a6:10:63d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Mon, 17 Aug
 2026 14:32:21 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 14:32:21 +0000
Date: Mon, 17 Aug 2026 09:32:11 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Christian Lugnberg <christian.lugnberg@soundtrack.io>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, wens@kernel.org,
	jernej.skrabec@gmail.com, samuel@sholland.org,
	dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 2/2] dmaengine: sun6i: fix undefined behaviour in
 sun6i_dma_tx_status
Message-ID: <aoMba8ERfJh4jG4t@SMW015318>
References: <20260817135723.12807-1-christian.lugnberg@soundtrack.io>
 <20260817135723.12807-3-christian.lugnberg@soundtrack.io>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817135723.12807-3-christian.lugnberg@soundtrack.io>
X-ClientProxiedBy: PH7P220CA0180.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:33b::30) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DU4PR04MB12028:EE_
X-MS-Office365-Filtering-Correlation-Id: d5e111b8-4ff4-4b16-f675-08defc6c5923
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|376014|366016|7416014|23010399003|10067099003|4143699003|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	w+ZOlhOcJ9KdVNlJVSuJdhLqX0Xsz+RJIeXhUsdMslGULJkamLDFVdqc+FXuT2KUbIPW95RlychkxKsaWoWus2tOyTex2mXQ3VuFZw4MfTr1wK2SFPWX8cGWb/suY44PEMIXMl+g/EXupc79F1MMYdGsfrlD4EHUnLc4ZyJiDanf7NmbKGTqmuWk/ZbExkGISicMzDCaUMMKICRvIsfT7Xzlg9cHxQjjsZBSZKSc4wV/QGnZuFmPxlpcRjfAZBUiQLaaPGSyE8WJpYp4V4fNtuzp37SOpbZaB3iQ6NydLpATzwIK12MEdi57t1CocK/bKPMkXKqoRRw5szy2OWjOGdIcaT7ySk5Y4rEAFV7RMEaV8B/iSjegnkF+Pt1dT/klT/tK8d/yFa8VjHyRky1LWYOw3iu5goUeyz3zrBnNnmV5JCQcGMXV27y200Y4Lwu100fbSfknzwMkUv3aNgtJUjL3y/dJGcwiXDLS1plKn71ToKIA4Nh8rObIZaDBZ3tnYnAtUPFp+4ZbRTfBjK9e8DHw226O/qtnACvaVgU/Bqyn8J2fOXD4HVfEdYz39vkzC8aOL4lqGz04GjlqBTSMTXhWQDsiA/QN9pv1EFSEjYF7mqxmr4CCZ3xqFDa/RVMetWNKzqhOoMh3DnrjTr5FjcXj5VS7w/zps4QfdWwHdok=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(366016)(7416014)(23010399003)(10067099003)(4143699003)(11063799006)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hl7Ecx4/RMZWhrsd9cmIcZaMlDSYJD3zbKGgdnAwrWFQfb72LVe8J5Xfueof?=
 =?us-ascii?Q?lS0vj4NRqG3tLUg+FxFxOqqd/7s6F/y8dNAFX3ew2mljG+bA1aU+jdJgXoYn?=
 =?us-ascii?Q?GNSR0l2kRIPMqmBAYdXTttWh0mhSLu971HoQi4li3yDWTUIrYJiax/MPviQm?=
 =?us-ascii?Q?SzZVZL5i/8CpWj2Lf8TEkRaTm7I+k/fCJtldw7ntYRZCrFb+ZtgCES9ITRNC?=
 =?us-ascii?Q?2bnnLlCa17p6AWyKbfOAaa/qHXz4+1/4fdJCSB8rllWpUnCrJpY06NapoZzr?=
 =?us-ascii?Q?pqUwBUKqRnPEq1ogtd5C7C2fbGylb7oqvak0E3hYsmNrTI5PhXoE7+G6qezW?=
 =?us-ascii?Q?lUZqoYimW9i2lg7z25pKJ9KzMeYY8lFIoACG2HDbsEdQBaxXmIpSwRa7GAPY?=
 =?us-ascii?Q?sd3/paDGJGrErAPEFmdRaejl9B7LuysH3XnTknFO0sNVhhNLip0uPVR+D005?=
 =?us-ascii?Q?jqxesdHcJBGZ3dkh7WVc9P8MI69k7Oy2g5QU4FLji2+rLhcNxKigz4zDfld7?=
 =?us-ascii?Q?3It9M4gvDYf+2nZxVjGaGICIQKbxuOHapDnuy/dDrW7tH9A6pGSaKj4lMxLe?=
 =?us-ascii?Q?Z+vMG/bdTRFNbiWdLCYHkFmbHi7p8asJ/cxVowBQWoaQTLmAVX7InpO8R7KQ?=
 =?us-ascii?Q?/PgmflS5hI1XNuB7Yk2ZBnEPoFsx5HZut1BeysHfEHCf4Qw2DB79IRYsHthg?=
 =?us-ascii?Q?fwV1QLkF8n/GxTW0+/+Psfl1Kv39cLUW5fviSDMr8aIs4HIq7U3jCfPfznSP?=
 =?us-ascii?Q?rGhTCPx1umlCcFt/ktVf2NdNDiIdEKyvLf0BtshltOWnTBPePQWHG5hKwiZj?=
 =?us-ascii?Q?7Ea0TLqbBixgVUzr0uE/c+r5uNdVPLaFuwZ1NpYphqhj8Uuk2wzI+d4SzIeT?=
 =?us-ascii?Q?bDQK79fhDKzqYt3Hx1VHHuKmAws75aw7egkXjC5uvz2QieQtCnt9dfA1lYtj?=
 =?us-ascii?Q?0Ql89Y36sMoiBA+IoVNKbAGsvLQJe8mLi5wlS+zr1SFXYUPzqOMkNJmTfEDS?=
 =?us-ascii?Q?HsEg6iPEBkDlg+MwCx1Ptoa80Wz6L1rzf08zdg/gAZQsFjuUu0KaJAIWXwXi?=
 =?us-ascii?Q?KQcJQ65aS9601jqR2+qLgJlwPTKFAV0qSOaLFgwkirEZ+I32bLXp5Cy1JkoC?=
 =?us-ascii?Q?Oy5fJXSn6ebgb9Kt/TgRhzi2mxPaunm5ALQgzahU8gi2A6ZnNz6pd4kDzv+a?=
 =?us-ascii?Q?ZzwV5TrX2ZSdekDcSYug73ix2xDdEJBTvkfAcJpaXgccOs++Kxja5KTXJjkw?=
 =?us-ascii?Q?lEtaazDodh6gjq0goAV26MSz0qFajICC6QbVUpQOyG8QjkihHzfPZP8Od5mi?=
 =?us-ascii?Q?yJM+pzPNYt6EbTY5B78hOGTsC341RvOEukZfAE9kVulwmrkgyAaguyTHNSL3?=
 =?us-ascii?Q?4KSJFnfZFR6d/874nVQjlBxXslqDRovII9mgHw6LmFGDOxQnvU9d8niikNeR?=
 =?us-ascii?Q?xM3pF3zhbvQclObdYlrVbBapZZj/3GbW2Y14JIXl0fVYY+pmuJ61J2yGF70h?=
 =?us-ascii?Q?LbG6bpKfE+acSqXAz6a/lGeXuFwWKglkWFirUCE5Q73ormbZA8kepdfBSrt9?=
 =?us-ascii?Q?9g0ftJcsY9qUgSZJ4RzfNlipEbOylynyYHAXX9L9vuwIb4qLDPwCT/2j2C/O?=
 =?us-ascii?Q?Mi5irEwIt9YWm5Z/GfFvr43hT17iDHMMpX0tBhdpxkLf6TrBlaSvnLJJaUvE?=
 =?us-ascii?Q?blyJePE6TpwFjdItfxrP8DlUOwSapr80yjKyUnhDZlvf2+R8nS5VJlMXNGSk?=
 =?us-ascii?Q?nJ7+5LPngsEoiLQHDu1ILV8pSOo6odpYXffD5YqhlvVH19HIlPsX?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5e111b8-4ff4-4b16-f675-08defc6c5923
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 14:32:21.8368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QseKwO5xd2+aZDindNUF7pYr902s3XbSickaU/Nu4c1wrm5OIE4nPJoWCfKsC78wm4Cao3HOXTbZC8VqPj6LcK1i6ZlqzwgUnPTLiqB6sdyjstNKM/NgJjYiONWvrM3U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB12028

On Mon, Aug 17, 2026 at 03:51:23PM +0200, Christian Lugnberg wrote:
> sun6i_dma_tx_status() calls vchan_find_desc() to look up the virtual
> descriptor for a given cookie, before checking whether the pointer
> vd is NULL:
>
>     vd = vchan_find_desc(&vchan->vc, cookie);
>     txd = to_sun6i_desc(&vd->tx);   /* vd may be NULL here */
>
>     if (vd) {
>         for (lli = txd->v_lli; ...)
>
> vchan_find_desc() returns NULL when the descriptor has already been
> completed or is in-flight on a physical channel and no longer present
> in the virtual channel's descriptor list. When vd is NULL,
> to_sun6i_desc() is called unconditionally on &vd->tx before the NULL
> check, which is undefined behaviour. Move the call inside the if (vd)
> guard to ensure it is only reached with a valid pointer.
>
>     vd = vchan_find_desc(&vchan->vc, cookie);
>     if (vd) {
>         struct sun6i_desc *txd = to_sun6i_desc(&vd->tx);
>         for (lli = txd->v_lli; ...)
>
> Fixes: 555859308723 ("dmaengine: sun6i: Add driver for the Allwinner A31 DMA controller")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-sonnet-4-6
> Signed-off-by: Christian Lugnberg <christian.lugnberg@soundtrack.io>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/sun6i-dma.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> index 04fe1f5042e9..7704b016aed8 100644
> --- a/drivers/dma/sun6i-dma.c
> +++ b/drivers/dma/sun6i-dma.c
> @@ -981,7 +981,6 @@ static enum dma_status sun6i_dma_tx_status(struct dma_chan *chan,
>  	struct sun6i_pchan *pchan = vchan->phy;
>  	struct sun6i_dma_lli *lli;
>  	struct virt_dma_desc *vd;
> -	struct sun6i_desc *txd;
>  	enum dma_status ret;
>  	unsigned long flags;
>  	size_t bytes = 0;
> @@ -993,9 +992,9 @@ static enum dma_status sun6i_dma_tx_status(struct dma_chan *chan,
>  	spin_lock_irqsave(&vchan->vc.lock, flags);
>
>  	vd = vchan_find_desc(&vchan->vc, cookie);
> -	txd = to_sun6i_desc(&vd->tx);
>
>  	if (vd) {
> +		struct sun6i_desc *txd = to_sun6i_desc(&vd->tx);
>  		for (lli = txd->v_lli; lli != NULL; lli = lli->v_lli_next)
>  			bytes += lli->len;
>  	} else if (!pchan || !pchan->desc) {
> --
> 2.54.0 (Apple Git-156)
>
