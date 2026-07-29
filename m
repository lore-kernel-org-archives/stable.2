Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010029.outbound.protection.outlook.com [52.101.228.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD0247426D;
	Wed, 29 Jul 2026 10:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785322597; cv=fail; b=es/xtVJmXoGUg5OnwbMESmCW43iw4JXr4XYNz833TqA/lmkXRdRc5vNYHMVoLkFOcggB4Pr8VALMpBpvzhKYZ1oNSqLkwPUW9kxhnk1oxukuPtz5h1yZCMR7JsBuHLSospy84Lb2/BvhI5O33BSC4SQISYkXh7OVop9koDUx+Rs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785322597; c=relaxed/simple;
	bh=oTjz+x1KMtOGKW4dJ32l25SXaIG6ZZqGWPwV9cfRykI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BLO6JdGRaxaI078+85KgwuXSdRLvfhQq46WbzHKJFFX1bWxQ/32BEtMOzi38rRvuzAkU2bQG866erfucN6abtQsS3hAmXUYzmKRkjtrISgaXJnYPM2ACR2pPmNN65usscHVmRHmQ+Tcp1M/i4WkC1SOv+kYPPFhcNHLLMssTU6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=UEDM/mRA; arc=fail smtp.client-ip=52.101.228.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="UEDM/mRA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k/f/P8llt86KDaslJc3TE1HQ6egM46h+vU5eC5/Fyml6ZJ0L8eJQUvoJx7WEdoFxTbePxjLR97LpGcDh/g0aivMWru9uuZSyFOGBL6vjgxdWpeC0AOvGmNtGJBOcny6KtRbMyW34Nvduycuwobaa+LgFl9Mb7cMMuAKfKyOyFkVc/T4JtqyhbDHPEwkUK+m9kuvXgwSoyeB17pa+1L22VQV1wjN1yuCcp3YbEuq5F/jqb7/3kK9Ridd2UND0vmayq5KQvSTQGh9A0qB6hGusFHpk8odfRjPmxzJk0ANVGmiDdXZHwQGVLiWY/hHU+S9zJYnF5ogzzF8Ar7jNGHwYlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X4WM7xkmxvN8D7MTm5sdTxD2Lvslu4BHLhAUpAWpwdI=;
 b=SC0YvcOMMaEEeyrq4ug0Dca5wD0j0TkuUX87/js9sc5SS430bqDipgCX79X1qxVtK05Jsr3eF64PbMLAzbj5YS02SHm3TX6KglnO70nu2g7QtMoBHoWrVG/jc2TCdZY0oXeLOJ6WMWEcFwVthM+gR/H64WTu1UmOLBheqAhbM9w1Nbzk0rpGVv/6se6ocRHB2RqKTipcA99iHV2SOpdrg16DQg/sUDT55LLkbcRjyHIbDHOZIZxX3YlPT0Br33YzUuPG5xLhnPWRRXM4a2Ka6tjhaHQrmXjKFo74zLSXdEhj1ah291DCvGOpjuIJJ1nbK7FHmnGA0NBLX8S27chs4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4WM7xkmxvN8D7MTm5sdTxD2Lvslu4BHLhAUpAWpwdI=;
 b=UEDM/mRA3aa1xS27rX4Il6PfX7CeYEvaYvPSmHlRSxh8E3XaF7l3rI8MTlD8FviT/cH5hwS2TIS/3WPesNuvady3Se08/tCCH36ZV4KR0a9URokw3KALNyU5EZMLxBWD2TCFOzJvxpQzUiOKx23HMehiQjymRMTM7LgD3GA6seQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com (2603:1096:405:18d::7)
 by TYWPR01MB10274.jpnprd01.prod.outlook.com (2603:1096:400:1e2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 10:56:32 +0000
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828]) by TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828%4]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 10:56:32 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: tomm.merciai@gmail.com
Cc: linux-renesas-soc@vger.kernel.org,
	biju.das.jz@bp.renesas.com,
	Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	=?UTF-8?q?Sven=20P=C3=BCschel?= <s.pueschel@pengutronix.de>,
	Nas Chung <nas.chung@chipsnmedia.com>,
	Mehdi Djait <mehdi.djait@linux.intel.com>,
	Isaac Scott <isaac.scott@ideasonboard.com>,
	Paul Cercueil <paul@crapouillou.net>,
	Daniel Scally <dan.scally+renesas@ideasonboard.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v5 1/5] media: rzg2l-cru: Align bytesperline to hardware DMA stride requirement
Date: Wed, 29 Jul 2026 12:55:46 +0200
Message-ID: <20260729105603.1160966-2-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260729105603.1160966-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260729105603.1160966-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0207.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::12) To TYRPR01MB13588.jpnprd01.prod.outlook.com
 (2603:1096:405:18d::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYRPR01MB13588:EE_|TYWPR01MB10274:EE_
X-MS-Office365-Filtering-Correlation-Id: 96106699-b9aa-405a-8a02-08deed600cf8
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|52116014|38350700014|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 eiy0ulMtAIhnSg4im1ixkacmVeytkBEtlkJHAngM8LJtRy9HQkFiqgp2IIrv0r4BEgjsDBucd7174E7poYxSQQY9LtRMGLgDsvBHZIzN6DpqMOgDKt8EvPmKnTTyoHOgrlcqef6V0TYx5mLLWltNjM0ePui3hxpzGUhDLHhW4BbO7jkBgI1ep5DDACBx/ZX65NXlEN94lYjHlZeWlLzBZZMumcLoPr9DX/GJicZpEXVcD6kFinC3P1fT+BYV7AlJ/VtePmiA2WKGo9gh9xPZTn40u0eOyB73I00qXnWJUMtokOvKeK4f2CUoFjaKeCaEljHdCBuUfzdQhsOegHsWHmmAUTZfG7DqI2GbikPettm4PrnEWxY2XT4YHIuzr6bKiuCfr6hToAdMoaH9IMSoAkiv3yErjdHFMjLv+HC5/A9gQrxi7kPRKDKNs4HTF7tv4LTb2edVa4oNBtjJjU23u6WPny+HsNOWpQcxtoffl+aWX/spAtgkma2IbJJfkq5x7IzL0E13i19ji17t/ZYGzQqI2j8hHWIxrG7CH2lPg0ib6MBw5MFUFaHEfg2XJhK2ppmJsqQ4ScugCSFbn/E3JUko/80S6Zin9dVlDtzujrTvhydBEtdKlZQIFxQ6mw6TrEr+m1y8bm4f1JRr9/cLmAxARZeCYfvYm/BztBhfkYQ+8rSCDo014C+YFg9vIk+EqDTf/bLB3QBEPV5zAeToArsepgfzOmM3taOkeAvuDMc=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYRPR01MB13588.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(52116014)(38350700014)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?+I2XIK5tjhpha2aak954RBMXrr8kNgfxH3qq68YKCrB3hdgnJnyfeU6hjMQL?=
 =?us-ascii?Q?zJ9Rtygd6xflqj7WuIB4lDGU7PgaOLCvpmYQi+HtG4EmxsLUCUBPCX88k8hK?=
 =?us-ascii?Q?2bgWnTe773IJ03A+VoQWLM51BWvx0ui1GAlRfM2Kux1y0KWzhzidORaKf4gA?=
 =?us-ascii?Q?NXGtDjV2z3qgsreq+H/qLFBHRiKXx4r3PrfBHuZA+VSzWp4bii9+xBr+mans?=
 =?us-ascii?Q?08bsAY6XorVl/2XSHPjZqbevWcd8IQC9e1wo/zXxfL0zcVBAaAZXaVdNu6BY?=
 =?us-ascii?Q?xli+H/30cM6Gv3rmHghSLMbznUEmVLlObAv4EnyuShj4B/2cytDSXIrzF48N?=
 =?us-ascii?Q?dLuBJGZTYjdpPkkKKuCrl+8S0OBL9DS1B1mJSWRS3Q6Dwa7lHIuSKT1YnzoF?=
 =?us-ascii?Q?PRLSudVY9bxvDh1Cg24ioZj2SJVVe0617/Ll0ZSaFmNYLNOJnMLIbLjr6DUk?=
 =?us-ascii?Q?X3MWC2fUaZqq9SofAtkN1VNT8y4vPzLSsqzc3GQqxe7ONLkpXb59TroSzhM6?=
 =?us-ascii?Q?5szBIX08ZMEACS5VX/zu/Hot78LT6ZwuN17DFijfWnM4LZ79j0mRPWq+BdyN?=
 =?us-ascii?Q?4cXwzOy2qn+v2QXqeNzRmKgpsVgTqGSIUggEoGbhwR/gFRbY/+iOC+BCeCny?=
 =?us-ascii?Q?byYA8LIUkqUD6t3c0mrobyE4BjfzlJswU0cSvgOATZscdth+iAZAZ4sjWeGv?=
 =?us-ascii?Q?3nl7o2NLxK7BlwVMNy/6oijJmhPnrzf3ShEon5jJDL53da5dyKtLVri+SXU5?=
 =?us-ascii?Q?bHEORpvFVfDkZn1F7j2HHfgRq4MwxUE0S/N0678QgFF+qQ9hxuNDOK6t28gm?=
 =?us-ascii?Q?mr9xDokHNkLJ5QM86o8Nazt/ZHXKMhj0NaJJUMIdaw7jAVu11rubk/NJc/3a?=
 =?us-ascii?Q?98myRl7AgPRqKFyA45yj4vPcJl1NJdyIcrWLgOLyAFKgtesPBWpxLHnGh/1O?=
 =?us-ascii?Q?05JBOyta7kfzShPZbsS5L2rTT8AUPKOZ5R6eacreHUD44bp5buD41nRtCy7N?=
 =?us-ascii?Q?HjfhrBp47YzplxiMA8DEU+3FQTg1Kugj9B7Xa03Yhf2sTHWy79J2MIULAvw6?=
 =?us-ascii?Q?PQU3NuX8FDEiFAr4HhY2xDr+9iiGAAkLIrH+9WXcNdV59KeOtxtNhBzMlIJE?=
 =?us-ascii?Q?Yd9W6V9AfiznN/5z6CCSgPJ22h27U60HRU+UT8tn2WPcUc+MJiKglkPqXrqz?=
 =?us-ascii?Q?u6ngYIU8UhA7WWN2UubjlXYo2QAnTM8uIaDDrPoGF3GmttrHt4K1PgFJj46j?=
 =?us-ascii?Q?8AJG/lPohBtMvWQCcFz5zi/7RRrFxifzglFU7eQJZ5SODeEYel+k5MwuLxJI?=
 =?us-ascii?Q?0wCcwepeYtEO9Jq2EjB+kEZb/H8Z72ggHizzG7BOV3guYlZEq5WC1UoIjPAJ?=
 =?us-ascii?Q?k+kJWSJW1aaUS6qxJP6HziU395dps/QKAiZRquTB2Fd/c3MgKaMvBmbSgVbw?=
 =?us-ascii?Q?gL+aE0WEVk0fa7x09kzia9VHNmCHnFk4bvNGVuv8Cu+/H+GsUvsC2uDiX1W/?=
 =?us-ascii?Q?HLYiBapMhDkWQMd5BxfxrsMJcV8+sCh0v4Fndl4/aGQLdM/owRfx4Al/FLjY?=
 =?us-ascii?Q?MwTbMR+tpxZuSSoBjHO55bD1xq86PkTOeBVcVHmp16sHTp4v9dgEhvLhZ25I?=
 =?us-ascii?Q?M5CN6T0taMFv0nLjTGFyN9zOQpdMLrn/mticFy5Q81UmwP8LFSW57RfcS4op?=
 =?us-ascii?Q?TuadgK5uV0nZ6U4wN0r90brgCXU0O+H+rfbqF/zd63Wleorezm9h+/VADBDM?=
 =?us-ascii?Q?dEfvXxs+H9rKLtL62ds2EHXYegjTkee1FA0ndLLVmmpDCV1J0m/d?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96106699-b9aa-405a-8a02-08deed600cf8
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 10:56:32.4472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tUXySr4Ue19sdBIne60m24rm0gguutxnXrtFrGJurjahagY1xXJB5rUPq0kBhJ3fd1/3e1D1+zwtRLswEvi9h5m59RLPVp+PFPeZZQ75Ccmq61TyAEVaikKBxa3ENJqj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10274

The RZ/G3E CRU programs the line stride via the AMnIS register, whose
IS field encodes the value in units of 128 bytes. If bytesperline is
not a multiple of 128, the division truncates and the hardware uses a
wrong stride, causing horizontal banding.

Commit ace92ccef0c9 ("media: platform: rzg2l-cru: Use v4l2_fill_pixfmt()")
replaced the open-coded aligned calculation with v4l2_fill_pixfmt(),
which sets no alignment, reintroducing the issue.

Round bytesperline up to RZG2L_CRU_STRIDE_ALIGN and recompute
sizeimage when info->has_stride is set. RZ/G2L has no AMnIS register
and keeps the values from v4l2_fill_pixfmt() unchanged.

Fixes: ace92ccef0c9 ("media: platform: rzg2l-cru: Use v4l2_fill_pixfmt()")
Cc: stable@vger.kernel.org
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
v4->v5:
 - New patch.

 drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
index 5185a547461d..91eda5034248 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
@@ -851,6 +851,11 @@ static void rzg2l_cru_format_align(struct rzg2l_cru_dev *cru,
 
 	v4l2_fill_pixfmt(pix, pix->pixelformat, pix->width, pix->height);
 
+	if (info->has_stride) {
+		pix->bytesperline = ALIGN(pix->bytesperline, RZG2L_CRU_STRIDE_ALIGN);
+		pix->sizeimage = pix->bytesperline * pix->height;
+	}
+
 	dev_dbg(cru->dev, "Format %ux%u bpl: %u size: %u\n",
 		pix->width, pix->height, pix->bytesperline, pix->sizeimage);
 }
-- 
2.54.0

