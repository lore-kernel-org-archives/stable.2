Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010004.outbound.protection.outlook.com [52.101.84.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A263AA4ED;
	Wed, 29 Jul 2026 06:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785306903; cv=fail; b=CGuMSTjoc/w2dwdNqYS24jKw4QPhbxC0TY3nzNVAF9LdkEF72FG62hnlivUePuPd5QzPeryPbAEpAYdJ864G8RN38G84lmgVZ57yEWwhlNyAZ91+QWtR6I7MhA7L6ff9ojicwEM//A0hDV0Sd8QDEGFas8xzlzLEvTTxIVsbn6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785306903; c=relaxed/simple;
	bh=FOmmykkKKugam9/LWMc5E03NRKtfWjRJEGeiXBXfRaM=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=Nfl0ZqE5s0bra/NSqQOjCeVZYg/kZNgd9txoy920Y3dSTtB+TuxUjzWQLyuby0yen1vsqBKaaprWcDgUO0DVyfu0NSxPgK2Ne+YM/3XSNzImk248no6MUj488q8d2j9BPLoVLWWv3oVD6m46ckkCWrnRk+dYOMmLGJ48rVlujO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=gozLxZGU; arc=fail smtp.client-ip=52.101.84.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="gozLxZGU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R2NNEUPXWGDTCemRNAo8om7AVgn/EMqS1/sTbhVyx9VpYNLlNyR9Og8ALme6c71M4Oe408U1FiqGJFdqswEgQn5vdTJwP136WZa1uPlF8kSLiZ884o3srZfPRASallPXzjBfLPEiB1RGrpuYG46Wk8EVU2OKujbXJHYjfyUSYH4u8ZaudKfGNbQduA0hdEdbXD+OeUESPOndeF7vFEgSOiwLHlhsbRQSSayt5IAGRV0GC4PXoQO9evZXXBr214BTZXLdWBwe6/n4sLxhaQXA9V/YoHRtGZ8JamGvkDEOkSe9sbUbGOXMm56LdxluxJszxP7XolTeIB+mTkOCBJ6NkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P7QXYoPMhaVq7jCPBWjb98Li8yyVz0OLWUuzaSxmsMM=;
 b=yVatT4xu+Pq4pZ3NH+lDebbhFoj2ZZIA0Oyv4QFuyh93ZXhFC35IZIWb9dsGJU7ZLaBRrGJhgkUdGtVm6oOQeLKKo6/I9QOiYTUSNsat3/hCrqMimOeb3lksuJ3NKYOlXyJ7GMi2RZEnad7/eXlwg0OEgfB4lpbHjghVozMyrJIPKHjGVuK/xNKN9S3YcR36iKu2uMDtE1nURLNsKYH8NjyTEpfWVwph21E6lEITB/QrsvvxUqlEXI9Vw3bQDOq7oj21IaK3rheRb/ETa5Ood8TylodxqjqTihk/njGxRw4sq1CtH69KQ3rrJVndef7LPyCMjHL8Me8ss0D0qgMPLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P7QXYoPMhaVq7jCPBWjb98Li8yyVz0OLWUuzaSxmsMM=;
 b=gozLxZGUBUknBAiicWaaNHh0hwn+2uHU2Od1+FyvzSCKkbLi5wdBkUFS1KvVu84U918appO2qSEFLRSEahkeBrYa6OOJmB9+XHq4zQCSKC560eQ8BndG24UuSzh7yko8eHp/YgbfAqYFflCrDBkXXYsj25t+ZH81l5MaSBwCNFL39JFhgURIrmjBD+A10ATFSXGQ+gCUMvBP2MQpDfVf7J2C8B9Qt54PSOWKdd2H55KMEWgpgg5LtoR2LSca9h+D+Z/fbA0/3uIqGH2tjSimH5GmYVzamFEGT4DhauzjrejDm5RnqttkB7kfuKtF9mesms2dSFgZ3yZZMu71hkYVOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9418.eurprd04.prod.outlook.com (2603:10a6:10:359::6)
 by MI9PR04MB826873.eurprd04.prod.outlook.com (2603:10a6:290:c3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 06:34:59 +0000
Received: from DU0PR04MB9418.eurprd04.prod.outlook.com
 ([fe80::130:1767:2462:db72]) by DU0PR04MB9418.eurprd04.prod.outlook.com
 ([fe80::130:1767:2462:db72%5]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 06:34:58 +0000
From: Xu Yang <xu.yang_2@oss.nxp.com>
Subject: [PATCH v7 0/6] phy: fsl-imx8mq-usb: few improvements
Date: Wed, 29 Jul 2026 14:38:29 +0800
Message-Id: <20260729-imx8mp-usb-phy-improvement-v7-0-c385ee40ade6@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOWfaWoC/33OPY7CMBCG4asg13g1jH+h4h6IIonHxEUSywYrC
 OXua5BWG5qU7xTPfC+WKQXK7LR7sUQl5DCNNcx+x7q+GW/Eg6vNEFCDBuRhmO0Q+SO3PPbPmjF
 NhQYa71yiQSfAOquRVSAm8mH+4Jdr7T7k+5Sen19FvK9/rNhii+DATeNb6+2xaTt9Huf4000De
 6NFriG1CckKteicRy/qxu4bUitIwCakKoTK6YOWIKyU35D+h8xhe5GuEIA7KkIDJFeLlmX5BbJ
 WUo6dAQAA
X-Change-ID: 20260602-imx8mp-usb-phy-improvement-4272d308d862
To: Vinod Koul <vkoul@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Jun Li <jun.li@nxp.com>
Cc: linux-phy@lists.infradead.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Felix Gu <ustc.gu@gmail.com>, stable@vger.kernel.org, 
 Xu Yang <xu.yang_2@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785307123; l=2472;
 i=xu.yang_2@nxp.com; s=20250815; h=from:subject:message-id;
 bh=FOmmykkKKugam9/LWMc5E03NRKtfWjRJEGeiXBXfRaM=;
 b=zYZjkJyv/m6QEwQGlitma85w9pXuqBWF8QT6XhEg2MWVYKumOx2JG6DbgDbYS3Qz0jW1haaq5
 b0xTV6rxbyGA4vqwY2x/0+KYpcV6/ogF38DwLrQeqiOQjJ9iTWgraXU
X-Developer-Key: i=xu.yang_2@nxp.com; a=ed25519;
 pk=5c2HwftfKxFlMJboUe40+xawMtfnp5F8iEiv5CiKS+4=
X-ClientProxiedBy: SI2PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:4:194::16) To DU0PR04MB9418.eurprd04.prod.outlook.com
 (2603:10a6:10:359::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9418:EE_|MI9PR04MB826873:EE_
X-MS-Office365-Filtering-Correlation-Id: 1590a405-529b-4589-65e5-08deed3b828b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|23010399003|7416014|376014|56012099006|10067099003|11063799006|5023799004|18002099003;
X-Microsoft-Antispam-Message-Info:
	QR7pQqNlCUzl8T3C3G1XIAhDwvgJv7ujN3LUnwLUinHHIt27npP6A8EDkwMkut/pqkBO8kNoUtKBkOFcXYrRZdgbqk/ze7jE28j9EPN2zkLzMrGdtzfIK2J5BhEb0KPq4hn4Aw2h/4VIYXqJ4BTlFtan2ZtzDrZbSoNPmA5x1CeRtSTL5xl7iCHZbFH6XKyt5ReSz+iUCSggKCRDl3SPvBx+vOwhMn0tYgT9AbiI7FovPHZunN4EcAgTAD9x7zpkbVwu/PR2RUg1kejU+EPNJGbKv2tT8QqZA7YZtac4k1gNiahHkkpSQ9HiSAVWnNiKMy4B+d8+DpOakpn25M0cx4kHVbApnHP7eviF8oRMfw7N2b6V+lyXraRP+gfgeXaYgbjXyJdNPSi25WqU5vTbN2htOQIJH2o6d2V+tg/ZFo3r0hZNb4yxwEkOmHcW7m1RoD4JqpYloZm7lj7e0KHgkf+K6qpDo+dUSX9Om53F+wrUF6Ymg2OByNJZfYmz1UrkpKQtrTyiZuQtE2Wn0KBeYMusQ63Hxw+UnGZja0gxB6WWgcNakGofWVT+EkIPTFHoTeETgithBj1XGgt6ouNOW4RQewR/AdR/pUbNzhW/JASbHKc9Ah2jrYLXlpwwQK4u
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9418.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(23010399003)(7416014)(376014)(56012099006)(10067099003)(11063799006)(5023799004)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZU5PWG1JaW9URE1RcWdPZkMxYUh4YWxRbFE2NjQwSTJiT1VWbitHMjZjT1lV?=
 =?utf-8?B?Q01jWFJDcGM4aUhzRE1CQWFWL2F4OVlsTm5jWm1UVkFwM0JYNGRZdlRJZEpK?=
 =?utf-8?B?UlR5OERmZ0R2VVYrMHpldmY1TCszSEhKTXpTSFhyNTdBakcwZ2h5bzl2U0tK?=
 =?utf-8?B?cW5UK2tub1IrZmhMd01nOHlxeE13MnZ5ZTQ3dlBuN25zWlRpOEg0ZGRQMW9D?=
 =?utf-8?B?OEV1WHRZYVl4eHhNZFI4WTFOaTBaSmRYVzRyUmRUcmZKQytnamQ2eGZaU2VR?=
 =?utf-8?B?NERFUjR2clZaTDI4N25IelFaSlJkTFAxU3lXRGFSVjd3ZzlFbHpiUUhMQnhj?=
 =?utf-8?B?K29yQmtRc2VCUW4rbDNkaXlmTUhwUkc3cDRkRDhBVzIvZ0g5KzY0WXFFcm9u?=
 =?utf-8?B?VW9ya2lqVDJ0U1pUM2wveUVnOFBONzhRSVhOQ1NSR1dhZmZ3RnZxOVdpcDJF?=
 =?utf-8?B?MlNrUExlZmlwUzJwYSs4bmQ0TlRaWFJJU3dpa1Q4Y3ZhMmdCMGNVWFBIOWl3?=
 =?utf-8?B?aXduRzFLSFl1T2xtZ0ZrZGlwZnVhNDd5eitiYVZtdkJ4UkJzRml5aU5DMnpI?=
 =?utf-8?B?SHFVQTJaOEE5N1Z4d3lXZXN3TjVzT0MwZGg5Z3dNZE1aTmJkaW92eGFhcFRR?=
 =?utf-8?B?STZ3M0RBajc3ek5kZFJGRW1OTVhQMkV4YkpxRFZ5MWxYRGxTVG56Q1ZraGVw?=
 =?utf-8?B?Yy96MU0zYmt2VGhvM1VsNExmL2pFc3E1MG9TaUZ3Z1VER3N1TU5uaG80T3Jo?=
 =?utf-8?B?NEh0UStJdW9odG1hZWh3U1FlakFFd2cvTklEb2trYmFwck16VDZYeXpESU5y?=
 =?utf-8?B?Mm0rOG84OGlnTjJDMWJoalpRc1FGMUNKZ05ydHNvUzFuZTFwdHpZMXZDc3E4?=
 =?utf-8?B?SnZmVkJSL0U4WGIrWWFlTFdqU3JQdUlpWStqakNLbGhVTmtIQ0lwZTN6SHVh?=
 =?utf-8?B?MW9RZmdnNFQwRzhycGVnWXo1NHRNd3RBOVBxRXdMaGplUUs5VlBKbGM3ZDV1?=
 =?utf-8?B?TUdYbjdPei8yV2NBMXgxSWxxdWp5elk1SWdpMEsxdDZHdlVjb1JpUkcvZmlI?=
 =?utf-8?B?VTkzcVNHTkF0ay9oYzJaQThqTURMc3VVVWhMTFE3WXpjMFRHaW1zVU9CR05x?=
 =?utf-8?B?VTRhZjN0OWVWeVQ5Nk1qbWtVQmtlMnMyejJlK2ZrMDBOeUdoZ0lycExZdExR?=
 =?utf-8?B?MkJyZmNYZ2lBTktyUEI4ZVQyWVlUa29IZm9GcnJSOHY4NnhKVmdZeUR1NUln?=
 =?utf-8?B?K0JZZVJYcFg2VUtWK20xVDdaZjFya2QvZ0ZDTGd3Z0RUamdMcVdVbTZNWE1p?=
 =?utf-8?B?aTdkeWdwT2RzeCtSVDFIbjNEWVN1Z1RKWmZxSGY5SEsrMHZsc255MVhkb2hG?=
 =?utf-8?B?c3ZaSlpLRkJIOHd5WlpLSWlySU8wa1ZrcFRDYWpoeXphVlhIMXRwbnNpKzB6?=
 =?utf-8?B?ZDR4SzE2d2xTdEZmZGRuZ24rU1JOSmxrVEpsWDRBVVVnNzhCR05QcUswMU53?=
 =?utf-8?B?dHptWnhRWTRFdTBOcUtwZFluNTd4UXNXbWROb1J4aW9wS3hvNmM2Mlh4WXh0?=
 =?utf-8?B?NWtYVkE5TWJpS3UxOUg3cVlhUWFNdTRRUCt6eEtyMWVBdE9WanVoaE84RVB0?=
 =?utf-8?B?YW8xd251MkpOdkJFWXFlaUhHU01VbXZrdGFmNXc4Vk4yN0VyM0hHaVZLQ3B0?=
 =?utf-8?B?WVc1VmJWTkRYNmdPOHYzVG5OY1E4ekl0QWR2amVUeitDbUgzOTF0d1ZyN3Q0?=
 =?utf-8?B?RzRwQzRmVVp1UXFGQk5Bck5mQnFWbnA3WmVDRVo0SnlORVVodFBuZm9oT0Fq?=
 =?utf-8?B?NHVnTTRsc3lKL0FwOENaOTVMdDZtZTlDcUh0ZlBZMnp3RFd6eDkvMmlVaUR0?=
 =?utf-8?B?Q3ZrOFNiYk9CVk9oNHNTYkhzMXlOSmV2MW1jSW9pZGNQWHNCNjR2K2pwcjlY?=
 =?utf-8?B?V2Y3anlQUmpqUjhod0RzVVV1TEF2UmZENHZBU2htM0hyWXp3NWdqcmFMNlhx?=
 =?utf-8?B?b1lrdUJkNExCUUU4L3ZMR3hadDJ6VVhJckZLTjdJQ3A0cExHUk9raDdTRmh1?=
 =?utf-8?B?QTYzSmhCY2ZBek1Id2Z6N2h5cjNaYkVtWWViNGF6L05nQlYvN0NkSU92NFBF?=
 =?utf-8?B?akU1d1EwdXMwQUJuSTAzcVNoeDVLS1J3OUdLZlQrVVlNMUd6M29JZmhvVVQ1?=
 =?utf-8?B?enhYN2VlWHNZTWdWd0llb2VrUy9ITHdEQVhxTWF0clJzK2QraG12TlQ3RWta?=
 =?utf-8?B?Mnk2NmlnY3ExM29JYzFBNThkOWtaNEcycWNaM0taU3lwcDJ2b2QxNFhKRENi?=
 =?utf-8?B?REN5bkI4dk1KUE9KWTJMaG9PbGY5bVV1b1g0Ni9zMjV4L3c4WTMrcEF1OHlO?=
 =?utf-8?Q?cpSTQhgE2CIWdJlfXyZtLa94HZi6fVnqOf/sK?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1590a405-529b-4589-65e5-08deed3b828b
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9418.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 06:34:58.7064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wDNaA+mR60iHdVkphepfrclg08yKH5fRdwW/VeIOr5Q73L4abUipJhzNEPgpeSVP5nPXShhcz1fStQ3xXrnxnRon/Z+LWwrfhBXw6+y0fkQY2JNXLU6LlC3Tjlxa+deR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI9PR04MB826873

Patch #1 fix Type-C switch resource leak if probe() fails.
Patch #3 add runtime PM support to avoid register access issue if the
      USB controller enters into runtime suspended state, in this state
      accessing USB PHY register may lack some resources. This will also
      avoid regulator leak if power_on() fails.
Patch #4 add debug control register regmap
Patch #5 add imx8mq_usb_phy_drvdata drvdata for better extension
Patch #6 correct i.MX8MP USB runtime wakeup issue after introduce runtime
      PM support.

---
Changes in v7:
- replase PM_RUNTIME_ACQUIRE()  with PM_RUNTIME_ACQUIRE_IF_ENABLED()
- use non-devm PM runtime callback finally, because the devm version will still cause the clock
  be disabled twice when probe() is failed or driver removed at device suspended state.
- Link to v6: https://patch.msgid.link/20260715-imx8mp-usb-phy-improvement-v6-0-00d95e270e4c@nxp.com

Changes in v6:
- use devm_pm_runtime_enable() to disable runtime PM if probe fails
- add imx8mq_usb_phy_drvdata drvdata and need_genpd_rpm_on flag for better extension
- Link to v5: https://patch.msgid.link/20260630-imx8mp-usb-phy-improvement-v5-0-25d616403844@nxp.com

Changes in v5:
- not use devm runtime callback to avoid clk enable/disable imblance
- Link to v4: https://patch.msgid.link/20260605-imx8mp-usb-phy-improvement-v4-0-b2ddf2f3862c@nxp.com

Changes in v4:
- add Rb tag
- replace guard() with PM_RUNTIME_ACQUIRE()
- Link to v3: https://patch.msgid.link/20260603-imx8mp-usb-phy-improvement-v3-0-7afb8f89abc6@nxp.com

Link to v2:
 - https://lore.kernel.org/linux-phy/20260512101046.1498096-1-xu.yang_2@nxp.com/
 - https://lore.kernel.org/linux-phy/20260512101212.1498223-1-xu.yang_2@nxp.com/

---
Felix Gu (1):
      phy: fsl-imx8mq-usb: fix typec switch leak on probe error path

Xu Yang (5):
      phy: fsl-imx8mq-usb: set usb phy to be wakeup capable
      phy: fsl-imx8mq-usb: add runtime PM support
      phy: fsl-imx8mq-usb: add control register regmap
      phy: fsl-imx8mq-usb: introduce per-variant driver data structure
      phy: fsl-imx8mq-usb: keep PHY power domain runtime always-on for i.MX8MP

 drivers/phy/freescale/phy-fsl-imx8mq-usb.c | 186 +++++++++++++++++++++--------
 1 file changed, 137 insertions(+), 49 deletions(-)
---
base-commit: 3652b49adac266a3d27cb41cdfdb7d8790fc3633
change-id: 20260602-imx8mp-usb-phy-improvement-4272d308d862

Best regards,
--  
Xu Yang <xu.yang_2@nxp.com>

