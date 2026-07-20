Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011000.outbound.protection.outlook.com [52.101.70.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6359314A9E;
	Mon, 20 Jul 2026 03:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784518283; cv=fail; b=YCNLIpFnC/rQSaD2lV4hTCy6dNmwJ9ZwRQWngdhV6vi07EgsfejLL3X/wpzijns8ZF0edrqtwh3TwpfCBkV+voGDIV9Tj0qvK2ndb6TWjYGx3qB3WL/O7oxyIiEu6Q5m72xxRv6R3s9MEAGRxq3NPusRJPq25+mrZYuSiaMWApY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784518283; c=relaxed/simple;
	bh=i7WHHxRj3fzDg8MB3SPMFe6cZ73NFRSoBJ9HgYUj/vg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=fX4+8010ngK0pebRtAawrrfGAkAp4CaKud1A5W6d85nv4bB9Evn2bbVHBvuSqTBExO7IJmBjADI/IwgAbGgWiNW5cjyp2I+AbaXHFDr2ebHrrzvsrLe6vRtEHqrgQoWxhJSryKZdvaNKJfRiwurlCVAdxtXa/IZ72b5bRhERGTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=GXQHyuiP; arc=fail smtp.client-ip=52.101.70.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="GXQHyuiP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IB+UaQGcwoT+Mezlht+p4HsHB2vqvT71xA7jCY6QNwsf/PNnTTJNkz6RucYPmejx7PgmHDNEwPWdDdjgbs6OAkT5ukERsXYzUNf/UAtUZiTSgsvdsgtRm5p+Fa6ETV0AZemyG53UKz0QPuSJsZX6YuQLK4M6qD3xGfJKqwfaDIAFcmq+B/qlEKm5Fm+lafeCtvAtYE/hOchB7hZ/151wAEj+Bt2/FY+VuEK2AFQeT2p2sWVMkoLPd3m2ugtejzgGt3fccvCGhDC9qhtEyodiCuNbv8fm+GhTzn4QL3jA9oBex9rgiW7d/v5i2YRxsJP4pUWEpsjwqY8/jtO1xY+M4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CpCqGUfnaGE0z79FO6ju1UlO4eUJXMnL5J6ihAnp2qs=;
 b=FhAdxIM0L+D6/o9XDRnAdRBX4E6ovwr6MUdOLGkKGKVY6fmyTl1qhdMvEuupSbW0jZhKgTuD65tF1gvvHh+HfmntsEZLZ9bGg16HlN3ZNC2YfwOBDF6DNw4qesCBidibKm5piA4WmxHuX05Z07V74P0+tG4QYIQ2wPagT8bSoK1QJUJgsPCrF7Lr8WJyHfdAZZ8mM32ggkfeXxAQaU/59Xku7wSt9fkaYE4WZwfcPEBxf13cg6y4hUADFjLZ6kkeOxVQrtfSOfByuZPQfR0Vr1tFmt24vx6wiQLj7GITEJunlNO+k+sFgXJr0iwyfi81uD/mV9xphUbnYzW4fBz0Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CpCqGUfnaGE0z79FO6ju1UlO4eUJXMnL5J6ihAnp2qs=;
 b=GXQHyuiPg/IZTXmunGAaexxIZe2RRUTa7a/6ih7k2MB5OWB8ci6RvBiMBpAoPieN3q5DcnQ4asi4rSqZHF7xjPesyVCwGvGDiwqEs3DwgpCRnlHpEJAbXZJ5x0/7ayZwlfpW3DHvfy62WxJFcNHs0XIkA5rR2qhXP3+s2nFXgYNgKnuMUFxClt1RVrMG2tU7h0Svd5hSzTReegu4koKglZ0u6CRcvJYkVYBq2a1vXRQqpjfhLJ/1E+6KNNslJeNOZLP/i3IEkthkcSD9DbJu55kQyjF8sZiLXsNnrEaqw1VJuzfr4UWvbwHXJMeODESRChgxspi1MV7dBT16LKpkww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV1PR04MB11513.eurprd04.prod.outlook.com (2603:10a6:150:284::9)
 by GV1PR04MB10534.eurprd04.prod.outlook.com (2603:10a6:150:205::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Mon, 20 Jul
 2026 03:31:15 +0000
Received: from GV1PR04MB11513.eurprd04.prod.outlook.com
 ([fe80::29e0:98a1:4577:2cc7]) by GV1PR04MB11513.eurprd04.prod.outlook.com
 ([fe80::29e0:98a1:4577:2cc7%3]) with mapi id 15.21.0223.012; Mon, 20 Jul 2026
 03:31:15 +0000
From: Guoniu Zhou <guoniu.zhou@oss.nxp.com>
Date: Mon, 20 Jul 2026 11:34:07 +0800
Subject: [PATCH v2 5/6] media: nxp: imx8-isi: Correct color map between
 V4L2 and ISI
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-isi-v2-5-45845bc5d4fa@oss.nxp.com>
References: <20260720-isi-v2-0-45845bc5d4fa@oss.nxp.com>
In-Reply-To: <20260720-isi-v2-0-45845bc5d4fa@oss.nxp.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Christian Hemp <c.hemp@phytec.de>, 
 Stefan Riedmueller <s.riedmueller@phytec.de>, 
 Jacopo Mondi <jacopo@jmondi.org>, 
 Loic Poulain <loic.poulain@oss.qualcomm.com>, 
 Bryan O'Donoghue <bod@kernel.org>
Cc: Dong Aisheng <aisheng.dong@nxp.com>, Guoniu Zhou <guoniu.zhou@nxp.com>, 
 linux-media@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Guoniu Zhou <guoniu.zhou@oss.nxp.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784518456; l=1130;
 i=guoniu.zhou@oss.nxp.com; s=20250815; h=from:subject:message-id;
 bh=i7WHHxRj3fzDg8MB3SPMFe6cZ73NFRSoBJ9HgYUj/vg=;
 b=KzNq2ezC56qktsurBXJacO/XXJNHuLf3fgFh8vNZ62AT1sZjbbEdbK+SLpFSrpUYTIz5hnDzn
 r4oJUlyAaz5CEaIELrooTQPeGJl8D1dMTDVl17d9mN5Bon8JDMND4Yl
X-Developer-Key: i=guoniu.zhou@oss.nxp.com; a=ed25519;
 pk=MM+/XICg5S78/gs+f9wtGP6yIvkyjTdZwfaxXeu5rlo=
X-ClientProxiedBy: MA5PR01CA0250.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:223::11) To GV1PR04MB11513.eurprd04.prod.outlook.com
 (2603:10a6:150:284::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB11513:EE_|GV1PR04MB10534:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b33a2cc-003f-4470-a11c-08dee60f5a87
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|19092799006|376014|7416014|366016|23010399003|1800799024|921020|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
 yTE5CVOVNfgk5YXvtH4Gj6Gtb3T7LBFaHHzaQ25r1lXbv7KFAZV+42R/9KMPqPnkVLC8go9o8zDNp4IvHZqc9ctUkGzmhMrZjPasPIXNLl7yxZUzkhYsLxja7h8TmbcTcZpFWf91b6um94LEqDMDJtum87J1XzBV79EArpegh8ZLLAplwWq1m6ya5DN6JqQlwWejnEdFUFYgVS7hG3CN/82wSOhQctZFjvdWZYn3kHLX8Mzv2JQaJV+5UltlSZOU2vn/GZNIf6gct6MwZ3PVDCwiIfd5KFmMrfcJzc4UBdylxHQuAGN7dBGPk5MoMFovl4dBTgStdIi9XX7hwQ1PaMl7nfG5t7mRgHI2e4vXrANKYJ8t10sguedvzbZQz/8V1WF+d5A/mp5nlgYz/zF8/QmYcnG1BJosP9PR1LmPxLftgECnl2p9yrRS+gsJeYNDQFtCDyK6n0zgdmllbn19KucLRi7yNy5vkGTTHYk9BkERBQdQ72IJUiL2DSrmphKkLGMMCmcNyUVfbMfGmlkfUw7bvgE0DEP2DE5W2NQDnUjezaHOIy+xs+ruPuzSdvMaIl79ueX9DIX9lSyeAUa1IBoTkDtww2PjDStF6H5cICfBbMSM/CB3Rv+TYfSFemjBiqcOpZggvXKKMUyW44p/aWt8GQgquxhqTZNKidgGyCW3vHRv9ZSIUPlxY0TOvTpHRjA9V2kLvwrTLyevRAGEVQ==
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB11513.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(366016)(23010399003)(1800799024)(921020)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?SGUrWXNwdHUvS3dkczNYNnFmVnlDWC9CN0FOSVd5OHBkZFBCV1phNUFodEtS?=
 =?utf-8?B?M1VjeWJrRVN4K3VaenRqYVNGMlJYend6UVNZVUZHQjdUcXVVaUQ1SmxMZ1Y5?=
 =?utf-8?B?dEV6eGZEN2I0a0o2d0txWkdxSlNEUDRka2lycjgzK3lPeUlhd3V2UTZyZHd0?=
 =?utf-8?B?ZXhjcWMyazZXUFQxeFJCNTZxM3N5V2dzaVN5Y1lRL3R5eUFxeVZHRE4rMlU5?=
 =?utf-8?B?S0Q2OVhGdjlGci9WMmFWZU81blZpaFNBM3VXcFBnMHFUbDd4UGlhZ3l3TVRl?=
 =?utf-8?B?ek01N3A2YmxQTUp0L2VVdkVGMmxuMFQyaWQ5RWxCSm5FYjQ0TEJzdmlzaXBs?=
 =?utf-8?B?ckppUmpaWDJFZGh3anYzbjgzaW1KTUJGYlhvR2pHMWYyRFE3Zzh4ZWVkQnNB?=
 =?utf-8?B?TDVwSzMrV2xwWGdSMDFUK1FMWmNtMkVMY3UwRzQ2ZWY0cGVjTWdpb1I3NENy?=
 =?utf-8?B?RWQ4b1IrbFAwb0J5aVpkVjlGVU0ybVJ1b20yNCtkdytlejJHbkEvV3lKckVk?=
 =?utf-8?B?aHVvWnQzK2tFNE9YS3lScCtkVnNKMjArWWptTjBqZnRrbXh3TEMvNTVBM0o4?=
 =?utf-8?B?YzNBdFgzWjR4V2FqbVo3U2g0Q1EvRjFDYlM0Sng0Tm9ta0FDYjh5WlZUZ2JM?=
 =?utf-8?B?UVBGbXJObHRUaCtDdkcyUWdjZXBEbFpnbmpkMzI1bHRlQTdWb0RyQ3REaUVa?=
 =?utf-8?B?RW9kN09xWGFnZFZlay9oYzNXTngyR3JmamJ0V3FSN3VQT2ZaQTdXK3RUVUZv?=
 =?utf-8?B?dGZ3TDFReGJEUTR1VUVnU0FvcTN4WGFRUUYzTTN1K0FNN2FzUVVmSmF4VXg4?=
 =?utf-8?B?MmlwYTFReksxWjJOb0lXakVtTHdVa2RhdEFhRkVXREgrUkZpd3BaOUo3UVhv?=
 =?utf-8?B?N2JKa1pzaFE2eVZrWUFqc05UZVZhMlNFTHFja1NKUjE0UFcxTTlvNmdud1Vt?=
 =?utf-8?B?U2MvS2FCM3llclhwclB1QmxhNDdHMi9ZdGRhMmIyOVp5TDQrZXJUSVFHYWVE?=
 =?utf-8?B?SWMxRHdjQmpVeDRidktXYitIUlUxUlJDNURpNHV1dEdGMDBLNTZldnQ4NHNC?=
 =?utf-8?B?Uy9YekNLNFByWWpSM1BaTnpOcWNWclJ3aEw3RS9PY1RJZWI0bmFHM1hKdnp3?=
 =?utf-8?B?UEtXM3phMXlmN2FrTUxDcUk5QTBOZmhaYTJXaGFrZ1pSVHg1bHJVTW9OZ015?=
 =?utf-8?B?VnFLZFBUaTdFRktJcEhpNmo5ZG1xQUlpU3dtZmdkYmZYMnQ4WVVLelhsd3Jl?=
 =?utf-8?B?VE10TjRSamwyM0k5eEM2cjlYVzJlaEZlRUlueTRiSk0xVy8yVmhYOHJNVW0y?=
 =?utf-8?B?QTF5Q2w0Y2Z4Tm1uZlhQS1I5c1lmcGt2VVR4cUZTTWtMQjcxa3c5ZEtDeFBq?=
 =?utf-8?B?MnVDS0g1WE0venlHa05rdmFQYVE3RGs4UU5XRXh4WlgvSGxzWjNVMndmcHpv?=
 =?utf-8?B?M0tHRUlNTWE1N01HYVBDSWcwQmdqdU13M2hBTUl3RVNQZ2thVDUvK1dHZXMx?=
 =?utf-8?B?M05yNGVtT0hna2lJeVBQdmZhQ2dtaTZLcDdwZVdzVzN5NlpJNUpoTjgvaHJZ?=
 =?utf-8?B?dnYwRTZScnBCVGM2MUI3WG1CMWxoOXFkTEx1Rzg5Sm5vRVBlaFUzTVdiK1Vv?=
 =?utf-8?B?bDMxUXN1Q3RPSjcwcmdRTExzRUhCeHdNU01RSDY1dGRXdjUySml6RW1zWnlw?=
 =?utf-8?B?MXdoK3NvMHptTHRwMFpDNmVEYzFxN2s0OHU2QkxCYTlBSDg2Y1d0b1pmSGI0?=
 =?utf-8?B?bS83L1Ava3VMU0l5Ykg4aEJEaHhKZCtxejQ4d1AzRXg1TzZqRVdxb3V0dHAz?=
 =?utf-8?B?UlQycHdIalNBL3dCZytYeHBNVEpxamRUL2x2Q3N2bE0wdGo2NGNyRURYUEFZ?=
 =?utf-8?B?czUwdDhkOEdNQ3FjMkdqSFhWclVucWJ4MDgvVGlGZUhEeUJiL3ZnVkx4aDIr?=
 =?utf-8?B?UzdNS0lCalZiN2NFVzc5bXQvWjVCTXNPRlI4TERlTGNXS2tQRnhSV2RoQ3BG?=
 =?utf-8?B?dDVqRUoyNUlrVEVrdklkbHhVcXFycWU2dmd1Sm5UUnYrS0VrSGxQelREelY1?=
 =?utf-8?B?MG5jMGoraEhoZ05qRjA1VURZY2pmcVpOSnJYbUxUZCtXZWFRYVhmR0djMTU1?=
 =?utf-8?B?Ny9NbDFuT1lIMWJZUG1EQ2wvV3Z4c2x2Zm01THVGRHd6aGVCSllSa2QvWm9z?=
 =?utf-8?B?c0w3czE0VlF4M0tCczhmRUZLNmxhS3M1V0FseVl0RDVkZi9LTGEyV2FXREVT?=
 =?utf-8?B?dnlpMnZoVWpWZVNrdHFRL0RMMFU0WXVudCtTS01GVE4wL2JyUGN5eWR2b3VB?=
 =?utf-8?B?NWVtbUdPQ3IwQ1orVmxucmRnWVIwbHp2akhDM3JEcG1BeHpvM0xXSWFlMGRk?=
 =?utf-8?Q?Csd/z5qc9dyIKMJgvdDOfbZIsprEjI+CYBoQd?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b33a2cc-003f-4470-a11c-08dee60f5a87
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB11513.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 03:31:15.3779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /jHri+FfQ77PTUnKgXBeWwwOE7ZTJWQqYhDYjtJKHf9SepKg3HfZPEm256NBi+FPOWeDcY+bEah3JnU7H9o6ZPOb1DdjylQEhj2AiYZESrwoaUoecVw8ihKCzSgX7VOE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10534

Fix the ISI input format for the color map V4L2_PIX_FMT_XBGR32 in
memory-to-memory mode.

Fixes: cf21f328fcaf ("media: nxp: Add i.MX8 ISI driver")
Cc: stable@vger.kernel.org
Signed-off-by: Guoniu Zhou <guoniu.zhou@oss.nxp.com>
---
Changes in v2:
- Reword commit description for clarity (Frank Li)
---
 drivers/media/platform/nxp/imx8-isi/imx8-isi-video.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/nxp/imx8-isi/imx8-isi-video.c b/drivers/media/platform/nxp/imx8-isi/imx8-isi-video.c
index 5eb448f4c26f..05b51b98344b 100644
--- a/drivers/media/platform/nxp/imx8-isi/imx8-isi-video.c
+++ b/drivers/media/platform/nxp/imx8-isi/imx8-isi-video.c
@@ -151,7 +151,7 @@ static const struct mxc_isi_format_info mxc_isi_formats[] = {
 		.fourcc		= V4L2_PIX_FMT_XBGR32,
 		.type		= MXC_ISI_VIDEO_CAP | MXC_ISI_VIDEO_M2M_OUT
 				| MXC_ISI_VIDEO_M2M_CAP,
-		.isi_in_format	= CHNL_MEM_RD_CTRL_IMG_TYPE_XBGR8,
+		.isi_in_format	= CHNL_MEM_RD_CTRL_IMG_TYPE_XRGB8,
 		.isi_out_format	= CHNL_IMG_CTRL_FORMAT_XRGB888,
 		.mem_planes	= 1,
 		.color_planes	= 1,

-- 
2.34.1

