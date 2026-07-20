Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011035.outbound.protection.outlook.com [52.101.70.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B2C389455;
	Mon, 20 Jul 2026 03:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784518253; cv=fail; b=aGmXHfGUDk+0BdPhzL9Lo/W43/YVIzF8oTJct6KbY0OQkkDTxmSaZDZst9abJJVO2FdFQSgrhqRk5ztfD4HD9OtoHoc4qwYoUtLMVpHW8ot8ZeK2bGIh6ggrV6yOcTyj9gaR932UP+R0SOV0PwTdWyUCjZmrpDjADfkYVLKtUEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784518253; c=relaxed/simple;
	bh=7LdACj5/lGKsIoxWOTOdpGddV95ttSQd0PgfXBxA818=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=i+vptw3wqEtF7VVKBpG5B4LmwlmULkUJohIIrQFEhO1WqO7dCEDjj4+D+6Bog1XQfm3l2cd2U5Mj5QEJ2IxryCUytkUL1WPCMWpw2joB6dSDFQHmXZcSQQkeTNKJpnkdin/HUpDtRAj9oG1Px+w8zaquF/nOy1usF5YJRe1efAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=w9u0zXcm; arc=fail smtp.client-ip=52.101.70.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="w9u0zXcm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HOvgAFeAIbqHgeG9e9MuHtrwqM7Iuo0zkBjXFsmQMxR9qb+c1jx4+ZsB6QP1OfCIyW2xsDkPoetleMFp8fXKyECB9k8lCL7ta+195aBtBZnM2rCTv59KLzoLCGm2lVG2FoCSt4dyCjxGoQwwNx4xPXdLoBS0FsPw3T3OQg09ica1sILVicrnPjDSox54h6D8hcZFGjXAQlOcpdROoiB8Z/HY7W1ZTxUSR4HE986np2vsMp2jRF2MUBGo5jpOBdMZy14FpbuMGykF3TCsWfhd7CrbQ3IbM32/hGIEXdHwzWuEhRNs1QhEzL7imrWrfLyJKaWhDWGRBoqQHkFca2qocg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EClAtv2h5kHEPJgSHYPfps/esVjFAZoWMporRerY9ls=;
 b=gRwDJH0/6tsK/gOxmPPm16qPDYXEm1dJUXB4MpXEQsLhgWJeApAKfz0xdXO3RCBPvJyVYcZf6PeM7CNKL9jVTcyhyZSmv318VTDiSUuF+jDTRPSXaJl+SVR4Go9OoIxmgGrhZictrUY3uTznsTzLttfxghASEjdnuHzqRwuVJ0nCdbTaHKW/YHu0tzrwi2PiYHu7/XDDz/WFwBPI041LoWWEYjLlT9oCLGYxZqFi9/rSVzoDxHnlRxDx+rL5LYUO9wFVQFnfBOwinzJNYPHvZ6wcpm1Pfyj8M2w57mpc+fU9N8PpSWlaFNk2Lsu6yJ/VwDYcBVyznnyB+r+8UzH+kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EClAtv2h5kHEPJgSHYPfps/esVjFAZoWMporRerY9ls=;
 b=w9u0zXcmZ6aobE+/XD2k5DBPwd77BnGUAsUPZgNjp3b7CW6MiH26WZa6YkZUQuyJdJrNk6ta5why5Oa/uBnJq1AhfNi4uyu31nypQ+Z7AiUbbvPS9kSWIMMgcI7N85Q/+TkhTbmlh/VlxjQTqvf33Y8K/L0gwvvHQl36aurT+5j8YXI9coNgcXJjNPGycS6bgw2dTDwblU/bf9lJCrUATSCWhBJLB9fFBlO+v+mVORlrp9Lt1be/aDNS/Bj//wFx6cxqcr9QUltYjUcmKZuohQTxV4WAAWF4vZc/9shAbnLMqv+bld1+EoIittubv2dtFVaPwvNyS0lQNfpubTHfKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV1PR04MB11513.eurprd04.prod.outlook.com (2603:10a6:150:284::9)
 by GV1PR04MB10534.eurprd04.prod.outlook.com (2603:10a6:150:205::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Mon, 20 Jul
 2026 03:30:48 +0000
Received: from GV1PR04MB11513.eurprd04.prod.outlook.com
 ([fe80::29e0:98a1:4577:2cc7]) by GV1PR04MB11513.eurprd04.prod.outlook.com
 ([fe80::29e0:98a1:4577:2cc7%3]) with mapi id 15.21.0223.012; Mon, 20 Jul 2026
 03:30:48 +0000
From: Guoniu Zhou <guoniu.zhou@oss.nxp.com>
Date: Mon, 20 Jul 2026 11:34:03 +0800
Subject: [PATCH v2 1/6] media: nxp: imx8-isi: Fix stream ID validation
 bypass in crossbar routing
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-isi-v2-1-45845bc5d4fa@oss.nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784518456; l=2001;
 i=guoniu.zhou@oss.nxp.com; s=20250815; h=from:subject:message-id;
 bh=7LdACj5/lGKsIoxWOTOdpGddV95ttSQd0PgfXBxA818=;
 b=ovwp1BlR323v7/rkvymxUUus71e/XsRFb0BlhVNwvpauQuc9dY0AhjggUYI2TK4B8MfXmShvh
 Fvxkggcb2bTAshh6PR58elKotnyXsyjXBXT2NeUE0OEb5qtYKu8uB6q
X-Developer-Key: i=guoniu.zhou@oss.nxp.com; a=ed25519;
 pk=MM+/XICg5S78/gs+f9wtGP6yIvkyjTdZwfaxXeu5rlo=
X-ClientProxiedBy: MA0PR01CA0096.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::12) To GV1PR04MB11513.eurprd04.prod.outlook.com
 (2603:10a6:150:284::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB11513:EE_|GV1PR04MB10534:EE_
X-MS-Office365-Filtering-Correlation-Id: abf1778f-2d25-4759-5a9f-08dee60f4a28
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|19092799006|376014|7416014|366016|23010399003|1800799024|921020|22082099003|18002099003|3023799007|6133799003|5023799004|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
 zn35QKF70ET4Bjnp8+7jvx4b5/ituUE7JhPDpey+O4JC4e8Z9GP4GXdttJfRE28eImr8xig6Pfmxxj6JVmSvre+G0hlKa3h5PebzWLHZlpBFVT5VFWyin+yER5AOW83gTPCBr28y3UrmSkjfpA4i5WzETzCRE3afGz70Feo93c6qVBrBSmQmkYnZKD8vjwAXfy0T6laiTiF3mXTKc3R3Nl58Dm7pl35OjdqzJ/EqxXbPQUE4fjbumg6sxQFAPPDdbXXPUrttgIzh+dt3IVxOOEvIUGVF3DdeiRrfZlehQ7Zz5UuU53iG/p7+LVGiiSCqydO+RVj3W9Q9cASUmkrLc2w2acRnuoduPpR2QPUeQDhI9GwedR+eaI4uW5dIdgGID87tEzL0VbJJAEcSC5aR/6Xmp5xMrSxqtuW48Dt0pN3NryD11sYhfdHbbY1wZSb+aull6GdYP6eBawbAr6n5GzP3pX1nIJMkQ+muY2In3ZzK/fF9GFYbu5DcsuLrcngte8ekJsee3FqecrlKt7laxC0LdUUjdSv6wtS5+DG9FDHp+CpsXAu9ypfU7WO9FC9r4kkg/8xVTNnMr76/bm6Z0IhWm9RYbFcQJbwbYwKwR6ul6dpZJEeBCCH3V07svJoFSesXzJ1LNJXkRW8lftvgq4ruiCgZpbaeZc6nEU5aRLEZggKa0YO/4hpoR3LhWQc1LxpjBDqrklCQOmuCIRq/KA==
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB11513.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(366016)(23010399003)(1800799024)(921020)(22082099003)(18002099003)(3023799007)(6133799003)(5023799004)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?eDcxYk5JUUlLaGJkaVZUL1Y0RG1tWTlUMDUvMGdIRU9qUnhkTmJDNzg5S2xY?=
 =?utf-8?B?bnl4ZDd4QVRWb1ZkeE5LeSt5cSt6cW1rd2kzVnRlT2prKzlwVWVrdDlhMFEr?=
 =?utf-8?B?T0N1UThGVWNqeVFPTnNXQlRkVzVrcmczRlR5alNTWkRqbStRYTZ5TmFMQmE3?=
 =?utf-8?B?Vll6VjF2ZmxiNkJvZzhGc3Yrbi9oUlJucXl2dFNveTBWUHhJVFNZTTd3T1JQ?=
 =?utf-8?B?d3lQRWE1Y2pZMitiVm5LQVdydkVpWGhJeXJKNzJiRE9FdlVSNGlLUmNMZDZz?=
 =?utf-8?B?OUhBek5JQXc1L0lIK2ZLMXJkRDV3ajF3WVRobVpQbmdSdEhDeHYxRThCV1lZ?=
 =?utf-8?B?SmRHcjhoMzNpamEyVVFjSzluTUpLRm9uR0pOWXJTeUpKa3R2b0g3d2VSeDZo?=
 =?utf-8?B?TnNOMk44L2FKMUtEdjFVRnZsODlzdEFqc2FqRDg3QWFhYkY3YmhpUlpEdkJv?=
 =?utf-8?B?Z1p6dThRSDZHVGZYU3VmT2p0TWFnREpWbDZxVnJIdk1TUk1ESjBNYnB2K0ZK?=
 =?utf-8?B?MWlaRDdZT3BSSDgxcmVhMWQrVW1tNVVaUzdtcU5zMEFFQnVPR3NDdXBjWC9w?=
 =?utf-8?B?NGVYQmx3ektYSTRRRFVGUHgvVHViSFpRKzlaOHBEck5pUVZGTlBVeUFaNHJ5?=
 =?utf-8?B?OTN1dXA1Y3ZtbmNrQ3k1bXhGdkNjTzhGaC9lVzZLWE8zemJMMlkrNDk2bTd6?=
 =?utf-8?B?WGdFQzNsWnpWSmxmcElvUGdEdkkwRERmZkN4cVNocnJkak85UVJTMFhTQ0NT?=
 =?utf-8?B?TnQzMmJobnpSMGZabFNMaWtCdWhETUVpWWdXeVBncjlRQ3UrbmZjNDRDekVX?=
 =?utf-8?B?RGdtekNsWENTKzU2WU1NeTVXd215eFJwVHdvQVgvTVpTZk9HSnErZUdhTXBG?=
 =?utf-8?B?ZFNKbVBleHdEOVZBbVBhcW5YSTUyUzdqbmpPdGhZSEhsQmdXZmY2a3VFOUNz?=
 =?utf-8?B?NVVUSUxHOVVkYXZiSlowaXlHeVRqOG0zdlhlakdYbE5GWC9rUFRnUmhvVFZh?=
 =?utf-8?B?ZlNVNzd3RUJWN29keXUycHNxSUtaT1hIcmlUdUR5ZGl6elo3VVBFNkpCK01J?=
 =?utf-8?B?eTNqc21nL3pteDFhZmRxdHFyb0NoSzJqSVpiSWVjSHJiYy9JWjV2RGNQa0Vo?=
 =?utf-8?B?SDJoWGc0cnUvOUlsZ3Iwcm9Wbk9WTkZVdEdJbXNjcGtnR1VoQklWSGlEMjVu?=
 =?utf-8?B?OTRnSjZZUVhZZExBNXE4YXJvTERra1dJMW0rSkNJOEZvOFhiTUVhaW42am5x?=
 =?utf-8?B?WmNycFlIS1M4QkM0TXRwRTBIaEwzci9LYllzVHlNelkxOWZwUVlXTUlWQjhi?=
 =?utf-8?B?WGtKZ2xBZ2pKSENmMEdWb1FEU1NheW1WU1BMVWtyNEdQcFlSME10U1NxaTFx?=
 =?utf-8?B?RHNnRjRqQ09pSHhVc1RSaEVKdFkxeVZjbU9CZEZDOXNOeEYzM2NrWDNNR3M2?=
 =?utf-8?B?alozSm15ODFqS1lsM3c2T3Z3UzZuN1JaODJmeEhtcnFzTTN6UlpNT1NLNlFk?=
 =?utf-8?B?c3prWld3Vkg0WDZIb3FHQUxJSzYvZGdhU0NPM0lzVU5Da0k1TTZEUUpsRnBq?=
 =?utf-8?B?SDlaMGRMM20wbW5VUVVLNmwvbHUxNld6Zk1CWWV1ajJ0Z0ZEWFZEaTJTN3dM?=
 =?utf-8?B?NTQ1OURPaW9jK3dpa3RtejhFUFhSYkpNR2lzMFhtTUg0ZTVXSWlnTjgvUHpm?=
 =?utf-8?B?QlJUcnhsT0ZrQlVLTlNLWTIwOVVHaWV3bWJ6TktMeTJwRmFNVXBzbGk1YUMw?=
 =?utf-8?B?UDlveVhnZ2NZRWxDY01OaklLN0dYeXNkMzlsUkU5ZUErMFgvQ3JEQ3BEWkxF?=
 =?utf-8?B?d2N1Y0xVRlc2dFQ3Mkp4eWdjNHFpdUVHQi83Y2tmeDZET3BJa09ZTDZuU2tx?=
 =?utf-8?B?RTF0MTFWbHA0R05TcE0yYkc1Zkk0MVdqN0FoMzlPUnV0eG9Oa3hCek9Pajk4?=
 =?utf-8?B?R2J2WXFJcjNZQ3dUR3VyYzJCNnZUK25jYjAwWWd1VlJlTDlqZDhqY1pUOTMr?=
 =?utf-8?B?U1NOZEFHR0Rydy9EMlhwbTlmck5WZDZDd0tTRzVwL2ozM3JyTzFEMFEyWm9y?=
 =?utf-8?B?elBpTDg3SkJ3SjE5NldjdVB4cjR3NndJYVZySUw4ZXRMeWJkbWNtQVhxUFlQ?=
 =?utf-8?B?d2JXUGY4czBoUkFzdkxHc21mUmMzSHFPcmZQWkZvT3RwZktDSFNnNW5DYXlK?=
 =?utf-8?B?YzJMSlQ5ZmdkNlltMjVXT3c3MldJT1M3RDJTU0NxK0U1UmlGTSt1cjJWYWM1?=
 =?utf-8?B?QTc0L1dOUEFjWnpjZzVwa0ZNUFZZc0J1T3MzYWJTYTJtdS9sVjhFNEhhdEVK?=
 =?utf-8?B?clc3SmY1b1NTTktTNFROL0d0UloyTzcvdVEzS0txMjJHeUxRL2ppbFFyYzRr?=
 =?utf-8?Q?PLh44u002IcmIIJGCxqmH3N4eWl97gnT8PvNf?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abf1778f-2d25-4759-5a9f-08dee60f4a28
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB11513.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 03:30:47.9177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZqJrFXYe2Vy2V3VDZqyr9yQlp1oPwMwOZzUbRuzqVGWzk1Yb49YVu11OIVDs1Rpt0o/3sQMgy9GOOocisd5n0VN+jpAoveXlbBXUx9b8rBaMKMd6GoUIi9sqFRZW9Yj1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10534

The crossbar routing validation has a critical bug where it validates
the wrong routing table, allowing userspace to bypass validation entirely.

The __mxc_isi_crossbar_set_routing() function is called to validate and
apply a new routing table from userspace. However, the validation loop
iterates over state->routing (the currently active routing table) instead
of the routing parameter (the new table being validated):

    for_each_active_route(&state->routing, route) {

This means userspace can submit any invalid routing configuration and it
will pass validation as long as the currently active routing is valid.
This is a security issue as it allows userspace to configure routes that
violate hardware constraints, potentially causing undefined hardware
behavior.

Fix by validating the routing table that will actually be applied.

Fixes: cf21f328fcaf ("media: nxp: Add i.MX8 ISI driver")
Cc: stable@vger.kernel.org
Signed-off-by: Guoniu Zhou <guoniu.zhou@oss.nxp.com>
---
Changes in v2:
- Split v1 patch 1/5 into two patches: this patch fixes the core
  for_each_active_route() bug, next patch adds additional stream
  validation (Frank Li)
---
 drivers/media/platform/nxp/imx8-isi/imx8-isi-crossbar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/nxp/imx8-isi/imx8-isi-crossbar.c b/drivers/media/platform/nxp/imx8-isi/imx8-isi-crossbar.c
index c580c831972e..84871bceb31d 100644
--- a/drivers/media/platform/nxp/imx8-isi/imx8-isi-crossbar.c
+++ b/drivers/media/platform/nxp/imx8-isi/imx8-isi-crossbar.c
@@ -107,7 +107,7 @@ static int __mxc_isi_crossbar_set_routing(struct v4l2_subdev *sd,
 		return ret;
 
 	/* The memory input can be routed to the first pipeline only. */
-	for_each_active_route(&state->routing, route) {
+	for_each_active_route(routing, route) {
 		if (route->sink_pad == xbar->num_sinks - 1 &&
 		    route->source_pad != xbar->num_sinks) {
 			dev_dbg(xbar->isi->dev,

-- 
2.34.1

