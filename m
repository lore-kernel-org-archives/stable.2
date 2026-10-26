Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793047801;
	b=BTYrVYFk2R4QO8buRG517owRptLZhJeqVdjwdnqSEUKqJLzCRIdCFpXKZhB1q0H6d99a
	 hv3VbGV9gjajR2xrTiULyGzZ82ui8e78uHzZxptcqLWWGdfqMSH5WG6BVqVxWcUhKtkNa
	 WJgRZW7KmOiCpTFF+sAVluFlyepXa4vSjAs1TAsBCbFaYA/FKMHnbTOmB+27XCFSp9Q5T
	 6nSMa4JGzM4HtSzxgz+h6qu7VAo8G5J4Bq0z3sLAlFjVnDcSNYSYiMRCH/4Nv2K4/hfBS
	 MgfhKRofKfPvG1H0A1fmqMzIlp4gGUt7ZLCeJpZcvX5Uyb4Xo2P2AA4AainzOD5dvrA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793047801;
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
	bh=H5iRjnbzQaAlrwhwVAeO6f65ic0C/2RcyjbvUamc928=;
	b=VnOJAzEyM4T8frzRNnhMMTNMQdo3FkWkW1HuTHSLEEKqWenj//Ynnx9X9KU0MyEQHJPg
	 jZl6RMF1hkCvLJ/xDanDM87wpTey6pFvZk4sL36Hyzh1CucSGZ/BOxN3NPGVmsePk2y0l
	 y5tlwmYWl9upT8MUxVioD1TlXuR/wLCztD23kFrLvWA5XH/sZbycZR9kCtNkImHVf0Ixg
	 G74m8VRuSG9p+17zUgSdUvHx+lS6B/s5AATFxoQGrvrzlQAvlIF/bEh221FE/vfMrYBMO
	 +7EGC2KsBifDunLo5+YA/17Qh3CPHgnUHncjUMev+zvUc1IIYxV904EeXD6vpX01tAw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b="m/4KHbWL";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.44
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010044.outbound.protection.outlook.com [52.101.69.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55849606A31B;
	Mon, 26 Oct 2026 20:50:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55849606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=m/4KHbWL
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=abgaNksmyrhQARTjwsBjvIoKAWTYZ6ZQ9gjwlZt+KSJhoaEm4x2UIYWwN9QUH/EXfq+43RylEJGMU1OcRaXkTI+Ix4JUnY9QcUQygXcm3AypTD2STzOsn6JdREBxWf2PNeh1NUiLUMNWonc4J3FkXjXLy2BYBghtJGl4st+qetKhtwrTnGE24wPZ4DkDibkLLnfeuS5Zjf1pj8kB8s+k/N4M6H/sQSpE/c2dYSRy/dQFfTnyQYPo84De0rNj8sbyDKdqkpwSV0Jtxq5/jGnDZnOj9MVoHRizVAsWjqgD7bnimwLWRxeteWLlKGFE40dKyscq89O3YGOnpYxBVrvHow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H5iRjnbzQaAlrwhwVAeO6f65ic0C/2RcyjbvUamc928=;
 b=TOn4D6hoAE19tfLE7+NBWL3vfjc1IdaQgZGMwdi1Z1Du5+ghMdVEKOmT9izeWv8HcS5oyo16ppBs+huzofxGPIYoxCYf+COSs+3CpVmt9nOelcHuTiMwfQF8vbRVVXzHEUPu8OYvc7mgdJXiY4ouLsHRq1su+7MXMGa9hkJpm3ZW1o8s7J1odrn/dnMY0Ro/9FexGL3NeOSrnEWllpKtDGde0AsHRlSrTxPnsnTZMDKVSSixlk5BfYFXe/uQJrfHhiQmQQsGFGRZpM67sFlazwXPTLMDGvipACL1auyai2Ox93z+VqaHxSLSRnzLFortPrBclbniDRYpycQkuZnYow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H5iRjnbzQaAlrwhwVAeO6f65ic0C/2RcyjbvUamc928=;
 b=m/4KHbWLABRO1leY31sHYvk0nQY9AtITTvjAcZwbTiYRxaIazCGIMPvoHmPAEhBRPoF9iAm5W+/FsHhXxw9xRiC2WkR/yYhHfWZjEak8cKC4T6ioeboBWCrpNEvdL51GEQ2tEW3B+JwHoOoEvh/zm4Sm0Oc+aJfJ3HdMxr+6gQ54IAtxrYO2cORpb0QxmwI+bhUXUjqCdPkNSO55RMhTi8hheiEGVgHa+l66hCiUa8JngKlDkwfZYo+9fib2yLhNYnHaHz1v/TZG1QxZqj7pLUMjn8spkRXKpdC1nVy6PcO05l9k8dOig1ytUpvN51RX26tvaCkh0JnXDUoSs6EjcA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by PA1PR04MB10501.eurprd04.prod.outlook.com (2603:10a6:102:44e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 20:49:55 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 20:49:55 +0000
Date: Mon, 26 Oct 2026 15:49:48 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Olivier Louvignes <olivier@mgcrea.io>
Cc: Vinod Koul <vkoul@kernel.org>, Paul Cercueil <paul@crapouillou.net>,
	Frank Li <Frank.Li@kernel.org>, dmaengine@vger.kernel.org,
	linux-mips@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] dmaengine: dma-jz4780: Fix NULL dereference in tx_status
 after terminate
Message-ID: <at-87AHdnoWz5M9Y@SMW015318>
References: <20261023080953.16963-1-olivier@mgcrea.io>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261023080953.16963-1-olivier@mgcrea.io>
X-ClientProxiedBy: DM6PR07CA0089.namprd07.prod.outlook.com
 (2603:10b6:5:337::22) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|PA1PR04MB10501:EE_
X-MS-Office365-Filtering-Correlation-Id: 5017a8e9-8bea-447d-1989-08df33a2b101
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|376014|366016|1800799024|261026121527099003|11063799006|56012099006|261021123027099003|261021121427099003|261022075727099003|261021135927099003|261022105027099003|261009223027099003|10067099003|22082099003|18002099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	7Gg+oe4uQYaE6cZ1CWhL9McQvTU7yAVElVOdm01mCKoCMxzsqnwvhigvTQ+iQ/tYWG95WpDqVqy2+JGmf0UoFEWZR66xeirb3dPaQIeGdVozy0PP6sVesHMgj1t0PMAv3anzTtqJym6jsTlUe91zKwPnnzsKo7M2RvT2V7PE8S6MsR+bmYjDq3ZKjFgDs42zEMWdmG4gDd8BVpsDV6JqL47W71KhbryNKRVltYEIrA/WefZEH7X17gfrD/V5b3k8zJPfCaqYUgwOtgpLwsGX6ZdZ7OIaIk+gw9wV751zTTD5qsuCOP5yIfjpTEk136idtqadYjkAebCM/O/Pjly8Y0pcIgh0z90E6DkMVKL1jrQD1ZOsiMWhNbAoUkdMpX1u4WtEp3LolvyWtmnkL0nHS0fIvVVmgY1PJwHVbHL05awJsUAmKIaqXzwiD/9YGxUtKRYa38h0OPWL/gJndVuBZ1EwTZlzSuBISKBtF1Wwx4yZ/ckwInuhD61tkpH3rTKIEXk+KIVHBm6v2DbuKDQz2F1Es7ad8TIh52ut1l7fwJuSFNCJ/FjeGBTTP8tlGVtZ+LfFo10PVKykJYGVddGRPn/GJyawvAfzBotLLEjOM9Qc1jFPNBNu7yAsf7E/aZ2z3Nvh4Q0LLMBBOZKRjRE65Zs29WKjVeET/5hsUBOik7Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(376014)(366016)(1800799024)(261026121527099003)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261022075727099003)(261021135927099003)(261022105027099003)(261009223027099003)(10067099003)(22082099003)(18002099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rTcKCuJ3hv7hsP7/BdZWVXxKhFc1QyhpFtJBkr95gPCEnRNl+ILUZi0382n0?=
 =?us-ascii?Q?52QE81pPpiuB+ZLcWoNEM4kD2tQdFdMAawn2vFVszRKm00WKAMvVtF9opeSa?=
 =?us-ascii?Q?zaPtwQPQQYkP+Q/2rRJzNvmgegTIQ3Hp1gOiNqI8IrV+BgGfkQrpR8+2E74h?=
 =?us-ascii?Q?NSQjB56bdz9O1AcRFNzZSFbewmvNr98YLIosIRcxDn4AmSahskUmYBh+cWgr?=
 =?us-ascii?Q?SfTgOtH4JL9rgd+ILhjjTzM2kY4RBoPGfyHFSj/n+BUnffVvDjsmo3Mwus9S?=
 =?us-ascii?Q?Jj4g9FLh1NDzZW4CC43KvPT2o+q+hceyK7GjWMe+MvaLeiNV5p6lWrnymQo0?=
 =?us-ascii?Q?qRT+PorPzCgB3SrjBHxGsfwmLaxAnqxXsVHQ+NpjtVP3cZ3B4+2fwf65Exda?=
 =?us-ascii?Q?2voQvr1vAXLmp4tfr6HBc40V2qqxdyWqnCGeMkM21/eSmA+48OhpjYwS9Ni6?=
 =?us-ascii?Q?+/SBdWfBcBPfCi/jHJG5n1BQevHqYSkkRxKbiTM/t8mcC+HAlIPK06cytmww?=
 =?us-ascii?Q?DOrdQWlsgtCDUUkXjEpdAt49yy6TCMFDkGVBAonuJs0jslzNXPtZnnfG0o5M?=
 =?us-ascii?Q?hhjJpP1qcj31Qf1znEK2wFaPQqrTALEdavMODRFhtamXy+bouo/33SQ+/3Wf?=
 =?us-ascii?Q?qyea9drSjGKdRx4OlcSC3xyfmeIcbx7ZErSf8nVmXbPotg+2/2PsjJJDWNrj?=
 =?us-ascii?Q?xsI8JeL1ga4p7xsO3IaHrPYzZg/SIpQoD0ZT1O6XBfZ7ZkEWGEfnQXpSVRmQ?=
 =?us-ascii?Q?56TXjTHEAB83YUlRmUUEiUKgNjanyKnmT77ICJ7uHtbFv2Q//HZ0n9+KyLlV?=
 =?us-ascii?Q?2INZUkTCei9bZBrCzYxSlYTuUiCamIaM4L2aNDJhLGvY5WO2jFQX4OAetqVr?=
 =?us-ascii?Q?LKCAZ93IG9HcUglnIsO4jQ6h7XDeWXBJYIALkKA69hAzxQaYlK3WfK3zdXm0?=
 =?us-ascii?Q?0thw0YEQrn1XlcdaISlBJS2JWQ3WSrFUz659TNNrYifP2UZ5zruIJQw1uhn0?=
 =?us-ascii?Q?XvIRHIfRtvZettc3CkcETTazKo19F+zkfqgWreYpVYFoaa4GJrORign86JHw?=
 =?us-ascii?Q?D+2olGLz3lYdmjMr6yIuvec5luSXG9NWAM5VkwN/XT+8FzOTR0HnQFDCG9Su?=
 =?us-ascii?Q?mMhXufQga4yfQ+Z/hId+cOGZ8nOtjvNBvGvYUpwEiV8JTfvcezjhzXtreMbN?=
 =?us-ascii?Q?dnen1I1eL99pxLN468erWhGT0zzcmybWzPA7cmhg+0U0HGwiRUe3QxnDS5fq?=
 =?us-ascii?Q?+ZWWre9wz48YCh3lyFxCF9r8GAfFUOIRl30mP+zDyyxjfUsAEP+Odcdg3vt/?=
 =?us-ascii?Q?/Bk6CssLLharS0tQncBUbwQp4rp19/GzHA8fz8V6KhlpaFzw/IK13rgFU/lA?=
 =?us-ascii?Q?mzppvqQ4wQoyjAdULYkybnyHXjo8TlYu+qXkTkgrSqRt4WKF1JEaZHXsx+1J?=
 =?us-ascii?Q?Q9LCDIC0V0BHBSQC/XYaN3Pay+ZqWWXL0p6eHrimkS/Gz0vaj1jInXZp0yD5?=
 =?us-ascii?Q?NNVM9Rg694zHqtzz+Ycgt6DGrN+7qcH4tkG8jUldBJYvKTdvSxaB5mPxTPdE?=
 =?us-ascii?Q?8rI0iyDZhBdwcItohkokzyRR/XHkoPfmY5aFrAsIbIxPyBzrLo5KJ5hc+vU3?=
 =?us-ascii?Q?X7zeUzNTNKW8F5zKNwEPwttDUWmapiAGR1qfJjj2KilG+uyAKYUQ5E7ls63a?=
 =?us-ascii?Q?dfYZG/trLNMGJrcbRPDC9WfoA5SA3FLdFAQHFXih3V1QFl3sh6p3ijwrkHBN?=
 =?us-ascii?Q?ZOJqptdeoS7HWbkBcOQErC/G0yadS83zf5vx3BjYsBsfUfvz/0N1?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5017a8e9-8bea-447d-1989-08df33a2b101
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 20:49:55.9048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yyjUAVl/9ud3wc+rN0j3GV/mQxsHyLKaSOw03Fcdix82uwm9sd13TtQbmedxT04+rvEOiVqQSsgSwE4NHVNs9/w+ppZw1hcojJTb3+L76IRe79EGYXqNQMH8vtw1tBRZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10501

On Fri, Oct 23, 2026 at 10:09:53AM +0200, Olivier Louvignes wrote:
> [You don't often get email from olivier@mgcrea.io. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> jz4780_dma_terminate_all() sets jzchan->desc to NULL. The cookie of a
> cyclic transfer never completes, so a later jz4780_dma_tx_status() call
> with that cookie finds no descriptor on the channel's lists, takes the
> else branch and reads jzchan->desc->vdesc.tx.cookie through the NULL
> pointer.
>
> The driver has always allowed this, but it only shows once something
> calls tx_status() on a terminated cyclic channel, as
> snd_dmaengine_pcm_sync_stop() does since commit 88e98af9f4b5 ("ALSA:
> pcm_dmaengine: Don't synchronize DMA channel when DMA is paused").
> Closing a playback stream then oopses:
>
>   epc : jz4780_dma_tx_status+0x184/0x210
>   Call Trace:
>   [<8048e104>] jz4780_dma_tx_status+0x184/0x210
>   [<805804d8>] snd_dmaengine_pcm_sync_stop+0x4c/0x94
>   [<8058f068>] snd_soc_pcm_component_sync_stop+0x80/0xc0
>   [<805775b8>] do_hw_free+0x20/0x6c
>   [<80577650>] snd_pcm_release_substream+0x4c/0x9c
>   [<805781ac>] snd_pcm_release+0x48/0x9c
>
> Only compare the cookie with the current descriptor's when there is one.
>
> Fixes: d894fc6046fe ("dmaengine: jz4780: add driver for the Ingenic JZ4780 DMA controller")
> Cc: stable@vger.kernel.org
> Signed-off-by: Olivier Louvignes <olivier@mgcrea.io>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Apologies to the stable list: two copies of this patch reached it earlier
> today from test sends, with the Cc trailer still in place. Please ignore
> those. This is the real submission, and it is the same patch.

Please bump version when send this one.

Frank

>
> Seen on an Ingenic X1600 (HiBy R1, compatible "ingenic,x1830-dma" as
> fallback) on v7.3; the code is shared by all the SoCs this driver
> supports. The patch is build-tested on 734bef548a96 (v7.3-7363).
>
>  drivers/dma/dma-jz4780.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
> index 6070dfdb7114..7f827be502f1 100644
> --- a/drivers/dma/dma-jz4780.c
> +++ b/drivers/dma/dma-jz4780.c
> @@ -658,7 +658,7 @@ static enum dma_status jz4780_dma_tx_status(struct dma_chan *chan,
>                 /* On the issued list, so hasn't been processed yet */
>                 residue = jz4780_dma_desc_residue(jzchan,
>                                         to_jz4780_dma_desc(vdesc), 0);
> -       } else if (cookie == jzchan->desc->vdesc.tx.cookie) {
> +       } else if (jzchan->desc && cookie == jzchan->desc->vdesc.tx.cookie) {
>                 residue = jz4780_dma_desc_residue(jzchan, jzchan->desc,
>                                         jzchan->curr_hwdesc + 1);
>         }
>
> base-commit: 734bef548a96e8774d6eef5dfa2026c6edc4e80b
> --
> 2.39.5
>
