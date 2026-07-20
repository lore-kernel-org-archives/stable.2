Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013046.outbound.protection.outlook.com [40.107.162.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D462D3955D0;
	Mon, 20 Jul 2026 03:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784518246; cv=fail; b=Myp8eakP5pt+ISMwfk1uRZtt+syfTR7Gmh7/PvF6Sv3EWpWqRvBoFxa1H2ET0EdXwcQZk8ecbmLWH02/DtBxZjG13GZgKcsL5zcQXlvWg8VaHL7qMoZMxOlJHPhupvnDVlTYT2rOlIhGmc6VPfrs4Yvb6tgHhmGZPGTykdgFylI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784518246; c=relaxed/simple;
	bh=+uWMOMXJ7KFCk58vq7lyg0/HmctGSG8VI+OJsq9dNlY=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=S2Xe4F1uxhliyzcAGLRvavfsGiGhmMthfE7lPUCJ5UhymBg/b+EKnXLB9TQwA3SX+E15vxKY/5+bijtfPupZyvEg50jwreVTg+Bq352EjggtqqzMNRRz8WFfNzmJFwORW9+ZDA7zBXPfocN5Zz+aicMikfrPoa0ngaA2PDAUms0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=cod9Xbet; arc=fail smtp.client-ip=40.107.162.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="cod9Xbet"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZiTlA3Wv6HhKZs8shCYqeBdThSWMIoHn/j2ICHlKerSTirSeMgA4DnYlloNplOZLVZwke6f7hu4k2wMWGIbq8+vlK0TofIg0C4h0WE/v7q10Yd0SL+tiPjzlpEZdxheoJLFGjo3N0MXweQh0ZhjiVtqvqJy5Av7O59/BSA8+YyU+EDSIPMUWyBjJVyyh/TqsN8SMkUnfXuYb0Dm7HTz/DU98BAlPjs657vPxCQK00UqbEcvhLJVOhIv5G3r69piW3ZsfkaJUfsY0b8PfbcA2IQrA72YkB2bXl22M7blJWNaqOoDYeRUdss17GcOnf9eSuf6ifuLIEfb7WrsdRjYfew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=faGqKMZXAuWUvin3T/yZPUyuyuLXO73rDGd+LwzYiNQ=;
 b=T+LYInuqNU5hKMuCmT7bXYX1PsXGv62eOdob9+C1TK3VRajxi+cZ2r5cuDQWSQINQ6cbGfr2cPlczsgl2spG+fiTKWvy75HnkvlxpexTY+D0HrXRHt3qdD9BdEG4+e4bHoe8Qnfj8vCppvQbaTlFfmpF1dwzuwuCGb9wUecRb2T6/rr9cc9XZMtGz4xvm+lg/WN1JAkq6PhJnIaxcbdlopgk8HH51FjlCXwZrXxMOPrMBCoRKLr87qv4TlO/c5N/yeN56HhbwLH2mmbrUNpKQaBWGlW8q5p7pDyC6ESy9SUApruFocg2WTPtvnuLFJdelprkjkz8YHBvcgtWGYgdhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=faGqKMZXAuWUvin3T/yZPUyuyuLXO73rDGd+LwzYiNQ=;
 b=cod9Xbetzr0oofqDlNpBy3UP9r0TWY/6/r96G9EaOuNtWSf4Eak3UFsqRXcIr4ouhvzhzl1SdRU+Ruat04Mny5nTJ9oVpHF34K/z85r7+Tgq1F5gN6fIYzO1ePbkgLw6P88cqmdgbbk43ty84eEUdzncRjBqVkhNl13LiV1fgVqDLMfbBoCss5E/4/OIBHXiY1esOLYufEXKZ3vSTOtef/JYb/nKyPzf8fyFUCPcaIQ1DSzuoZSC7QBC93VdIHc+EkpJOJgeoTeZr4uNgHyMYp7MbuFn8LEZBvBr/eddQP9l2QX+qpRlaJ8ZNYuZhTSwZhGfGUW9V+BtdNNEJqlw0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV1PR04MB11513.eurprd04.prod.outlook.com (2603:10a6:150:284::9)
 by GV1PR04MB10534.eurprd04.prod.outlook.com (2603:10a6:150:205::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Mon, 20 Jul
 2026 03:30:40 +0000
Received: from GV1PR04MB11513.eurprd04.prod.outlook.com
 ([fe80::29e0:98a1:4577:2cc7]) by GV1PR04MB11513.eurprd04.prod.outlook.com
 ([fe80::29e0:98a1:4577:2cc7%3]) with mapi id 15.21.0223.012; Mon, 20 Jul 2026
 03:30:40 +0000
From: Guoniu Zhou <guoniu.zhou@oss.nxp.com>
Subject: [PATCH v2 0/6] imx8-isi: Bug fixes and format support enhancements
Date: Mon, 20 Jul 2026 11:34:02 +0800
Message-Id: <20260720-isi-v2-0-45845bc5d4fa@oss.nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACqXXWoC/zWMQQrDIBBFrxJmXcMoqSVd9R4li2jGZhbVoEFSg
 nevFbp8n//eCYkiU4J7d0KkzImDr6AuHdh19i8SvFQGhUqjVlrUh0B0eDU4DLMdoT63SI6PVnl
 OlVdOe4ifFs3yt/79sflZChQLkXGLkQZv5hFS6v2x9Ta8YSqlfAGLioj8mAAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784518456; l=3050;
 i=guoniu.zhou@oss.nxp.com; s=20250815; h=from:subject:message-id;
 bh=+uWMOMXJ7KFCk58vq7lyg0/HmctGSG8VI+OJsq9dNlY=;
 b=oBW+VWayHhICkRizWkYLkKJpEkhS000uEgI3J6padOtW3IOx4KDcS4EkpW2SQof3TdNObwoyW
 qIWf6RB3gLlD+NVs3JiPJcLWzHxcZXj9YjZBuB3sLiJBi1XWLMiCFn2
X-Developer-Key: i=guoniu.zhou@oss.nxp.com; a=ed25519;
 pk=MM+/XICg5S78/gs+f9wtGP6yIvkyjTdZwfaxXeu5rlo=
X-ClientProxiedBy: MA5P287CA0051.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d3::16) To GV1PR04MB11513.eurprd04.prod.outlook.com
 (2603:10a6:150:284::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB11513:EE_|GV1PR04MB10534:EE_
X-MS-Office365-Filtering-Correlation-Id: af5a6906-6115-4baa-8f0d-08dee60f45c3
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|19092799006|376014|7416014|366016|23010399003|1800799024|921020|18002099003|3023799007|6133799003|5023799004|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
 I+T6rrxeUs3PfgvaHL4dFxkVZGgHUQfsTjByVaPzUlO6l+xGO4Ga01+zk66Xrk8/0gd5h0yfPWG+scieiH/Pr+zL+bD17N95m+3c3xJFZlZ5dazykNIcCcFImVUpDsjaR43KYSPPQKxJ1cUsBz+Yd1XlVj0RSDDqKZ5efA4L+h2JzsekNXFwWzMXAa9u+8Pp0I9FjBlVkSwZ88UQK3bEDWgPA8ZgC2v8AwXCWxKre4N5flJV978eDOK+zPgaQh7Bo5FRYCDC4/ZF6Ry7EbQvtyuLExcjtjZ82P0dS3nq9sH/2Jaxn3clcaeehmr/nPctHMMe8ACW4VqWPpTsnQxI8i4b2FhvQ2HRwmKvWWi2XJCIPExFYKy0e6q374JTyy4cu1GSYlJh9qTpG/Vol7ygHSxhJeqaP3w+QmB5mGvAR+91+PykTNSi5yqw4vWduvgJVyav+/1Qy9GNLisiqbT3r7KQoQNiLNOy8CVYrdiI1AG2rgYxMHvEPyhaWnUHVZjq6jqWlyAvDVPhcBhjp9K3JPVVNzS04RtnyQclLotnW3mKCxr3Wzd5zu5b0B4XhN6u7nS69Up3M5a8liPosC9KG+4ENX363Ok6jk97wpM8IDrgJZhbEUzU+HGFt5gn1GbO1Co6iGuNPA/7BVz+BZ19oe092fUZJEcEIA2aUWjVbQrhlwalcg/4vu65AN7p/O4e2tBsKD6uLO2Jv48ZF7gYUA==
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB11513.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(366016)(23010399003)(1800799024)(921020)(18002099003)(3023799007)(6133799003)(5023799004)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?VkVXNHZ3RElRdll6MWpUcXhzWElrb09LYm5NY2V4WTU5QzhmbVlXMTlqQzRU?=
 =?utf-8?B?UHF0VkxxZ1ZNNWtHaVNGTTBZc2FwK0huaFpGcXIzc1I0S0xTcWhjL3hLSkJO?=
 =?utf-8?B?bXJxbWFKUmo5NGp4Z2oxVTgvVHFPN0NXZmovam1pdlZqVFR1TDBVK21mYlZs?=
 =?utf-8?B?ZjVFRDcxRldrS3VKMXlvajRSSVV4UlZCd0JJbXlUWU1BdWpuZEtOeklhcDht?=
 =?utf-8?B?eS9ZYnFLYmQxT25Jb0tnbFNWd2JySFB5TG52WWhZeXY4dURNYzJ6Yzd1SlhR?=
 =?utf-8?B?YkR4VFJJSGJPU1B4a0xOeUplMVdSc0FOK25rNG0xc3YxdFZHbjVOV1VrL0lZ?=
 =?utf-8?B?UGZmM1dpNElCV2Jmd0FkWTZiUGYvQzExUzQyWlZTRGVHbzBxcDBsNWxEMC9h?=
 =?utf-8?B?RDdkNEJ3WlBjdU1ZNk5JYlBNN3NPdCszWnhpc2xpZS9CTEJqRXpieHBNd2Z1?=
 =?utf-8?B?THUzU3pYYWtodGRqRVRka2dFOUNZV2Y4bEg5U0F5dGdWZEhvZFFxQmJtOFBK?=
 =?utf-8?B?WStoYjZBYXQvR3dtUEJyMmtzYUY0d0syM3J5cTBKOFp1Z1RKM3ZiRzNkU1gv?=
 =?utf-8?B?Q243M2o4Wms0WVcyak9veVN6S0lXYTlMRXFHaDVVTjdKTHV1N2JLb1p1Q0hr?=
 =?utf-8?B?YkUvT214UENsNDZtellSdU1SazRPNGQ0ZDJqckZleXRPQnlzQTZ2K2ZsRTg3?=
 =?utf-8?B?cW11ZEVQdlF5M1U2MmhwMVc2MXJ0MDQxb2E4N21sSi9zazUzQklHemM4WWJG?=
 =?utf-8?B?Q0t5VkxMQkhYVWhBcnB2cHVlNy8ydnFMR2wyckJuM21SN2hHU1NmZTlndjdD?=
 =?utf-8?B?SkNKa3NCMmcxamI3VUV5V0NkTDcwWFJPY1J6S1ZtSE13SXg2aVkrVThzWTNF?=
 =?utf-8?B?eDRiUWI3YS80dDROSjdhOVE2RzBuYUxPbDBob0ovcGVJa2ZNZ0U2R084aSta?=
 =?utf-8?B?TVlCYXcxYStCcDUrVE1ycUJqRVBSMmJTUjVtM1hRUG1sZTNFWCtaNVhuNEJy?=
 =?utf-8?B?ZXpxbUpFVXZqWDBmTGIvcmxnd1krczRYOGlEVElUaEVWR2VIenlUUEZ3b0RR?=
 =?utf-8?B?b05LTWNXOXYwNkx6ckxVanNPMVNKR2NzMFlqUUp6SkgyWmYvcVZIdkh3emp2?=
 =?utf-8?B?MTlONnk0cHRvZEdSSm9HWlRFWTdyN0lPT3Y3cTI3MDN2NGhrQWZBMFFqQlda?=
 =?utf-8?B?RjJodnZmTkVWYWpOd29YUmpjaWxjYThIaERydW0rOFltQ09uYmdJL3UzVExN?=
 =?utf-8?B?eFZOZXlqRjFaWjZ1Q0JhV0lHSzEyQU9sanB4cmk4VUJkSXloamJMbHpkOFBK?=
 =?utf-8?B?eWxSQk81c1VQbzcwa2Q4ZFNvdEkwb0RwQ3dMTkFQYlQ1Nm1BQ0U5dEhLck94?=
 =?utf-8?B?MHJRV0huaSt4Z3JtS0tUOUFHekQyTWUxOUxLNHVZK2ZRQTd2cG40TDF0WXJ4?=
 =?utf-8?B?WTl0dTRGSDBQb09ZbDZpTlp6WHk3VWc0L2NPUjZLTUZkb3NTbkFBYnh1elVE?=
 =?utf-8?B?cGRNbWp6Z3NwbHZEdjFzNFV1T0FWWjIyUXp2Sy81NWJ4VGpmRFM2a2U4UEx4?=
 =?utf-8?B?MFo5cFRoZWJybDQyTThtdWZmM3F2c1RsWW04UFkzeTJwVTAzdHhPVUduSm5t?=
 =?utf-8?B?UWlCTmtUY1BIMlVYTjZoanA0ejhCakp1YWJrS01RWUF2Qi9pRXA4Mnl4TUJ4?=
 =?utf-8?B?ZUpZWXdtbFpWYTE4enE5dTZ3K2NjQU9DRUFWbWFTRlNTbUczN1VOait4VnZr?=
 =?utf-8?B?c3J5YVNIOXpSNUdITEJFMkZJWmJ0eFp1ZGVRTUJyeGNlK3JDaDNvUGhaN2RH?=
 =?utf-8?B?TGFKaUNBVGpBZXBkL0xDV05wVFdpaDVhUmV6YjZuaW1tVmV0ejlrVVRqdVRU?=
 =?utf-8?B?VWpIMVliUnp5VFQyV2UvaURpN3Y4UVg3dnY1OEI3L2ZiVm5VZFFQWHNtSzRS?=
 =?utf-8?B?YVY3RUxBbXBUc2FvRCttQmRWaU5iN25oKzRYTzhxa2s4U3JGdW94UGd2TWht?=
 =?utf-8?B?disrQWxWUHVzekxwcnQ3Tk0ybitQdlliYlZCTloxUlFmRXR4b0Q1bWkyS0Y4?=
 =?utf-8?B?eHBHNkR5VFRmbGp2WllnalZ5cS9HQXJyYzdEQUxJNnpiWm5OTENXR25zZCs2?=
 =?utf-8?B?MGNBNGZ3Znc4alVwV09jVHN3bG9kN2RHS1FDaTZrRWlQUEZ4RkF4VkpOdDV2?=
 =?utf-8?B?dUxvU3loRG1BQWlSbjVlTDZtNVRUcFc2Ti81WkJxS0hySExKYXBWWlg4Sno4?=
 =?utf-8?B?OXNBU0N2YW13QnVmWnJjN3llbTZwdGdPaGlOZFo1UEVGMEtBeDFHdGdscElL?=
 =?utf-8?B?K3VkeXZRSTNHVXBOTlZlOTlJTkd4REVCZ25oamNCSnl2TFg5RmJncUl2a2NK?=
 =?utf-8?Q?0jt2ofOwMR/pF0o8QQgKh5ZKuvSepj2KeOPkr?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af5a6906-6115-4baa-8f0d-08dee60f45c3
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB11513.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 03:30:40.6150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vpTAPKTDcaW3OKuti48liut1LjFqdKe/bM23fN9n4Us6Ak4jP6piUZh/abVTPpLEOFMk7X6bYSEaRh+O0md5wg6EAjGQvwBD/WfPVd5sdFzM9I3FYy5Vmal7klxlp4tV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10534

This series addresses critical bugs in the imx8-isi driver and extends
format support for high-end sensors and Android requirements.

Patch 1 fixes a critical stream ID validation bug in the crossbar routing
where the validation loop iterates over the wrong routing table, allowing
userspace to bypass validation entirely and configure invalid routes.

Patch 2 adds additional stream ID validation to enforce hardware constraints
(SOURCE stream must be 0).

Patch 3 fixes a stream reference counting bug in the crossbar that prevents
multiple streams from different virtual channels on the same input pad from
being enabled correctly. Only the first stream gets enabled in hardware,
subsequent streams are silently ignored.

Patch 4 adds support for 16-bit raw Bayer formats (SBGGR16, SGBRG16,
SGRBG16, SRGGB16) commonly used by high-end image sensors.

Patch 5 fixes incorrect color mapping for XBGR32 format in memory-to-memory
mode (marked for stable backport).

Patch 6 extends RGB format support by adding BGRA32, RGBA32, BGRX32, RGBX32,
and ARGB2101010 formats with full M2M capabilities to meet Android
requirements.

Signed-off-by: Guoniu Zhou <guoniu.zhou@oss.nxp.com>
---
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
Guoniu Zhou (5):
      media: nxp: imx8-isi: Fix stream ID validation bypass in crossbar routing
      media: nxp: imx8-isi: Add stream ID validation for crossbar routing
      media: nxp: imx8-isi: Fix per-stream reference counting for multiplexed streams
      media: nxp: imx8-isi: Correct color map between V4L2 and ISI
      media: nxp: imx8-isi: Add additional 32-bit RGB format support

Laurentiu Palcu (1):
      media: nxp: imx8-isi: Add 16-bit raw Bayer format support

 .../media/platform/nxp/imx8-isi/imx8-isi-core.h    |  7 +-
 .../platform/nxp/imx8-isi/imx8-isi-crossbar.c      | 92 +++++++++++++++-----
 .../media/platform/nxp/imx8-isi/imx8-isi-pipe.c    | 24 ++++++
 .../media/platform/nxp/imx8-isi/imx8-isi-video.c   | 97 +++++++++++++++++++++-
 4 files changed, 196 insertions(+), 24 deletions(-)
---
base-commit: 06cb687a5132fcffe624c0070576ab852ac6b568
change-id: 20260626-isi-00f05b044ac9

Best regards,
-- 
Guoniu Zhou <guoniu.zhou@oss.nxp.com>

