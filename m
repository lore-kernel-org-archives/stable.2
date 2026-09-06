Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazolkn19010021.outbound.protection.outlook.com [52.103.33.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD7327AC57;
	Sun,  6 Sep 2026 23:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788738152; cv=fail; b=rquBzfaO2HEVrkBOVwLq0GW1PrNz+Vv9Vcdvw+RmdyVwLScnhdsbhWr/iW0YM9BVXlob+/cG6nYjR2cp75bVLt1Y+Hp4dPyuLsZTZAqhOpyv/KrVn29s38i/F65VDlxnniJxyw63hdgocLfumPMTlvx2nZncwVqIBS0/IQEm1oM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788738152; c=relaxed/simple;
	bh=0X9v757BtP6zWA44C/l5fxSuB+vTe5e+4mGov1TamSI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=kbFn2tw5+LtuVeGBtBDFeu48sRBb+L9U2hF/cBjwXQIzY7ecPmxKHmPVy2BbwehRHiDfIzvFGst7yNvqWZtmAi7SKY9dpGVRhh2TB2ra4tD9OnhFd5St+eok3WEv1Y4qDafYj2fdPtZAyIF7mAuxB9eSuKuuu48I9qCoTg8bd0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk; spf=pass smtp.mailfrom=hotmail.co.uk; dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b=Qr4caX+v; arc=fail smtp.client-ip=52.103.33.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b="Qr4caX+v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J3+EvfO9243Qosq+0p2fvvbiT9NaQpkue5zxvhG/qnwuOk//w7mM8FSmU2uKxJwCZ/276KWYbhq7JOYbFQdJaIkT54AoZpljlpfQiV4jUYUvvrnKD7nxPHizGw0/CbTM/A2+Y9ZT1uQf2LQWuTl7GimVxHwIoMbYlnLbVGhMBd7KgRdoPsP0U2elaC8NOllgNpl9ee/EJRnzjQ7dcswDMwAKpuDwXHvHsPgY1kGkVPMijnyP74JMhvjfXVWFXTQyayBPCcg+okurEEti2HYFFof8kMTNRKr2QUI8Cop9rTguP+LpDR32EcZm5FNHIku/Jid5k8qVAD7pikg18iGapA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6621Tt8Wofg6hjcmAhxUXL9WY6V4fKEh16GVa0K/klc=;
 b=GnObYswprXLQbdabbLxT6JPUp7b/BfF2LlbC/yUTo4gOPnAYFidWHmYeHHiYoP4uj9hQ/kGIRb8v/KqVMko8e/VRsImq8sHoRsp6IEnfrwPlnd8ulYbSkBAvrhdSQiVik1zXM2VM4ZpWe+9nZu/P1Fv0JGaLOqfMI+e7Kz/HzsmRv5hWzeYlm/uYe5hgl/O2wqyWWC6IPjYM5yffA4SJFIdYp645XzmAg+qtGrgdeEXfz+eS+VZkF1fs43RcOQw5N0iFa7vzEawOXY+bBkJjufTmWQc1Rlck+9QaS8n96bcl1SpsJ7QrkiMvTkOoh4MZyI8g9CRNvwOY0cGDyPgSdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.CO.UK;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6621Tt8Wofg6hjcmAhxUXL9WY6V4fKEh16GVa0K/klc=;
 b=Qr4caX+vhJKNR652dmlGEYoZdvZmyRC/2K6mV7ucB0gBVqhi+lQ8ec/418qEPGk9/HUFcsjv3+SU911jmSWdaIBeExO//xjQfqafN3pGgQb7mUA5VD/ODzIlZfHtQgBJC0kisANjKAt3f8Ht0TpoBOPuIr9rlEAaVcEQrLcMXU7nQdgGnC6WkJnibSJj9DuMYhDevqKrUg1d0su/NRqkzGsIMPPfXZQhDvhi8Vv0YJjehLN4wb++qQJj4XSsNrOQp4PVrT2bLF/g4IlQN9QiDYqJ/gQPdI/do1fyn0g0qtQzZYyWKPcGmBbGcR4u1l9mLk4k8SBRuoeAfZYB7wUmQw==
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:344::22)
 by PAXP251MB0113.EURP251.PROD.OUTLOOK.COM (2603:10a6:102:200::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Sun, 6 Sep
 2026 23:42:29 +0000
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352]) by AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352%6]) with mapi id 15.21.0382.014; Sun, 6 Sep 2026
 23:42:28 +0000
From: Aamir Ahmed <elb12345@hotmail.co.uk>
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	Dan Callaghan <dan.callaghan@morsemicro.com>,
	Kalle Valo <kvalo@kernel.org>
Cc: Arien Judge <arien.judge@morsemicro.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] wifi: mm81x: validate packet length in mm81x_yaps_read_pkt()
Date: Mon,  7 Sep 2026 00:42:24 +0100
Message-ID:
 <AS8P251MB0001B650C31E9F37C3B7907BC8B32@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.53.0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0091.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::8) To AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:344::22)
X-Microsoft-Original-Message-ID:
 <20260906234224.87901-1-elb12345@hotmail.co.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P251MB0001:EE_|PAXP251MB0113:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b61a61d-7b48-4a39-057d-08df0c7082e7
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|24021099003|55001999006|16051099003|5062599005|5072599009|4140399003|15080799012|25010399006|23021999003|25031999004|37011999003|19110799012|8060799015|41001999006|440099028|3412199025|26104999009|52005399003|40105399003|2607281247196008;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Hii0i5/BCKClTe5/cWnOSmnyAJTn3J1gN/1YNb/OZhEsZue8w/TtWDuzL6n0?=
 =?us-ascii?Q?cL+cxDLXIxXgr4sqH8wPLxsAC78q8hujUIFUk6UdPABCrEkaroNtFPRmOnAp?=
 =?us-ascii?Q?CdeDsP7ASlL0TblCGBhqA/yLsqJVGqLwE/UJzCoALmz01IIut9Hnd6GMxLZb?=
 =?us-ascii?Q?AZtTAsGE+MgAyHcxXvWw3SLkBO7gl0sbSyCJMyVxTNlq18Jd2edaWNGf16/H?=
 =?us-ascii?Q?pbJWfjPMxedGcKUBJDcAUKqj/cuNHnAuar0HQahykOF5d1wAEUrpi/JwlPGx?=
 =?us-ascii?Q?01PgRtplf+CkpX2uuO8eoJ0RvbOyLo21wSCPmLngqGxdc82Jvhe6+cn/MCXt?=
 =?us-ascii?Q?j4bOnQFsR+iZ3MeYqrpLkLyG8nd0fv5Ypsv2VKORTJFrsPvI24EnGbskWoPc?=
 =?us-ascii?Q?/OYyo7Lf0kU7QLlndxip5J3iRsIl2Iy5REdOSYhCI4vJyCbM+KhVKNU3kWw+?=
 =?us-ascii?Q?i3BwBfTxA2xQysum5SXA2WN6qlniW2Z9zp0UnJ386xSTCrVrTqKmaT8/gbmk?=
 =?us-ascii?Q?LfiuHkGEhJH/cdMOpd4lqkc33hl4GVHzxoomAE0rPWDkDrxnelJUrIrVdCGB?=
 =?us-ascii?Q?p0w6/7O4SwBO0uDHIBCEuzRd1ygvhfasvd0pDui0Np/MqUIeH094MeFKNs+y?=
 =?us-ascii?Q?U7j2m7hWHNVPSgI1T+SmWjS/cl9SaRG3GyDs2ZJIZRMPO8zMpJim156t+ZIg?=
 =?us-ascii?Q?Fj8xzypYpg01C6Yr6cqkPB8lOC9YpOpdUofBgrqMY0ZH+BZzffEffhfYiEm+?=
 =?us-ascii?Q?L7BywJ55r/VnnmhrkSF0Qf7gzcYNkqNK8Q6RbMgJ1hADYsCYF+Anp/XcZHU5?=
 =?us-ascii?Q?KehGdmCbn8wkxN/3TdGHmCIoIkKoiVLcx9+XgJi3x/kz7CgbE9L9UwJpySy8?=
 =?us-ascii?Q?Y+lPl5Qx0G9HcPSgb1dwxuLObwNTPxI1HsklAl7/chuTvqQMrJof73zXXIMY?=
 =?us-ascii?Q?rfWell7LwOsOknDoj+gSU0pJO5UWAVVTKORJvmXnfyjC0USPKeg+mcHzn0kN?=
 =?us-ascii?Q?ngbeVm4cBWPX9I5vlNnJRPVjxaN7P5CvwcHFEbGY9ZIDLuF56oXxNCR5q7sY?=
 =?us-ascii?Q?ztYQhn73D/g+V5Vvm3gTL+7I4FxGosM0sad53iOM6Pics+UMEnb3SCqVq4Q1?=
 =?us-ascii?Q?rqhLvlWKxnGc?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Kda6xH05GM7jHGUHPFk3Uuff4R17YXP8RNwH/zfHtCk1Qc74zXTH20DSW7bt?=
 =?us-ascii?Q?G7KxBIgvjO0FkGgSjS9tUWBwln/Xi5rEYGIalo2X5s7cVoseclynBc2P/2EK?=
 =?us-ascii?Q?YFN3twHurqSt2shQoREzbqIev4B4dqa/k5OG7Z1CZEHkDzyvGuuF3tLGqsnb?=
 =?us-ascii?Q?FT2YEkw+xFSD+J/lQwv7fkjngE2fsOIb97+QiN/U8kHOLaS1A+FDKQRgl9aN?=
 =?us-ascii?Q?49UTvo2CQ8AsRIif+0iqjrwS2F+ZmZJY7o1U4vgTFsvLwAPBTfvlAxEFwWcm?=
 =?us-ascii?Q?k4xxpAw9d1FJJKFWY71Q7dnARTyKkIAkaRHP91xHEhXNdLdjR8fn8n+1Rs3E?=
 =?us-ascii?Q?gHDLIgj01aPmAo/r/H0zcsRzV8F4O1lZkydZKbj6e847IwZOq3CuzltdLXAc?=
 =?us-ascii?Q?nAPy0TO5gsvLLAfKP0UD/TLpgjiJnj28TjN7foC0tkd9+HzBd2uf+WVkqsEz?=
 =?us-ascii?Q?WAOzeXDT9z2CQwIXJXtewmggTl3UIA0l6OlkWsPMjLf8i9ST2MMiAAPqEVCq?=
 =?us-ascii?Q?hH4FVizoaBJeWIm47gW08ahiDDMZS9lLCQ+mXerair2GvosL/PIc9Z5g+oNk?=
 =?us-ascii?Q?CrtEYIY/6UYFCQzmmWO8aCvrr+Oo8aV0vmCVsR3eF1Hlmc3wrVFmsXPHkvRv?=
 =?us-ascii?Q?vjAyHGrdnSeq/N5LJAuWWlnImpCG+rd+hdvxnNvd+d02fLDELx+2npn14mm/?=
 =?us-ascii?Q?kYk1iOoFHf+7Bb+7a4YS0WuNgKRS5fFa58T1ppa8UMjDWRlpp/sxeCYM7SWf?=
 =?us-ascii?Q?VjvXOFUaKy3Lw3Zhogrudi8cZi4dmf7N7sdg2UvSBnX1Xp7GvZfjFkacqy2W?=
 =?us-ascii?Q?iIdatJ1sVzRgfQw9+tYNADBeEmRrfiON1Mf/DWV2xZwPPPzvp81pkNaJb0yi?=
 =?us-ascii?Q?FVXKa22RN647mzBVLb8pzj5ScDFnVlr5v6bqvTQnjXfFjxrePNjCAs3kUy/o?=
 =?us-ascii?Q?dEj5+M8/UM91ikgHh80GLb1pnkH0O/8fIZ5SdlfcjEvzlVBdDM/GQbqqu5rM?=
 =?us-ascii?Q?mve3uo9k0MXpVbed2+YIU4hAP/Q58iN8/rOZ0hArk5BTbCnBfxipDwohNBRU?=
 =?us-ascii?Q?7IMC5YrVNITNq7y1mFvAixeUORd1+5IV4+259qpiCQERXdnaZI+e9+OcBM+2?=
 =?us-ascii?Q?koYalxtF/rd8mnKJlEbB+jgGv0AbGJcf2Zq399tTr8Za2KVCyrS4QBG5jQrZ?=
 =?us-ascii?Q?Ka4LUrChw2iFT+9k3fkV9j/U6c8SQCzkSQZfNlq360vjNhognYPNmOVxTnSU?=
 =?us-ascii?Q?WIP8Z1r2X5UtZNAaCnDLdxagOjee375Fq1T0R2X+5efbh8MHkjrEHr0rHP+E?=
 =?us-ascii?Q?7E/2mSoSYGsVZTYRnIRxBOzoypzHiOiPlbmPIsVlDdi6WMllGStEE6sXsa9M?=
 =?us-ascii?Q?PA4wB4/Dp0jkCkNwW95hvgfqLkDPuu7APKTN07zunzs4rCbZ+uGD1mLj/PWc?=
 =?us-ascii?Q?E6GHJMniH+32z8QBz6Aq2Dge7Fv2R64S?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b61a61d-7b48-4a39-057d-08df0c7082e7
X-MS-Exchange-CrossTenant-AuthSource: AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2026 23:42:28.4308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP251MB0113

mm81x_yaps_read_pkt() casts skb->data to struct mm81x_skb_hdr and
accesses header fields without first verifying that the skb contains
enough data for the header structure.  A malformed device response with
a valid YAPS delimiter but undersized payload would cause out-of-bounds
reads from heap memory.

Additionally, the function computes the expected packet length from
header-embedded fields (hdr->offset and hdr->len) but never checks
this against the actual skb length.  Since skb_trim() only shrinks, a
claimed length exceeding the real data is silently accepted, and the
subsequent __skb_pull() in the dispatch path underflows skb->len.

Add two validation checks:
1. Verify skb->len >= sizeof(struct mm81x_skb_hdr) before accessing
   any header fields.
2. Verify the header-claimed total length does not exceed the actual
   skb length before enqueuing.

Fixes: b1906cea00b0 ("wifi: mm81x: add mm81x Wi-Fi HaLow driver")
Signed-off-by: Aamir Ahmed <elb12345@hotmail.co.uk>
---
 drivers/net/wireless/morsemicro/mm81x/yaps.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/wireless/morsemicro/mm81x/yaps.c b/drivers/net/wireless/morsemicro/mm81x/yaps.c
index e98a2a58726f..da2c88901d64 100644
--- a/drivers/net/wireless/morsemicro/mm81x/yaps.c
+++ b/drivers/net/wireless/morsemicro/mm81x/yaps.c
@@ -147,6 +147,13 @@ static int mm81x_yaps_read_pkt(struct mm81x_yaps *yaps, struct sk_buff *skb)
 
 	__skb_queue_head_init(&skbq);
 
+	if (skb->len < sizeof(*hdr)) {
+		dev_err(mors->dev, "packet too short for header (%u < %zu)",
+			skb->len, sizeof(*hdr));
+		ret = -EINVAL;
+		goto exit_return_page;
+	}
+
 	hdr = (struct mm81x_skb_hdr *)skb->data;
 	if (hdr->sync != MM81X_SKB_HEADER_SYNC) {
 		dev_err(mors->dev, "sync value error [0xAA:%d], hdr.len %d",
@@ -186,6 +193,14 @@ static int mm81x_yaps_read_pkt(struct mm81x_yaps *yaps, struct sk_buff *skb)
 	}
 
 	skb_len = sizeof(*hdr) + hdr->offset + le16_to_cpu(hdr->len);
+	if (skb_len > skb->len) {
+		dev_err(mors->dev,
+			"header claims %d bytes but packet is only %u",
+			skb_len, skb->len);
+		ret = -EINVAL;
+		goto exit_return_page;
+	}
+
 	skb_bytes_remaining = mm81x_skbq_space(mq);
 
 	if (skb_len > skb_bytes_remaining) {
-- 
2.43.0

