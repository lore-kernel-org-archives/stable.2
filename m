Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011034.outbound.protection.outlook.com [40.107.130.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256F43B8BD1;
	Mon, 20 Jul 2026 15:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784561839; cv=fail; b=H/Mzmnq7efwzpuN8os2o+Vpv2CbTVnS/zvs1aAFJaxxWIetN7fuh92n5C0b8pQKiQXewncGeENUYLf9QH+/Dwowo7nMkS25sj2zD9u+w/l1hkcoEQEFpovvgbEde8ICasFdG0nJw7dhai3bWXnqWt4WhybQDtYgCRVBLS/5P8KY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784561839; c=relaxed/simple;
	bh=YfzX4olXiOsYKOTS15cBLonto2AegpaH6FI1iKWjI88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=j6Y1vfYZI2JyfVZ8wmxPbnOW8PS6j49Xo3AYPebeRzWcZBtSI2+VxMwUhw2hN14l2kyGwww7Kmp4IKFoF2l0BS5kADr+vovw2tJ1BliflvmxEFYNEgkYg5gdQY+dPBzIITn/FFUfM8nTb4BYCaP06BUzrSTM1BwLPEDhOEMhhsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=CGEIXhYo; arc=fail smtp.client-ip=40.107.130.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="CGEIXhYo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v7cFaUyBAV9l9wxrpwyKPbFXFGP03MAsNvn0h7wH41WpyXDkPgingbUYQz+8D8fGQpp4RwrCoonl1XqDI8MYnusNeaj1e6B47eaItC1n2/S4IKgBAPIXSlla7Clev7Az/o6ml+X+Bywa+QvAbhrgkROKSWwzQU+wQmPpzytbhMG5eQSElO6f/q/S11sQF9bh/1oO/n3upT4UXGB57JiIpkF5YL1QKzZd5ax4Poe2ZSMf0l2f0zoEqlRYfRJLfGMWhZX8F9U4tvNG15xA8e2kSM9g3y7qPAgk+e/zosj4i+RhvYvkIEaqMQgqH4mTyL3tOICq+xY/jAXZon5Gcswumg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jk3ho9lH9e94DKXc/n2ERZzz1vmPbGjF4U78iqh9izQ=;
 b=o/4vlFETnK7+wJeaQcVADGdecyYHUUR7wDqNKt3hPpOFkNy3AfSEBwjF8OztTDJc1r4NX49rMPSDn9+dyznHs7kBeNQs3nMeIFP1VEasePaw0v6xSQF2Wa7Lq/f9SOiPR+L8kdKSjM9od2WQAaA+TuhRzXWwjWnTsjCdTsgWbER+KoXvSKt0ZmFv7JgH6hCA03UP+z43VRiRULYoRv+7tTcCZIkiEXgGOFb8fhfJGJ2hyfUycZxKwMlomO18EQhJUSNgp96qyHs6dVBzXI2tr36VgRB68zR/k8OUAB7tSE13sy1WtP4g4s+MPvJicEi1KO3/s/9ddttXWOIZK5QyTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jk3ho9lH9e94DKXc/n2ERZzz1vmPbGjF4U78iqh9izQ=;
 b=CGEIXhYoZLTusiBryb81Vgec1tq9my6HSq5M2+oDn6IbHhPgCJA6VsDs+H5M+969IbIAMHQ/hGeRV7l9wIHayqOs8Vl2pRrMmzOuH/gdtGAFl+FyZ8Vh5n+sj38ykozSy6UbkfBCrBFt8kaw823Y/E7OmgfXDBrb4oGPTxsuerYtQjMM2s9Y5F6e00BszuxX2Hit4sosH7LHIUc7FVoGE9GVcga9SFRFBqVWJB+X6PAMd0ZZvLvD0hPp16J7KuVsEp0bgMTJAkXQ1PIxH243zt+NJM61j0V5e7JCBryp6Ab26Zy9Y3u60Ct+8ew83ACK6LGv8vh2bMCZ8bF8uiEceA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA1PR04MB11506.eurprd04.prod.outlook.com (2603:10a6:102:4df::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Mon, 20 Jul
 2026 15:37:13 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0223.012; Mon, 20 Jul 2026
 15:37:13 +0000
Date: Mon, 20 Jul 2026 10:37:02 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Guoniu Zhou <guoniu.zhou@oss.nxp.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Christian Hemp <c.hemp@phytec.de>,
	Stefan Riedmueller <s.riedmueller@phytec.de>,
	Jacopo Mondi <jacopo@jmondi.org>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Bryan O'Donoghue <bod@kernel.org>,
	Dong Aisheng <aisheng.dong@nxp.com>,
	Guoniu Zhou <guoniu.zhou@nxp.com>, linux-media@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 5/6] media: nxp: imx8-isi: Correct color map between
 V4L2 and ISI
Message-ID: <al5Anrko0EjD5ory@SMW015318>
References: <20260720-isi-v2-0-45845bc5d4fa@oss.nxp.com>
 <20260720-isi-v2-5-45845bc5d4fa@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720-isi-v2-5-45845bc5d4fa@oss.nxp.com>
X-ClientProxiedBy: PH7PR17CA0055.namprd17.prod.outlook.com
 (2603:10b6:510:325::16) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA1PR04MB11506:EE_
X-MS-Office365-Filtering-Correlation-Id: 26b5df7c-6fd5-4fe5-e699-08dee674c4fe
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|23010399003|1800799024|19092799006|22082099003|18002099003|56012099006|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
 j/0e95x2PKCU9xwbUn4fRBDJU2zOH+957UzOGekvYUBhjv64/0E/yg+QTT6vJWdsolvhcnVbNbqlK7B30GuAgjYNki11a7/XmLDsCpaKCKlWSNQI1J4HPnPfShGtU9mPIVCooTnSRs4NVPp94wYBoLdrpKgAchqTTwwly71Xpqodpf+zCe54LWgOdLox3IkwGFMJtZw/Txbua015dsSh0Y2ipLXXNeGwjlpVOGzyJWq6jRxiLcuyhDLhOLWo3vj5UPev/wbVKsZUTQ/Bbm8amdZAQiLJFCAu2quEqZ4TD763YfEh/kgKNX8oAwwaWMX/DPhguNu+G/bIf78G14k2EydVyT2spG7Kjgt0NH/LW9zkDGvW1EARJo49lSI6MkE8E1ggLehXSZ5vE7mvsNhUGwQPe/sFTxCcRZ2S7bwW/CFl0M6hb+kpJHsPx/dDNqiwJIDACYG5+1lYWaWKnodxApp1+UNAJWewTiOU5koXJ59j4XENrvPsDWmZTcrSuUz1W5oJfnta1kVcKifc8pBiNOOabbi4gjz32Y8DXgv5shKuQf1Qaj8D9EjMZ1Nq6fOH8QR9R4BtZBtnFdSeBgB6UrQ5QdeGMkEH+zXDPKt1WJ9Bq3NwfZ2Pvx+HfjOZuI+y9IZUm6D5lJOXjdYRhooyzeo+KzpyLbXANxSbq3/YWO8=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(19092799006)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?V3SAmUbQASMJbbU/tyGrzCheu03F+gV7WSviJKTx8xrDbCYbD0ghbqC0sh08?=
 =?us-ascii?Q?RRMOTPKs9AEB00fOHMh4o2wYJybYCYNhii8OekrI2vB+e/dookmwBvZVndhM?=
 =?us-ascii?Q?IjQrV9vpB9uWbC7c/IcQ4SVTK/x5Yb6JJL7bD07LWr1/2CtsOApdeT8xc63z?=
 =?us-ascii?Q?W6NuEWvTYsxhqY5MWeVYSbf6XjzBw9lnZFSvTzcAipGOdwgOHWcwUcoDAFh9?=
 =?us-ascii?Q?pCZFlRmgMOhcQzR3OZiSeqcys5WAWVWki1Z52ehMn8biGpQDffQm9i3BkWCe?=
 =?us-ascii?Q?VoOFnWMw0gBcPOrpqpciAttnman6ZSEqJwHPG++/QwvRMp7M33DJXc6rZInW?=
 =?us-ascii?Q?jqoGkoV7m7bH30h+pJcylWR5GpyV3rQ7sRTM9OlyUuEuhuqrO0PnG0OXWB4i?=
 =?us-ascii?Q?krqhMkMLIiQhz4npRCEtUOIa12iP0/l9x5o08dkFxq8fwgs0c2J+hgXo1jFl?=
 =?us-ascii?Q?WLRo5qVqoGC0+AQmVcTqUsX/8fQNUnp+KNdw6Pr3lN2/8E2pkNSureXm3txv?=
 =?us-ascii?Q?5BtBQFPgFyv+ylHE9JGSWh7YKzAGWIR+MypI8AsZM8+Px94UQm3tMJr7d4rl?=
 =?us-ascii?Q?BWk4G+6UFoWbk0xLj156E46oGjb4s1axksYUrrmgY0TDB6SrITW0eZCMYkKj?=
 =?us-ascii?Q?Ys63PQxFuTCWfIbv2wxuTLpv2MBYOj/PTUsi8xF80J0Xmm/qkFIAKWlJ/8Vv?=
 =?us-ascii?Q?9G8IqQUSMfNnp9XrtZI0BbCu+Z2VzKyVZRo64D5rDEzxEZC4FDrGPdDq4Ske?=
 =?us-ascii?Q?eHwSgIGMaH4pFo8REMQREosu6H3bZ80qyysub7JuJUcJRH8kKjljVv/iJatj?=
 =?us-ascii?Q?Hrjlgarvv4UOBesfx7/GYr/ezSkveBPXGchA14Enw6GLYFds2dq4XSrEMK2z?=
 =?us-ascii?Q?hidlz5xjDx76NppG0c9qgUuxotdqcvBrzvTNj4/oMM1i3QXkCiXVsWcsyM4N?=
 =?us-ascii?Q?yXzHYByrAIiuRDWPZC1h2ku1Tbv/abF8QZbJZBJVPMz9EhnAYoeZ5J5awWDT?=
 =?us-ascii?Q?XS9D6qgqLmZwBGSPKCKUuZXS1a+K7dxvnozsoE8s2gcqAYuXceFX37WGUsPV?=
 =?us-ascii?Q?78I61Vq9nzxXT0p7vdUj60VeoJe6cY1cCcyF+E/ZU6vUKqEwPjyhgSBP6QhN?=
 =?us-ascii?Q?Sqo0ACKQrlzt34Hime+e1Wu+D2sr4q/oaCDvI84NgT7rsV8z3mLgOqEvpBqn?=
 =?us-ascii?Q?wfA8qg8TYGpapWujUR0AbZjZosg1uWwAwl3hwVM2ETa52DqbXyorSumRH/Wg?=
 =?us-ascii?Q?+7U6ljSqvkT+Nx6w0w/KFv6YhNrzcgt+bXK9KV23AKHokPgcm1+Q3RtumAJw?=
 =?us-ascii?Q?JgwjeiMW0wVPBZ6gZ5fUZqfW7gxHk1mAwbDiKMndNRpiIm+bABrDgqRcptPT?=
 =?us-ascii?Q?/FFUa22zHlucEKoIYk/ShKVqAORI4yf0P6IT0QsnA87dxLU6pcOwFsjPQzSI?=
 =?us-ascii?Q?AK0C/b7dzPGoZKt3dUmFHrK2Kj0CrNpn9oj2XCZoYpMj8GVhchV5ZISIFJ45?=
 =?us-ascii?Q?+P+J9jDHSwolf8MrDYWWVSKDKXdfbttZXhDkyR8mGc6zXBDqdAjfJvRLy9aL?=
 =?us-ascii?Q?y9vLiw+QioTgv8zKzZMXQ6G9ZVynupBA/CUwx9Cz4H1v7tbizUsb2WgcDftE?=
 =?us-ascii?Q?AG0ngLx/FtQVMVPdfd5PevEiBU3sCLUsLoQ5KxD4y7zMo4M+5UcyNdEigfXs?=
 =?us-ascii?Q?JD+I29nKFBkCHAsPCpDSaJNF7pDZcdhOamLfU/WgXIT+AI4tSaqTbdKsLSKk?=
 =?us-ascii?Q?HoAxpeU8W0zudbq2AKdl+MwkB5P5dMjEPXadfedDGQxcGs3LWrPa?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26b5df7c-6fd5-4fe5-e699-08dee674c4fe
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 15:37:13.0520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yoNF5colVzNj0Fkl28ORGbT7h5zEFymg42RCVwDu9NeGGYzAGZaY/A+2jD2EtcRqHOkjsg2OBhGG+MtwaCorTYOUFbwxmW+2zC7/2XRQfYa1VZHwbPsdB2nJPMEbKMex
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11506

On Mon, Jul 20, 2026 at 11:34:07AM +0800, Guoniu Zhou wrote:
> Fix the ISI input format for the color map V4L2_PIX_FMT_XBGR32 in
> memory-to-memory mode.
>
> Fixes: cf21f328fcaf ("media: nxp: Add i.MX8 ISI driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guoniu Zhou <guoniu.zhou@oss.nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes in v2:
> - Reword commit description for clarity (Frank Li)
> ---
>  drivers/media/platform/nxp/imx8-isi/imx8-isi-video.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/media/platform/nxp/imx8-isi/imx8-isi-video.c b/drivers/media/platform/nxp/imx8-isi/imx8-isi-video.c
> index 5eb448f4c26f..05b51b98344b 100644
> --- a/drivers/media/platform/nxp/imx8-isi/imx8-isi-video.c
> +++ b/drivers/media/platform/nxp/imx8-isi/imx8-isi-video.c
> @@ -151,7 +151,7 @@ static const struct mxc_isi_format_info mxc_isi_formats[] = {
>  		.fourcc		= V4L2_PIX_FMT_XBGR32,
>  		.type		= MXC_ISI_VIDEO_CAP | MXC_ISI_VIDEO_M2M_OUT
>  				| MXC_ISI_VIDEO_M2M_CAP,
> -		.isi_in_format	= CHNL_MEM_RD_CTRL_IMG_TYPE_XBGR8,
> +		.isi_in_format	= CHNL_MEM_RD_CTRL_IMG_TYPE_XRGB8,
>  		.isi_out_format	= CHNL_IMG_CTRL_FORMAT_XRGB888,
>  		.mem_planes	= 1,
>  		.color_planes	= 1,
>
> --
> 2.34.1
>
>
