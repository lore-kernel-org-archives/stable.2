Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011008.outbound.protection.outlook.com [52.101.70.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AAE29DB6C;
	Mon, 20 Jul 2026 03:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784518266; cv=fail; b=ZPkGaeF9mdyaKRO1lZJv0z69RRhRdt6z9vjJu4c/Y88TI9WhP0CgY8uYMweYAV83i6vnQPyUSlVQROby8WzFlnVTpnzALrCnbdSc9fjABdCCZFFpwu8xPlP73p5SPmmUJ/AXbrqvJSibHa0HcvfSMUuytdWjVLV1+izH3Ke6Z38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784518266; c=relaxed/simple;
	bh=SfOAuoTdcleZ0lgoqiMkCIRSEg0D79H6Mo+wNe4UHg4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=RCWhgbioHIXaDHNBhGArhRMmj9+h2dRc1nZqOTREH71Mz4dlpGuHyP0MjRw1GUaNqLfRFDPpSxYkNS8K2c/LBCrAKL4f9VFlZHJ3sDhC+DZ9IYOCmTAZETbsRhMP+wUwTtYR8gg+lFEM3a4Tfj14OixIVSZMdoNS4gP6svHHM/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=RLRuCCny; arc=fail smtp.client-ip=52.101.70.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="RLRuCCny"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cspj/SCuhVBe3/ChmdleBJm5VgvA6eJXhILA8cgnX69xINZ2T+rh+jG7W/7pPSH0UqNOfUGo5VkdxBHAAqNgMYzxAt/NjvNZKWGphwD8PiAYwDMJFarSaWK3N+bbegq8Osu4DeNnmcdwYh8OxS3RkCNu/N7HdaC9R/LuPHr6tTsjTfI6m7vuTXjDLSH1+TQ49Ugm6A/PN59TbuA4iUu2Z0hPES17P6nCy9rXHp/zcz7LqUcFpsC9ikaVs6K+UQB8G56kBW1Q6z2NLm1TC+pGaumSqoyMUmjOgsw0PhLE2yZyRhFC2xYToeAKVgh9MrDAj21SNLW+eJrsSbrd4/E4TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZEOfMUht/pHk/hwlK7qnyYGPXu5A8RD7A75JAA6Hnxw=;
 b=bHXyZfubnyDFi+givKhAosruXtZ2BcS39J1X3s/xYvv91u5aWdwIqeuU4IeDFyI4nRPoFSwC7ifWnvu2/5mZokf4X7JgkLJxGXElBNIi+ekp9H8Psumeqh+9xSK6RPYHsauI+nNV1xhUZ58e4UANgg4chK88/MVNFWkGjOcAmbaohWjOxEpiCjqqhlRcauvI4pEhOTtRcQdfXifSixic13pYbrQG99IC2X4FlauXP7vS6Oe8cJnSRv6lJFCrfuc3udS9Lmf0yY0klkuXU3I9pDtCZuaYIjrgSKGns4Boz8u5Ll30OcdIYxxUJ83m9NsNrZ1JmUNtrZj1EzgH4gGyHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZEOfMUht/pHk/hwlK7qnyYGPXu5A8RD7A75JAA6Hnxw=;
 b=RLRuCCnyM6eDF3qtFmFkBnL69XzsbtjSIQ2xQwbDJyXeNuCFJu5OHc3qVUPzwuGsh69x8/wDv7x9QI6nA/WaLs1fT30Ak5ojWbIGChM7wPSUrX59mpRJ1/D7KHEJDYbiCxgX4m+j4QRbqKm0vUwF6R2btaGhJTucgYsrJKxbq8kzZDJkd75HVMNf1VamKravmKecYykjEHREWvER5LdWuQzpypQzy+a/WEL7o6A0K+nNGONEfJdbM84PdD8d3Vpt7iXdIKUriKYThn1ud5biMriDVM4mZ6aIbhrG6lS40is5MsEPxQr7b54XLuMolK/cXn9lSRSlOd4NB0aSJz1Dyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV1PR04MB11513.eurprd04.prod.outlook.com (2603:10a6:150:284::9)
 by GV1PR04MB10534.eurprd04.prod.outlook.com (2603:10a6:150:205::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Mon, 20 Jul
 2026 03:31:01 +0000
Received: from GV1PR04MB11513.eurprd04.prod.outlook.com
 ([fe80::29e0:98a1:4577:2cc7]) by GV1PR04MB11513.eurprd04.prod.outlook.com
 ([fe80::29e0:98a1:4577:2cc7%3]) with mapi id 15.21.0223.012; Mon, 20 Jul 2026
 03:31:01 +0000
From: Guoniu Zhou <guoniu.zhou@oss.nxp.com>
Date: Mon, 20 Jul 2026 11:34:05 +0800
Subject: [PATCH v2 3/6] media: nxp: imx8-isi: Fix per-stream reference
 counting for multiplexed streams
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-isi-v2-3-45845bc5d4fa@oss.nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784518456; l=6584;
 i=guoniu.zhou@oss.nxp.com; s=20250815; h=from:subject:message-id;
 bh=SfOAuoTdcleZ0lgoqiMkCIRSEg0D79H6Mo+wNe4UHg4=;
 b=zmwM+6WhW8ED6EPECI5WppM1WI4Dbz1rHJnT4aK0z4UGPovYKhZAmjs1Y05OaddkuhGVn6XCi
 3q2aVIgZ5VaAEcTBjGr7JFFl4upF49/ZlHYkq/4nAORSB2F38Qgescr
X-Developer-Key: i=guoniu.zhou@oss.nxp.com; a=ed25519;
 pk=MM+/XICg5S78/gs+f9wtGP6yIvkyjTdZwfaxXeu5rlo=
X-ClientProxiedBy: MA5PR01CA0004.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:174::6) To GV1PR04MB11513.eurprd04.prod.outlook.com
 (2603:10a6:150:284::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB11513:EE_|GV1PR04MB10534:EE_
X-MS-Office365-Filtering-Correlation-Id: 63be8101-6a89-4edf-b033-08dee60f5211
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|19092799006|376014|7416014|366016|23010399003|1800799024|921020|22082099003|18002099003|6133799003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
 OZuTzHHR8dBt9uWfHkLPQshvgzmMBanS9K5R42ti83v/+nQrLBZSGyGOCFvZolrY2gPG7wehf/otfhhLQNN7pFtOSglJwYxpo8/mHG2sRNGxxe4y7qB9bE+vrnCtRcyUJJCokjq9S4aDk4IDjW84ywlgB5lqmFRmLjqFSzhhCU9wWQ2XFxdJ585rBt9PSw2chfTXs1O5nyUrni2/59/qZGZdreNA6fR1EfOJ+d59VM10GVNactLjKRMvPyjmchEKQ0iiRUAM3vx9ew7oPADiTWe/vWyUGcLtzzf20mn6lIc4nNP9hLtkXcwjD2ISTWIzENgiFfL0L0pCdnAvaecO6Ff++e5DvDKbTare7UW74ubw/l9xokTlZeFNcwG0o4qxEY7b7xQ1HSL+R6M5E2Au5uC66Fo4WcB58qlUtJfeIrEmeHVKGCuJ0joc0rzIJFjK6ZzmWcBoUgyPvPAZH58WfXBWmbAQA9OfadvIm11Psh3VYV5OZW8XeL+GkVwBxXbPBb6Itv9fiBzMZMkUkSvxk518jGrSD9Goea2yefMs+6xRirkiLVtdQ63uwHnsgrJrNaVZhF1S1Mmbyq4zlUrx2k5U3aSTSdZLlA1sXdOJZP/FJU8i3BxKM31v2CdbmBTzaDMGq8y08xtnRyFBUvtQyktrvWpFLFcjtqtVVQMZgR45hFumRiwv7jZfDKiik2b64yQlCdNErhkKTUVX8R50Pg==
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB11513.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(366016)(23010399003)(1800799024)(921020)(22082099003)(18002099003)(6133799003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?NlVTYS9VK1NLVFBBVyt3MHpZYS9WL01BbTE0K3dJemYxMDBmcXNDYnpuRG9F?=
 =?utf-8?B?VzJ4dXJhSWlIN3Q5RmYxbWN5dzkwUzZsdWFMTnpxbi84S0pMSHhJZXNuVkJF?=
 =?utf-8?B?UWtidEhrdkxjM2g2UUp4Ui9CQ0lURFdTSTJYN0hqT3FGQS9mY2NBOVNITE1x?=
 =?utf-8?B?cjV3cC9NemZsbXBsV2hqdlJRZStOejRZTlE0eTErVk12OVptZ2hBbjlKc1dv?=
 =?utf-8?B?UFpHVW9EVGlGOHJYdVlDMjJLMm56NWdrN0NtS2dVM3VwNjB2OHBEOTcvM0g4?=
 =?utf-8?B?eHA3cHRlcUJNeU9ZeEhmNzJ0V1NXMmRlTHpRM0NhQ0o5VGc0VkN3ZUhia0hq?=
 =?utf-8?B?SkUvUGtkVXBRamhqQVU0K0o4aHN1eEpuNGVRL1JxaENxdG9yTVQ0OW1yRUZI?=
 =?utf-8?B?WVNwa0ZnN01xZ3htYUw3Y2VlY2kzOWxPdWtCczFWd1Z4amZjbGMrSitYUm5B?=
 =?utf-8?B?VlREWWVLbmtoUHhpZmNINDdDb0tJWFUrQWQ2RnhteEQycjNWbmlQVzRSdjJN?=
 =?utf-8?B?bityRTI0dUhmTU9yUFI0TjJycTZUZ1NqSDZOMWxvYmtBWmZqMW16VTA2VnRs?=
 =?utf-8?B?b3JKNmRxZHExV2lBd0FNTlErOGd1RnRRNnFaZDh3aVJnV0JjN3JXQ3FPcjVV?=
 =?utf-8?B?SXZTdFd0SDNjcGJYNkRwclgrbkl1TkJISkNIdVo2eEI2dHUwMitOcDZzYjhL?=
 =?utf-8?B?ZFltQmhkUEpWWng1T0s5MzZJNVJxWUZXcHMwM0c1SkRQcUpjQi9xNFVMZGZF?=
 =?utf-8?B?TFd1WDNwNmx1aGJGUm0rQXBuVVlaYkRsZW9PdjczZ1Q4ZmNCeUxLL0VRb0FX?=
 =?utf-8?B?V0pkeHpJZGgrMnExYmtpclk0SUFkVHk2ZGNQUUNSSU0yOVhqVmdLcGV4UTdU?=
 =?utf-8?B?L2g4TldUWDUzRkdQM0h0elZKYWlQQ2FkWG80U04yNVhFRVFHU0hjWm5wcXFi?=
 =?utf-8?B?QTlaR1JvVkNtbFZoNmg4ZFMvelFHZUo4ZEpoV0gxYWQ4WTI4NTgrWHFsQUxU?=
 =?utf-8?B?VHFIdUg3ZkoyNHNPbnBLaDg2d1JxZkc5MDM2a3EyN0lBNEJ6RDhVRnNnMkdq?=
 =?utf-8?B?L2RITENPS1dQRytFTjdnbXZlZHhUdldjWW0zTndaaG9zVkFJN1l2WlBtaVJP?=
 =?utf-8?B?dldXdEdObzBKOFB6bjVhdnY5amVRaHlNNjROZ2dpM0wyejNjbHgwSThiMEZE?=
 =?utf-8?B?QXkvSUNIcVJlNmNRZEU5MVNxU1hUTFcyZWZsZEdwWkZKNytOL0RGOHo0L3NQ?=
 =?utf-8?B?VExqYlVsa2J5ZkRJRFdENjFKL0ZrN0YyRjN1WXlyRjBBUE5MK2tPZ2t2QjN1?=
 =?utf-8?B?bnNvUURkUU56SEwyR2NJY0M1UDh1SHBVYWRDSHI3WTlzQ0lRMU5MMFRvWGlN?=
 =?utf-8?B?T2JLOW1jd3lYR2tvWUY4Qk8wblJWeDZrTVJVcGQrZ1cvZjVKaWNhb21kVWUz?=
 =?utf-8?B?MytmR3Y0QTRNM1pGRjFjMjMveGNPN20zQ3B3dmxiVU56dFJ4dUxxTmxKY1Qv?=
 =?utf-8?B?SCtOTHJjZSs2bXRVNTAxa1ZGL3lHRHpxeVYva0s2S1h6by9VcWVOekFheHky?=
 =?utf-8?B?V01HTW8ra2I3Z2NFMUpmcVZRQms1UFNab1Q3djBjTWpmMnE4WlNjdzdBbWRF?=
 =?utf-8?B?cDkra3dublpFaFBsTmdqSWlka3hZTTE5RHJWUjdiZEYxR1JwQlNUZjFEVGpR?=
 =?utf-8?B?L1Y5a2hHc3F4dThuQzVHY29tUTRDRmUzQ2U5ZFRveWNsSFBhQ0xLY1Nkc2N5?=
 =?utf-8?B?TkNVVUp1Q0Y5OFF6RTdCZDJ2UEdBTWowc3RSUWhlK1h2Q3pKV0IveVhVbkNn?=
 =?utf-8?B?ekhLWkxOb3VJVlV4S1lFSmJwZDNnRFRtSnh4NlhpclEvVUJCdHhBdWcvRU53?=
 =?utf-8?B?TkJDWmk3U0tqZ2JlaTFQUHk4WVp5by9YbkM2SjladU1obDdCQVJNMTVUQkN5?=
 =?utf-8?B?OCswMTZ2N1RFejB5NTVUMjZKd1hZZVRwSi83M21aQnRLY1FpKzVKTitINlNs?=
 =?utf-8?B?SEhFKzlSMHV2YUZ6ZTNqUVF2cm1kL1FEMTlsMmUvanRTOXBwQ0tXdmVROVNT?=
 =?utf-8?B?RWt1WHZDY0JJVzJEMlFwR0xwSzRCUG8zTS9RaHBMYU1uZ21MbzdZRE5yUFBh?=
 =?utf-8?B?aEQ2ampGWHNTZitrZW5leFFOQ3Q3WGgvNCs5OHFmbHpiSnlZVC9Kc0RMM2NJ?=
 =?utf-8?B?ZmxQK3d0OUdKSUdVamRLckR2SFIxTmtlNWlyQ2VwSklsQXlXVWp4V1RZQi9Z?=
 =?utf-8?B?VzJSZXZsY2tHWkdpRVhUc2lERldTaDVFTWdnNy9wVnlOSU1Ba1NHN2lnK3N6?=
 =?utf-8?B?dHZUdjRkbmRSZzB6N2dqMTVScG9MU2RzazFjaUd0dzhORVVOSzdUaU5XVWQ1?=
 =?utf-8?Q?8rdAfxp3bDIMRyTrL55naekdqOKTIlOBB41to?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63be8101-6a89-4edf-b033-08dee60f5211
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB11513.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 03:31:01.2156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gZYJDXEfb7DDm+qnlnBqoAzn9dTZKnmTLcBURLbwNNfuBsAiTPML9EePGxEB618Iw3ySn8PM6iKE14EDQdbIpgwFmSk/w1B1H7fM7VuVqKBkSSeQSE8g1wbiObl+wwsH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10534

The ISI crossbar fails to properly enable multiple streams from different
virtual channels on the same input pad. Only the first stream gets enabled
in hardware, subsequent streams are silently ignored.

The driver uses a single enable_count per input to track the input state.
When enable_count is non-zero, the code assumes the input is already active
and skips calling v4l2_subdev_enable_streams() for additional streams:

  Call 1: enable_streams(stream 0)
    -> enable_count == 0, enable gasket and stream 0 in hardware
    -> enable_count = 1

  Call 2: enable_streams(stream 1)
    -> enable_count == 1, skip hardware enable (BUG!)
    -> enable_count = 2
    -> stream 1 never gets enabled

Similarly on disable, when enable_count reaches zero, ALL streams are
disabled regardless of which streams are actually still active.

Fix this by tracking per-stream state using:
- enabled_streams (u64 bitmask): tracks which streams are currently enabled
- enabled_count[] (array): per-stream reference counter to support the same
  stream being enabled/disabled multiple times

Now each stream is independently enabled/disabled in hardware based on the
enabled_streams bitmask, while enabled_count[] provides reference counting
for scenarios where the same stream is enabled multiple times, such as
duplicate cases in the ISI stream.

Fixes: cf21f328fcaf ("media: nxp: Add i.MX8 ISI driver")
Cc: stable@vger.kernel.org
Signed-off-by: Guoniu Zhou <guoniu.zhou@oss.nxp.com>
---
Changes in v2:
- Use fixed-size array for enabled_count instead of dynamic allocation
- Use BIT_ULL() macro for u64 bitmask operations
- Use MXC_ISI_MAX_STREAMS (64) as loop boundary instead of num_sources
- Remove mxc_isi_stream_counters_alloc/free functions
---
 .../media/platform/nxp/imx8-isi/imx8-isi-core.h    |  7 +-
 .../platform/nxp/imx8-isi/imx8-isi-crossbar.c      | 76 ++++++++++++++++------
 2 files changed, 63 insertions(+), 20 deletions(-)

diff --git a/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.h b/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.h
index 7547a6559d4c..9adbe2fe7cf8 100644
--- a/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.h
+++ b/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.h
@@ -184,8 +184,13 @@ struct mxc_isi_dma_buffer {
 	dma_addr_t			dma;
 };
 
+/* V4L2 subdev max stream ID is 63, need 64 counters (0-63) */
+#define MXC_ISI_MAX_STREAMS		64
+
 struct mxc_isi_input {
-	unsigned int			enable_count;
+	u64				enabled_streams;
+	/* Per-stream reference counter */
+	unsigned int			enabled_count[MXC_ISI_MAX_STREAMS];
 };
 
 struct mxc_isi_crossbar {
diff --git a/drivers/media/platform/nxp/imx8-isi/imx8-isi-crossbar.c b/drivers/media/platform/nxp/imx8-isi/imx8-isi-crossbar.c
index 328d08a278ea..64576f6bd45c 100644
--- a/drivers/media/platform/nxp/imx8-isi/imx8-isi-crossbar.c
+++ b/drivers/media/platform/nxp/imx8-isi/imx8-isi-crossbar.c
@@ -337,6 +337,8 @@ static int mxc_isi_crossbar_enable_streams(struct v4l2_subdev *sd,
 	struct mxc_isi_crossbar *xbar = to_isi_crossbar(sd);
 	struct v4l2_subdev *remote_sd;
 	struct mxc_isi_input *input;
+	u64 streams_to_enable;
+	unsigned long stream;
 	u64 sink_streams;
 	u32 sink_pad;
 	u32 remote_pad;
@@ -350,30 +352,47 @@ static int mxc_isi_crossbar_enable_streams(struct v4l2_subdev *sd,
 
 	input = &xbar->inputs[sink_pad];
 
-	/*
-	 * TODO: Track per-stream enable counts to support multiplexed
-	 * streams.
-	 */
-	if (!input->enable_count) {
+	if (!input->enabled_streams) {
 		ret = mxc_isi_crossbar_gasket_enable(xbar, state, remote_sd,
 						     remote_pad, sink_pad);
 		if (ret)
 			return ret;
+	}
 
+	/*
+	 * Track per-stream enable counts to support multiplexed streams.
+	 * Only enable streams that are not already enabled.
+	 */
+	streams_to_enable = sink_streams & ~input->enabled_streams;
+
+	if (streams_to_enable) {
 		ret = v4l2_subdev_enable_streams(remote_sd, remote_pad,
-						 sink_streams);
+						 streams_to_enable);
 		if (ret) {
 			dev_err(xbar->isi->dev,
 				"failed to enable streams 0x%llx on '%s':%u: %d\n",
-				sink_streams, remote_sd->name, remote_pad, ret);
-			mxc_isi_crossbar_gasket_disable(xbar, sink_pad);
-			return ret;
+				streams_to_enable, remote_sd->name, remote_pad, ret);
+			goto err_gasket_disable;
 		}
+
+		input->enabled_streams |= streams_to_enable;
 	}
 
-	input->enable_count++;
+	/* Increment reference count for all requested streams */
+	for (stream = 0; stream < MXC_ISI_MAX_STREAMS; stream++) {
+		if (!(sink_streams & BIT_ULL(stream)))
+			continue;
+
+		input->enabled_count[stream]++;
+	}
 
 	return 0;
+
+err_gasket_disable:
+	if (!input->enabled_streams)
+		mxc_isi_crossbar_gasket_disable(xbar, sink_pad);
+
+	return ret;
 }
 
 static int mxc_isi_crossbar_disable_streams(struct v4l2_subdev *sd,
@@ -383,6 +402,8 @@ static int mxc_isi_crossbar_disable_streams(struct v4l2_subdev *sd,
 	struct mxc_isi_crossbar *xbar = to_isi_crossbar(sd);
 	struct v4l2_subdev *remote_sd;
 	struct mxc_isi_input *input;
+	u64 streams_to_disable = 0;
+	unsigned long stream;
 	u64 sink_streams;
 	u32 sink_pad;
 	u32 remote_pad;
@@ -396,19 +417,36 @@ static int mxc_isi_crossbar_disable_streams(struct v4l2_subdev *sd,
 
 	input = &xbar->inputs[sink_pad];
 
-	input->enable_count--;
+	/*
+	 * Decrease the enable count for each stream. Only disable streams
+	 * whose count reaches zero.
+	 */
+	for (stream = 0; stream < MXC_ISI_MAX_STREAMS; stream++) {
+		if (!(sink_streams & BIT_ULL(stream)))
+			continue;
 
-	if (!input->enable_count) {
-		ret = v4l2_subdev_disable_streams(remote_sd, remote_pad,
-						  sink_streams);
-		if (ret)
-			dev_err(xbar->isi->dev,
-				"failed to disable streams 0x%llx on '%s':%u: %d\n",
-				sink_streams, remote_sd->name, remote_pad, ret);
+		if (!(input->enabled_streams & BIT_ULL(stream)))
+			continue;
 
-		mxc_isi_crossbar_gasket_disable(xbar, sink_pad);
+		if (--input->enabled_count[stream] == 0)
+			streams_to_disable |= BIT_ULL(stream);
 	}
 
+	if (!streams_to_disable)
+		return 0;
+
+	ret = v4l2_subdev_disable_streams(remote_sd, remote_pad,
+					  streams_to_disable);
+	if (ret)
+		dev_err(xbar->isi->dev,
+			"failed to disable streams 0x%llx on '%s':%u: %d\n",
+			streams_to_disable, remote_sd->name, remote_pad, ret);
+
+	input->enabled_streams &= ~streams_to_disable;
+
+	if (!input->enabled_streams)
+		mxc_isi_crossbar_gasket_disable(xbar, sink_pad);
+
 	return ret;
 }
 

-- 
2.34.1

