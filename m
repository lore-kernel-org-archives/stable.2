Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793143456;
	b=KlF3+jtI78jpre2pVSp+yVeULtAjshj4HbtDKioiexLIzFA93DJET+7IuPcrusOvM/Eq
	 T3q+CGiU1CUu87btABSUU/2CAaNbbiMeoBnHwC2F6oO5WNF8Lo0i/q5xoJ9blqWW8d8YF
	 3R6HZl4r7xALwRe8Vj0aUtbFIEucJVVecHwps4b/vk+n9QLRhG60hzW2j4LJzLouQyX35
	 9ZiH9eCKit3yasNOjD25uuF/d8BKThNtH+eOZ6CCyQRvgsoKKa183prBiHxXJ/nv4Vm8x
	 EkcKW97PdlqUOC7QKycXkFaThVjMTC6AKBCMKI29J+Dxj8OWGL42/JEj6Bl52VMlU+g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793143456;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=K1ndogGsTWbFDLVgM+axPSOmgQbR3hyd1uA1SABlBm8=;
	b=VIUsqccxYdx1wGV+aeV2kk9s9rdZKW1XgCyY0P/0f4t9HB6BeqbEGwYF22+pa0wvwe7Q
	 HNIm56tPY3f8XiS2K+5T/B+9cmeGyYnuxQWBIQbZ7hXL8zaLelROuI5rGniGeljyfyUAi
	 m+bIB/w7qKa4nrB/ZJO6so7bJxATw4VB4Fg7doD4uT8LzwfLgY6oPHyJhYxzhdbGfS0jj
	 2icrF5mfhlgZHOo077sY7Tga5M9Cqnwj+EqWwX4HwhQRK/7M292bnKOI18yD30duFLjNN
	 7URHfDSGlpNLZLLnH/0fhwyFFJ/ULVrQXA1TPKM69vX2qgGifeoHRSN506hEc+gGTxA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=3bUqRRJ4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.52
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012052.outbound.protection.outlook.com [52.101.48.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2832E606A31A
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 23:24:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2832E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=3bUqRRJ4
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NxEIuZu2px2rcfu2Q45ausGLnmpij3qjClOMM2cFKIkM72oxsWceMIhp5VlwrET3FvHVoCVYouSMMlOM/HPwdOASv7DNFg9U9sT/fbhMwp2To1b0TdJLTWYoOHFsTIl4UHSeI39OJSfV7Art/TYJi34R5+K4BJREFqkdGNUzuTejcTw4DEk1yXXT8QEzfXmWbaLPuMwCqGdfAgFhHVBXzgya+4dn2lVniRAxH3H79uFz3tysgx4IYLLZ2TOakKi4uQnoq3G4IjBKH7LoqoPLF/DKcWJis75SXeYA3VrbQBdFvfV1/eCi62lww0+4N7IqBzBb7zdxd+1tf4XaqA2SEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1ndogGsTWbFDLVgM+axPSOmgQbR3hyd1uA1SABlBm8=;
 b=ZcOjaXMYl68xVjF71KAAJYguuGAUrisU9XkY5TzsztFkg4b/g0JRF8rhOcKCKCJS3GmDlTUiovTGcGAZeZE0F1U00Kb1YAM7QtsqDB1V9b++vq5INlwIDCsYLXNpsVtelZcGivdsnl4V+ioH6UNpwyO9d2qsZ3JsLihsVo6D7auMVhe42KUJhYtDndLNfk9mASuyY+lVosKHyLxyETPg83N4CvGwNgEgZHFdIeXtuzRFyGGbmlytwpIagnhGcnwC+sHS2SwigGhTrE5IBZE/x2XzuA3m8jyE0c4FKNdHZr+DrE2VTbFeYi8ObTd8MeNRdxmnCNP1/oHutI9tn74+nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1ndogGsTWbFDLVgM+axPSOmgQbR3hyd1uA1SABlBm8=;
 b=3bUqRRJ4oms37J8F3MgMcjYNd/HH7xk6pIevGBefyZ1o/MNycSvnjd0HGRVEXBqp/bbuujghJrQPBOE+EdG3+6H9ssIUXPnZ3kTXTxNQAHW9SQTbdSyEbhE+S+35oN4nVKbHxlasf8ayyrgpiHUTvCyOJ/r+tMsavj+bFmreapI=
Received: from CH5P223CA0022.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::12)
 by DS0PR12MB6656.namprd12.prod.outlook.com (2603:10b6:8:d2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 23:24:13 +0000
Received: from CH01EPF000BE943.namprd02.prod.outlook.com
 (2603:10b6:610:1f3:cafe::4f) by CH5P223CA0022.outlook.office365.com
 (2603:10b6:610:1f3::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Tue,
 27 Oct 2026 23:24:13 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH01EPF000BE943.mail.protection.outlook.com (10.167.244.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 23:24:13 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 27 Oct
 2026 18:24:10 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
	Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
	<Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
	<alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
	<Chen-Yu.Chen@amd.com>, Dmitry Artemenko <dmitry.artemenko@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Alex Deucher
	<alexander.deucher@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH 17/28] drm/amd/display: Add missing OTG_CRC1 reg/mask entries for DCN3.1.2
Date: Tue, 27 Oct 2026 17:17:13 -0600
Message-ID: <20261027232005.2879750-18-alex.hung@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027232005.2879750-1-alex.hung@amd.com>
References: <20261027232005.2879750-1-alex.hung@amd.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE943:EE_|DS0PR12MB6656:EE_
X-MS-Office365-Filtering-Correlation-Id: 049769bc-3ece-4cce-eadc-08df3481695c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|261009223027099003|56012099006|261021121427099003|10067099003|261026121527099003|6133799003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	e6UJzNs61hDj3qhPJmcYf7XxEIweW3EiV/1FgakiikI5+wJ+4eZTdXwD3IqMLal6+UMTCLqExL7tTCDGum99BZZjZP3EyTjrmr5sfqeo5RTpjXvaBwZNyE65cD8lwaoRKx2IlY9PhZhuaJJAgKSsvGHST9FDis4oyHNAHtrgcUeMICFSvSWLH9n+9FoSoxMYfU2xomFITS/fj3POrCdZDOItKz03SBpdW9z+GeOU+X+fzrEU/NVC4tXnkQ6EbwgSydUTX65IxQRVbIUIvfpxdkKDhLn0OzX0jijpDUETqQCAuZogVw07EiWg408bOq4jt+N8WCELdhbYn8emWgV3cXp4aypHkDS7iDFo5g+f3ORSp8YJkxSCSZrkZE69EPuO4Wm42kVeumIN/iE3647kHQn7xX5Ww3WN0dPC+cBayBRKD8vI7VdO9m5Rfamt8fKMA2GAr9OCy8IdI0SDRbqWre6g+QxrW8AWQyYpjtaGnEbTr04FmS4EYkDVr4/7BiqHwaRTQqdW8T/3/cIfNAedJepk7kK4pCKCTy3I1VVU4wAHmZeNzb393sHfIH1XUK4J9STRQPc22BMFkwcbLQRXB66zeCLj3PC8d+Mqj10OK+12/WUERrq1QOxeJPSTf7sG0SOhfd2D/JXgI/wVdBMD6BYeJajItYb7qyLrk8SuNqgyZlCKBFa52yoLStlvmdk1Cvy9LneVOK8YYkvdQuj7zg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(261009223027099003)(56012099006)(261021121427099003)(10067099003)(261026121527099003)(6133799003)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RUnyiX+9oMNejnPoDBJSqnF78PuJ8hwZqr5E5nEhs9rxSTItvJ9VcptyBqrge4PK9DsTLtnmaSI4aKlsSl9UwM2n3nxlXmUyZQgcgCJxvbeXrO0SxGljNQ0zP4e/+AqD0M99lRr6XWns78TdXCDgmFVbv1PCeeRrKZr3PHw3CwCIrAg3uCqOY1GGLvKbZ8X+FkHJGToCcs+7KFX8NOp9uAX3X+XbKM3scPX9ilwqhGr/OhT/tsuNWWuvew7VNHq0AcH26AxGboopEk3XFJeEnvELfud5BmVhS8O7IqT5DO1OWJTMuh3y4nBQGXgjsV8XDSKUZT3tPVP4ZFRAaj+OzEbjwkSQxdBEmEMTEIiT1cNsNpBMFjOnJz8XdbmFSNExm9NWjECsa1sOCjzuyBflaSJCP9ZSkXFoXSnnLBJkBPWdeYi0YvrRhZT+2t9lf6H8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 23:24:13.2740
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 049769bc-3ece-4cce-eadc-08df3481695c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH01EPF000BE943.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6656

From: Dmitry Artemenko <dmitry.artemenko@amd.com>

[WHY]
amd_hotplug@basic emits a kernel WARN + Call Trace in
optc1_configure_crc / set_reg_field_values on DCN3.1.x.

[HOW]
Add the OTG_CRC1 data and window registers to the DCN3.1 OPTC
lists, matching the DCN3.1.4 fix. DCN3.1.2 hardware supports CRC
engine 1 but the mask list only enrolled CRC0.

Cc: Roman Li <roman.li@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org # 6.14+
Signed-off-by: Dmitry Artemenko <dmitry.artemenko@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../drm/amd/display/dc/optc/dcn31/dcn31_optc.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.h
index 19d90c65a22b..a60a96075d3b 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.h
@@ -83,6 +83,12 @@
 	SRI(OTG_CRC0_WINDOWA_Y_CONTROL, OTG, inst),\
 	SRI(OTG_CRC0_WINDOWB_X_CONTROL, OTG, inst),\
 	SRI(OTG_CRC0_WINDOWB_Y_CONTROL, OTG, inst),\
+	SRI(OTG_CRC1_DATA_RG, OTG, inst),\
+	SRI(OTG_CRC1_DATA_B, OTG, inst),\
+	SRI(OTG_CRC1_WINDOWA_X_CONTROL, OTG, inst),\
+	SRI(OTG_CRC1_WINDOWA_Y_CONTROL, OTG, inst),\
+	SRI(OTG_CRC1_WINDOWB_X_CONTROL, OTG, inst),\
+	SRI(OTG_CRC1_WINDOWB_Y_CONTROL, OTG, inst),\
 	SR(GSL_SOURCE_SELECT),\
 	SRI(OTG_TRIGA_MANUAL_TRIG, OTG, inst),\
 	SRI(OTG_GLOBAL_CONTROL1, OTG, inst),\
@@ -217,6 +223,18 @@
 	SF(OTG0_OTG_CRC0_WINDOWB_X_CONTROL, OTG_CRC0_WINDOWB_X_END, mask_sh),\
 	SF(OTG0_OTG_CRC0_WINDOWB_Y_CONTROL, OTG_CRC0_WINDOWB_Y_START, mask_sh),\
 	SF(OTG0_OTG_CRC0_WINDOWB_Y_CONTROL, OTG_CRC0_WINDOWB_Y_END, mask_sh),\
+	SF(OTG0_OTG_CRC_CNTL, OTG_CRC1_SELECT, mask_sh),\
+	SF(OTG0_OTG_CRC1_DATA_RG, CRC1_R_CR, mask_sh),\
+	SF(OTG0_OTG_CRC1_DATA_RG, CRC1_G_Y, mask_sh),\
+	SF(OTG0_OTG_CRC1_DATA_B, CRC1_B_CB, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWA_X_CONTROL, OTG_CRC1_WINDOWA_X_START, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWA_X_CONTROL, OTG_CRC1_WINDOWA_X_END, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWA_Y_CONTROL, OTG_CRC1_WINDOWA_Y_START, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWA_Y_CONTROL, OTG_CRC1_WINDOWA_Y_END, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWB_X_CONTROL, OTG_CRC1_WINDOWB_X_START, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWB_X_CONTROL, OTG_CRC1_WINDOWB_X_END, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWB_Y_CONTROL, OTG_CRC1_WINDOWB_Y_START, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWB_Y_CONTROL, OTG_CRC1_WINDOWB_Y_END, mask_sh),\
 	SF(OTG0_OTG_TRIGA_MANUAL_TRIG, OTG_TRIGA_MANUAL_TRIG, mask_sh),\
 	SF(GSL_SOURCE_SELECT, GSL0_READY_SOURCE_SEL, mask_sh),\
 	SF(GSL_SOURCE_SELECT, GSL1_READY_SOURCE_SEL, mask_sh),\
-- 
2.53.0

