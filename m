Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.21
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795106687;
	b=V2UEGWTozJpbUdWtkW+RgGdRcrLRPLVHNAHHVBSeJINiZnZTK2g0oXcXhHlrItBKVSAN
	 Ez0SwB/lAd0yT2ZEAcozukOkSur/lB9yT3wpE2KGu6BTZk6LyPgoayzYkZycx36vXBflM
	 RVbLPMxuHF4hkwtzLoqP1CfmIZJVVsn65YjWyY/U7sd/ZWTU9E3oGqDPiDwwK4dUyCz96
	 DjZ4VnedGIOakkbkNGoDrU1oB1AMgOApJjiigHNaS1d57bWMe9XVP2Ut4vvwEclzv31Q2
	 2D82NjCj/alQpjDJw5l3dCY1UjXqp3jf4PF1V09VkzPIA0qN/npCwWLYRA/WjFgkPNg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795106687;
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
	bh=jzmB2Y1NepPegp86hJTtRmlVeJgc2yrjfDcJgNtWRqY=;
	b=qEpfTS6Jrg5vUd5VOmTkAwwmog1/g5ka12hVAkwsRQIwDJgixkQJo4AeiF67EXrzHs3X
	 kf79sq2krvJBAJHJE2yRlGc2sqlTLg2lFZP1nZuJ4hk23spRgdD9/5aiVlMg4SHMBOLis
	 u55bzIlpOsv5IdphrDZa1ikGHkB5mujodS9hrHmvPUbxzZQW4RMXc/V116Rukt1D2Ry9u
	 t3MQiwg/3HFTjz9A+3mGS3byc8iG7UO7sQVlVmeCdrXgjCwZw2zMmjNlGRJ3EupbRAKAj
	 6MQd7iSP34m/DhDv38n3YgRGQhRKpty53jJfbhbLyl2s3x5lTWVx8EmZMrWhMWOl8DA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=QvbZ225M;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.21
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011021.outbound.protection.outlook.com [40.107.130.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303D2606A324;
	Thu, 19 Nov 2026 16:44:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 303D2606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=QvbZ225M
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y/DRCUjXAI7tcmWbCDM+vj7rX2y29lMYopFZcF4V8WGWfAueo6+bFuhyXBW0A8bTrskLAYfNMPMUebJ+DBorw7+I9wg5lvfq27iaBvLvTFA0fwAtcZrbO8JLSICXIxx37AQKDYw/Fi/0BUgusmJ34Z77hG940zmXGjsjuDzwqvSwpAo+wvfDz5iZJO0U6Nx9mFu5h6Kf+agsMZhRX7LjuLQpsVTQScUTbHNhL3w7Ze70PLOF/OvOuMkc0M7uPSJB26FOYGTe7AyC4zJ0semw8Qwz0p+4NUNtRInoHCzSKIIVmR2lXmVa8Fe9aWEi4TpTDV8qRPWOD9/SwDWbtQeOhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jzmB2Y1NepPegp86hJTtRmlVeJgc2yrjfDcJgNtWRqY=;
 b=YzYqpTZhqz1iq32nmP78KkREcofcf0hdho0yTmR/Lw1zJcQf4ZkhutGFMLhmmjhpS1exzRj0zE1TpYwc8wDm0h9GFj3ev0XSzcKlNE3xhskb9A/rEIBO6PSBB7NcdhqEm030q5sM0ou6X51c94YNFASOuO+WKBUnXDrtSxVg/uD2qQjxY8cOtjNrHslkKOuicPa67wt/YP086frvTuMZp+mzBXz7FB0jNO4t2HuSg+hJZ0y6pOyUmK4wyOC8DeNzSgS64D9AQEwNTS3VDSIxlmMxW6h2EAHw4nR/OP61ZoHdpb9GQbZ1Gj8Uz+0kaIM7CWpgd3FNTh7JH60o1s/LtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jzmB2Y1NepPegp86hJTtRmlVeJgc2yrjfDcJgNtWRqY=;
 b=QvbZ225MVGEjWgvzRycVM6ngLaJ3f7qgMXKJVQ5GhdNKbfAU1VkLnV26XbzxqL16CGzijcAPcGS/67EOr5MBMfNhV0OB2YY+y5SW5MMUuH8QyLzR3i1k4LrvfWxZETRQ2sdgBc9rLmvGMwsfJ7y2JhG4FuniP4zEUeV9u2ZzieR+nTqFcSOBT9dIfz2/fwh3UcpNi4Lgk0W9uve1k5pSQMdQQbtskCHdM9P1HHbvMlc8lB8BnnuTa1eVplf7wMtWDpydkkpZq/AuvdMNO/uHBton3EDTFDfrOR+lhLsvFz+2rurVAIwMO3yBrADTwibR+uMoxrxUu///IIESYeP3DQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by AS1PR04MB9239.eurprd04.prod.outlook.com (2603:10a6:20b:4c5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 16:44:44 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0639.010; Thu, 19 Nov 2026
 16:44:44 +0000
Date: Thu, 19 Nov 2026 10:44:34 -0600
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
Subject: Re: [PATCH v8 7/9] dmaengine: dw-axi-dmac: serialize interrupt
 status with channel reuse
Message-ID: <av8ncvLCe85P5j0r@SMW015318>
References: <20261119-submit-dw-axi-dma-stop-pause-v1-v8-0-f8e7fe60594c@gmail.com>
 <20261119-submit-dw-axi-dma-stop-pause-v1-v8-7-f8e7fe60594c@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261119-submit-dw-axi-dma-stop-pause-v1-v8-7-f8e7fe60594c@gmail.com>
X-ClientProxiedBy: PH7P223CA0004.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:338::12) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|AS1PR04MB9239:EE_
X-MS-Office365-Filtering-Correlation-Id: e0ef0cb3-a3cc-4f2d-741a-08df465c69e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|7416014|366016|376014|1800799024|22082099003|6133799003|18002099003|4143699003|11063799006|5023799004|10067099003|261026121527099003|261026135527099003|261026130827099003|261028144727099003|261021130227099003|261022105027099003|261021135927099003|261021133027099003|261021121427099003|261022075727099003|56012099006|261022113327099003|261021123027099003|261022115727099003|261009223027099003|261102123227099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	tmMWOGEuFkq2L8FpASoGP3fVAxMRbMwS1HsZPtbxDKZwZreeodBDLmOTLvLOvus7i0TBGIC0+gB7PCuacb0MQyqnVPUpBfBF+DxyAQw22mQD3Mcmt64SN6ZGa13Gq1Ts4lxnDkffjquY2mL1sujgfi0WjWA94Vll0vEsE/zNjkHEw1WY6AbOebPZDfmG6r9dSGOFcW33yN6gzVfjCr/qWQkPdhNz3+g6gMzAYP/0q5rt+1ise8tDxEMSq5NhTBowy8rJ4jpiX30bGQrG+FN5VZkWoHT0wIQfwz02dhypblA+li8gz5PaPXhu9epgxYTjhHRQlM9W5Y4mHa9Fxy7tX874PE2sBrTgzKx6LAIssTQUO2fbCe8996tHVY5BNrWt9M15bofA0NAsA8DhjYhLtOWXyy7OP9dipHzb8EMmZUyRKdRUdhioPJSJgfYuYX+2nAqjhYUyQ3rSmkVYGYPVHgaYCZ2QIrtETaZU65fcIVfip2nTluIaKKh1J9cNH8R23hv3zzjd3E7s2/+Y/YIycCybMwiOCVWiO/IH91XLgeckXHQuRZyVyXip1RF8197BJUHplkbhCAFs+qk4mB9EZZTB7GYbe1uumHyleA7n8IAPhYwIBq0TdMBbco6siVwn8LaTEWwXrCrplEjc9bRzDvCrb+lra53/72lbjeRc+uc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(7416014)(366016)(376014)(1800799024)(22082099003)(6133799003)(18002099003)(4143699003)(11063799006)(5023799004)(10067099003)(261026121527099003)(261026135527099003)(261026130827099003)(261028144727099003)(261021130227099003)(261022105027099003)(261021135927099003)(261021133027099003)(261021121427099003)(261022075727099003)(56012099006)(261022113327099003)(261021123027099003)(261022115727099003)(261009223027099003)(261102123227099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ut3hZSRMoan0WAyt+UJ69zc81VattG+wzscMKqKjdcQt/uA0xCkGfzzV04OF?=
 =?us-ascii?Q?0oBTI25oXLiEVaEP5pnnAo9bn8MHilQzwTvk11YDfncVcDBz6N48iv0tpEg5?=
 =?us-ascii?Q?8qeYkigKVrZpMuJPXF991mw5HOZLQCxqDkCA7Ic/G6nQSYG1gdiSD2MCgfsa?=
 =?us-ascii?Q?X+gIVZonZGDHiO8lRJF6tcLUT/XzwzL1JVsbtrfIJQEBWLysMEqj8O3ddijy?=
 =?us-ascii?Q?NuAxvmpdBmeScnP+g2SI0X2eg7UkF5D/eHmzxFBF8IXK/hDkT6Q7yWWlO0vD?=
 =?us-ascii?Q?f9r3Pfpa0dF35K/bjE/6qWyQc9pA14RAycvl5mThfUAIZCiFmPhsnCksc7We?=
 =?us-ascii?Q?bxsDKFTinKd7M9O5c+sJGuBGMKzkh2H9BlKkhVua2Chg9j2xNFTrkP3ZIzVW?=
 =?us-ascii?Q?j+W/iRbNZYqNML3rRRBr3cQiddV3QcLrZ/jk55SIbTukEKTwb3ok0SyTk/Ha?=
 =?us-ascii?Q?RC4iPi/PSvnpbksbXp8mPT9reKKqFnmDchlfLGAbTFjjZtio7qPs934pV4eR?=
 =?us-ascii?Q?Qs0MB2hPMwJJ4ku7NYvPf1O09esCUmiM8kK+w+4XWsAK5Zy79b98iNLF/GeP?=
 =?us-ascii?Q?c9RU8xXTiPW7hGpp44aXNbTD+EdWf4eT+LKLNT5Dzw/ygqiYTMOUYgbx/fUb?=
 =?us-ascii?Q?UUOi9scjxXaIE21JqeJtj2ikh2zKgE0GAap6j1FTO5MyiKU4oPg2oDAk3b/X?=
 =?us-ascii?Q?uR49DIksli/mbGeYPGFegEbYsF4PopHyWTGqZJMjXmqMvZNxyHXLpICGTvsk?=
 =?us-ascii?Q?K7Y2geK+OPLDP+cewQSKHx53VKsG7ZwOje7UiykiCPjr6vKgWXD1YVBsQmej?=
 =?us-ascii?Q?3aOn8sYVD7AOicqESRa8suxFa7xmraCbCa4wfXVrkpyBaZZf3l72NrdlrYkC?=
 =?us-ascii?Q?nH7rKsY0//ir+Hg52Hs9o6vG4lKsN9lAoS6HYm/snWVnM4yZkKGxLnPCkQ46?=
 =?us-ascii?Q?4Fh0A0NSRQMCwAdNCwpp9PLf4C6B5CnPqs2JbujEiitbFgGT5ZTxH3NCyLyr?=
 =?us-ascii?Q?hfqhXI4ARvKy6KuupCrkEF9AT/mNnVc3iA8ga7uzfcxokGRX8Y+m9FFPSLtv?=
 =?us-ascii?Q?zJiWs+/+rz2LeqM3bGyK4OPTQ4FyBG1z+cEZPgJghF46wi0YqgAK+rzL4YD/?=
 =?us-ascii?Q?yoIWUCYMrKsS/vgclfdD2qUNJrHXGTHHpox7VXOiLAnLRmWXZLRuVDe86hLe?=
 =?us-ascii?Q?HJNIV1aNn5wLpnDFOre4XNukutiGv20+9QPx/ZI+VUduM+gS/dxT3S+OqSmn?=
 =?us-ascii?Q?HAyCA0zq4MDei6BC/eeKAOxjFKyw3vygst5Mulq4XNux1Z2RmAr4xuZTVDKg?=
 =?us-ascii?Q?NYHPFNpZmKbi1vbeiVEzGENXOzFsAx65Lnxyf5/8haTPQOpzf1Zt3J5iSd5D?=
 =?us-ascii?Q?3jM5StZgGB+g31ieEWFCHuxmAMUAIBduE28jFil+NLbgiQY7h2eJ9B97qyR0?=
 =?us-ascii?Q?o+Z19n06iGXrgGW+HetTdPht9XFow6J6/dld89GlSupBBdmKG1mkenwIMYHc?=
 =?us-ascii?Q?dHTj5IlrHBgJ9aUcnGBj3E+IpH5EYR4B5E5UMaUBpe1adcj5O28TeWrJa1f+?=
 =?us-ascii?Q?7MAnFR6hEKIhRMrH6GQhM9f8bQjbY/ejdfPsfhHEvLjx6H23nyYDayVhSvkJ?=
 =?us-ascii?Q?w+BqWgf5QwT2PwQRhHzw+C4Be1iHmSWuZvPd3ie5BlLbspGimgZPd9qaXc3n?=
 =?us-ascii?Q?by6HFv0jD6IpL6hWFlmEKNpX7TBscOFoAV/7m8eyajor2X9GETIvitoliDfl?=
 =?us-ascii?Q?0/ZHbpZypVJTWDW3+TZkG10hEvMujU+YUc9np6B9p/Is6zNtTS26?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0ef0cb3-a3cc-4f2d-741a-08df465c69e5
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 16:44:43.9829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2s6IXi7AqYB4J0cKC52Aa9uXnlh/Mrc09gC6qBtPhbWs3OjRYJIOzr3t8nb96l4jSQ6aTGKV04Or4Y0vtVB4NuPxsCYAA7S1aArvZopbT0CbYFo08vO+3/rx2qW44WGC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9239

On Thu, Nov 19, 2026 at 09:01:02AM -0700, James Hilliard wrote:
> The interrupt handler reads and acknowledges channel status before taking
> the channel lock. Termination can finish and a new transfer can start
> before the handler takes that lock. The saved completion or error status
> then applies to the new descriptor, stopping it and completing its cookie
> before its DMA transfer has finished.
>
> Termination also leaves completion and error status pending. A subsequent
> interrupt can consume that status after the channel has been reused, even
> if no handler was running when the old transfer was stopped.
>
> Read and acknowledge status under the channel lock and keep it held while
> processing the event. Move locking out of the completion and error helpers
> into their sole caller, and clear all channel status after a successful
> stop. Status collection, descriptor ownership and channel reuse then share
> the same serialization.
>
> Initialize the virtual channels before requesting the shared IRQs so every
> lock is ready before the interrupt handler can run.
>
> Fixes: 1fe20f1b8454 ("dmaengine: Introduce DW AXI DMAC driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
>  drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 31 ++++++++++++--------------
>  1 file changed, 14 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> index 2547f9596ae6..2eeb902eaad3 100644
> --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> @@ -21,6 +21,7 @@
>  #include <linux/iopoll.h>
>  #include <linux/io-64-nonatomic-lo-hi.h>
>  #include <linux/kernel.h>
> +#include <linux/lockdep.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_dma.h>
> @@ -1072,9 +1073,8 @@ static void axi_chan_list_dump_lli(struct axi_dma_chan *chan,
>  static noinline void axi_chan_handle_err(struct axi_dma_chan *chan, u32 status)
>  {
>  	struct virt_dma_desc *vd;
> -	unsigned long flags;
>
> -	spin_lock_irqsave(&chan->vc.lock, flags);
> +	lockdep_assert_held(&chan->vc.lock);
>
>  	axi_chan_disable(chan);
>
> @@ -1083,7 +1083,7 @@ static noinline void axi_chan_handle_err(struct axi_dma_chan *chan, u32 status)
>  	if (!vd) {
>  		dev_err(vchan_chan_dev(&chan->vc), "BUG: %s, IRQ with no descriptors\n",
>  			axi_chan_name(chan));
> -		goto out;
> +		return;
>  	}
>  	/* Remove the completed descriptor from issued list */
>  	list_del(&vd->node);
> @@ -1100,9 +1100,6 @@ static noinline void axi_chan_handle_err(struct axi_dma_chan *chan, u32 status)
>  	chan->desc = NULL;
>  	chan->cyclic_restart = false;
>  	axi_chan_start_first_queued(chan);
> -
> -out:
> -	spin_unlock_irqrestore(&chan->vc.lock, flags);
>  }
>
>  static void axi_chan_block_xfer_complete(struct axi_dma_chan *chan)
> @@ -1111,11 +1108,11 @@ static void axi_chan_block_xfer_complete(struct axi_dma_chan *chan)
>  	struct axi_dma_hw_desc *hw_desc;
>  	struct axi_dma_desc *desc;
>  	struct virt_dma_desc *vd;
> -	unsigned long flags;
>  	u64 llp;
>  	int i;
>
> -	spin_lock_irqsave(&chan->vc.lock, flags);
> +	lockdep_assert_held(&chan->vc.lock);
> +
>  	if (unlikely(axi_chan_is_hw_enable(chan))) {
>  		dev_err(vchan_chan_dev(&chan->vc), "BUG: %s caught DWAXIDMAC_IRQ_DMA_TRF, but channel not idle!\n",
>  			axi_chan_name(chan));
> @@ -1127,7 +1124,7 @@ static void axi_chan_block_xfer_complete(struct axi_dma_chan *chan)
>  	if (!vd) {
>  		dev_err(vchan_chan_dev(&chan->vc), "BUG: %s, IRQ with no descriptors\n",
>  			axi_chan_name(chan));
> -		goto out;
> +		return;
>  	}
>
>  	desc = vd_to_axi_desc(vd);
> @@ -1159,9 +1156,6 @@ static void axi_chan_block_xfer_complete(struct axi_dma_chan *chan)
>  		chan->desc = NULL;
>  		axi_chan_start_first_queued(chan);
>  	}
> -
> -out:
> -	spin_unlock_irqrestore(&chan->vc.lock, flags);
>  }
>
>  static irqreturn_t dw_axi_dma_interrupt(int irq, void *dev_id)
> @@ -1169,6 +1163,7 @@ static irqreturn_t dw_axi_dma_interrupt(int irq, void *dev_id)
>  	struct axi_dma_chip *chip = dev_id;
>  	struct dw_axi_dma *dw = chip->dw;
>  	struct axi_dma_chan *chan;
> +	unsigned long flags;
>
>  	u32 status, i;
>
> @@ -1178,6 +1173,7 @@ static irqreturn_t dw_axi_dma_interrupt(int irq, void *dev_id)
>  	/* Poll, clear and process every channel interrupt status */
>  	for (i = 0; i < dw->hdata->nr_channels; i++) {
>  		chan = &dw->chan[i];
> +		spin_lock_irqsave(&chan->vc.lock, flags);
>  		status = axi_chan_irq_read(chan);
>  		/* Leave suspension status for the pause and resume paths. */
>  		status &= ~DWAXIDMAC_IRQ_SUSPENDED;
> @@ -1190,6 +1186,7 @@ static irqreturn_t dw_axi_dma_interrupt(int irq, void *dev_id)
>  			axi_chan_handle_err(chan, status);
>  		else if (status & DWAXIDMAC_IRQ_DMA_TRF)
>  			axi_chan_block_xfer_complete(chan);
> +		spin_unlock_irqrestore(&chan->vc.lock, flags);
>  	}
>
>  	/* Re-enable interrupts */
> @@ -1220,7 +1217,7 @@ static int dma_chan_terminate_all(struct dma_chan *dchan)
>
>  		vchan_terminate_all(&chan->vc);
>
> -		axi_chan_irq_clear(chan, DWAXIDMAC_IRQ_SUSPENDED);
> +		axi_chan_irq_clear(chan, DWAXIDMAC_IRQ_ALL);
>  		chan->desc = NULL;
>  		chan->pause_requested = false;
>  		chan->is_paused = false;
> @@ -1600,10 +1597,6 @@ static int dw_probe(struct platform_device *pdev)
>  	if (!dw->chan)
>  		return -ENOMEM;
>
> -	ret = axi_req_irqs(pdev, chip);
> -	if (ret)
> -		return ret;
> -
>  	INIT_LIST_HEAD(&dw->dma.channels);
>  	for (i = 0; i < hdata->nr_channels; i++) {
>  		struct axi_dma_chan *chan = &dw->chan[i];
> @@ -1617,6 +1610,10 @@ static int dw_probe(struct platform_device *pdev)
>  		vchan_init(&chan->vc, &dw->dma);
>  	}
>
> +	ret = axi_req_irqs(pdev, chip);
> +	if (ret)
> +		return ret;
> +

Most likely, irq request should after dma engine register. irq handle may
use some DMAengine APIs.

Frank

>  	/* Set capabilities */
>  	dma_cap_set(DMA_MEMCPY, dw->dma.cap_mask);
>  	dma_cap_set(DMA_SLAVE, dw->dma.cap_mask);
>
> --
> 2.53.0
>
