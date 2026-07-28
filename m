Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010070.outbound.protection.outlook.com [52.101.84.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382AB3BFAD0;
	Tue, 28 Jul 2026 06:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785221727; cv=fail; b=UcoxA69x7mhxmxhbzeRetEhNegLhLM1Yd3wgw9rG5v3h1Emjvna7tLqJJhwtnE8ClS/4SEuHDrshThNF3EikYRGrYQaER295Y4B0f0DSmiy6cALmyvdiQkIctf7vXjBby1qCWZndKnc2I5eihZsEJvFpcim2BdA4iPhDcQdAHaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785221727; c=relaxed/simple;
	bh=FmnhNwhHSndCGiuJ1KrTkNX9u5X5tqdePZP2r3e7Flo=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=dIjV8PlIZmL7Nudf85ReDFAUmDMj5yHI7VHGfzetjIxNSs5ipCIyxBy2jyHE0QnB1SCmb7BHzyxgEqPYHkIV3N6BtM7XvA5PBv19yjS775jI6ufOSAKetOzbZq39l+ZGCFHBw+G4wCNIZeO9eL93RDsaIH3pZX1E35EO2r2MtqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=xBtRDmbG; arc=fail smtp.client-ip=52.101.84.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="xBtRDmbG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MTocchHdl+2HPtUI9AxAfdHFaXt6xpdU33eHRAoShQy8pICz+B/0TaZb1Nh4HnT17/MHVbKuB5tvXbLf5iVsbLpseRV5JXi/07XRV2ufS8qdGuu1CvInjhEPfuS7ogsTn1v9T3trY5z84HbBTtPtEzQ5Kny4y4p0hegfRlVVS11R3xoUgu21Zto0mPNZr+wn3es4ZH3z0LUUnA+0Cw9/Gqm76NvpdSbBk0vg0Z9n8MUPC4F0oD/6lpM6eJGhsCMFIKC996hV3L6QU6dcMJvIBDM1rnZQAE5C1GOZeqz9tNtZJVLU2Aav1iArB0wpkTUHw6MarUdR8lFzNs29ZB5l6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sgJfoTdvfcDheJ0F1+kVzPCp5rqIdrxKXzQqtH0RqAk=;
 b=HYb1e4nrbGx4OXJwFXJkcT5cghWbL5v+QmZVffdBZJW4HFiRqpb4Yjr/BU6aG8BiLlY6oAwJhJrK8sN9i3vHQMtQGWgYcdqwZ8kr5FVhhrVHhLhIpn20Y9XqphznW8XEq3fK47Je+Y5rvNz0w0Ir9R0fkf8rT2JsnStBrTlzv7JFS/mD3vwX0ZINMl605yqvUvGLpIMZ9WxVJlZkaA9RxiC+Iy14sCJdo1s91/PMBaYYB5nVYvzZtPpo+IoJoUafK3eCppiTBKboAgCTRzepzWbICdLvcshX+2ua3eqqaJ4tlmN4MyteARR21ez2t7XfzvW7qRWK+BD/gMlmgcId8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sgJfoTdvfcDheJ0F1+kVzPCp5rqIdrxKXzQqtH0RqAk=;
 b=xBtRDmbGXYdFvMp4Er7u+5ZflpEHzqzxDJug2eSOOhfh9gZivD0Q9aK2QblVSLcagB9WuehlgLbjXFfM5eIH0GwDkLeeQl43tLMQB96GFISXjK1g6naHt8NnWI/p3cDQCNUo+Od1up+l6QC92v/Oh8dEOnWOobV5mZxlexzuIEMbj4aH/qxSXtVLFhlQdZRYQRV0jPxZqESFA4Eh0+q3sNfHyVVne1GBbLi6d/B6sF1YwxGr6Vq9c0weTjENzHnIpQj6+fjSylLMoLddwBTKK5fq2+GU2Kp6jECdprRP0haCDNkgls8fZhSHGwE5JR0zToXyd6XBPDRMWg/afjjl9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV1PR04MB11513.eurprd04.prod.outlook.com (2603:10a6:150:284::9)
 by AMDPR04MB11584.eurprd04.prod.outlook.com (2603:10a6:20b:71a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 06:55:22 +0000
Received: from GV1PR04MB11513.eurprd04.prod.outlook.com
 ([fe80::29e0:98a1:4577:2cc7]) by GV1PR04MB11513.eurprd04.prod.outlook.com
 ([fe80::29e0:98a1:4577:2cc7%3]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 06:55:21 +0000
From: Guoniu Zhou <guoniu.zhou@oss.nxp.com>
Subject: [PATCH v5 0/4] imx8-isi: Format support enhancements
Date: Tue, 28 Jul 2026 14:58:55 +0800
Message-Id: <20260728-isi-v5-0-1d22ab91602a@oss.nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC9TaGoC/2XOQQ6CMBAF0KuYrq0ZypRSV97DuKB0Kl0IhBqiM
 dzdEWLEsPyT/37mJRINkZI47l5ioDGm2LUc9H4n6qZqrySj5ywUqAIKVUhuSIAA2gFiVVvBzX6
 gEB/zyvnCuYnp3g3PeXTMPtevt7MfMwnSE7ngXebAuFOX0qF99Ie6u4nPwqh+yihYlGKFukTta
 u0xVFuVr1W+qJyVtmgzSxWVaLYK1woXhayU8cE4Hfhx+FfTNL0BxhoPXjoBAAA=
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
 Guoniu Zhou <guoniu.zhou@oss.nxp.com>, stable@vger.kernel.org, 
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>, 
 Robert Chiras <robert.chiras@nxp.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785221945; l=4448;
 i=guoniu.zhou@oss.nxp.com; s=20250815; h=from:subject:message-id;
 bh=FmnhNwhHSndCGiuJ1KrTkNX9u5X5tqdePZP2r3e7Flo=;
 b=ad1RWjcOZMxAvnnD/gykp7XthSYqNHpPjhB28j3a8T7x+UBon/xQNWGR7oUPxa6K2iWqwAlPT
 4lXSJ+/RhYfA/MnYMCwUQFuLlL24U8YEFBLEOuFMLx5VaWeu5LKMGLL
X-Developer-Key: i=guoniu.zhou@oss.nxp.com; a=ed25519;
 pk=MM+/XICg5S78/gs+f9wtGP6yIvkyjTdZwfaxXeu5rlo=
X-ClientProxiedBy: SI2PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:4:196::6) To GV1PR04MB11513.eurprd04.prod.outlook.com
 (2603:10a6:150:284::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB11513:EE_|AMDPR04MB11584:EE_
X-MS-Office365-Filtering-Correlation-Id: f0674b3e-d2b3-4a8b-0ac7-08deec753142
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|19092799006|7416014|376014|23010399003|1800799024|56012099006|10067099003|6133799003|11063799006|18002099003|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
 UAwwH2DLVWW0ke1p93OsjiRhBL/vdZRGIiA318Cb7MED72K8WSZRUZirE2ufkMV+83BSAO+DZegSdOUox6MGmKs7RPDtL8pBCreWziKd9LD1cYjr4IQtfxXzbmjOuMxu3fKh+eFeX+ICFhuNOCLATOqxOxf9Yait6QPtxQ3BVevBVQA6pdQFrqDb5A9QRoPPjcfLubICTv750y2sCxk4ec5N6BdB/AKOlwURpyhAmWnsABPOD/PtXe1OsQY7VrgZoWRzPoSpKfTPMJhXZIE4gQTQondnCWQotv5B3ftA+vmNHjssNkNbu1U8uU7KhmlFru9XiahmWhrlUJEEVCDoyRoF8BfDAsL2Z/ozKL9WmVgHWgXBoinp0cAHYftsdPKICp1CWNZzv0/t69bftz+ZealJgXfJSIQoVQj/EvDWS9n+Zzgz4g869yQOzISG1BcGAuyDtHeYtj2UI/tMRd1uBoEnoCxHx1FEEGw0RWdZs3cqXUOzFCKTEoCRdNGrvkX+uOC5krKWfjwRgfK+RAINwwJltIUPZ1DxnXLmjuAbOMtq/k0Y/kYvUypyYvcdzYT0f8wthIAMnCc5hvb0TjLnbIPumVWADr37HbUnuAhVRKvMFa1u2xiVJI7YyPmIytu/GcH1XZKysf5eQKSL8UPcsmkHHdKKf8WorjH3SXjeClptXS96+eno6siBEOKem3jcLz5L3L81eUR6Lax83S1CXA==
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB11513.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(376014)(23010399003)(1800799024)(56012099006)(10067099003)(6133799003)(11063799006)(18002099003)(921020)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?d0IzWC9sZWwrQWxOQjBzQnJNODNWOEozYXQwY2ZhYjVvTW1GeFlxR3NFRldZ?=
 =?utf-8?B?dzc3dk9CekN3SGZUZ3RadURPSGxQeUNSaXFiak1ReFZOWFNybnJGWGN2TWdM?=
 =?utf-8?B?b0dTSkdyZThRTWtJbnRXRzVlOXRiRzNnMWhPbDhOWGVreEFSVEJTWUZKUWZJ?=
 =?utf-8?B?QXYzRU16alB1NzR1dEJBNVJ1elVIczZoTElrSDNmVFdjc0djY25YK21IcXdp?=
 =?utf-8?B?cWMvTm9DVnRxQkx3NkJDWTB4M2h1YVdXWDRhazFvUXRWYm9jUlZYb2xURmo1?=
 =?utf-8?B?aGdkMnpnRTg1WHBacHNUOTh5T0hQWkc4NjU5T1NXYks3UlZrOXpHeTMzYUww?=
 =?utf-8?B?K3Y4NllSVk9ERlQwQ2NDQlR3YVZRS2p3NG5UampVYjBGVGFTNlVqekovYUU2?=
 =?utf-8?B?M0Zrb1VNcXlnVW9EYU15amxYaXA1MEp3OEFTaXlEdDcvekM1SS9NY1Q1eXBF?=
 =?utf-8?B?ZGZmN0FzMU9HZk1nU0FmVDJXQ2lsTHgrVTZzQWlYQWlTaXFUUDEzcjJGc280?=
 =?utf-8?B?dTdXUi94V2ptMU40Z3Z5ZExpTFFHblphOHBXdUZYNzByUTl4NDJBcmMwaXJ3?=
 =?utf-8?B?Qy9oK05hank5eWlpSWdLQXdsMVhxNlV2SlRRLzQ5WUJOUWZmL0toK2orRDBZ?=
 =?utf-8?B?N041ODRiemkyMVFhV3UySjhrc2tOMmpmVGtaOEZSRUNhRTdaUmZmU1V5VWky?=
 =?utf-8?B?RW5QN3RrWDRxY0ZtdDdXR3NjMEhYRVUyaEZxdTZQbGZsdnlEcG1lRUFhNlVi?=
 =?utf-8?B?SW4rVWRXYldzS2lTVXZMZVdQcHhMUFA5TEp1dGpjMUdRUUl4bmY5aHpTZ3ZP?=
 =?utf-8?B?bTZUNlk2SVhmeFJzMVlhaWd0Q2FCbXViWUZlL1ZRay9mdHFEZU56YmJrNElt?=
 =?utf-8?B?RUVYZDlIdzJaYnFVdTVVeTkreVpXTWNJK0M4RTJvRWVpUVloV1RkRThOYk9j?=
 =?utf-8?B?Ym85RFUyVE5jeHZhRDQ1RkRzUTVHejhqQ1dMbGFRVmJGWTM3NVZjT2xnWmpW?=
 =?utf-8?B?OW9uOEFCZGNGb1JvWjRCUWFEYWJDWjlib3hEd3luYUVDQzdrN2cwRFZYK2Ez?=
 =?utf-8?B?RjBjWmtjSW5WSWxNR2Iwc1lkZUx4aGw3NUFXaEQrbjFlVjlncW51WC9Fdm41?=
 =?utf-8?B?a053R25vV1VHREd3aVdVRjJ5bVhpeFA1RmJ2VjJ1RGQrSGtDN2lyMUJXY3dx?=
 =?utf-8?B?Sm9QMmE0Q202YlNHWTdNRTdBa2dmTkNBVHpadit0K3IrTVErNlkzWEhoTE1B?=
 =?utf-8?B?K3VmZ01QZmNUWVFLK29JMXRpL0FxQmFjWHVMNXV5dlJwN2tVKzVVQVlIVlhx?=
 =?utf-8?B?UGg0aEZiZXpsOENkT1FNZjgrRngyeUhOcWFoV0Z2ZjYvNW42cnQ4RVdxaFp6?=
 =?utf-8?B?akxsTFhDZEhPbGk0SDhiMjRzaHl6MktaSmZjdzZsaFJCQWRTbUw2a2NqTHZk?=
 =?utf-8?B?bUY4M2pjUGhDUUZFU3NhTXNnTEZmZFU5ei8wV0xqbnNSM1M3Z0dtRWxDS2or?=
 =?utf-8?B?SVhOMFJxZFJoY1p3UENzZWlsUmxDTFRaZnBSS0hxYmxsaCs3Q0N1RkEyU3Yz?=
 =?utf-8?B?SW56WFlYVFpxMXZQSitBMjZjZGxURnhCeGxjMFkzb0tIbk1Ha20wWm1EZnZy?=
 =?utf-8?B?SWZVQlM2SDBQRHNld0RIQVYxUWtlc1pvUzVFeXFKMkw0NXR3OHExSDNiT1pQ?=
 =?utf-8?B?OEdUanJnQmdMUDZoNnpDV1lIbUJxK1RQM2tYbTFta05kODNPT050MkNVc1k5?=
 =?utf-8?B?ZnhpS2pVM2R4dHhaSGQrakgxS0Y4bWpxbzlGZVFHWTdNK21pYlpGbUxjSXVo?=
 =?utf-8?B?ZlpabkZDZDVEQjErM1M0ZGZKUHBOQlpwNjB2U3cxME8vVnQwaXZzKzVzZWNQ?=
 =?utf-8?B?SkF1Wm1ZMjRNY2NUTFY0QTVLaXVISm5hTzB2WVVtNWk1a2czVkQvVkJ1azJK?=
 =?utf-8?B?MGZLTWZkNFNUa1QzZkxwU3ltTnJJQy92ZFBjL2I2WENyWWRmSDJYcXBmaURT?=
 =?utf-8?B?Vm5Ha0tHN1FtUy9kK1pmK0kyamlrS2xueDJHR2J6VHVmUE9PSTAxdm5QeTcy?=
 =?utf-8?B?cXFHam5lOStCYnREWlJFOVZROEo0K2lzMXdlbDdGTjhlSWI4S21ad2tWdEpP?=
 =?utf-8?B?eW9lZXBmVDNudkMzbXZsNmFWR3FXeUVicGsrdFJDcEgwbnVRZkhpMGRVL3pK?=
 =?utf-8?B?TDlSNzR2Sng4Y0FZVHBUckxnZjF1dm0ybnpaUmU5c2FnNzVJdjFPeTJUTGpC?=
 =?utf-8?B?NTFoMFdSSGdXN3o5TlFFQlNTdHdUOGFuTjQ0NW4va3hCM1dZYmZSTU5sWWhl?=
 =?utf-8?B?RGtoc2RkRTRSM1Fhc2dLVVJ4K3dmcmlna1FXVmthdGJoUElSUHpRK0VBUkRk?=
 =?utf-8?Q?TJB2k274gsx4zGHu1cxr8rgFLekr7yhWC6jqM?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0674b3e-d2b3-4a8b-0ac7-08deec753142
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB11513.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 06:55:21.7236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v+akaN0ZqGvvgtg5ZnnYpR2y1IIcET0bo0WK/EX5iWprImN8zl7UPOwL002A0u/D5hs4GzIZZ8whxI+jUolktz7N1F/kb9qOHvTErtPsTZyOTl87jgDYpdET8b/zhAyb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR04MB11584

This is a follow-up series to the imx8-isi bug fixes and format support
patches [1]. Patches 1/6, 2/6, and 5/6 from v2 have been merged into the
maintainer's branch (pinchart/for-next/media/nxp). This series contains
the remaining 3 patches rebased on top of the merged changes, plus a new
bug fix patch.

Patch 1 fixes BIT() usage on 64-bit stream masks which could cause incorrect
results on 32-bit architectures when stream IDs are 32 or greater.

Patch 2 implements per-stream reference counting in the crossbar to properly
enable multiple streams from different virtual channels on the same input pad.

Patch 3 adds support for 16-bit raw Bayer formats (SBGGR16, SGBRG16,
SGRBG16, SRGGB16) and Y16 (16-bit monochrome).

Patch 4 extends RGB format support by adding BGRA32, RGBA32, BGRX32, RGBX32,
and ARGB2101010 formats.

[1] https://lore.kernel.org/r/20260720-isi-v2-0-45845bc5d4fa@oss.nxp.com

Signed-off-by: Guoniu Zhou <guoniu.zhou@oss.nxp.com>
---
Changes in v5:
- Add new patch 1/4: Use BIT_ULL() for 64-bit stream masks to fix potential
  issues on 32-bit architectures (Sashiko)
- Patch numbering updated: v4 1/3 -> v5 2/4, v4 2/3 -> v5 3/4, v4 3/3 -> v5 4/4
- Link to v4: https://lore.kernel.org/r/20260724-isi-v4-0-27df7b5f6060@oss.nxp.com

Changes in v4:
- [1/3] Make enable/disable symmetric by checking stream_in_use
- [1/3] Add mxc_isi_crossbar_stream_in_use() helper for both paths
- Link to v3: https://lore.kernel.org/r/20260723-isi-v3-0-594919eae847@oss.nxp.com

Changes in v3:
- Rebased on maintainer's branch which already includes v2 patches 1/6,
  2/6, and 5/6 (stream ID validation fixes and color map correction)
- Series reduced from 6 patches to 3 patches (remaining unmerged patches)
- Patch numbering updated: v2 3/6 -> v3 1/3, v2 4/6 -> v3 2/3, v2 6/6 -> v3 3/3
- [1/3] Change from "Fix" to "Implement" as multi-stream support is for newer
  SoCs not present when the driver was merged (Laurent)
- [1/3] Remove Fixes and Cc: stable tags (Laurent)
- [1/3] Store input/input_stream in mxc_isi_pipe instead of using per-stream
  counters array, avoiding arbitrary 64-entry limit (Laurent)
- [1/3] Use UINT_MAX to mark pipe as inactive to distinguish from valid pad 0
- [2/3] Remove "high-end" from description as RAW16 is common now (Laurent)
- [2/3] Add Y16 (16-bit monochrome) format support (Laurent)
- [2/3] Add Reviewed-by tag from Laurent
- [3/3] Drop M2M_OUT for ABGR32/BGRA32/RGBA32 as ISI ignores alpha bits (Laurent)
- [3/3] Remove Android requirements from commit message as alpha formats
  cannot be used as M2M input (Laurent)
- [3/3] Add Tested-by tag from Laurent Pinchart
- Link to v2: https://lore.kernel.org/r/20260720-isi-v2-0-45845bc5d4fa@oss.nxp.com

Changes in v2:
- [1/6] Split v1 patch 1/5 into two patches: this patch fixes the core
  for_each_active_route() bug, next patch adds additional stream
  validation (Frank Li)
- [2/6] New patch split from v1 1/5: adds stream ID validation on top of
  for_each_active_route() fix (Frank Li)
- [2/6] Remove incorrect sink_stream validation
- [3/6] Use fixed-size array for enabled_count instead of dynamic allocation
- [3/6] Use BIT_ULL() macro for u64 bitmask operations
- [3/6] Use MXC_ISI_MAX_STREAMS (64) as loop boundary instead of num_sources
- [3/6] Remove mxc_isi_stream_counters_alloc/free functions
- [4/6] Add Reviewed-by tag from Frank Li
- [5/6] Reword commit description for clarity (Frank Li)
- [6/6] Add Reviewed-by tag from Frank Li
- Link to v1: https://lore.kernel.org/r/20260629-isi-v1-0-deebfdb1b07b@oss.nxp.com

---
Guoniu Zhou (3):
      media: nxp: imx8-isi: Use BIT_ULL() for 64-bit stream masks
      media: nxp: imx8-isi: Implement per-stream reference counting for multiplexed streams
      media: nxp: imx8-isi: Add additional 32-bit RGB format support

Laurentiu Palcu (1):
      media: nxp: imx8-isi: Add 16-bit raw Bayer format support

 .../media/platform/nxp/imx8-isi/imx8-isi-core.h    |  5 +-
 .../platform/nxp/imx8-isi/imx8-isi-crossbar.c      | 88 ++++++++++++++------
 .../media/platform/nxp/imx8-isi/imx8-isi-pipe.c    | 31 +++++++
 .../media/platform/nxp/imx8-isi/imx8-isi-video.c   | 96 ++++++++++++++++++++++
 4 files changed, 195 insertions(+), 25 deletions(-)
---
base-commit: 4d32fbba9d23f50d157ed4a37c9e8fbce61c904a
change-id: 20260626-isi-00f05b044ac9

Best regards,
-- 
Guoniu Zhou <guoniu.zhou@oss.nxp.com>

