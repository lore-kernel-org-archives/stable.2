Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013056.outbound.protection.outlook.com [40.107.162.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FD540F8D8;
	Wed,  1 Jul 2026 10:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782900271; cv=fail; b=AMfoyGiJVp7wNn5EInr1o2aesYDK7Kvq3hpwHjRoSVa6D7STv5QxJMEF2vCCtPqEda3yVPzqvC13wB+sv1Buu006pcwYSV6Uq8B1A6Tu3UKbHdhe+n/WnUvpD4vC6AXHSGmqlGPETvQ/sv10en49p+cVNMY+vxDo8DXGSoUQdG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782900271; c=relaxed/simple;
	bh=S+WuRZOv0VFMsXM/uQBuQRHSA5xdheW5Pn91V/D9veE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hkmhV6vW0hzBvkxAv818ai1NWipRh1KPa43zsmaLNK8zjtGSh+fdy3nBZkuskzBECQr0yH/QVGxJ0siGZwyHbO+sKiYZCSJ4Kkvwpg8g3iKXG0Axw0xdq2tjFOAbbMLAUjQ8rrQT21rx32YEKjD+y1UoBMgFD0QAxXbgWakesjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=szhkFR76; arc=fail smtp.client-ip=40.107.162.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="szhkFR76"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VuU+sAqSudYMsMu7odeSEG1zJuFrkUIyX2buVVtSEzWKqQwETlaWi4BYvOh3TTCAb+BwKfzCj8NT578Gh5JLaA037N2L31z8RZSA8dnKPiKnACBWpvrY+sTyeIHWSgS3deI9lIMElys2WsYFhE/bIgsabL2nkV8QO7opCSEOxCFtsGTDH5vwdr5WHgQhnov9c+mve8D2YiOavkgoxHFraGgiOo+i+2Dkhji9ITpgmZTq5z/9l8z/O6cy2vgbMzpB4k2eqW/t/6tf0DoV6XqOAajqoBtSBvyPPrQ+sMNmVObDjJemnBnHPHZIgu+3v/2iDnfrEnEhABRI1pDDMERhhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qpi0yLvFHq1L5fy+jThaEg9BGKUbcOGn7QXIotOHLsw=;
 b=be/+k9WsisFGQOHjo0K5Kt02WeVvFW2o3Lg1FIVlhaVdB0EQ842JF2GJMRSTVBzsZxhd+IcwYJEZd2U8/U++xaUM1VYighj69VCamX9O0nW8Uvo9+sXtRUHkx6rJlKRL/FbFhYK37Nn5AwaL4DmSLS2ypOfrWaH+E5JWUf5JrfFk1qh/sZEcOgURLBu/uYwwa9vx6Sb3MQa57z2qvCNPjfX2F1jrCUU0+Lqg96LBo7YjzqMe23/tzlcvqqCLiMCcTfYmzPV2YhS9Vhms1DCyO088OcDGjOk89exBc9yILRpZwrIs2F0xhk7mP6EtQ0gosvX5unY06MnAxnP8qWpR/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qpi0yLvFHq1L5fy+jThaEg9BGKUbcOGn7QXIotOHLsw=;
 b=szhkFR76X2k277KE4xvqCRubaT0WssjezRl3jv6pxqzHYMGWWuQdVhShoVjxoCuZXRInhbXIWZFGbpralMInTiVQOmmntmsBBSZLpyaVm7jgLE/Ystjg4I8zd9PjSaSS+GwPMxre88/HXsy6hXnN3H/E0zqqjRqXI7UNmDbM1B74sD01K1woedliD6ATUPeS4O47TGjG9a23cWDYPNnYw+RezdBpmnK99UKFANDCaK/cE9XW7g4ig7IPO96XhVNf4/asGIF7apc9devwxv+SKpmQpldZ1T/aqRb+PmO2WszFtqLXTuYcrS698M9pQeE/07ywiSN55MK82bGjJHigTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by AS8PR04MB7557.eurprd04.prod.outlook.com (2603:10a6:20b:294::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 10:04:26 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0139.009; Wed, 1 Jul 2026
 10:04:26 +0000
Date: Wed, 1 Jul 2026 18:07:50 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Ulf Hansson <ulfh@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>
Cc: linux-pm@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>, stable@vger.kernel.org
Subject: Re: [PATCH v4 0/2] pmdomain: imx: Fix i.MX8MP VC8000E power up
 sequence
Message-ID: <akTm9rfJe41zu47l@shlinux89>
References: <20260610-b4-imx8mp-vc8000e-pm-v4-1-v4-0-ea58ce929c84@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610-b4-imx8mp-vc8000e-pm-v4-1-v4-0-ea58ce929c84@nxp.com>
X-ClientProxiedBy: MA5P287CA0110.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b5::10) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|AS8PR04MB7557:EE_
X-MS-Office365-Filtering-Correlation-Id: a13fad01-640d-407f-3639-08ded7582214
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|19092799006|376014|1800799024|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	kq4C8ecfn05EV08hlwesvdJ0zvkNTOQW90QlswHhDac5JpotP/zrngfJFpcnJnRkY9nyBe3SaKxUBTdFjAatkJeDUvpJhFDoTNCQTxfZk3+tFq3vUZnwNZvJ8WQeCRueKkuqg8bKlvFDZhNsn+a2PN2x9kwIrmZTUpUil1ZKrAu4nsoge3bibz0ZUdFztlLTZnOqPQarC45OrTxf+spGPFGOFylQRX2lb6cqsbmVVxdEy4J8hxjPLXPDLc5OcHEzO/eEFY9u87Pxo9/WmqkWAdnLsdTRKDMJGcIQ9HGr1GXvjrd7Y0SXPf8a1tFyxohWbYgIvC5h6kEqbyHYngrLo/7vWWWQOWagruEPDwHcKozqMJjoT0o9kflYLuTJp16PeAYodQ6XZ5FFW8kYQfu663q07Ty/TCM3VNqVZvmh1G3v7A+VnTq22gPwPYPRoSbVZcs9GoYL009iZsjvPqxNAdSn9U5ITXa4+SXL9lkBcCtUD9XBIr2on9UGPyi0hSj3GDcSQj1FpAfD95lgTkBWAC8Y1gUOGZW2t5IP08usrfIThg/kP/AkcXBXSvC5lQjzhzEmF42IRYEvuoM1MYGiVj5F4BBjHkvXSZ4lixTOzmIwrBDwSKMREQE0KqUANGt/mDJaSua5oKNs1265Log9Xpse/BT7V+aFkhiKbHdbaqs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(19092799006)(376014)(1800799024)(11063799006)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tPi+bbXCB6e1E+Wn6piLtFI8gRI73jTQX2MXaQ4FNeCX9sxRS1i1a+f+5tqn?=
 =?us-ascii?Q?IHR2tlhEjNcsB/FPL7oe7WMBTmA5PLPv/KCONGOjlsEITzuJFAgfQqxRLdhI?=
 =?us-ascii?Q?7XtyIYO4YF3ln7VXoOJyTIwu1qlCwd1MEs+L0vdjQ6JSSIj6P6SoH7tB2P9L?=
 =?us-ascii?Q?XeAZoudNgdllsrTMTwOiz4FF6FQt3wtw45apxMKgTkJjsDXUotV4kSsAaebj?=
 =?us-ascii?Q?izYCizn7VLmCXZLIVS0bE94KE7Gzo2HCF1w44eWwxk4og43wCh6GDx4wT5Ke?=
 =?us-ascii?Q?1Ew+EygRPLOiaFBi+2otRvsRHmYiqhJP63BNptPJ3aU6bVZG13gFIeOXPgcn?=
 =?us-ascii?Q?VJDXbUFyEsD0nv3bgicCfD+y06jgP3tPgsYKAbD7nt6Z2oQnvH1ROGMT1lk7?=
 =?us-ascii?Q?mdoAF4AsO0Q3Dqq/Ez1vayoTTDhqVr2J7ibwVMPuBmLy4jnAWazqvhWy1vfX?=
 =?us-ascii?Q?hpcEGe/5QNtdE84NKlO0dfH7eJ32junzsxx915wfolIXMAW/k+pjmNpNQlZS?=
 =?us-ascii?Q?/5Y51BayrreKsFEevtKQFFh25nR+VKgRAsPdENh6WarDE8VwMj407xNnrq2l?=
 =?us-ascii?Q?TFNr4XKQ70N6HXwT31sq0O0WX1L7JC6U6BnU6uSC7CdaWmKXQOJV50qY5gph?=
 =?us-ascii?Q?Fd8TlFZlKR2O/HxnrGC/0QodpkmzA2Nk3RdSR7KyZ51RBWq9hjUbr/Elo7Mp?=
 =?us-ascii?Q?DpGg1AL7Qh9iyL/x9JONKUYX+kVBselQW48xkqQkSxpRtVHZocNnK3d8r9me?=
 =?us-ascii?Q?iEGqhVPVoV6ze8Wr8pXs3vbmFl+nrzl7gdp0zwAZkDbkmELUSK81eD49SxYS?=
 =?us-ascii?Q?04gSQivWGlv6WU9mG0a8d465a9OZZH6BRI7SZZ9u0bl80YJTLoarIbX5s/O+?=
 =?us-ascii?Q?CEqC82m44+SxuC6DUHGGezrQ2LaH8pFOzengRVmNhU4ju2F81ulfkse6a8f8?=
 =?us-ascii?Q?0bsHw2ku7/9GsaKpviapeIthI1M0M/j4qwpBOWUHVDFyUWHAz+VE2ZMhvvRo?=
 =?us-ascii?Q?jwggO5PHbRFXH5BWkh/RM5k+Nc10j4q5r4G/bgtwze5Cmzin47pN8uEC2/JW?=
 =?us-ascii?Q?6eD0nX0NdZDsCkqSIFXgGJnyEidghOYMNN3lxwQU8xEroHrhyAtP8khbD8b/?=
 =?us-ascii?Q?mcc9VnDSG6Li2bWD9JpRtAQai7t8CFeZHMuGRbgqg7omlSIfN0RPtq6dUi7V?=
 =?us-ascii?Q?OFy2i6p3OXjqwXuhmx8T2Gy3qhsdVaBC5AKC3EMEHYFZbDNeJDMueAkHBr+R?=
 =?us-ascii?Q?Kk07WP+oITnfnwJqO3LyVmrxxZqXkUr23z/wqjsoBVnXsg9eWST3mk6J30rf?=
 =?us-ascii?Q?6avnt4cZNjJ3gRmDgKDBsVbITWw+lQalhpSdwSink+RdFtzT4eIUrZwShvgH?=
 =?us-ascii?Q?jdBcKeGAcx98BCbNxV5NU1g/jWUJD5DYjTgdyUf4qDx7LhjfGK0T6ghHGQnR?=
 =?us-ascii?Q?XNP/b3B/L7BENV4Kn4ryy4Au8g+EJT0LfjuPjgLI68iFnBpqxQD4lmCEQjl/?=
 =?us-ascii?Q?Ir+YKry0755VMv2WeioJ223dciERhQI9qq3/Nsj2FAJ/ojYmD/3iUOQnBHiR?=
 =?us-ascii?Q?S5tg11FhD6W1/o1mh4uA70F1qqPbaK4+TdUng+3jDBJuOuUkq83AmR19oBu3?=
 =?us-ascii?Q?pcdDPFj/foaZvDUuXE799v9X5+mNJbxl6SbpxCG7TGvrefdHh+gZGPkmDjZP?=
 =?us-ascii?Q?opz49HI6841BhQDXqowZbGR1q/r5Qk5yUvor0ii06cT0rmv2umCFwEpJTcoM?=
 =?us-ascii?Q?gNLqjOko8aVg99dhv1YwSNO192dHFPNX+OxJd6mU9kzCVR1ydT8Z?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a13fad01-640d-407f-3639-08ded7582214
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 10:04:26.3708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tChh+tAIe/saPHa29DgkJgx5TGw6hczemiUDTiHpK2/pDBJCF/drubKSrNzMb2r58IUvjZEaHX4d+b7OpN6BqA/67crecaNrDAi2j5hnrIHqO6AytRbqrVL2AdVMbC67
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7557

Hi Ulf,

ping..

Thanks,
Peng
On Wed, Jun 10, 2026 at 10:39:09PM +0800, Peng Fan (OSS) wrote:
>There is an errata for i.MX8MP VC8000E:
>    ERR050531: VPU_NOC power down handshake may hang during VC8000E/VPUMIX
>    power up/down cycling.
>    Description: VC8000E reset de-assertion edge and AXI clock may have a
>    timing issue.
>    Workaround: Set bit2 (vc8000e_clk_en) of BLK_CLK_EN_CSR to 0 to gate off
>    both AXI clock and VC8000E clock sent to VC8000E and AXI clock sent to
>    VPU_NOC m_v_2 interface during VC8000E power up(VC8000E reset is
>    de-asserted by HW)
>
>This patchset is to fix the errata. More info could be found in each
>patch commit.
>
>Sorry for sending v4 at 7.1-rc7, no rush for 7.1.
>
>Signed-off-by: Peng Fan <peng.fan@nxp.com>
>---
>Changes in v4:
>- Add R-b
>- Set is_errata_err050531 to true for vc8000e
>- Link to v3: https://lore.kernel.org/r/20260409-imx8mp-vc8000e-pm-v3-0-3e023eaa245b@nxp.com
>
>Changes in v3:
>- Separate power up notifier fix into patch 1
>- Link to v2: https://lore.kernel.org/r/20260228-imx8mp-vc8000e-pm-v2-1-fd255a0d5958@nxp.com
>
>Changes in v2:
>- Add errata link in commit message
>- Add comment for is_errata_err050531
>- Link to v1: https://lore.kernel.org/r/20260128-imx8mp-vc8000e-pm-v1-1-6c171451c732@nxp.com
>
>---
>Peng Fan (2):
>      pmdomain: imx: Fix i.MX8MP power notifier
>      pmdomain: imx: Fix i.MX8MP VC8000E power up sequence
>
> drivers/pmdomain/imx/imx8m-blk-ctrl.c | 46 +++++++++++++++++++++++++++++++++--
> 1 file changed, 44 insertions(+), 2 deletions(-)
>---
>base-commit: 49e02880ec0a8c378e811bc9d85da188d7c6204c
>change-id: 20260610-b4-imx8mp-vc8000e-pm-v4-1-a978b40c59d0
>
>Best regards,
>--  
>Peng Fan <peng.fan@nxp.com>
>
