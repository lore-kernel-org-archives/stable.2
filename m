Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.35
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793669710;
	b=2PSHB4D04/r6o/BFpeLj3cWjjV+kU2NUn1vg1RnUHHZAUPfC45N+wFfDsa7AbWhJDn8D
	 L2PixYjfCbtlZuvvkXaI1yN4fRPJSk6xtPfq9XAlHNHb6mc8ItaDhStKfb38VqoXF0XZK
	 IdzHOoKDbIgfgwqrlfSf0KoZjz+9l4boz7/CkrcX4ioHYFQnAiGdQOYZnFaYRUW6igelt
	 ErNmornEcOu9ffuKMRPdpB6o3+r9GjTf3MuGhN+B8qiAc/hZgGP548uWYzt0bvmjA16Dk
	 D31afwPgS8m+6/feytTRR4DJ24ZxaVPU4pdH1rIF9O3DO+aFCyjkZqbWPYWCrQd3Y2g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793669710;
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
	bh=/G96NQJl0lIzZ/6e121XNa6DMkUa+5R3j1hvLvlIiz8=;
	b=N/xe+69yekDEjS8Tu1qkxQL+5qnngmzgG99muEIUd90kMuRbHqOAtkgwIQLRt46FAgL4
	 kxdZX1XVQRClzSv7xOAEUs1rL29koRbJaqlY0lozZc34dqAQFMlbC9gB0o4dXjJrTX0Ph
	 valyF/pt4gg4HEZCExsgPWNkBIFhtI06gb5ydNm90Dd6uoLWy0xW5KtARo1POZ5RNY5ie
	 CyBVQaiERzgWQpXFFv2kx0jGCLsHBe/zHCOFfrk92IOMYUVsh8sQfOfA+S5+65E4z4k0a
	 WzM3NjMnLvweiq6RihxNGqUD3tgojKsB756ryyvp9DLL1wCy4ktF80wyR7UJ+8atEjg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=VcVkpdKh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.35
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013035.outbound.protection.outlook.com [52.101.83.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73712606A339;
	Tue,  3 Nov 2026 01:35:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73712606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=VcVkpdKh
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uqVb/DdyLeRkzqT4+mvMTTu8sM9u/mPm5C0xHved3ho92wgIyPPhmSxMvNoOZ0cji0GYty6QwdXyvfqK8EhymAZSWjXkuXmAAO3v3wdAk38FWTwtmYaeiiurfFsp2Lzna7hWMkwYSu8L01/HKWzPn58uDGkq9sHyiTYil9AYX55b7i1KFCFRfbxTUxvTcW1IQsJ1pOQDhAQg8eaubZddNtdHqPNlV6xy15nh3ztHZ/ktNBKYk1LVJerVlJqaSp0RBNF6q/IpYRpTCEWJ+RrpEQYRO8oNZtqjouqptPhpoLw398G6GXszuIToIHKa5q3Jkto5lcplqFnUbSJp2yMSqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/G96NQJl0lIzZ/6e121XNa6DMkUa+5R3j1hvLvlIiz8=;
 b=QZw7adoeMKHwrHNUXsKn+jXlRxW0YRmpVM3avOwqmNu3yupuYb3YLAVwNBBnZnMNZEfskPdk4igYkThyqnYXF0pO1eiK6KLlDidTtSJDlKMdhfiyTrwMBt4QekwC4vmWJfd+ZhcthuyupIs2qxohypSiAkVHkcmFvAUj+B4FuZZidRrQqE0CAdoQKRNEcYd+ShF+nMJwrZw/tu72Y5nKS+Et31bv2uJBJrl8VQzdzK9fZAuPgWqbLygLv6Fyo2QgUqz+zFKOD5CLAeJq8yfvFVuPGXLVLNOi3VsyGT0vx7c80SNlCpsbaqg+LPIkZQtY0vyJ+IA+LzIK3swAVgKlbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/G96NQJl0lIzZ/6e121XNa6DMkUa+5R3j1hvLvlIiz8=;
 b=VcVkpdKhKZsok4z1P6T36BjJHdAoCOaSi2cesfVqORV7tKBJm/So8StzbJ9PmJuKutZ2ud7mhL711WaNgyY4NQu9Ln7p81hBSClXzwSwGus+w8u77QlRTFfLfDbQ2g0X33kCVT5hSuabp6p2YSleZ+1872VTr77o9wtWISvYCQSvT9l8snVmyq7SbrntiY/9yWCjBTxzzLXgaEeuOiKhjaW6fdXcFqKjCGdH/0wxJf1oCS+tjzFbpAh9t9ZZFSA5laVeF8gmlf4bO1sNTNpqYL/zW7v3MMhX+cbzNON1zUVMXXSSNtQXpm0qsWNa7ZPljEqAkaniSv/AGhIwu+p2FA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by VI0PR04MB10688.eurprd04.prod.outlook.com (2603:10a6:800:25c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 01:35:05 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 01:35:05 +0000
Date: Tue, 3 Nov 2026 09:39:53 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Abel Vesa <abel.vesa@oss.qualcomm.com>
Cc: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Dong Aisheng <aisheng.dong@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>, linux-clk@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH 0/3] clk: imx: imx8qxp-lpcg: Fix the clock-indices parsing
Message-ID: <auk7adxCT3ghJCEc@shlinux89>
References: <20261102-imx8qxp-lpcg-duplicate-clock-indices-v1-0-1c3fc3fe727c@oss.qualcomm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102-imx8qxp-lpcg-duplicate-clock-indices-v1-0-1c3fc3fe727c@oss.qualcomm.com>
X-ClientProxiedBy: SG2P153CA0040.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::9)
 To AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
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
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|VI0PR04MB10688:EE_
X-MS-Office365-Filtering-Correlation-Id: 97e60fd9-7bd9-4292-fffb-08df394aafb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|1800799024|366016|19092799006|261021121427099003|5023799004|11063799006|56012099006|261028144727099003|261022075727099003|261022105027099003|261026140227099003|261009223027099003|10067099003|18002099003|22082099003|261102123227099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	lSj4gApDnP/X5N1gLBmQMONILrDgaNqXngrAy2Cv371sqMiSALSaJTe0V+EM/3k9t7PU+pTPt6ZcJh7PMlNYG+C7LZfbDA9z/NDHHPLWhULo7cqbddqcdsC0fOBWPCirui6NbA6kvN6XcJjcPP7i9Pr2t3xfjt8c6ulHAj0Lgw28ioanR+H22FPqGjFsnVsIq2iV96LwBSbn/pNN0dCEwuAgCRnANEM17ooq/8qb4xJuPDGlkaTrUhE5geUKm6ViouvyK6gvdGI6s18g2D5kanvu3bIu/lozRZINgWdQhVxcjPzGltkTXwtkIXyEn6Z4HdfMWUl+aPWQ1jLYzd+YSlVNQsquBqU1SCXoz6UGJnxiWyGeofd4b+uuEVnlqjKVDae2A9E0YCi+6W9gQL/MzxOUI8JpuluvUV/tH6lDCdYIPgTNoEi/aMunJvXXVL/MV1bUoHE6ba9HuHSdK0K2kS2DHRjnX4AwrFiwDwNfO79+y7FSimIeVOXUNfGr/d6k+r0L2tvAGMT+amiZmSXlhdzMW9z08H/QFm2StIFozBVfqqETGhC2NvZMWhSW9G6uJZ/uempybM7epCu/eoK+eW6uajY6XAT1L+KTOuDvSQ/eOuywcm2Ktkg1ZuMYX1k8KwgCBARsgvZ+ppXqwPUvnLYAkvoafWt3GxL/dABFmpQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(1800799024)(366016)(19092799006)(261021121427099003)(5023799004)(11063799006)(56012099006)(261028144727099003)(261022075727099003)(261022105027099003)(261026140227099003)(261009223027099003)(10067099003)(18002099003)(22082099003)(261102123227099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wjrLCl8PmVpogKm2Igz3mrAFQp1M5b4DGioNrJbTYU4nB4cJZjHdOHVv5+us?=
 =?us-ascii?Q?nOzrTmcip5M40MHezi+284VQVO5Od+BLNywUPE9AE0grfRO3waiTcVarijWR?=
 =?us-ascii?Q?8f0FfzcAOAS7E7ug4bFACTqjtbqSmAcT/oSNoC7uYkWuW+Eotk4szzgvAGWS?=
 =?us-ascii?Q?3fpyFrpesk1UrQ9jw1iCiwccLlTtNSGrVkYM0MR3A0yd+QmdKjtcowPsdrhY?=
 =?us-ascii?Q?G1VaTxOLZpaA5L7MRHM+YtIc8D4/LcSE8RslIXAPyth9gGEKIkyqa2dWThO1?=
 =?us-ascii?Q?KDVEqW3bXd5iig/83eMkrrCiFiAY4cKt4x7oxV+KVtXC4nxpNGcbwi4K61jX?=
 =?us-ascii?Q?/55rShr8IEurbYhY6P50Sg7AAtxRAVG6id2M74Mnefg6/ZocWUJsc/D6A4H5?=
 =?us-ascii?Q?YTvyFGw1aN064Q0JkAK/uJLiG007Rsw7pQZ6IAdtw2bZrO4JQZjrrTtYfuEI?=
 =?us-ascii?Q?Dt54KjY8IcbgLaf4t6696HfxtNzZpIqmXwdIEdOPR3wlROVgAXZWRNK/Bo3e?=
 =?us-ascii?Q?ufL8Q0GgnDk+kDSkfr5k54cRVg+gSGMv6CygG65HD+jXGdKCVUKp4mw/HJgE?=
 =?us-ascii?Q?eKinCqmodrKPSNgGMvoyjSB7+MMfB/0a2wfCZ4UHcg632ruqzNjPRit+XKfc?=
 =?us-ascii?Q?KcRg8gFzArFINKvoA4PQHTqgqkD6Txngf93T+3CcdhHT1GFDLFMAsuCEsJHX?=
 =?us-ascii?Q?mv748pOjy277g8Ri77SgMIsZfeRnPFYlLPsRBwvx+RVrgs+z+ny40SR54okq?=
 =?us-ascii?Q?EQWC8dVBoMW1BstJSD6vyNsgJDU81EKulGpPhhdBCPt3VZJFxQB+9gwrD6zQ?=
 =?us-ascii?Q?aOrouvieq0FPLn7oqISuUJr1vGYzEhcz1lmwNlfLPM57JJ/Rn1E7qb/4MT2+?=
 =?us-ascii?Q?44AiENMw/6OL7+hJu8efTgTaQGR++LHiXnDqB/v/1wBXchUga4wn9GW105qb?=
 =?us-ascii?Q?ovcr7B9P8VG08M7b9LEVgxKI2CnHV6+HcVzLkDbKo01R+wBBCjQ+/HB4W4On?=
 =?us-ascii?Q?V/NCzDjYVGKsfdsUjgTVVes9OJdS1Zw+6GdEBuAIq5z79nX8pI2Ztz9JhD35?=
 =?us-ascii?Q?oY+i3Ns3ZP1ur5X2LzFhfzJXLHU8Xr2MbUoN1MKGIWGhOziDihyJEtujQCtH?=
 =?us-ascii?Q?YaPULuy1SI6StHzvkNoO48r4eCETg1SjQrn4FE51WposE8xzisICdDdq8rol?=
 =?us-ascii?Q?qagYcpvigejqPEF/dXGCdAML6Xt2phO8AvmWkfLcwX+M/2ioUaVmZkJQX68+?=
 =?us-ascii?Q?kD/YAm1syIGfr0g9RXnOB7itfpmdy19MmUV0ZL2dI9sWcEBnwWcMIgZXOkTJ?=
 =?us-ascii?Q?NAs4Jd0ZwJR2QKJFKmbB0zAULx9afYIE8G07h2JTa+CYAAJ5mhvx1MpJWRAe?=
 =?us-ascii?Q?7P1LCEicR5J9hWujhRrPv3MCwf1VTU0Ua+V0qvaCJkdJBhqpeRQBYbb05DaI?=
 =?us-ascii?Q?1GmJtc86MCscSU1rz8wzD3+TtM7oXoNKkz0jZOpEm6Qpbgl4dWBXZdncyRpF?=
 =?us-ascii?Q?EYka5NbzzTLi7liBycsL3qMCErmoSuMCBMheRJJf66k7WT2C8AsUbv6DX3kh?=
 =?us-ascii?Q?Bo8G1CF9I+ILRRMEy8FQQGWFnrlESS0Z4QP1ZL4RCKUJ2qU4I/2P7cgvsE/z?=
 =?us-ascii?Q?/bvjapTWqzve8Q06/14tt3W/6+vnZ/hOcOnGupSH+4h4ZdOIIgI6WaMld4+g?=
 =?us-ascii?Q?LFJ8mYl/WKqFno9a/iv/DMtXR9m/Xb5OloMwNma1hBjcaveCcKbBMhfyE1vr?=
 =?us-ascii?Q?w/A1YGso5Gk7bQsCouX9KJ0KONEgUyoifI9p+jNehcigiMXXtFqc?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97e60fd9-7bd9-4292-fffb-08df394aafb5
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 01:35:04.9795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f6ZwWJZWgUgni/naR0jE+1b2OJBsV/1541WA/IGg43oVcTpI0gNfUoZryfHCnDNr0vlREFw8wm24pne4j1JsUg513svS4LC+fC0+BXYWfu9XAFa8Ju2NoEqGNV57jZNf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10688

On Mon, Nov 02, 2026 at 01:48:48PM +0200, Abel Vesa wrote:
>imx_lpcg_parse_clks_from_dt() trusts the clock-indices property of the
>LPCG node. Duplicate entries leak a clock and make the error path
>unregister another one twice, and more entries than an LPCG has clock
>outputs overflow the on-stack arrays the property and the related
>clock names are read into. The first two patches reject both. The last
>one makes a failure to read the parent names return an error code
>instead of the number of clocks.
>
>Prepared with help from an LLM-based assistant.
>
>Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
>---
>Abel Vesa (3):
>      clk: imx: imx8qxp-lpcg: Reject duplicate clock indices
>      clk: imx: imx8qxp-lpcg: Fix stack overflow with too many clock indices
>      clk: imx: imx8qxp-lpcg: Return an error if the parent names cannot be read
>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
