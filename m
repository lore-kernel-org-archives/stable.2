Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793204659;
	b=lVahR8VsnE0xkLXuvKLxMQgALFYXe6yM2aVmiCCptI+41jpiZrN2467/3petWrWeLYnp
	 BzQceyZ9OHv1GaW4gzTSNsOjvuppv4UQBhvWRFjxvrdkfa5UL+UD/jyXxQwNSdgyDbhz5
	 NwhgK0ZRTs1X1WEIW+DM2GWy0Mj1yb3fhyrNIn+bqht7/vQy/SGZdP93e2Ye8sI6Szz7b
	 1j2dr6+nvrXrRBJCUTg4VFwvUFRnosAPv+tJscKr+mYGTnw2nHKWQVAl9pG96hmZr3OiG
	 n5kvk99UpCf7j5PsB37U0quj7Ctz+PPEB590wq/VYteZIgOgBv2E7Fkq9BS6ApYLlCA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793204659;
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
	bh=RzghwIJywr9/TH2WGtcNN2E1NcXxjM7oYHv5o8xHrP4=;
	b=t4LJ/HhMwthe+tvZxiPC17QBCvYUus4jsY528L798bc/Uutvaf3oBYM8FY5D+sYStEQl
	 GpueEGSp3iZwyF85zFZCz97ZKFHnj1ofs3tgbF0YB/afM6MMB9uMcYnVLxIX8UOwTs66h
	 bTJuNojSoJnIKeioya2UE4gG2lsuBX11b7boYSVVJyUGMEI/tPiXo/Too86xIBN6AiO17
	 6dESCqre2rFKStNDRhbzmSZ0dWvvssSxgLLgLVgGazlJGdizNIsjEgCtNpwz8emgqxuK3
	 MqBqDhEntfw9kNu3wD849SkliOqXYLgJkqsluwETHszSjWoX25ZQpcKeofNHMC9LtTQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=EHEeAMSZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.48
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013048.outbound.protection.outlook.com [40.107.159.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D094606A31A;
	Wed, 28 Oct 2026 16:24:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D094606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=EHEeAMSZ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HI/qAxPqMsq0mOlKLWjWXSM0oohfWvaFIr8P/S9DTQbBq2gCh5AsomyIKJqBD1/bwtNmaCXlB0/U8NzFYrjz0IdELQczkGyx5T6dd6GXWSCygZNoJ2QHeOQbXAHGFes0uXQtwXh+AX8RYE2VnnoHmGocUycXidxm5igZFXgLNZCUjEpPLfRMzsu06pPJ0nbcevvu5b5gVa0x7zFsHO//QsJDNQhTz6wKsFXlrF8OrEPX2olbLspzgVGq1rh0rc0MwOAb/uzQQ4PkDwJRu9BEiwai3vArEEMP9Jf6YrZ3vxN9yOGvtMuj/Ye7vUJemkd62Y+QrebP70o7ufftjswKEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RzghwIJywr9/TH2WGtcNN2E1NcXxjM7oYHv5o8xHrP4=;
 b=u85YvlTgZNirZejLXdtrQcJ3hwQa9ktE5AH5oF0DIAGpGoC8tbIG1Baba3C8vFoZ4te4J108U2vHT03l7ul/jFMxiB3HGBaLf5vEmCJJLCWo6QdXVxK7kO+CgpnXNrKzRKImenSHfGCGyRdd4D6ug/LA1P81SHZI8EcbuifKuueGiIyIDDfx9iTKFF0wvuEe7TxKIOcDZ6O7zrC/3wNTwt56U3+yqB+01jfUJfz7BzzzkdmWujw4y0j+WN4omye4S5REYQjw405U7Of/yT6g9QlbBhccR2N1CgsFs+CHzBpWwfD/XbV0aC2k6C89lOQja1wwwBDxIffoHGcM9zJOWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RzghwIJywr9/TH2WGtcNN2E1NcXxjM7oYHv5o8xHrP4=;
 b=EHEeAMSZ4rt5aZvZ+hRaf0WLttqRJpsCZTUlSnEB70W+7srOuc1H9s6S4W9KTnuwkCXLmDT0V9AhMMynXchyixkO6gMoT01XLFgRC501nroYWxMJEwJ/5hEoN1HEQXMV0rdgwvmDfPV1srXHTjobCUBJn3gXFz7AFxSNmmtoHdysJnFsuNv+un8mOWIOs4sMW6e7+HKc9GH1zcAaptwnA0OtLA/V0+sNckvUE3xZkXsGQAur6JlQ/PF8VzE1KjEGKNUq4AztzEhHZn9eRVIhiVnAy3kyL8GtZL+hIxwqdlpsOshfwohelkuglBL6AThbpOn1DuAP93QknEk1lVu95Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by MA9PR04MB203935.eurprd04.prod.outlook.com (2603:10a6:250:110::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 16:24:16 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 16:24:15 +0000
Date: Wed, 28 Oct 2026 12:24:06 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Viresh Kumar <vireshk@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Maciej Sosnowski <maciej.sosnowski@intel.com>,
	Dan Williams <djbw@kernel.org>,
	Haavard Skinnemoen <haavard.skinnemoen@atmel.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	dmaengine@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, stable@vger.kernel.org
Subject: Re: [PATCH v3 2/4] dmaengine: dw: serialize error recovery with
 channel termination
Message-ID: <auIhpgXNseoUh6an@lizhi-Precision-Tower-5810>
References: <20261023-submit-dw-dma-synchronize-v1-v3-0-c62bf048f5ce@gmail.com>
 <20261023-submit-dw-dma-synchronize-v1-v3-2-c62bf048f5ce@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261023-submit-dw-dma-synchronize-v1-v3-2-c62bf048f5ce@gmail.com>
X-ClientProxiedBy: SJ0PR03CA0202.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::27) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|MA9PR04MB203935:EE_
X-MS-Office365-Filtering-Correlation-Id: 311f3561-b313-4e71-d7f4-08df350fe8e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|366016|1800799024|376014|23010399003|22082099003|18002099003|261028144727099003|261026140227099003|10067099003|261021123027099003|261021121427099003|56012099006|4143699003|261009223027099003|261022105027099003|11063799006|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	Zr+FRimxpm0VfikD0081C56mro6fbfD8tX3ZwwlmvMTqIHNmwlzMGSxiLC4Bl1xEsfrOJlcn6DwJOZjQdh79CfPwRWUW5aGZOvVsm9oBDxd904cw7E8J8CbzN52IKwv/v7rjrbby8z86F85eI7AniW4TR4jCcOrYZbf0ZONtynRmore9dVoPm7A2TI1AU9a7s4xNcCLhg8M8li1xqgATBt+XG/ePc3dVbBPUfQZcrK60VW/0hy64QdMbuvoTdIj3SX3xTbP4qOFuayCyeWaXrqEdjw3VOIhYHcKgy0cKm6NQXXofxx+Q3zIgs2MPhFqWJJVfycNhqVLDzF4kJXGNysQsXC+DNNWy79wk0gHiwe6K1weQaKjJsaBzLNKwhPuMQ/XCIgvlfxXt8yY27GVI0XXAS6HDhOXiNLa6zyrwagq6naqdjl9vUbQ6Bon73WtpXLC/cZzE7yIKMhvzo6Q+xi6ZAZ8Bf52cSzeqAqsoKIv2hYpVIL/8XjTq2x5k3gqzuI9JRzPGKISuQcJyOa+kQ6zo00q74GxNu5dQhUcCj0Q5cb7vrtFwwRlQk8OrlX8aSX6Na79X8Pw8qXfCwdWKJzsbCEpdqRGTDRBp3jz2fXzhiK92UQvu8FPKw5QikVSosSgb/3K/MTrh/vt897MThRbdy03x3Nk0VA7TvQkObso=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(261028144727099003)(261026140227099003)(10067099003)(261021123027099003)(261021121427099003)(56012099006)(4143699003)(261009223027099003)(261022105027099003)(11063799006)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B3DE4JC4KuBfhE4SwrENK9nTViNQmlhVgecMCme9gXivZ4MvCJAdDgjBK3Fs?=
 =?us-ascii?Q?Od/W5Nrj77G2j7/7ERAAPP79LvksGVeoGzfvGKA4MzD393xEeFcDhtQ3Ugey?=
 =?us-ascii?Q?oenh3Nl0bc0yhdfkp8nT6XKoYRtn60kMdROkN4RqUcyWEE3H0t4xtaanghzO?=
 =?us-ascii?Q?EG1Cli7mHC9gBYrwmxp8jQ0/hOwQbJT3DNm2uJ8Q40E1VxO+HH32vsvApDvS?=
 =?us-ascii?Q?4B0sLolSeZc6fHDNM+/JV7nlivE02iT8ogEeK7M6lZRL4NKbVOYOiOSRSAzO?=
 =?us-ascii?Q?/S1Mv4qZdRFpsyGTLHT0A1G83A7AkHclOaKe1mJ9S5FR/vUxaU1Tc4urNFjj?=
 =?us-ascii?Q?mLbrxK/f0q1YRW5vHE4qyk4tXfq1eykrCTk5RJvF/kX/4aeRR3sYD4Rsf1mV?=
 =?us-ascii?Q?dTjQ1ji0iUw87yF+vzNohM0ZseUZjYhbG+GMHjbMDUQHBB7LiJKbn5nALscK?=
 =?us-ascii?Q?cunWubzWkCYbKbLE2X7qEE3jh3YuqqHjY/Za/C6UuV1ma/iqRmMbuGCt4ZtC?=
 =?us-ascii?Q?udu+GxkUD80Tcre9KOVMBWOYWr7jvZXjErv9Ym9otWjOg140YisuNrGWlVd/?=
 =?us-ascii?Q?zOQx3yT7ZXtOxR9Dy2ppuhuEhSFwTrNKDfrx8JtnfcQ7G20NyOH01s09QEbt?=
 =?us-ascii?Q?s7Lg/OM9sJr5djyar5MRAOms4/1AQIYiqPuLqLZRCyxx5MYd1ErrgC4vqGYV?=
 =?us-ascii?Q?NmfDOjMo4HtNyO0cbE3UrpKn2YTLKc75wB9jFN20S8YuR6eS0GRG+PEg6tkj?=
 =?us-ascii?Q?dxb7Xhlf1a2EYOtQyS2pn1/Q/aWwgCK4J002VAFDMDRGaa7XRlw1qLcMwzhn?=
 =?us-ascii?Q?g0iwGFocv9LmKubfyB+68lEucmduMw4hqleteINWc0Zn0ZU98VgPEivGOTHH?=
 =?us-ascii?Q?fOV9DxyhXGAKkOezAC0A+aMKJfyIksFde7/h323XAQ/yq4TxnMreEgcCwAe+?=
 =?us-ascii?Q?jyMIIuRO5KkSSs0ulrNuQDuou/XAaLtVU9D/qLwsrqY3PRlUr6dT4y+kJc/z?=
 =?us-ascii?Q?AISU6PpLJPMMhknyXs7Ovz4O9lNrk8DJASS4VEXa/khnH2D2tcDBWHAn1yeZ?=
 =?us-ascii?Q?KIuASrlXPIZ3cR5A9wsDQPGKev4IW4As/t1/WDOs8XvAa+kkRe1uBxRCihS1?=
 =?us-ascii?Q?0WYIjUuPXei3t33zwlX0WimRNNKf86KAZEVcpZ7dhi7oEc/AXs1jTWtrYSvI?=
 =?us-ascii?Q?vVYlKA3eiKrsffyz3I5qqVaIRD+WpRzvZYWldfGDmOpkDEA9HBVzhq4KSu6Q?=
 =?us-ascii?Q?f60MXT+3fmfdlUjacX/3o4LycAYRugaGYMOeQeUfGEelxO74+9wBFgS0WpvK?=
 =?us-ascii?Q?gytO7NpWcI3yiBM0P6H0/92WykqU/Gp/2T1B+sXtC1l5TyaaAhuvDgoxdTYO?=
 =?us-ascii?Q?E0Ut1ygGBiURc9EQfUEzwoGSWpg0lU5waclfoGvCoQkuXJoE+6MeCs/T4+2+?=
 =?us-ascii?Q?CMfT9MWoLEgG37jTojxdoCCyejIDxbFITOlctNUCfWnGkfH0AHQimWkkVorP?=
 =?us-ascii?Q?EuHPPlhEh4aeMB5KDlHA1pKuaIDEa99Y7YZ0wo31mNmrDuVo3RNxlr+5iEib?=
 =?us-ascii?Q?rgrCyhX3i8+eQh7XQku1bKuI/s/lUiYE9q7yULJyNi1DW5HTzNDqchObqZiD?=
 =?us-ascii?Q?JUtk8RKf4v+/l3FxAVTWRzjTH3MIXkeST6ljXw9j81dnX+CQNRrw81syDi5G?=
 =?us-ascii?Q?eGuFGb5yutf518+cSd/mk0rJBkyydw3n0aItK3NBZbpYg8L7GDNF3kt4WVqF?=
 =?us-ascii?Q?PA5NTUB3o6dN3Z5VrquoYVbgJGml4fY0ETNa6MTUU/MoUeRhmUaH?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 311f3561-b313-4e71-d7f4-08df350fe8e5
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 16:24:15.8783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jCckQtI9UWByRNrQ7oMzPbFMRhCB6zFII2YaqQqf8FPddePjVhJ2nRj9FJBh/fZSLWDy79q9NqrcSmyK0o3dbChZ6z4z6Og9EKIbVSpdmFiXXfNU3gyNcweUNq2UTLHn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA9PR04MB203935

On Fri, Oct 23, 2026 at 10:27:23AM -0600, James Hilliard wrote:
> The tasklet samples RAW.ERROR before taking the channel lock. A
> concurrent termination can empty the active list before dwc_handle_error()
> uses that cached error to select a descriptor. The list head is then
> interpreted as a descriptor. Even with an active descriptor, moving
> queue.next unconditionally can put an empty queue's head on the active
> list and pass it to dwc_dostart().
>
> Recheck the error status under the channel lock and stop the channel
> before selecting its failed descriptor. Only one transaction is issued
> at a time, so take that descriptor directly instead of scanning for
> completions first. The scan can otherwise complete it and start queued
> work before the error handler has identified the failed transaction.
>
> Detach the failed descriptor under the same lock and use the queued-start
> helper, which leaves an empty queue alone. Clear the software-LLP flag
> before restarting so a failed multiblock transfer does not prevent the
> next transaction from starting. Keep the completion callback outside the
> lock, with the detached descriptor owned by the tasklet.
>
> Fixes: 3bfb1d20b547 ("dmaengine: Driver for the Synopsys DesignWare DMA controller")
> Fixes: f336e42f73d9 ("dw_dmac: Move single descriptor from dwc->queue to dwc->active_list in dwc_complete_all")
> Cc: stable@vger.kernel.org
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/dw/core.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
> index 07a5f5105787..51c5460b4670 100644
> --- a/drivers/dma/dw/core.c
> +++ b/drivers/dma/dw/core.c
> @@ -408,10 +408,17 @@ static void dwc_handle_error(struct dw_dma *dw, struct dw_dma_chan *dwc)
>  	struct dw_desc *child;
>  	unsigned long flags;
>
> -	dwc_scan_descriptors(dw, dwc);
> -
>  	spin_lock_irqsave(&dwc->lock, flags);
>
> +	/* Termination may have cleared the error since the tasklet sampled it. */
> +	if (!(dma_readl(dw, RAW.ERROR) & dwc->mask))
> +		goto unlock;
> +
> +	dwc_chan_disable(dw, dwc);
> +	clear_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags);
> +	if (list_empty(&dwc->active_list))
> +		goto unlock;
> +
>  	/*
>  	 * The descriptor currently at the head of the active list is
>  	 * borked. Since we don't have any way to report errors, we'll
> @@ -419,12 +426,7 @@ static void dwc_handle_error(struct dw_dma *dw, struct dw_dma_chan *dwc)
>  	 */
>  	bad_desc = dwc_first_active(dwc);
>  	list_del_init(&bad_desc->desc_node);
> -	list_move(dwc->queue.next, dwc->active_list.prev);
> -
> -	/* Clear the error flag and try to restart the controller */
> -	dma_writel(dw, CLEAR.ERROR, dwc->mask);
> -	if (!list_empty(&dwc->active_list))
> -		dwc_dostart(dwc, dwc_first_active(dwc));
> +	dwc_dostart_first_queued(dwc);
>
>  	/*
>  	 * WARN may seem harsh, but since this only happens
> @@ -443,6 +445,10 @@ static void dwc_handle_error(struct dw_dma *dw, struct dw_dma_chan *dwc)
>
>  	/* Pretend the descriptor completed successfully */
>  	dwc_descriptor_complete(dwc, bad_desc, true);
> +	return;
> +
> +unlock:
> +	spin_unlock_irqrestore(&dwc->lock, flags);
>  }
>
>  static void dw_dma_tasklet(struct tasklet_struct *t)
>
> --
> 2.53.0
>
