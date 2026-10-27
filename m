Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.33
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793143445;
	b=P9SXIbC1wPB+vNFKaEK8xhtjlM7URq6puwuWHCByoc0e7jcC/KfUR+6m1zL2KzUvsQTh
	 w0wfJZj+WcH/S0EH2Z9Sx9cgg9QF3GGJQv+1qkQS1o7A3qoNrylxS7NYwhwRhKPieZ8s/
	 T2ojMg0r8BAME/TQrMfWpYdn35Ps7wYSenRicYa/Is1LTNbWZLJ3/IQd8yq/W4+0BhCEE
	 hBhjIe91rF0Pn46fn5qJKUoAcqmaawQvZ0gNbaPjUi5a2HaL+cy2NGlwalcOn3IvubmAR
	 p3IbM5uUnU7L2WP/m1UK6pG3ufV8sHgJzb3cerRFYQFVFSGjGAGq7I09UqCJyXToBew==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793143445;
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
	bh=hobfvgTvqj6QzlJdWU9w0eA+enJwUW2Jrpgvl9z9xus=;
	b=ATiVAUKYgo+rYlclN+KOGwOiyZtekZCFou5is3KyJ4Xm6OY+BMDI8CD/cIvRhoUrkMMS
	 Z6GuPVgsLpD2lyLczhy1TINCjCNgurmTtRpoPh3zcYKJvB412ImXw6AKWmg71ekkuiUeQ
	 3fh/vmXUozDyiZII8ajm2nH3lOr1tAXEAqG4y0EJNz8c2CVtUb78lqQLv55NUVXYBeY3E
	 m8JUqiOmgRCK9gcF90zd8js/wJLQdeMJa0VlY4/JiJTSFvGdaAPQBYcMCyZpt+OZGrtRK
	 tTrLqyCUbsyUw4RC4ouAy3xc1Mmy5cj1YpRPm5tJCrRt6QaQEApczhxXA7iE046PspA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=1cGwQbgO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.33
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013033.outbound.protection.outlook.com [40.93.201.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903E9606A31E
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 23:24:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 903E9606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=1cGwQbgO
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kFTX0FG5o0xvuaY2tFvVJEnKuw5IXghNEwVnbsxhaF3JUyuaY5XFEnSay6wmQaVWRhk4+/5phgfgVKs8+j6YmVQcjOlttIGy6ywb4EskeGe4yHfbjA2h3l5Sr0HwiZNZuKubWEg97UwDgnIJWxn/ilD/RgCgaDLcWCP0VDUGntpml9rWOw43/CWrIe/JReIm9ONEXBCPx7PSpTtmym3EOKXiK1Qm0TYt+oeiQ5BH5tyVRvax9ZroqOS/rGy6kqmoQ/q5xvoKCH8oV2w4chIeY3PRmt+i/HJTmxPqvpDLd1qeZTS7+H9NjjT8A23jN0xYgEmS+RdcdRJQEXT6v7jVGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hobfvgTvqj6QzlJdWU9w0eA+enJwUW2Jrpgvl9z9xus=;
 b=f/U+IsIwbTBQ7zbugwmJ1zUxzX3RX6tm801rWxNMG61AF4h7Mgx26e9hnZWWdgFfZQwhKmO1o2I39IskdBpnKUW8HfhZrRb0tP8GSXvCl9d/dBR9Z5oZtEv8fHt65wH6DZ1X0i9Cz1/zKK5aMLuQ30LB/RjDV9Sxx9/mEyNQtABoL+/RWMZq2aUv9DFiC8uSiQkl2rFTofGG/kAWMgDYZXsDf7hw1wBMc6bDz/wG39fs+hm/ymzTCsb04grBVm2f4+zHA9RUH4aiQR1mrJAr0gnBv/i/RQE/IDrjbGrRZhKUfGOsrmwCslaN0b4JKQ90GBqdzfBswlNipzXH8/iNbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hobfvgTvqj6QzlJdWU9w0eA+enJwUW2Jrpgvl9z9xus=;
 b=1cGwQbgOResGqgPIi6voBO9RtRGrwxrV4bGA1mZaOMQkg66Ea0gTFV39rXclrH/ksYx4PD/NJ+Dx/HvcSHx3/S8/TAKltsFAASmlc641Akm6mbz3Wi+LLG9Pdgb+C+9+Qg8Is9ElMFM/u2szZQGiMxtCCgwKQPlVub8l0AMboEc=
Received: from CH2PR08CA0021.namprd08.prod.outlook.com (2603:10b6:610:5a::31)
 by DM3PR12MB9434.namprd12.prod.outlook.com (2603:10b6:0:4b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 23:24:00 +0000
Received: from CH01EPF000BE945.namprd02.prod.outlook.com
 (2603:10b6:610:5a:cafe::33) by CH2PR08CA0021.outlook.office365.com
 (2603:10b6:610:5a::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Tue,
 27 Oct 2026 23:24:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH01EPF000BE945.mail.protection.outlook.com (10.167.244.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 23:23:59 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 27 Oct
 2026 18:23:57 -0500
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
Subject: [PATCH 16/28] drm/amd/display: Add missing OTG_CRC1 reg/mask entries for DCN3.1.4
Date: Tue, 27 Oct 2026 17:17:12 -0600
Message-ID: <20261027232005.2879750-17-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH01EPF000BE945:EE_|DM3PR12MB9434:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b9ae688-d004-4290-71b6-08df3481616d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|22082099003|6133799003|18002099003|261026121527099003|10067099003|56012099006|11063799006|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	dyTnAxRk1v79MuNLpMV7B22Eu9ZgjN2d6bcIczITs2RueQYCEKIvci0Ylr77ACzCbs2195PgXPs81LtUDuekueECEgZyMuiTUfFQPTDf0ChRqJFfknmfKnAkBQvDB1vE17wPAYE5wLJpFdcjxx62UDwWyPlS9+/j1NDEV9SOAjWWAVrKZ5rT6TUi4Mvl5Pi8GO+0WkCkD04vKJTIN/Scy9tl7OEgPN7Pnbm1aSJnyQmJmxVnFWIVhHwVP3nTa+qrGmtHE/89fcN4dwTT5pAa0B+lJ6oCwzZXsNXyiWsEbZ+au1tFraKWM0GGXsZ/WbCW2T9x9+NjaMebOrYShjeaINkY1QiTXAuh3vdyox1Pf5IjdKgBdxxzpvoVXID9AUPxwtDJr6kwo8gDb1cz5L4V9m86vDZoW0FvLe/1R7HspvSxvHc/61kIgGprqmrxAArvS8JumnuE7uPYhvUFEEZRt5WPO3PPvHUYzH0v/wIJWpmrR9zqTbEsNcsnANKT/0qt07+8Jw3qzLFm+LVnUAoxGvQBrmfimdGS+o+FX/ACbtStcwnh9EqN85xeJnmsCZXFBI5QQpzZFwiXP2wCh7cr3S0ev3fod7fFeHWB0ZMcb6dSDH2hnV9NXCF5UgjlZPRuTMurs6wbilOVqGJ3Yx3ltfST9j2xBIJeQp3UBHTrchLWFXf3vGu+TixJ/NMXgwUfc6eSo/c1NoWE2WR93NUNwg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(22082099003)(6133799003)(18002099003)(261026121527099003)(10067099003)(56012099006)(11063799006)(261021121427099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	updM4AmuNHuRHnAou7JBRxavqc0gAxsJKXXGGmYrzM/XbSJTG9wMu08LLs3WngY4dhnfAusDFrAOnPLgNMhCYCTZYXIiYBRaV0JBgID9RYHVPy/ARYe2Oqx/jXm7rNUP7ia2LUANopeTl2eMn4evEzzvolj8KFRpB7LbQ6sgrzpSOyR8AxpAc7ZOFtucTkPbi+fif+topkQFTiESGk3ecud1usX9A9cy8NfwarFEljc30s2RivC2i7Qa9D00fuuWnuzzMF+xa5+/8gtVlE7Hx7BmSmblojChCXh5sGtCx4BvcGd+579LJVGQC8VF1Gk9JTkzIXzKctz7hKd6Vr3DRPE118ZJV+KKY7EN8iwhIoERPP0jn/B+JgDpDuyegO2kbgqw5v6ipPSVg+hsbRZF51/NgQVnKpnVHXs2ofqbQShy5ihQqXEu0nudNcRV8579
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 23:23:59.9330
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b9ae688-d004-4290-71b6-08df3481616d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH01EPF000BE945.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9434

From: Dmitry Artemenko <dmitry.artemenko@amd.com>

[WHY]
amd_hotplug@basic emits a kernel WARN + Call Trace in
optc1_configure_crc / set_reg_field_values on DCN3.1.x.

[HOW]
Add the OTG_CRC1 data and window registers to the DCN3.1.4 OPTC
lists. The hardware supports CRC engine 1 but the mask list only
enrolled CRC0, so the CRC1 field masks resolved to 0 and tripped
the WARN. Tested on DCN 3.1.4: WARN count goes from 2 to 0.

Cc: Roman Li <roman.li@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org # 6.14+
Signed-off-by: Dmitry Artemenko <dmitry.artemenko@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../amd/display/dc/optc/dcn314/dcn314_optc.h   | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn314/dcn314_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn314/dcn314_optc.h
index 7b43c3ecd46b..25dedcfa8d48 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn314/dcn314_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn314/dcn314_optc.h
@@ -84,6 +84,12 @@
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

