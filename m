Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794935559;
	b=0GLeFskX4jV7Zt56oKkMuEsgnce1IUX4b1I/X2CZG/9GuemCDnUgqkkkopJj9EQxr1sw
	 sIMnkH7TFVfKq9YjIXE9z8ereKJdEN3C+1vU+1YLAhWED4id2GpJ5Ugf9emssIH2GFcWS
	 qDrhQUr7cCuspjruXcVv8uKhUj+6kS19Bf0t2wgdnb8PQkOtJ44t8B/1ajdmWI8vF85vZ
	 lRFoNBHF8XTpKWV58AcMkgqfN5J7Qc+mqqmncGBnziZBLmM3DtAKZ3u7FPjleQtvvnp08
	 LYciqyGsZZeqkg1mU4nXzmcjR944a9mL04pyIVdcrnKGei9mc3h/x7hp1PwAu1pOyRg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794935559;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	bh=4rTCGU7Iuw/qVjkTnUUbBqLtOzWS2WMgpMDRtYNlsHs=;
	b=2NthlPV4pi1rqlWHFT+5Z5cxq+MXAcqlHBlh3AdzVQkkTjj1GNybrgJFbo62o0c1noX+
	 js4jqrbvR9/F+/TfNh1FY84e4Sa+z784EBiHAC36gr5NWiEy7YTXxKiPX2zguhp+gLgzZ
	 o4DXTrVJEHlKNwmuTtSqKjx80HYDKAXZAOG4ME0440LIukgSs7H5VCvPWK8rjAhWBGpEQ
	 ilJxV0yGPQk4/Y5ZRmlbhzkfIhM2qbZUFsLGXd4t26UmYP5rP8Svb1YJuVjZK+WoI08kR
	 JF3QgiMsrfX8fNcZy4oToMDkkK5PB18r2zG1UTjTO8pJWnxNZKyfPeJNgCeT0MBXEDg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=rd7qzgXu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.32
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012032.outbound.protection.outlook.com [52.101.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24650606A32A
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 17:12:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24650606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=rd7qzgXu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qs9cRj+C2K617NlDrzzRrraAUnUE816C2Zmg3x/vAIActX0MuAi0H+BymvV0CoqI5pDQR0cUfdoIGlU8cfXtbQRu0At6wjaOpRrGxDXLEwxgQX4kQ1CgoYf3K2DcmveF7zOwQQznFr7sImD0KIRZy+jLzviXRpuf6/IkVP8bKsorKZljCrxXVBMc0WJlDTpUFgMOxc6aY3El56bLYaeH1Q04AHVp7JGsyOTpQrfjcceVnxTvlFc+ufY1ut3lZj4Kb+HbsWRRtH+QsRlH+Swlzh2+p4aV9xXNj68nz4Jo38I8tfw0uFUgUH8symR9Q3aQWigBdTS7fRoYRI4VxLB9Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4rTCGU7Iuw/qVjkTnUUbBqLtOzWS2WMgpMDRtYNlsHs=;
 b=jkX2FyhcNfgvVAg39LzadZX7+IYPqSLHdOF2HUjKJypBqO2sUINihku2IzDwXw2pQcwWPFPRqmBPduf/P4Ax+EvnuhbeXV7EdZXUXFV3hQaNna1ovaUp9JImL4Uz5blkGNUDrK1lLK2OH2WuEbAnkpJXcpfoDXll17T6knvvvZXMNjUgxpYJIDi3Mtk4xld1kofe0tUXmF0iv9i42s41LWEGGipSNUwJseKvgLT1JXY8a53qUgzRdVPYFtlsfvQ6nzgFHK3VCPAHlwBWIxOeJy1Stw2vWmFv/r7w2NJ9TKwDYujDLGEH7+N12r6HgmYWQ/8LgbGC53M/7uZTHltMfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4rTCGU7Iuw/qVjkTnUUbBqLtOzWS2WMgpMDRtYNlsHs=;
 b=rd7qzgXuplXUZ4dNg6PqW1+sPKwEIsUWrYJIb4FtoHSa6+3cJVjZskuzeC+E2sbZ4YvqmTCwyQ9D0x3kPZRvXkho3uw2fNBsmazG9mSAodNx6wiYuTEmzUdtM5MnBzEsPXV3zUt8+HVvwmrs/59TBnVtHVjKAGKk2jgnX6Hhnac=
Received: from CY5PR13CA0010.namprd13.prod.outlook.com (2603:10b6:930::12) by
 DM3PR12MB9352.namprd12.prod.outlook.com (2603:10b6:0:4a::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.13; Tue, 17 Nov 2026 17:12:35 +0000
Received: from PH3PEPF0005961A.namprd05.prod.outlook.com
 (2603:10b6:930:0:cafe::73) by CY5PR13CA0010.outlook.office365.com
 (2603:10b6:930::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.6 via Frontend Transport; Tue, 17
 Nov 2026 17:12:35 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 PH3PEPF0005961A.mail.protection.outlook.com (10.167.243.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 17:12:34 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 11:12:34 -0600
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Tue, 17 Nov 2026 11:12:24 -0600
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
	Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
	<Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
	<alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
	<Chen-Yu.Chen@amd.com>, Zhikai Zhai <zhikai.zhai@amd.com>, Wenjing Liu
	<wenjing.liu@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, <stable@vger.kernel.org>, James Lin
	<pinglei.lin@amd.com>
Subject: [PATCH 03/33] drm/amd/display: Power up eDP when detect link
Date: Tue, 17 Nov 2026 05:50:40 +0800
Message-ID: <20261116215641.2800595-4-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116215641.2800595-1-PingLei.Lin@amd.com>
References: <20261116215641.2800595-1-PingLei.Lin@amd.com>
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
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PEPF0005961A:EE_|DM3PR12MB9352:EE_
X-MS-Office365-Filtering-Correlation-Id: 7067a925-f104-474b-8428-08df44cdf948
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|10067099003|11063799006|56012099006|261026140227099003|261021121427099003|261021123027099003|261022105027099003|261028144727099003|261102123227099003|261009223027099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	tu6YGFEdN3kNSEVMzzQCiuF6weSj/04lXtaBQmzX6mCKontpfWUgYtwbhjdQ7ZavaIczznhAXOCCE0iz/f21ja8LZUltUJ5Z3Rs4IpgSvMqfop9i13eeYf2Jc9vRjY+vSHEUftqweq3ODfUWZ4kKcsXLT+ELmhYUN8Oh56Sv/5rfQfys1PTOcJDCmqUFYb+5nJ2F7mWPEkC1RTGTVptaUA7LEEGzbgNxW3X63/uGMbM5Bn6u/s0nZO1z9WV0x9si9UY9Ds3lAn2JV4oSOEvSQfufSemXrf18g8aQzaNQjtpn/KMjubFDqQTM7JnlbNEh4YeQ1YJe1TYr6xMX7YebIhHwtB8XKq19/noEs+ISTl0eIfotJ3bzPmfAhzawF7h8pvIgSFfC3J1NOwf5OxjZSz1KEFHrwhoOhUNOHadlGs8TB27CpGB4p2/anFVwBplMNJdqf6h/L1p5lHeoSICeqzomreohz4iMz6NT8wWkWpwN5WD6dc1MLYzbOCsYQMyXsvDdJbJ7qf+TZEGagyQx5sKvsHW7PS8982/4S1im0P7F5SPQPeDLNkYql/nfBpaHHXebjmEN7sIgwiM6hHny/vXBNt7Ki4JnJY7KcBpmEPSW+L2f0X+LJIyuTvDgU4E9ZiMPVKO+HlDv82XpyhyWHYJk+ZlOQ2KOEWccC927fvG9P+8BTjBKND5vK7PfxGCLPi0AYEb/Q3F1CD7nHIyqfw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(10067099003)(11063799006)(56012099006)(261026140227099003)(261021121427099003)(261021123027099003)(261022105027099003)(261028144727099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WpeTYFrZhMGEsagRaKTnFvVwg2TsbYKdKWp+aAjQLaXf1BJSfO7GpcrafgSUwgP8SGXPGQGZqhD95Xs+CFkZas2kC73z2anKRs+RQKWLip18J5iXW06gDnnYDr/IUzmZquTzAII07Wg1U8Mt8/c2HDn1ZAEgHJRuYyXao3SGVNC/OPqYc837qd3YyOw1CrbTzEung0hLFBcxWd4wjlSDGLTvu92s3pSJznPD/EmZ/sfCTq/cn/sY8JgnidJtKbUnKKn73AB9nrl9iW1giayxSM0hSYy5UXRAE/oKHI7khYpTkTyP6dOwg5i+impIpg7LhbX5Wu5iAqtBqVKQ0traYtpPDXyC/jC6yjCuTZB89YWu+wXxHI1tE1xD9mtEp4X4bzxoCpVIzJBPyxuWOLrh/dtaEX5A9Htb/0w4RX9VXpEhXThtGT31heaaH4ZDDzho
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 17:12:34.9835
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7067a925-f104-474b-8428-08df44cdf948
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	PH3PEPF0005961A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9352

From: Zhikai Zhai <zhikai.zhai@amd.com>

[WHY]
Previously we would start the asynchronous detection
timer after resuming from S0i3, the sequence for
eDP power up when resume from S0i3 is:
1. eDP power up when link enable
2. Timer trigger async detect for eDP
3. The AUPI could read successfully in display detect
Currently
1. eDP detection runs from the display detect path
2. AUPI read fail as HPD low when eDP link detect
3. Link enable to power up eDP

[HOW]
Power up eDP when detect link for aux read.

Cc: Wenjing Liu <wenjing.liu@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Zhikai Zhai <zhikai.zhai@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 .../gpu/drm/amd/display/dc/link/link_detection.c  | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
index 9bd24b3e4291..dae9e6840272 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -1153,11 +1153,16 @@ static bool detect_link_and_local_sink(struct dc_link *link,
 		(!link->dc->config.allow_edp_hotplug_detection)) &&
 		link->local_sink) {
 		// need to re-write OUI and brightness in resume case
-		if (link->connector_signal == SIGNAL_TYPE_EDP &&
-			(link->dpcd_sink_ext_caps.bits.oled == 1)) {
-			dpcd_set_source_specific_data(link);
-			msleep(post_oui_delay);
-			set_default_brightness_aux(link);
+		if (link->connector_signal == SIGNAL_TYPE_EDP) {
+			if (!link->dc->config.edp_no_power_sequencing)
+				link->dc->hwss.edp_power_control(link, true);
+			link->dc->hwss.edp_wait_for_hpd_ready(link, true);
+
+			if (link->dpcd_sink_ext_caps.bits.oled == 1) {
+				dpcd_set_source_specific_data(link);
+				msleep(post_oui_delay);
+				set_default_brightness_aux(link);
+			}
 		}
 
 		return true;
-- 
2.43.0

