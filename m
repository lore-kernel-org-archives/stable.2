Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.3
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795565667;
	b=xc3GX0NPag+mLqWDLs6yJSkeAxB5njZlKWwZWv0sS88wTAPctGHCzg5nr+8eXpPyP5j9
	 aMeDGYMRNx9GDOWI+R5yZ48p34jMXk7M/5HqCzJeWRAUkPYaMP2qfPYvFC8Qqgbsjy6yK
	 OZskcY145ehWQHHKuPBQ8/tKPZdq2YdWiBmgChdguIGZTsqCAZQsOvlTgCT3wYatPfUWD
	 FTOGeFBl57Vr3ClDsqiLi67dWJ8LH+tgV1YRvgd1o8hLrPgsX+7hEdC8cjUKX23Kq2tiP
	 Yl5+9CSE+pXpkMn5PPP2/gpO1hZa1UKqpInq56uZ72Y0lkTFT00RcmcYQ1VF9noXD2w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795565667;
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
	bh=mEiGV0BVULzbwzyV8lMhWxm8vyyKK7LiQ/cqHfgbHBA=;
	b=g2MawhkTZoud8PpblGWD1WAysV8HeFudZi/4pK1fN+Zy+0p9OhSDyAQnITWRVC+WpZlB
	 OCAmR8vUya4bIZJ2pFw5Ka7rVdF5s06yc5A23N/z1fr9TVV407pE9y+MtfVIL/GPFO4Ch
	 H7VSoI/olP1oObaCjqurEzotALLO14ZVNk9NrmNMAC2tZ0YbQc2ZViKIP1Cidt5bxiYKi
	 GWffdW2ZeF0NCYaqIcvslSs8maWwc8OanM/8Gwu5Uyu+dBfiF0PUmEupub1Z3Zv9a6hK7
	 zzkMdK4WEfKyEv5g38zuzGEdUQuYtwp16M4aM6jstlVL1OlTKn4484dzeFwe5yc7FIA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=kdKZGUiB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.3
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010003.outbound.protection.outlook.com [52.101.84.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A1E606A321;
	Wed, 25 Nov 2026 00:14:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22A1E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=kdKZGUiB
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L/PEN9t/TjklWpoy/aqtHhaWXRSKFwVYcdGQm1rXCsB+Dg/8afOTJMAVpZALZJkCO2M5JoXmuSb8UfoPdj2E8F8Vu/7ddBKiOkvCAFDysmrvvrDvM642ebSom0ULdEGRNROljZTbc8xMzkvUr7EKua03j2WR7cEYLna7jfQg2uDm/FoS1mvNiD4KW+oGS82FghX1H5yXZPp11a8trZgLCigvfwmtec1RS7lI0ifNyOUTR60CJQofb7/j1a8ZpEC835Va0G/3EfNzIq5SQ7nb2jUgav25MAxk5KpmKYxuwt67/K53BWKIYjp02YhoTLU+TrDW06zsdtrdUtscfYNmMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mEiGV0BVULzbwzyV8lMhWxm8vyyKK7LiQ/cqHfgbHBA=;
 b=D/UmTBTsnzCWFs2gVMG66Q58uzNfn3CpEUHb9P1WkBl48WFQhBcllelEEBBedIdOkyK7+e0Oa7qEYw+tk2FnSw9QUutRZXmQYELFJMIx79vzXhGW1P9yqmjuZesmgLgGdUBSS01qWXINPQXVlkR9iUB5gpQxDTlSnpA15V/aXwev1o4+B8ndnRVD06RCbV4E4jR7DRfaUJP8+k9evmaGwxre463ICqa6qzs9Is0y84MtMrDgw5FABnsX4pPUnybxVLlAUrzOoOK4bnW8nTDF4fMADRfbFd8Acxpoj1C1XLBSGaqKISHx5Fea34hH/vpxAMxO5qdvKvL+b8mdM1ga/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mEiGV0BVULzbwzyV8lMhWxm8vyyKK7LiQ/cqHfgbHBA=;
 b=kdKZGUiBiaqCAVCpc91fFMtm+9AvYLex3UkVzEfkaXvLlA3SsVOZ7EICg5H/0c844rpinjFta0Tq/KDXMYWtN/S3WLbREJEa7UaLhwUB6xMK5kTNvHQOvbwLGrq5GTUwkHJTgqNCcXOODaHT37UTLKM+ZrsC4KdBfUTsYi3d4TOokmyIcQZZoF+e6H9NCz0nhWfn/gzgbD5ORAIwE/ikov9qEwAyoNLlkM9+EOGRft0yDTdWwxDGXf5nRrjj5gVnmqjmigQ1+pNEo6zmfzXVbj6v45AmXSaD0YNpsR74AYAXNO0B3rSVXTeFgZvH5657uLI0PkzHLnzONxueZOxxDg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by PA4PR04MB9415.eurprd04.prod.outlook.com (2603:10a6:102:2aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 00:14:24 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%5]) with mapi id 15.21.0639.012; Wed, 25 Nov 2026
 00:14:23 +0000
Date: Wed, 25 Nov 2026 08:19:27 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Lee Jones <lee@kernel.org>
Cc: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Dong Aisheng <aisheng.dong@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>, linux-clk@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 01/10] clk: imx: imx8qxp-lpcg: Prevent stack overflow
 when parsing clocks
Message-ID: <awYpjwvlR+VvYnyf@shlinux89>
References: <20261123164834.3330320-1-lee@kernel.org>
 <20261123164834.3330320-2-lee@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261123164834.3330320-2-lee@kernel.org>
X-ClientProxiedBy: SI2PR01CA0026.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::16) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
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
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|PA4PR04MB9415:EE_
X-MS-Office365-Filtering-Correlation-Id: a460094f-5087-487d-e1bb-08df4a890ef8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|23010399003|1800799024|19092799006|10067099003|4143699003|56012099006|5023799004|11063799006|261022105027099003|261022075727099003|261021121427099003|261026140227099003|261028144727099003|261102123227099003|261009223027099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	QFKnUduvJyHZKuVcSmgd+82KryJ3pPUWLCy95bNaU3UpBPYvxAn9e8oJoRr/18BwqJVu6Ukxb8LJbxlXpXIYUWFaa7ivocewKaCjoILTziA2sqCHDL/wXJqjUn6CDJ2hqT1PWHzGuLwBxZPZGaTWyaaJ9lyxGzNQMTybB7tI2E7Ms7z6R+qfES+f8IsWyGV76WURX2RYoxtM4Xo4TXGly6WOjS9VB5WFbFg/XHvtYeOULZ8EjC/9xzglf5uf+mhFcRIoOqoKAjOzNerCTArgbOFCyC61f4zr0K7Se3sL2DsoMVcgRgaX419UjKuSDiiuv6J0UVQ6fxW7Ifa/n/sqAV3UtfKYtO8KO7wGbNG0+yLYKV2kotmBH6yfD3sVNLoP2F4oa/25gfvdrvlrmxoTafA9BVgLzLxacFetbRez0AFrFnV0quEPOg4mOIuvRoaGAjnk86jiu60z6zvJ8m5riCsM836Qu6eQ7fGviymS8/C9SxVIZ2ubw6V76YVLenG1MjYxJ54pq8NCPImnnGhxwqMhXNxbepvLKR8vZD4HhAeFOv/KJLLL1/wySRoXOyEl0f5P2cB3ozp5+dV/LqRBTMnYBXb7oojtkZ//bri9FCQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(19092799006)(10067099003)(4143699003)(56012099006)(5023799004)(11063799006)(261022105027099003)(261022075727099003)(261021121427099003)(261026140227099003)(261028144727099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C0c/9i+1csAQRbT9eexqG9GOOLgXSEx6x78otrgVwewIlie7ddU4/sOU9JbI?=
 =?us-ascii?Q?kvA3qpkyN4000FIcBWt0SJRz0srtPyOPAGJl+bcPvsh4pfO18cUdzYoStsfo?=
 =?us-ascii?Q?DTNEYm5npBz9RUQl8c6K+Hfsewvfs6iV66z0m/7/BCyr01uRniAYO0ye0w9V?=
 =?us-ascii?Q?7ovPn9gnzV5NMkTGe6Ua/zN0uAnpvXiWAEzE+YHHK6efsh4SCycVuxKS6Xyz?=
 =?us-ascii?Q?KfBhK2Y8ZkXJ7EL61u2HxGQ3u+hl8+dylUfNQMl52bk/0ifDv9VGviCX8+tj?=
 =?us-ascii?Q?JsJ4fVtWtOP8tgYfdvd0vXDSXO+lRm841YzwNCU0kSXH2Jpk3FeC/GnoPX+a?=
 =?us-ascii?Q?PURvtdbAXsun/Lb92RE7WXFgk/ncjC1xldn1IQXTX4rqOQKbc9C6QN6zuHOi?=
 =?us-ascii?Q?+e7aM55q4T9kUMkSXVGACGOCI3XCN/oZ8xQ/YWVvmLQafJm5+OVN9n25/Pcf?=
 =?us-ascii?Q?uEDkCWyIvndohUnGk3bwxC8sNXNPFsWGs2bvuL2K2X4dTE40k1vhE/Au1Bi+?=
 =?us-ascii?Q?EsVCKt78cHjRh7Tohfuv0s6UzTjEX7f0HoV8lsdNIdAGRO9YXIOHPoyAjRhs?=
 =?us-ascii?Q?b/JNeJxGbCGdPbGea2LcRNU3iSm3vP9hr5yuOkpsbnzoaFRJl9lfI9OvXwRZ?=
 =?us-ascii?Q?76N6UIelEMbPNAj4FGf7n0NXQfZUAf1TZ+M85nzIHFRPhHEXsGQhfiiqL0YX?=
 =?us-ascii?Q?ObY0JuDieJUrbfNZ2n2JCcl2OOkW4ByRk3dkyojnzk2mdGAo/BwD79PfFga8?=
 =?us-ascii?Q?qEFsU1KFqZ+jmzoM1m/H+DNn6+JkSRhhcx8d/thiKhdo7V8OKwhCRWV+2zaa?=
 =?us-ascii?Q?99m7frHfiErXC4fn1cz9vau4j9wXr5dhD3rO7+HXLN8yamZFFqhK86GOJANf?=
 =?us-ascii?Q?UfYUsVtLyRB0pOiSdE8eDiB0mXD7GLPXltvwJ9FwT52XzwjcJAClL9YsGqTO?=
 =?us-ascii?Q?y4dBTKLNAjhrN5RZe20hYYCdj2E5DDz2P0W/BWFSJZMRw0P+0HVcOHsF/qQL?=
 =?us-ascii?Q?6wCddcK8DGMCmQiD64kopG9xtbT2bh+Ac79pJy306s7f8oCBXkrW0qYJu/El?=
 =?us-ascii?Q?2opcN42W5dbUuKd70ab2UdqNxwDy1N2S/KEJdATvDHrYlsdcPKnDAkUCJeeY?=
 =?us-ascii?Q?whAMEQVOTGqn0UrBKJY8eFGM6f6IgCdoshz9r3QoB1iICVCxPC3tIJ8/o3fX?=
 =?us-ascii?Q?7FuU4w1uN9TfaO0Tq6wcv82Kz/J8H5PBzA/cSTTx/A/DvqUq/Gk3BA1s+qcj?=
 =?us-ascii?Q?HjpYJ4uGDWqPHNxhDGWdzcPb0X0m/KpXOhEoak4vZWy6lMVmmQ/fNm3wjyuN?=
 =?us-ascii?Q?WEtv47uqx0as7OGA0Wy5I5mxr4ULFNaD1AVE8BX0N17YKdIkYLoXcfRalPCz?=
 =?us-ascii?Q?NUeqwRT2MS2tltoXfBQKSWhljlR/Dwy6l++GUF4qaKgSmD0qoSurDAKMWbxg?=
 =?us-ascii?Q?EYNwBRumwohan1hhu5odUDIbfdGgTAXAvuY33nCqa/vZ/UYzcqHSgu87Xg65?=
 =?us-ascii?Q?3FRgrdC6hHfhPtGnIOad41SYxPfhIJXxixPOGdhaMH+ogXFZurnKJimfLuMn?=
 =?us-ascii?Q?PQypqqqZ/PyaOMIl+tjz/YSe8qw2Kowsc8liRm6SIt5gH5NlrObchHxmnYiV?=
 =?us-ascii?Q?bpDiqMUTeDYR6fo7FNeFA4EO1EAZJ9YwiA4zMwbQ1Z9u4qVsKvbO3T26ePAo?=
 =?us-ascii?Q?STF5senhmphoOG00uCclgdgMZKnb4Ofu1ex9Zb7l+Cgktbl6z3i1zNSka8gw?=
 =?us-ascii?Q?CbA9jpKtZ4sRT6Idgh402ebW+gJlRUUgtlXge1L3CGIZXy/NcgrQ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a460094f-5087-487d-e1bb-08df4a890ef8
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 00:14:23.5846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I9aydOBnKrvAdvbnsToZQzRWwVgNsyG6VTJOcDF/ugZleBZU6xSk6TQdwoXMYrzcTsrJF0yvHdTCAsPMKFrVWNQhcjPZ6I3G0xHmrqoznFp3U4CSBcUyK5nUlXkLaGMo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9415

On Mon, Nov 23, 2026 at 04:47:34PM +0000, Lee Jones wrote:
>imx_lpcg_parse_clks_from_dt() allocates output_names, parent_names, and
>bit_offset on the stack with IMX_LPCG_MAX_CLKS (8) entries each to match
>the hardware limit of eight clock outputs per LPCG block.  However, it
>only checks whether of_property_count_u32_elems() returns a negative
>error code and enforces no upper bound on count.
>
>If a Device Tree node specifies more than IMX_LPCG_MAX_CLKS entries in
>clock-indices, subsequent calls to of_property_read_u32_array(),
>of_clk_parent_fill(), and of_property_read_string_array() write past the
>end of these stack buffers.  Reject counts exceeding IMX_LPCG_MAX_CLKS.
>
>Fixes: d5f1e6a2bb61 ("clk: imx: imx8qxp-lpcg: add parsing clocks from device tree")
>Closes: https://sashiko.dev/#/bug/linux-22dfac78-f44b-42f8-985a-995308723fc4
>Cc: stable@vger.kernel.org
>Signed-off-by: Lee Jones <lee@kernel.org>

There was already a fix from Abel.

https://lore.kernel.org/linux-clk/20261102-imx8qxp-lpcg-duplicate-clock-indices-v1-2-1c3fc3fe727c@oss.qualcomm.com/

Regards,
Peng

>---
> drivers/clk/imx/clk-imx8qxp-lpcg.c | 4 ++++
> 1 file changed, 4 insertions(+)
>
>diff --git a/drivers/clk/imx/clk-imx8qxp-lpcg.c b/drivers/clk/imx/clk-imx8qxp-lpcg.c
>index 9ad016106b1e..5eb4bdbaf7d8 100644
>--- a/drivers/clk/imx/clk-imx8qxp-lpcg.c
>+++ b/drivers/clk/imx/clk-imx8qxp-lpcg.c
>@@ -199,6 +199,10 @@ static int imx_lpcg_parse_clks_from_dt(struct platform_device *pdev,
> 		dev_err(&pdev->dev, "failed to count clocks\n");
> 		return -EINVAL;
> 	}
>+	if (count > IMX_LPCG_MAX_CLKS) {
>+		dev_err(&pdev->dev, "too many clocks: %d\n", count);
>+		return -EINVAL;
>+	}
> 
> 	/*
> 	 * A trick here is that we set the num of clks to the MAX instead
>-- 
>2.56.1.750.gf70dc682cf-goog
>
>
