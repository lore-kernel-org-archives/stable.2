Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013063.outbound.protection.outlook.com [52.101.72.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211A43B7759;
	Mon, 14 Sep 2026 19:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789414562; cv=fail; b=LarptIMafAAkvTPC7GIXBXvdN32Xfh2pSnnQbBrFTypTbGhA0hY4wQ3mUXlr2zuh8ySfepbJ5rrU/TyKmKt/MA+GN0VXAuWnogjclI4JWuzZtUba0b6JtuPGO3TW5CAHElsK7Vsd16XHa+i0sjfl4gF7wHR99nkkHVWM6LkVt+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789414562; c=relaxed/simple;
	bh=qdt9Kw/Gmj5jN0RNa45crmsl1H2/E+nrJroqBMGLNaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PyoKaOSJdoD0OYSyjBIQrV/BwNLNtU4rlQBQrgdnyr6TNZyJEtas/z3X2Hjgwss0BYib9dOHUamukrLFDGA9mU47ByM50LODD5UhV14H5to646od2Ur60QmIoZYLGtmgD3G+RIlO9uEJYvrEr3r9w3qkopj6AufTSsalu75pXpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=qUaPynN/; arc=fail smtp.client-ip=52.101.72.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="qUaPynN/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HE5pwhm/2PmZIjaOqpKPeKv4JaKmg2MERSSkbktagOTNrVjAeYonX5xrOM1EawG6/pvqR5IV8Ajp99xIvTfIidBJuom/q9NRlz0g6jgBSGqoDffeV4tDPY5Cm+jopVUBjp1QJ5Zv2zUxs0cByzdwBpQtZ3aAc/rIc9XXVXmNBf2xrFc59fM3ojFVtKE5yRIhXai6Dcyw8WAtQQpNLp/LncrKjDXyjoVDVJ5cX0TApfLZk6DqwNmrtIsIzwzyqCfblh07vsbzKgGuuGW3ii1WkhQiGc412wABsVL0XphioNAYkzoxV86dcbQu1S9mpPVIrBNF7bTpuvfMbKPGUAV+jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iyXgHaOVhJTLfrJ//71oMlzcRJJqCS+rsdhx8cHx2G8=;
 b=rR498j/y9OOeEO3p9uPqqeV50MZ5uwypHJ0Z7BDBkc5pf2KhvCJ3X0SeZMQY9ET4UXIlZ2nN0Qie3tlPkeKwk+gQ5x/BE3E7G2qZBJGb2NVocTef9iEgGsxP+Fe7LkJHsL5jHFns1bTWGrlzRyzhm5ZytgncMBIp04em04kSNzB/x+vZssd2/W09uFPfGjOV8bAbqX63ebl9OeRH8v9RWV23UR2yWR800JfhjSWzLBMLozm5c/76pm99meW7sMWfSriCTurXcf5LxT3egr0g/uKN35ekdB/dBZEqCaZwqHeAwn7i/NxnZ0iKxrvh/8IfGvcOX/SOxdiVLFI4gFocQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iyXgHaOVhJTLfrJ//71oMlzcRJJqCS+rsdhx8cHx2G8=;
 b=qUaPynN/Gtc/JY6yuEsH1GwsmyTlUlMLWZhw9lH3vqvs4A+05Z78voRJuyi8diP1AdURMdapDCaKKWAmbYD63nJWqKp8jHkpxTHdZb/pytJMFr1iVkYqt+x2dbFEucxEJM6ve6C3/49C8Txe2OIIv1vVjdI19YRGGHOflhaTciH/dy7SGauK5oikAloJ42COPh67r3zVP/TcwQ6ggQNtFy49B3QPagASswQC74V89EbSdLdqcVxrAcvYsI5sXIUrapgjDSB9VkZjrkivF0FAv1DwrKC5xpR/RSzlJ++3+BU+QoUdyhgwrQEtAgpypBrTwBplOQVxCnWQB2IPUz7k6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA1PR04MB11531.eurprd04.prod.outlook.com (2603:10a6:102:4df::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 19:35:56 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 19:35:55 +0000
Date: Mon, 14 Sep 2026 15:35:46 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Shengzhuo Wei <me@cherr.cc>
Cc: Mirela Rabulea <mirela.rabulea@nxp.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Hans Verkuil <hverkuil@kernel.org>, Ming Qian <ming.qian@nxp.com>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
	Bin Liu <bin.liu@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	irui wang <irui.wang@mediatek.com>,
	kyrie wu <kyrie.wu@mediatek.com>, imx@lists.linux.dev,
	linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/3] media: verisilicon: hantro: cancel watchdog work
 before m2m release
Message-ID: <aqhMki4hreEab8w9@lizhi-Precision-Tower-5810>
References: <20260825-media-timeout-work-v1-0-ebfebbeb6c31@cherr.cc>
 <20260825-media-timeout-work-v1-2-ebfebbeb6c31@cherr.cc>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825-media-timeout-work-v1-2-ebfebbeb6c31@cherr.cc>
X-ClientProxiedBy: PH8PR15CA0021.namprd15.prod.outlook.com
 (2603:10b6:510:2d2::24) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA1PR04MB11531:EE_
X-MS-Office365-Filtering-Correlation-Id: a741bfee-77f3-4a55-54b4-08df1297651a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|7416014|366016|23010399003|1800799024|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	G/O3CO0604uLq/ARtOYbPiBo+o6IMmygFyAW2IvRGObi4BXMqzTEMrNaOGf8IQ173Ov2rHb5tBMVvzbVBAS+y94LvGOxzPTRLs34iStG8f/WPv4/Pvf2kwyDTDCDAjyVaa6TaH8OZHAQzaSTSyL/Pt5UjxwOG8uA+t+rdqRin5JjkyuyfecRX46Q+ziyjN9YWCRclX7BQDU33c+hhUs2D0M+y+lNG7drQmC+al6ueXA1UvbMfY1/Xrr3UtMtXbv95gZ8qhrNAffUXgLR4ZsTLKYqvaA75QsSK8Js9/qD8ur2dCvRSsdz1l7h0rHG61kKKY5wXKmsgEO/RLVLQUA8UgZwbMKVyAgg/odrjMixUsqzAypP3U74vkVerZLJo6wsMKJ0OtZxP1k2EHWbDs1CzohvTFPG8MKzjs/+kIZnud2pXtxo9bGb6EjHlJjKfYYEyhX3FvWtywiJGHP6Xz7WHnFFfRK8/qnfkg8yfLAgYXw0wSBs+Pk4PeZC+NWSFvFxac6Ns8J8F9FRv9DPQA1uLrlq1LhVFtMxFnM3iVCbI4v4cPRGgSwxoJKr2Lr+UK8NfYSxUd3t0gHm2InaqVhsDJhP5CbIZ52ADwtUEKaVCOAoJbsBShVZO9kpMZFW7REKvXcO2KxFHlVvTpFnkr+o9VEvqLtfkZj7DZgRBurwZj4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(7416014)(366016)(23010399003)(1800799024)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k28EOaNX7+CA9scIG1sZuhnmq9H9X+50Xw7KNdDg1CAhtGWmH7seq4ZTkf7E?=
 =?us-ascii?Q?N/GSp0DPXR+DS5xv26rnyt8JjvttYvOkxX9e6EjSpInrR4eT2H4Ob9ddrwjB?=
 =?us-ascii?Q?zDyeAkOATuMs5DehwpbzJ483afNquZkl3/DVk414dYbsmXGklUQ36XWLv5F8?=
 =?us-ascii?Q?rYM46vfOIIUiP+pkDasO06JHYqguAjJj8J6ajPEUB2tzcGNMMe6n2wjYTZJM?=
 =?us-ascii?Q?dGtkKPNWRWbMVTJHeeazWP4T3lJURWkgTDmi7IzUmsMLASaJUwjaTJxBw9mx?=
 =?us-ascii?Q?QHDc61ARQw442nnPeZ++FeoK2AOA2qRwMdmBc+XWbeUehvZVPVxVO32QgsrC?=
 =?us-ascii?Q?L6kSpvXNovEUbIx/Yropg07wc/F3u3rlh3O1V6sr3xy26H9PPYpUg4X9ouja?=
 =?us-ascii?Q?qdkcYZwhY3U40W8khUS4ZEhk3I7tOTi5SQfjpnmBQAzUDRM/ZuQN56IIvIDV?=
 =?us-ascii?Q?0fwsPHhA1jqaDqzobSadycSJlK7gJR87wEln+xfhzTjXiTxn2ZvZezBrzdbC?=
 =?us-ascii?Q?KKevmKUn6v0S+w18zQpMY3I1s929qNW5HYeADSh+2d34GZ1eyhBjumdCGTrl?=
 =?us-ascii?Q?ckNM8hfFnJIH6HBLNDNjtUnm714gYEaapY2VdGfehP2dZ5GFg6Xy4lNJyUiA?=
 =?us-ascii?Q?W2Uud19gzec6xhNoeIEaMRjNTH2iuB1szPWVa/IANlLHF0PgljaXU97i7FUq?=
 =?us-ascii?Q?A9KhGBF2UFBO8NqN0eBL2ktlcjR1w7Hc6kHRFIuC0w91kTRXKLX/S6k0f1tK?=
 =?us-ascii?Q?SBxaZhMP5S4tlz9d1rdrdYuMZStd0bUeaTwNHPvbRUIgGTwplSGh8oppOxYA?=
 =?us-ascii?Q?Y/KOd3QR7RXIpLaygKxVA1IpQVpIZFm8BZORtu0gvwu2dHmNjdd42FIE3szk?=
 =?us-ascii?Q?MmHBN0cjke/+gFBB2QePrA1NRi/kx8ZWzmrpJCI0R+FBsXq1CmLAMtetCa/m?=
 =?us-ascii?Q?xaP2c8p/RDRmR4iqv2BfBLa5F+1/Rn4srROdUje+UgvifipwMUcqyh/UaDlT?=
 =?us-ascii?Q?aEBY7tkaVkfhW86VEHJiChf3VtvbYo4KR6tZGusMWZXoQrCOm5owTcVR0A+C?=
 =?us-ascii?Q?NB13v1qsN58SPcQ3VjSf1RGSdI0V5XFUpWdmes1HyxodCUK1w5gScvzg1G6N?=
 =?us-ascii?Q?hX+9PnwbMNX5cYM5yeZmfgvWcPMaO+0hUGB7VAOuXpN7ESKmprHUfd39BS2E?=
 =?us-ascii?Q?Jrk9NiKCApHQ7x+ZRLidX/tJtthlLtWkdg7tT8QUURo9yFJYmvmu7dS6ciOu?=
 =?us-ascii?Q?g5DLwwgCmAny7rg10HgiiFF/5EES3PKXrND9EeEJHy1jCBAgEwB/RSAps8m2?=
 =?us-ascii?Q?qu3WGe+r6i9DgrATQmD6D2aIVzMDBMMQnsw6uZtvTH2R/HAcRnbhwF2M9ZFG?=
 =?us-ascii?Q?n3VIdF/A6+ZDpnN2hsaNgzfyKlHYPYJwhBdwJU/iLLCjc8aglOHjVJ1yT+pE?=
 =?us-ascii?Q?eyK1ThqU0xNsHxeRv489nDMAGYHzJ3yKR1bmPWw4suimTrRwSjcJrtQvrndv?=
 =?us-ascii?Q?5RGEykxkMYy5LZ36/5LDn/yhT3HpbHpCoY6WJxtwCP7w33UY0YJ+RsWHtHdc?=
 =?us-ascii?Q?c12yxYqy+hzHhEU2F8YlZImPtZdWBCMTScd10TIEG9Xa09fQJ+60HAR8BKM3?=
 =?us-ascii?Q?Qbe89+9vp/g8clhlnbxqeVWl92UebjoHDKQD0TeKr3cMdeJo+vh9hprlJ4zB?=
 =?us-ascii?Q?SPE4B5mLkHWwoYRtPsCrKDHyBk4SjB9H2Kru9UghyJdko831Jt9bvU2pOS0h?=
 =?us-ascii?Q?L/SfQc+FJRSKANnh035+QCfNi/Ivwj42x5AZEBToXaNcRCbrYbha?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a741bfee-77f3-4a55-54b4-08df1297651a
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 19:35:55.7577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cD9esj3d2dIWt918FXEHxlbeIKbnVqDW4t/VnjZdY8/ETbG3hYycNG2YOOAlt1U3uiTyWXmuLYirVcuO/8dKa5gk63aZhxtM7pjiuaWODy9R/KkqERCnj7j9YditA2EV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11531

On Tue, Aug 25, 2026 at 03:34:31AM +0800, Shengzhuo Wei wrote:
> Each job arms vpu->watchdog_work, cancelled only by the
> job-completion path. If a job stalls, hantro_remove() drops the last
> reference to vpu->m2m_dev via v4l2_m2m_put() with the watchdog still
> pending, and hantro_watchdog() then dereferences the freed m2m_dev --
> a use-after-free.
>
> Drain the watchdog before the m2m device is released.
>
> Fixes: 775fec69008d ("media: add Rockchip VPU JPEG encoder driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shengzhuo Wei <me@cherr.cc>
> Assisted-by: GLM:5.3
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/media/platform/verisilicon/hantro_drv.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
> index 2e81877f640fb429b18d2f4fd64bc0c392cf600e..1b04b98371a48184f390a13791243fd00d6b80ef 100644
> --- a/drivers/media/platform/verisilicon/hantro_drv.c
> +++ b/drivers/media/platform/verisilicon/hantro_drv.c
> @@ -1284,6 +1284,7 @@ static void hantro_remove(struct platform_device *pdev)
>  	hantro_remove_dec_func(vpu);
>  	hantro_remove_enc_func(vpu);
>  	media_device_cleanup(&vpu->mdev);
> +	cancel_delayed_work_sync(&vpu->watchdog_work);
>  	v4l2_m2m_put(vpu->m2m_dev);
>  	v4l2_device_unregister(&vpu->v4l2_dev);
>  	clk_bulk_unprepare(vpu->variant->num_clocks, vpu->clocks);
>
> --
> 2.47.3
