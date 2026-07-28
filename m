Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013011.outbound.protection.outlook.com [40.107.159.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9173C10A3;
	Tue, 28 Jul 2026 06:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785221734; cv=fail; b=UMPc2W13heXJpywpzj9FJyc5AEqqegUyqruMxEYChHqDpeLOBrHvCt/aWuroYawBBtLSt34GNrOxjx1R5TE2Q9KhB+iJKXyi5VzdwybVTcV67YoOJrpwBQ5Ldxi5hZ+Qeo5EOKO2iAlcDFhTh9ln5QhCjbzKesRuwYGt+dh2+u4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785221734; c=relaxed/simple;
	bh=mLTjU/lm+MtVrYvOfgMgpMUg9xnEeSNvCIUPzWiOT0Y=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=V5VE2ZcIpmrRQwJVHL8pXm82NKH3tMitWc9Yb/UClmdn1CBLO9AgZuPMC57IYo1AZVpvxJHN8RsPL4cwsY8HIgv/OmARHLpQOy0eq5TDf+fA0P9BGrSICVFeXPfdpXIaj+Mqt6IqObSG541Nk472QVim0dbXEmsZsx4aUd+QJjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=WDuy6j2j; arc=fail smtp.client-ip=40.107.159.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="WDuy6j2j"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ffgcp83/OK+Rd39hfS8gUwZEOX9xRIQfJAHdH24JLPkfgFw+oIH4fvCLxn8k6lZgb7v6mEY265V2kzibekgE3RHi0pEm1jOdPc2Fre8QY8mdxmDxxsz+gd8gSApbA6wnlfjnKckCXK/qeBVxdqOkiz70ho02xOlFwooNsSQa7uQ9qyHw8flJ54pjiOTnL78wX7JX1gwqFsC6s/UMECD/AzdTC6d+N89X5KTRNlkKHTEZgoDpCKYKsTIAr/tsYb0j/pYQEvBtW4n5+pi3qWxqhbGz/a3mxMlNP61KF3wABWiQXYjKmV24p0UixFsomY2qBBvoevzfwamGjLFQx9r6kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mG/cAlEi6PHFb5gBss8NAY13lyRXUdGKbX1OTA49HFo=;
 b=dltjCxdVCQSEISnxC4NbJ+dDzt1p3dSAmCBvrGUPwvNqyk+0Q1ozyIiR2JDcAQ/n4stGbGbxKMu0zxbCq0outwX7NGJ7hpibVbNVwW2+pxPmANSjAMLLMFAQyqgcUsyfcde3Ligveo1241CxcV5ImfUP/uldwl0xOwlyYN4LsPFVVNRcEH5NnRFiBsJVojDKTwl5J08jB+xvgKbQwg+Y+p3ATobgLtjVhzAJWi1kHIq0aTF/KN8Bd0BuUzq0ctgRu6jrQr4OwjvnIUWSchiEjivG4l4gixU/B6cLFuhMzv4tpcVHdgQBs8wFSdtvpFRmtKNQ5At7mPyPEPzJMTOemw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mG/cAlEi6PHFb5gBss8NAY13lyRXUdGKbX1OTA49HFo=;
 b=WDuy6j2jfw5WP5NAc7KGszUQJteqlBArl9skyjZ/wPeM1mHc+jLivaJZgA4DHdYAfZhUui0eqCVx15O/yGFu8TbpxNJACywRcsc9M97NyEzWIxITSFklwmmqKklUogOftI7vNlgr10GJSSJAuSY74IHNJg3dMhheu1WBCZ2BbQPzR/qkR9ZcAwUci1kVEtpFTX8m9RDShL7Qs01Jrd5vwprd4VWqfXmk9Gyz5GIOIl8rWMWVcOnPhLLKwIabfrKkQgMF/6VadSzJi6ph1/hnJz54cycG6ofR2XqzLVOrGcNeka8ikZltY/ph/3k7Togf8jfA7d2nXooP6QX0fM9zew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV1PR04MB11513.eurprd04.prod.outlook.com (2603:10a6:150:284::9)
 by AMDPR04MB11584.eurprd04.prod.outlook.com (2603:10a6:20b:71a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 06:55:27 +0000
Received: from GV1PR04MB11513.eurprd04.prod.outlook.com
 ([fe80::29e0:98a1:4577:2cc7]) by GV1PR04MB11513.eurprd04.prod.outlook.com
 ([fe80::29e0:98a1:4577:2cc7%3]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 06:55:27 +0000
From: Guoniu Zhou <guoniu.zhou@oss.nxp.com>
Date: Tue, 28 Jul 2026 14:58:56 +0800
Subject: [PATCH v5 1/4] media: nxp: imx8-isi: Use BIT_ULL() for 64-bit
 stream masks
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-isi-v5-1-1d22ab91602a@oss.nxp.com>
References: <20260728-isi-v5-0-1d22ab91602a@oss.nxp.com>
In-Reply-To: <20260728-isi-v5-0-1d22ab91602a@oss.nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785221945; l=1168;
 i=guoniu.zhou@oss.nxp.com; s=20250815; h=from:subject:message-id;
 bh=mLTjU/lm+MtVrYvOfgMgpMUg9xnEeSNvCIUPzWiOT0Y=;
 b=gs7YMjGZzqDgG2DqAmUsKFUo5u5iiYLl7/bmtaakY3EbjCq/tUh8cNtF2saEMILG85h2NpukI
 OduE+5w9HddBqSg0bwJfwnHZGJsCAJAeEKy3mC2AX0SitRviaWcjKju
X-Developer-Key: i=guoniu.zhou@oss.nxp.com; a=ed25519;
 pk=MM+/XICg5S78/gs+f9wtGP6yIvkyjTdZwfaxXeu5rlo=
X-ClientProxiedBy: SI2PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:196::10) To GV1PR04MB11513.eurprd04.prod.outlook.com
 (2603:10a6:150:284::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB11513:EE_|AMDPR04MB11584:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e6d30e8-b4aa-4d81-75c1-08deec7534b8
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|23010399003|1800799024|7416014|376014|19092799006|921020|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 f4BBxQHJtlrsyYM2f2PqnhZnY07O+tTPXp7MeCtmpUUUaDDEJXALOjCq7oUu+quhBC+AJQjXVIDjDc9pt9mjGkZDoS6U2Y+VRk/KPoBjygpDoi0xfG3oMRTb+knBgp4b5VNFLXpaptN3c02GYKwLdYzumCRUS4xc35cu+UisvJr5iQCASYlD5b7HHar+zACBqTVp5RnQD+t8ALKX6oNIlgGMWwp//IU7SnITZNTMugU/2L+rSnJGXV02vEplUjxVRy+2uYSLAFifWrwLNgs/FcXRzzI7Rx+9hL+SitaoBYhngWedHeNZ7gI81yzLNaL10LOBdOFeidlknZfthSsv/x0G7PKoR6SjKsguaT/BD+DbGVFP9wcLEs5Hd+TkTWXytfhuv7OX+2/dsMx4FtIVcT0yiGfsnUPJYUMUHX76DlDkJx9sTjPwxCo4YE2HjWmtflTKStfBf8JXNvIQS2eiwix8BkXVCUMBoGa3fTU1mB6CBZwNnhgQ4A1wLeqcfPujc9v2y+0+sJBNU80XTIrFXme8upMJ16RN1W2S9dE82YjQn+2Gf+5bsT4H+nd8vJdFIQRBLt92Cjee0DFtoYGPn62vt822sMuaN6r4aU24CQmishvecvxI4GxkC4D9HkyyC4Vo4OYfoTGwuhAYz2Qz6b2f0/fq9ZS0Ig5KMaJCRKGz/iaEXSu3UzzDvd8fZxcXnwSL8hdhA6wI7/Mzt9sH5Q==
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB11513.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(19092799006)(921020)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?MlZmQ2p5TXg0NnRYT0pyRUpxblZncWdlTzlUWXB0c3htbzNxUVBHN2FCVlJH?=
 =?utf-8?B?OTlWT1VJWDJESjgxaHQrcUdrazJTL0h4OTFocHd4YVdaZzJnaTNmUWRxaFht?=
 =?utf-8?B?d2pXOUtBSjl5dWtDT3FwbnpCbXBFVnVkbHU5QjIyVGRYQnZUcUIrV3ZzRGNy?=
 =?utf-8?B?OXNrd1ZabkdCc2NSK1orajJJc3Q4dnlWd1ZXRzgrTHlOcVN1Ukl5a2ptYzMw?=
 =?utf-8?B?bHY4MWRXeU9VQzlGR0dkUzVpYmxJZkpZbFRobjhsKzk5bFRoM1ljdG9CaEk4?=
 =?utf-8?B?SFdwYU8wMVdzeHR2U3pxZU1QczVMOEpybkNJUTJZdm5UUVZ5VFlka05ZU3Fa?=
 =?utf-8?B?dFpJQjFac2xxNy9GMFNNUDAzOXZxaWlLRVU1MEZPWGtacDF6TVZvRzh1RE9K?=
 =?utf-8?B?OW85bGFKdXpqc1A5MXZHVjF2TFAzR1R0QXhycmZxUWp4S25rZUZkemM0cGh4?=
 =?utf-8?B?MWhONTZReCtGNWpsSEF4L3c3WFpMdDQxbG9xczdQMUNWczhTZEZiaWZKbnU5?=
 =?utf-8?B?Ukt2amlmeUVaQ05HWjFTVzhtT2p1L0NocmZNU05CbmM1RVhwcEZTSUpVbUw3?=
 =?utf-8?B?aGtmUWJCV3V5WVhrSG5PTFk2Zi9mSFVxQ3pFcEdGVWZkeC83TVZ2eHZaQ1lH?=
 =?utf-8?B?Vk9DVSsrRHc0VjNZVFpFODZDVUJUU24rS2pJTldaVHR3UGNWT29sNkZKd2RZ?=
 =?utf-8?B?dm9lL0htaVVBQ0tnUWVxODFkdkQ2aXVPbzlBRGp4eTZHSXFiSlhCQnhwemVt?=
 =?utf-8?B?Ynk4d1dOa29sclBjb2tWTmsxY2dQVUNKNjlGbzV0aTZ5OHZyaDl0MGZ5SnFu?=
 =?utf-8?B?YTZ4azRPRTI1b3dReHZHR2x4TlJMNnNGdEJvQkJkRUdHdXl5MFVQcU5wSGFT?=
 =?utf-8?B?TjZBRjlxRmhRRFBPRStkblNFU0dUM2Q4bWFjblJESHpvR0U4Nmx2VE0veG8z?=
 =?utf-8?B?ZnkvYWRzV0M1L2Vudm15WHN4bmRxSTRkUmxCZ0RnQXhnTVhteFlVWmsrMHJi?=
 =?utf-8?B?WUMva0E2NThwTzFzN3d3eXRyRzlTbUkwT2ZjR1NPbGpZT0RYSFJXRkYrYzJF?=
 =?utf-8?B?blgvcnRBV0NXZ0ZpUXYwYlppOWVlZ1E1bEl5RU1yOTZjY29GUmlXa3hXWDNq?=
 =?utf-8?B?WWdob085QytNOHhBcllRNVJwMU02eVc5QlhuNE5iZHZMSXRzTU51cEJYT2pX?=
 =?utf-8?B?WXJxc2RlRDEzeFlIbG1raW90dUh6dDhOUmpUSnJ6N1gvOFpjWUt1NVdyRlhq?=
 =?utf-8?B?cUxVbTVxdTRLYnJYTldKT3BlOWJHTVF4SFZHUlZvU0NQQWJDVG9BbndLNS9F?=
 =?utf-8?B?UnZoNDAyanM1VGhvalBhMGhlLzc5TkJZbkF0dzNZT1VJMEhYUmNVMlVPNUh0?=
 =?utf-8?B?dXcyVkhUSlNHMzhRUmFZRDk1T1FPR3FIV2tTSnp0aFBhVjJXWFIvZXlkb1BW?=
 =?utf-8?B?aUNXM3BnWSt5dThSbFFJR2ZMK3V1T0hJZUp5RkRuN2ZrTDcxeURTWi9yOWU1?=
 =?utf-8?B?cWRZaTQ3MVUxSGlibkRlWVNaUXFHNDNEeXdlbDRDWmdCZUhRWU9kOEhoSWN3?=
 =?utf-8?B?VUVvenU2cWFGTVRjSzI2aERpWTFRZjJtZi9TS3IwSUN2eEdlTm1xSWNOYVVC?=
 =?utf-8?B?dEVtcEdqcTBlVTlMcFVpWVEwS1A3ejRnRG40WjZ5YlhWQjM2SnNycXZRUHBQ?=
 =?utf-8?B?SGJaTmMxZmxWODEvRnFjOVRadmcxcnIxaHFpN0o4VXF2eHFwa0ZvUFkyZDA2?=
 =?utf-8?B?S0VtNW9ORjBOdzU5UndzZDg0b1J6SkxIVXBiU3dFeEo0VG00ZjJ4SUU0cXd3?=
 =?utf-8?B?ZUlOcXpLcDJlY1BTMHBPSDA4akFZNlROVS9kQXhtT05USng0OWxKZ0dLOTlO?=
 =?utf-8?B?VHVlaG1yU3ptM1oxRWZVMS9yck1TTEd4dlhPYVZDUFRMOE91QVhVcjdETjE4?=
 =?utf-8?B?NDY4NUI2QWJQK3Y0aXZRSXFnMWtNWGpxK2NwY2hWNms3WHhDL3l2b0tDdnlK?=
 =?utf-8?B?Z0FkMlE2L0lsaUd2NUl4dEZ2ZGdubkduUk82SnFLQWlaOHlTN24vV1VyekRs?=
 =?utf-8?B?UWZTUEVaR3AxeTFzazhaby9GL09MZ29QNmRLMEdyRGxWNUt2cmhPNjJBZzQw?=
 =?utf-8?B?QWt6WjlUM25QVG9iSWlUV3dyNUJ0eUdJQUpNNVNTZ0E2MHNUTmV0c2tOMzA1?=
 =?utf-8?B?TmdNcjFBcTBMOTZPQ29nODY2dVBOREozcitjTTJIWEEwK2pCOWNPdkZhTkpq?=
 =?utf-8?B?d29DOThOTzFlRVF0SHZDemh3d2xYZXFhN2F4cUM2M2FGakNQK0NES2xrNmhO?=
 =?utf-8?B?eTFLMHFBS05UWTgyeDJScFlvYWh1clJRSVJ0L1pmM05PYUtJWXdUcHFnZW9Y?=
 =?utf-8?Q?ibuWzCPhmUdoNqImV+pt/xkcvMH+7Fmu07uN1?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e6d30e8-b4aa-4d81-75c1-08deec7534b8
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB11513.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 06:55:27.5036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sj7Ss8WG8s+WygvprjlhIkcZkfNAKylInhI5q/71KceNQIU84/4s+EvRG+SfYA4sIDuqtHn03SYeSL/yhBYiFXG4DQt30XH9Wmhm0J+DDHFmKUguU/1u4Ti7yPaZz8tq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR04MB11584

Use BIT_ULL() instead of BIT() for u64 stream masks to avoid incorrect
results on 32-bit architectures when stream IDs are 32 or greater.

Fixes: cf21f328fcaf ("media: nxp: Add i.MX8 ISI driver")
Cc: stable@vger.kernel.org
Signed-off-by: Guoniu Zhou <guoniu.zhou@oss.nxp.com>
---
 drivers/media/platform/nxp/imx8-isi/imx8-isi-crossbar.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/nxp/imx8-isi/imx8-isi-crossbar.c b/drivers/media/platform/nxp/imx8-isi/imx8-isi-crossbar.c
index 9f0231ca47a3..9db9c6e55c2c 100644
--- a/drivers/media/platform/nxp/imx8-isi/imx8-isi-crossbar.c
+++ b/drivers/media/platform/nxp/imx8-isi/imx8-isi-crossbar.c
@@ -157,10 +157,10 @@ mxc_isi_crossbar_xlate_streams(struct mxc_isi_crossbar *xbar,
 	 */
 	for_each_active_route(&state->routing, route) {
 		if (route->source_pad != source_pad ||
-		    !(source_streams & BIT(route->source_stream)))
+		    !(source_streams & BIT_ULL(route->source_stream)))
 			continue;
 
-		sink_streams |= BIT(route->sink_stream);
+		sink_streams |= BIT_ULL(route->sink_stream);
 		sink_pad = route->sink_pad;
 	}
 

-- 
2.34.1

