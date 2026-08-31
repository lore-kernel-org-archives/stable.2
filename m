Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A1B39CCF6;
	Mon, 31 Aug 2026 21:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788212017; cv=fail; b=lu2ZJ8I6S9AuKcvU0F1wOsdj7ZyC9ClK5ECzNGzK0GLgkThf5t8HL/Q1ag+bBGj/w6E/7ce/V3on79O6NezYlp0aQRWwvu2VqDEfxmEAV6/BSh4+TKkRIwEwWLL2XvejLLp88Uuc7qWkCH34+nqGKZhsBdLzE9yhS6fmxAhYYK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788212017; c=relaxed/simple;
	bh=RqkhnFF+zwgHBWl2t0d6rMJ/5xwax66D5K2zHgGPO8c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XIpE/eLuqku1HS/5j/A4wbrixJqBAs8r0PqhzwQilXqqYylk/KoYhcsWy0A10q/wTJs+pegqx92CltzMeT1pRZGCF5w0c6S2TRtxdUcavkkMRDUDD7K3gcg2T30H43akmzF6x8m6Cw5vhEqpAIZeGxHjL8NBKMisCyRbVHw2xmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=SVIHBs7A; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=V1hKpYLC; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="SVIHBs7A";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="V1hKpYLC"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 67VIRgJM1642785;
	Mon, 31 Aug 2026 16:33:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=pa6V0D8Jl3UALzk7LSsz2EU+vDCAb2Yrv0iUUc7Nz
	CI=; b=SVIHBs7A33CJdNse7e6pncQ9k8k+d6lCknW9SN6SKF54FVvR8ZsFHFR3d
	kkf+AsTy3orXUdhH5R/dDquAFWvUqcJo4sjzQlDJPna1Mos5xhEln4Bn7onHrd8N
	nO+0KCXA2d6lrlXqXaPHNNWlJ7uiEVY0GHADMNNTMx8SJ6uiatX8UA+NyVBAWsmd
	kgl6epe9bmaiMoihsW4TIZEiav+TVCthttzJpdOf3GMVf1drc7BkBmSktD/sv2eO
	hrgnN1puh8qCJoIvvJFNDPTErpPr7M+ipuQGDFwQ/Gn25jIu0cUG03UH7GIPaWBc
	tvhViutTbLanOygwJsJg2KXDg6bmQ==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011035.outbound.protection.outlook.com [52.101.57.35])
	by m0380145.ppops.net (PPS) with ESMTPS id 4gd44nd354-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 16:33:27 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gaAUj87rjGPvSauHnipINiYLfw/thu0phwPtp/Ze8Kj9m3BybASap2rGI02jjq9kYwuP3Y+xjZCzEsbwtR6R2zM5lO3JtUWcYe6YBmp3xEN4WKAxR/Rzh2QGEcCGkElOi0MXvH1VqjSxE/0YQS9J1Q24/d9nbv/ODMMllLPkbO4kb7l6iD7GYI3l4Dpjmy1nOsvgK4VLMUahoJ5fhEonyy5Yac7VJH4No3B5eYo5fjKANZLqLCavJJ/G+tORep6JWWKzS9W4AFBdJCwUdj9kMOcBqp1NLClkvz0X8+t449O5n119Oo/C3GH7md5OeYrFgE8YDWhanfcScJ1XiePi0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pa6V0D8Jl3UALzk7LSsz2EU+vDCAb2Yrv0iUUc7NzCI=;
 b=XnxmH4k87Z8gEhu6Ln9OKs7DjzhOLw0koAtlix4dCBs9vKGSUASPD0UgzpeuoKCy1nsTp4Ohe7O2b5lJaCMxIeCX0bDpaah6SUZD55dFxkf3gPrgoLgdprxpDFpNI9khF78pKSU52BWMhSWl6I6Dv63DP5xp26PuMFsG5pzonGgEgxJxZGbOc/+GexUSjrSjv6TxSFOuU6bukWYjbQUoOGV4dQgrJL0Rvb7rMsd8e1qvJ7MvSmdUS0daZ5yy717lEs1Jc9mNP4NwZeU9mkomW3E9eLUAFD2+y6sDQUUk1RifFe3M3eHgsNrtrV9L+agfvqFCi9rH9rcnWES3+vPsag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pa6V0D8Jl3UALzk7LSsz2EU+vDCAb2Yrv0iUUc7NzCI=;
 b=V1hKpYLCmBFH+un4RHRxmYJmUzqyvayngyJotI3g9MDrDy+bx/oiua8IPBpWCOmILyYqfiap+A9iWMOGSoEuOQlxPGbhc0x1/qtsP20BOKp7oEnAJOTm+jeUr0SsWSQPyP3H4P1UL+f3OjQR6CoOcL9JB3ppQsJ9VtVwulAlCAM=
Received: from CH5PR02CA0013.namprd02.prod.outlook.com (2603:10b6:610:1ed::27)
 by DM4PR10MB6207.namprd10.prod.outlook.com (2603:10b6:8:8c::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.7; Mon, 31 Aug 2026 21:33:22 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:1ed:cafe::58) by CH5PR02CA0013.outlook.office365.com
 (2603:10b6:610:1ed::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 21:33:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 21:33:21 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 31 Aug
 2026 16:32:43 -0500
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 31 Aug
 2026 16:32:42 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 31 Aug 2026 16:32:43 -0500
Received: from b-brnich.dhcp.ti.com (b-brnich.dhcp.ti.com [128.247.75.1])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67VLWbYb1545515;
	Mon, 31 Aug 2026 16:32:43 -0500
From: Brandon Brnich <b-brnich@ti.com>
To: <devarsht@ti.com>, <mchehab@kernel.org>, <hverkuil@kernel.org>,
        <sebastian.fricke@collabora.com>, <benjamin.gaignard@collabora.com>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Brandon Brnich <b-brnich@ti.com>, <stable@vger.kernel.org>
Subject: [PATCH v4 1/4] media: imagination: e5010: Properly Release m2m_dev if probe fails
Date: Mon, 31 Aug 2026 16:32:28 -0500
Message-ID: <20260831213231.2125544-2-b-brnich@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831213231.2125544-1-b-brnich@ti.com>
References: <20260831213231.2125544-1-b-brnich@ti.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|DM4PR10MB6207:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fea592e-943c-49a1-d612-08df07a77aeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|82310400026|23010399003|18002099003|6133799003|10067099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	VsI3+cpCs0PdiUl9z7Z7+t0ByZ63isowXEB0WiPTg4wLLwHGGq5gFREPUTQ3WmpLb2j8gOKcO7CeIn9tQgYFY8pmuQP9Nt9C2xcX3VCvfPJ4GW7IRsyU1Cj/2NGzybP0dVyY+PyypI4fwsB1SYxeYufffuZmYs28r4Rumo6uURanMZQ0TuPLrtU7POix0xeBwOTk2VtZ9aInCMlC1ZCJ3kART3YDbChhZsxdOg7y8n9WLdqSwnfLFNsNFG8FSpMcc3QqgAwQn/6E3i2iQJx5m+0bLZtaf75hIqKd2ws6BV+9G4Pqtn/sTKimfB8Mh0ubzWrnWKRR2+p7UuBzLbNS/nt45pfmeNGBec18DOKXQ9Xe+FmfUdLkbdnPbXnNpLl/jHqi/UJVRrXbMHiN9m1YvrVeBV1M4RSgfM7lzSyPdj0bnRe03NJJTX59cK0i3lRPn8gGb45G0LX+iasmkczPj697Flxcs4OU9WAqe6lGC/gC2MCxN5ytMPivhUjiMj43yYf+iyPiUK98gIRotppgd3p4FH6CcfxW5DhYmIwscDRM9kQhsAR8SwAYKSEope9Pis6jaFXpGQH70wguZcHf7dfTmkJxpA1cXXGdAw3DT6MYK7TmvjjbMq4MMGH5vHo/EPR0sCEGvDQk7i93IpAMPUW+m5Z0PWGZydvtKs6jzqagySxJ/RmPjaa0Ovm68CQn+cwMAcO2oVNh20XqSx0EuA==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(23010399003)(18002099003)(6133799003)(10067099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qYddbRTHwag0vhY3HeD18NHFhLPDXEZ3ocdKokfTGw4OgbcDatfvjvYIt3Wk4/dqvS4eNhKdfXLLJhod0eJePPTqXlz6gIXY+1ZMmj2kZ3mZEMlzx2XWZdgxWmkBkx0TE7sQuzRG/GH7XWUvEyN5yomLgJadjx9rqB9EG2WRltFH6u284qBWjwuZpX4N0kaOVAn6XGilNEW8JqdaREHJtgUsZFQOicfEkeupRls6k9ezraiazD/1yEqBneQwmfGcJqaw7ThoigLgr2x3Rjbb6Rl+BGkuQPPHoMewitOemJ03zEXRkExn/RGkF5q6IU4+BZM4JeJOf0JyJss0z95GuEHi7pF90KSdYDttimKcg25FjvRJpa0VSfwuOh7PsdY4BVCHm40X2e5tSN7CaGknw9uyXP9I40As+n7DsT4BWp9hQ3oTY0pqOffwa7Eo8FfF
X-Exchange-RoutingPolicyChecked:
	G+M/NNyy3Ozlyl4UF0zlhH0XmwocT4pVTn6qgukIru/x997F5LMoEhnAQh1ocaHbEQGOQZy3sc4I1IQiu4Jx/3zb1TnX23aQuXJSjIY3AYn1UNFVE75UlcxzvUcDIbt48fnsArVDMAIHzTD9q4mXS+jusqa1/CZT7y7KLz9MjQTszGER7Ffc70YHpE6GxzmMvcTGQwgfLF1L0r4WD6slUYaG1Or2lz9y9cKeth6pYxze+9nmsmtrHjGGgdTXhae+cYCpQzMeIPE6ueQYCSb6y0vb94H66mQ7Jzd8cXNTl2jMXk6Dp9SpWFm56qwRGGTXAPXoW3KuHeSz3nDiQZpykw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 21:33:21.2179
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fea592e-943c-49a1-d612-08df07a77aeb
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6207
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE4NiBTYWx0ZWRfX7dyalSoxARXe
 ef5nySMNDqodst/ICBIcNzkgnxXSPg2CtiQlpTaasFNkACrXi29HS9VLp00342mcTNAisYGRaaH
 Imapw9XFGcUT1uqB3OaTPZvMiBzdb0bcCGBubWPN4rvHNgogDF9UmdcB5PJHEik+3U084/t1flu
 f3hg+C5lieWSmcxGmRcnaIKIdcl4lhlfvSQdu99NEoU6YHoOU8toYbpQ/Cvf60TaNCphSr8U9Yx
 pkf7wQBDLrTjm95MgTSXnY/ZHAu4q4rFDWWzNDuJMeXOCiKFcMld2Uk0ZU5b2lMlTjg2Bvfyoxv
 DrFlpeholYZpeq5B2hKDCuHzOHVavG/xXamiVDqhaJONQZY1CLtvJGhHOZBwjMoNihdUwTffYg9
 OBnseR/WdUfbBt1x4dzby8HR5wlXg2wusphGk1q/UAHCDxN9a+ktlYf3pGdqpRLjifkEIDLvIaa
 UUHa/thXvPvyDYlQMIw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE4NiBTYWx0ZWRfX5+8XnV2LACNr
 Z0tLg34B2hp0cdjuajj8RUWytlDZ5wTv3X3uyEyAbjcNyeVyyzwJP++qSrQ7GdPT9qxdttqwz2d
 lcJpPxC29RZPKGPC/dffiG4Qm0zcvlo=
X-Proofpoint-ORIG-GUID: CuO9kOGEF8T5btbVCiJnzpaTvXNtfTk3
X-Proofpoint-GUID: CuO9kOGEF8T5btbVCiJnzpaTvXNtfTk3
X-Authority-Analysis: v=2.4 cv=T7W8ifKQ c=1 sm=1 tr=0 ts=6a95f327 cx=c_pps
 a=MvJzBjTJNBx6A1eu3kpgJw==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Sv0fKeRqtYgA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22
 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=BvWq2gUW7f8KG5-ffTcA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_06,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310186

After the call to v4l2_m2m_init() is successful, the following
initialization functions should go to fail_after_video_register_device.

Fixes: a1e294045885 ("media: imagination: Add E5010 JPEG Encoder driver")
Cc: stable@vger.kernel.org
Signed-off-by: Brandon Brnich <b-brnich@ti.com>
---
 drivers/media/platform/imagination/e5010-jpeg-enc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/imagination/e5010-jpeg-enc.c b/drivers/media/platform/imagination/e5010-jpeg-enc.c
index 42ad9ee3993b4..d3c11337c815d 100644
--- a/drivers/media/platform/imagination/e5010-jpeg-enc.c
+++ b/drivers/media/platform/imagination/e5010-jpeg-enc.c
@@ -1072,14 +1072,14 @@ static int e5010_probe(struct platform_device *pdev)
 	if (IS_ERR(e5010->core_base)) {
 		ret = PTR_ERR(e5010->core_base);
 		dev_err_probe(dev, ret, "Missing 'core' resources area\n");
-		goto fail_after_v4l2_register;
+		goto fail_after_video_register_device;
 	}
 
 	e5010->mmu_base = devm_platform_ioremap_resource_byname(pdev, "mmu");
 	if (IS_ERR(e5010->mmu_base)) {
 		ret = PTR_ERR(e5010->mmu_base);
 		dev_err_probe(dev, ret, "Missing 'mmu' resources area\n");
-		goto fail_after_v4l2_register;
+		goto fail_after_video_register_device;
 	}
 
 	e5010->last_context_run = NULL;
@@ -1089,14 +1089,14 @@ static int e5010_probe(struct platform_device *pdev)
 			       E5010_MODULE_NAME, e5010);
 	if (ret) {
 		dev_err_probe(dev, ret, "failed to register IRQ %d\n", irq);
-		goto fail_after_v4l2_register;
+		goto fail_after_video_register_device;
 	}
 
 	e5010->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(e5010->clk)) {
 		ret = PTR_ERR(e5010->clk);
 		dev_err_probe(dev, ret, "failed to get clock\n");
-		goto fail_after_v4l2_register;
+		goto fail_after_video_register_device;
 	}
 
 	pm_runtime_enable(dev);
-- 
2.43.0

