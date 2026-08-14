Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011057.outbound.protection.outlook.com [40.107.130.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADED35F609;
	Fri, 14 Aug 2026 14:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786718906; cv=fail; b=Em56X0SENp7d5qpI9izKcb6f5hX4jPd7+pnyWGiVECShfAlXdR437xv3XErE89dmaQ0V9UbU3D6DJw4ZhcNx3Isr/ncvfQVA7iCMK5o8UrZT2Iwca9vzRX8V8kp5bfvgDhvvSZXConkvc4XOqh86VCXp4TU1GOXixY5oAPRp480=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786718906; c=relaxed/simple;
	bh=wq/jtGvlUlaOw3AZde+ykShY0VPYm+dYqusEUJ/SBy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CVIU/RBHmIjPbFPDM8vLJygwcXVn6e3Sx7XvNdMUHrDh1u37ozUtJ1eO//OZbVDh2L/XLQwjYAqxLBFWnSK4XH+xAlPhO4L29Ol7D3pDcqi0Jn2mh7ky9UdYDjFsYy/l7if2qU4xANVjJzxqRpAaHhUQl1hWNDuUX9Bbfj8q+Kc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=EwvIJFp+; arc=fail smtp.client-ip=40.107.130.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="EwvIJFp+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eOM26dXWylaZtinKeKWG/Lv0HYH4hDqFrcivDEODp0tyHxbnL7yyz30lJNzLMdEfWdxloGK73LwPFD7R57hZ63yJeU7LdTZGXWWNwJnIIGDJx6WJQ2eFdXGiPR4njYDVUeFIQX5o2F56RnKyP7pjgi1rnNOi/sxFw1iuZ/VX7bT55EIl+5FZdKJjR5KNtbrETS4ZDdEraiCOSL5cN/OsnTKmqKO9elYc3i4qLa9StrVrtQ3Ju5xmMOQxDxja5IMaELIrONQddHu2j9zilLQtCcZXjAqkv3OS9+KDiEe49aSZNzP6LT4tqBhKbXoJpOddj7eZluIDg1oRptjUYAvKhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=faZw13vDKRLh2wQRGMxkTOquwzAolkc2c5zo8JCXKJA=;
 b=Qre1K7/a2PW5nPBf7yIkjHe75z0NjRT8TJFuOIe8NMX3hlhloRgB7X/Y+RGDQFJtPRFzJMIjK6GHOrl5SYkXI3NDXymBluXFKgiX/zNZjwIYpbv1fUsNr0w2liUy/SZwfhHLNkvcVz17pWnOtFfot3lXFln0qnS9IUE/qyR7Deotsfs2Ngkl3sWi/znlF8ELwLENKwqmczxH/AbEsq4cjJOdGCg9zQ4ukziuTl3M5vLH0V93XkB+bjNVW8uIBMei8JZsyKN5HC2VBAbk45+h+vl45k6hn174fd84tzsfWywu8zT1ALsbWVeNnxB0aZkS7bSk0BH3qvpj9BtYsl18dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=faZw13vDKRLh2wQRGMxkTOquwzAolkc2c5zo8JCXKJA=;
 b=EwvIJFp+XyQveIu9JJvMBDljsPiyJoPmmCpnTeNA70PzBHsbGjQ+xtQ2mQi5lAVnTsfwFbVaBz8u4mWPzf007uf9Cm0yq2bh0uvTLztTY05MA4npy6QIZQmef1QPCVHU1rGsOHjM3sSEEW1ADrPCA6phoDY5z5y8crSIryLIFXYfuO1RC3FhgiizasZAo91NSBV5rBsEd9xnG0VR/YJOBoa3q/+YGh0s9OcdCqI119JueU+WBWU1vmMTR6+chdOPBgZ1TlOG4JT1fm6fQJojPP6LCEIqQGoXLrQilyY6s36Fv5zeEZ/NZZOy9S35Nu0XlafWlO3sXMbTHrDnH4kzXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GVXPR04MB12107.eurprd04.prod.outlook.com (2603:10a6:150:334::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 14:48:21 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 14:48:21 +0000
Date: Fri, 14 Aug 2026 09:48:13 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Christian Lugnberg <christian.lugnberg@soundtrack.io>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, wens@kernel.org,
	jernej.skrabec@gmail.com, samuel@sholland.org,
	dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dmaengine: sun6i: fix non-atomic read of DMA
 position registers
Message-ID: <an8qrUqJKthIfZq2@SMW015318>
References: <20260814142708.79120-1-christian.lugnberg@soundtrack.io>
 <20260814142708.79120-2-christian.lugnberg@soundtrack.io>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260814142708.79120-2-christian.lugnberg@soundtrack.io>
X-ClientProxiedBy: SA0PR11CA0127.namprd11.prod.outlook.com
 (2603:10b6:806:131::12) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GVXPR04MB12107:EE_
X-MS-Office365-Filtering-Correlation-Id: b505d750-c492-4f35-5031-08defa1315fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|19092799006|7416014|376014|366016|10067099003|56012099006|6133799003|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	qGMJiHDdxUwgY1yjJXr/TIrYDfz9YutQMca1VtMUF6CIgUpulSBeGJ6CuTvqVyBWsQFgH5AKjghoaI4k4Uwo4FNMmx6RuxeozEBluU1MpJIU+4SkCsRBPDRGonyC9woSnA7HU6g1d8YB3q/hbfnzFwO2hYszkL6OvsHn95o8xMS55odXvK2yVbN5ztn2cGYc+0w591LvdO+k2g0bT40LVZVnH+UbYoYxaxJ+7d9y24cAxwbNpHefZgjH7oG0MUVpmUYWNz/LIE2P6MT/zLyLypGebv+tDlTHMIVOOslR8m5544nzyUBGJtoWdRww4tKT9U8l2IdtC0Lop3I4IlAz5VtShWJpwryhqumSon8kzpeS9Ns4VhPgl4e93jgvlnf6/7Il3ZpVFhmabciVsGjqJpy02Bvhowh1DtSnhyMyoA5F3vgcAecdeCl9Z5R0JCxVN5+7qWE0yQsbjpFcRmPKW4dnKNlWcPS/zh68ixGoBEkvWvKQ6vI7v/BuiTY2xLjwRyul9Rjb8QKy7WD7SwwryNUMvkilfoEKgBgt2ApCGrCvOxPKq95PFkcgMbFk6uVY1VB3SdyqCnDKBhP5quNcQ3pSD0bRFzBi0ZNNpqLsAik1pr98k0+8yn4MDfkBtoGzez2CL/mC8QfC18LwGWwFyi7EHX5DiudcwOKTctBxvqY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(19092799006)(7416014)(376014)(366016)(10067099003)(56012099006)(6133799003)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MVVxbXJMUTFmcXl3bklVd0tUNVRISllOL3ZRVE4rd1B4TXB6allsN3JOS3FL?=
 =?utf-8?B?TjhqR2tQWlNpcnJ2RmJ1ZjB0SnlVZnhOQW5jSmIrZDRibUdvZFltemNrOHI5?=
 =?utf-8?B?bkdLOGxlRGRscThoQjJGOWk0dE5GRXVLOEJTcXJqOGFuendJeURxWkhtcTh3?=
 =?utf-8?B?dHZpWnZXSkc5eGpqQVBXVWw5VHQ0NUlMckdoY0s5ZFVkako2OEdiTTJuYzcw?=
 =?utf-8?B?RkxzakxpaU94SW93RnZhNFdrdzl4ZlpPenRpM0d1enNmYmFGYldHUEZMMzI4?=
 =?utf-8?B?KzRLb0ZHK3R4M3JiQlBJMngvNzlSVndPWjVLNlNKOGE1eGZLNkpiVVpvN0V0?=
 =?utf-8?B?dU1LZUhRTnErY3pha2F0ZStac29tRk1rTllFSUNuT3MxdSsxMDhvNllYV00w?=
 =?utf-8?B?WjdsSXU4RWtWWjRHSGVNZG00Q2l6a1hiWjRLZnBPQ0ZCcEtkeVI0WWdYRzRr?=
 =?utf-8?B?Zko2MWIyajBjYzVhOHBxenoyVHA4NklvMVRCYXFQMTlWTURLZGpoZ1hTQU5i?=
 =?utf-8?B?QVZaWjlsZmlvSERhMDhoMWZMRjcxbG0vQnd1dWc2Z0lQK2xCWjR5MWQ2UllI?=
 =?utf-8?B?aDZBRUJnQUdvZTFnYXRNNWRFRkdCcDNZSUp2VFBLSnZLeVRMU2phcTR5T2wy?=
 =?utf-8?B?Z2kzZ1lkeDRZSzRmMWJwT204THlwUCsvVmdaZEd4MGt6ZWZrU0RpdEtWbVND?=
 =?utf-8?B?c2tzVzFLcnJUZk1QekRjNDFKQWk4WG96cEhXcU4xV1hKS3FQdG9aWkRSTjk3?=
 =?utf-8?B?SWphVHVSVStIdGh0dkNjWlVUN1BkbExkbytBaHUrU2lxZmhFUWlxSTZKbldS?=
 =?utf-8?B?OVFnUG40aG1aS29VN2w0ek4rRm5PZ21sSTExd0JXMUMzd2NTTFI2blIybDJH?=
 =?utf-8?B?U0VjcEZPTE5ySnVyNnIwNGx1R3JUb3hHWWhEKzdTb2EzZlIxMzc5RjA0Wlh1?=
 =?utf-8?B?Vm16OFpPMkpZdlFYd1pnZWZCV3orcVAyalpSUmF5YnBRL29hdkgxR1NtTTdJ?=
 =?utf-8?B?Mkt4SGE4T3JSSGdYeStpb2EzK05sWEk2a1JhTkpSbjk2djhqZmNISVZoSVdx?=
 =?utf-8?B?YmE4SDZEN2ZXYWFnVVVoOVZoR2tYenp5bGVZQ2taZlhiOFVYQXhHc2p6SHRR?=
 =?utf-8?B?KzBrL1Jsc1VuZm5SdkZsM3VmOHNGUENTUFIzSTQ4dE4yT3BoR2l0ZFVRdTd5?=
 =?utf-8?B?MXZvKzFUT09saThOVWJIZkJQK2RDN2tVd3hjOW1jeFJnTXlBbTZkRHZKOGdP?=
 =?utf-8?B?bWJnaE1YdmQrajNDam5sYzNkbkFZMlRROTNaUmxFYm5MWkduVkF6M0k5V3FD?=
 =?utf-8?B?TXpSWEJHcG9iQll1aDZCbXQ2UFk2ZThRTEw0TVhWL1FuQlhUOTFXNXovb1ZF?=
 =?utf-8?B?MVpkR3NvM2ZhUWMxY0ROOFV0L1ZxMndTV0NWRWJRZkZNSFdhS1ZHdHJVTEl3?=
 =?utf-8?B?bWJmV0hqTnVXUjNCSU9ac0pJWG9YY0VQUFRhMFVIMzdWUXdiaUJxcmNYNXVu?=
 =?utf-8?B?VG12V1M0cDJUZjVwTnBkc1BYZFRCdjlhZFo5YVllVFA1Y3RqZmphVkN5ZVR1?=
 =?utf-8?B?SmlBTXNYRjdmazhqUzQwWFNSVEJzN1hHZXo0SU5vYjc4NWM1ajZPdER4M2dH?=
 =?utf-8?B?RGtMZUJuR0ZUTDYrbWUzNVcxVUFMQkZLU09IVWdxNnhEMWt1WnhYaEhtZmd0?=
 =?utf-8?B?UWM2bEM0MXhFbStkYnZKcjVWc2VPTlJyRitERVdsZUlCbmJ5cWdOUDdMK2NL?=
 =?utf-8?B?QW1pUll1dDZmSGVNRWpGRlJTMk5mbE14WkFESTk1cUltRFp5TFRkY1puU3ly?=
 =?utf-8?B?VmxPVU5NMXplRC9NWkdPMnVHODZ1c0lNb3FKVGxVSWovSlF4OVQ5dlFRbHY5?=
 =?utf-8?B?a3FJa1V5L05UbWR0QXZFaERzN3dDd0Q5UXRHRGJyaHZpallJOUJmSmlUdVB1?=
 =?utf-8?B?U2ZMblhVWWg3L29ydlkxZHA4Rm5wZjlzRVZ3dkVhZ3JOS1YxWGJFR2luNFln?=
 =?utf-8?B?ZTJLZ0hjbUdGZ0hxOTQxb2VoaVlTVUw4Y1J4MU5wSjV4UXBXVUxrcVp5bk52?=
 =?utf-8?B?Mng4NFpPNmdMZi8rY1RsSllhbi9VcmEydC9tOFRUYWJ2L0tYczNZL3JRQ2N4?=
 =?utf-8?B?YVgyS1pGNC82SmJYTjVyY0dPOUZJZ0FWQ01JMTZiN2czdGd5SlRPQjU5RXZy?=
 =?utf-8?B?dG9zMUR4Vy9IYWlkTlRWQXJ1MDVOQlM3aXMwaHZMVTE3dXowWjNIUHUzYTVV?=
 =?utf-8?B?NXI4ZFpRYlc3V1g2cUxLVjNvdE1xa1VrTnBRRUkyRXRPcEhmNWZ2dk82QmFn?=
 =?utf-8?B?Q0kxMy8vVmtmc2NtVmZyZU81a1BGNitMQ3BHMGo1YnZTWkZYQ3c3TDQxWUcw?=
 =?utf-8?Q?GVJ/ZQYkfGdbDzF2ESqZaYucOO/L2tzkik6PI?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b505d750-c492-4f35-5031-08defa1315fb
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 14:48:21.5158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PtK+m9cjulBQXjJTUfV5PqfqLsngnhzBKdpnGtaHxu9MRDvGyk8HW6WlH5T6PVaEzSOxc9mDFMGR8tnPmNesnH3F4Llcs2Emue3M8hMizXnyzVR6uUOXlRmBTUhhoo3r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB12107

On Fri, Aug 14, 2026 at 04:21:10PM +0200, Christian Lugnberg wrote:
>
> sun6i_get_chan_size() reads DMA_CHAN_LLI_ADDR and DMA_CHAN_CUR_CNT in two
> separate readl() calls with no synchronisation between them:
>
>     pos   = readl(pchan->base + DMA_CHAN_LLI_ADDR);
>     bytes = readl(pchan->base + DMA_CHAN_CUR_CNT);
>
> DMA_CHAN_LLI_ADDR holds the physical address of the *next* descriptor the
> engine will load once the current one completes. DMA_CHAN_CUR_CNT holds the
> remaining byte count for the *current* descriptor. If the DMA engine
> advances to the next LLI entry between the two reads, pos becomes stale: it
> still points to what was the next descriptor at the time of the first read,
> but that descriptor is now the current one and CUR_CNT reflects its initial
> (full) byte count. The subsequent virtual-chain walk starts one entry too
> early and accumulates an extra full period's worth of bytes into the
> residue estimate.

Thanks for this fix. This common problem, above already clean enough.

please cut below debug/test proccess. and keep

Fix this by re-reading DMA_CHAN_LLI_ADDR after DMA_CHAN_CUR_CNT and
retrying if the value changed. This double-read pattern guarantees that
both registers were sampled during the same descriptor interval.

Frank

>
> For ALSA cyclic buffers the over-counted residue can reach the full buffer
> size, causing the computed playback position to appear to jump backward to
> near zero. The ALSA PCM core treats such a backward discontinuity in hw_ptr
> as evidence that the buffer has underrun and declares an xrun.
>
> On the Barix IPAM400 (Allwinner H3, kernel 6.12) this manifests as audible
> glitches accompanied by spurious xrun log entries, confirmed by two
> independent observations:
>
> First, the ALSA buffer in the affected configuration is 2 seconds deep with
> a 500 ms refill period (the interval at which the player software wakes up
> to top up the buffer). For a real underrun to occur the player would have
> to stall for the full 2 seconds without writing any audio — effectively
> impossible under normal scheduling conditions. Yet xruns are observed
> regularly.
>
> Second, the underrun duration reported by the kernel at xrun time is
> ~30 µs, roughly one audio sample at 44100 Hz. A genuine drain of a 2
> second buffer cannot resolve in 30 µs; only a phantom position jump
> caused by a register read race can produce such a number.
>
> Observed on a 44100 Hz stereo S16_LE stream:
>
>   $ cat /proc/asound/Codec/pcm0p/sub0/status
>   state: XRUN
>   delay: 0
>   avail: 88200
>   avail_max: 22514
>
> The avail_max of 22514 frames (511 ms) matches exactly one ALSA period —
> the amount added by starting the LLI chain walk one entry too early.
>
> The race window itself is narrow. Each DMA descriptor covers approximately
> 88 samples (~2 ms at 44100 Hz), so the engine advances to a new descriptor
> roughly every 2 ms. The two readl() calls must straddle that exact boundary
> for the corruption to occur, which explains why the bug is intermittent.
>
> The bug is further confirmed by the xrun_debug bit 2 toggle (jiffies
> position validation). With it enabled xruns cease immediately and do not
> return; clearing it causes xruns to reappear within minutes. This on/off
> reproducibility isolates the fault to the hw_ptr position reporting path;
> the DMA engine itself is functioning correctly, as evidenced by hw_ptr
> advancing at a steady 44100 frames/sec between events:
>
>   $ echo 4 > /proc/asound/Codec/pcm0p/xrun_debug  # xruns stop
>   $ echo 0 > /proc/asound/Codec/pcm0p/xrun_debug  # xruns return
>


> Fix this by re-reading DMA_CHAN_LLI_ADDR after DMA_CHAN_CUR_CNT and
> retrying if the value changed. This double-read pattern guarantees that
> both registers were sampled during the same descriptor interval. The cost
> is at most one extra readl() pair per call in the racy case, which occurs
> only at descriptor boundaries (~every 2 ms) and is negligible.
>
> Fixes: a90e173f3faf ("dmaengine: sun6i: Add cyclic capability")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-sonnet-4-6
> Signed-off-by: Christian Lugnberg <christian.lugnberg@soundtrack.io>
> ---
>  drivers/dma/sun6i-dma.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> index f47a326dd7ff..04fe1f5042e9 100644
> --- a/drivers/dma/sun6i-dma.c
> +++ b/drivers/dma/sun6i-dma.c
> @@ -354,8 +354,10 @@ static size_t sun6i_get_chan_size(struct sun6i_pchan *pchan)
>         size_t bytes;
>         dma_addr_t pos;
>
> -       pos = readl(pchan->base + DMA_CHAN_LLI_ADDR);
> -       bytes = readl(pchan->base + DMA_CHAN_CUR_CNT);
> +       do {
> +               pos = readl(pchan->base + DMA_CHAN_LLI_ADDR);
> +               bytes = readl(pchan->base + DMA_CHAN_CUR_CNT);
> +       } while (pos != readl(pchan->base + DMA_CHAN_LLI_ADDR));
>
>         if (pos == LLI_LAST_ITEM)
>                 return bytes;
> --
> 2.54.0 (Apple Git-156)
>
