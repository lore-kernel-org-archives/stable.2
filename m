Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.1
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793200286;
	b=XAkjyjGORn/GWkySClC2Omn6FL5rRltn0CE0GXyHli+htnr/GMhrX/NRCnhj05AHln8g
	 yKSrUToSqO8L0RSlWk45ow+kCRGoGiXRIZzOwddY+k/vrOLLp5YhaiA0tk/7wiZKLLrW+
	 QSXrZlxuBDidSbRTFT7MY4CybXrf1R7+EDYq0FS4GXjfxy8Dpr2R2C1kXHu98eFKiy5jV
	 7u0tvtbIdLrlP4UltZqmPbGmK9Yi037ZcUi6lomr/UjlI+0iUUcl106Jsv1RbY1eA2rAD
	 r5lv54nda8LYfOHAnqGCHMfkXEf8cuU2RQESTEyh4mfc/xyF1dSEfKlcvVfENsSbn6w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793200286;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:
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
	bh=0gSU2XiTr8/7nuHu2uATFBSh8VJYLYM1YilIIwTEzLE=;
	b=l0HwFuxkRdimj9eve1z0NJXlPAJ8IcbypiZMaGkIEYohv7tUo1J9C4VTj3KX/OvSOi1Y
	 nvXjupmwH9i87U2FF8ITcK8wZN8/Gzpok22i+svkbT3Rl+svF16hXHYds8ik+NGayTi6K
	 HDr2jJlNAou+pmmak4sQq9k1QeLwUMragQN9i2geHsg0N+SZ0AgcQXzDkGu4jNdHu1kKh
	 /4Ed8fQf/6/yltXJD9OSE9peZSxMjabwm+VvtneGIpDj/NKpoDtu33C4ghnfcuHK9c0QH
	 ncy7tn0G/TCRfv8Ykj68W+zfPf8zbrp1rhXANIGzNgoKF/NSg6myK53+MJOYc6b5vxQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=eY8XpGB9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.1
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013001.outbound.protection.outlook.com [40.93.196.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60971606A31A
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 15:11:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60971606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=eY8XpGB9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TxYc5pOlfFNAJiXP0Mii/1K2LQM5iQ8R99rLnjgzhljvHhXfYO4VEMEFAzQYkZdjed5YPAoO/awXsz3+y30Ls1MWXoEPKlxUeMZNaiydWO5R3c0rzpBN2gDtGT6BNl2qrlZ7PNzD/dHxEE0onHQJINLdlF41N9CwTgeTKCdhbtxLymMIOsSruamM7iS1N0gwmtfhokhfq+GGnwhFQfcRP3897VLvUtzl+SwrBQQmnEQVEW/I9XdaZzOU+7nWLsP1elY2WQ5D3LPZAHnNwsTgiUmpbfQZoDGNUm8jeiAHrn3SMbmZrYjPRfcepWwSkR1Y6IGxYiVLG9GYyIytsM67XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0gSU2XiTr8/7nuHu2uATFBSh8VJYLYM1YilIIwTEzLE=;
 b=HL52brg/fsFRTdgkO81lAfyR2vzMz425L0b2ShSRLl4CXqCUsfOU00c/3gihSjdfIGsjbCWEpDi+scfAZSfR/TgwWskQHck+gGgM4TNEfONnhg28YT1qNwqVZK+is3Sy1P/KPtwSJDnIwv7GW2eLDq4+cmiP5YllqLpd+iTRl1jvsq3EAr+tMIydAcZOZQoXYtW80uFmXvFRVLJU0ScoNvRkSFNM5TdPJM5rarUHgdQWALU7AeKNhSvzdBUOl5TglWxhQe/0OPLIEiCIL3072xToBFepz+Ax3AVqkHzi6mHKqLH7F7pMMKEVKkT0e4nhwSuqVxGRAa5mWF4Zcgs1wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0gSU2XiTr8/7nuHu2uATFBSh8VJYLYM1YilIIwTEzLE=;
 b=eY8XpGB97lfMbbXnmHKSbJnlgRq8QK8qWi19flOYNnskt5AzGIWZicay9kBAnYjyXNpoZ1PvYTO54EE1LRETE7krXo6mMENDu/giXYX2XFct/Hi3tQh0GJ7H8ky9NBh0pRhqOJoxWa6weqJmSeUNQA5kkHzVbrihxuU5AK+Hzls=
Received: from DS7PR03CA0268.namprd03.prod.outlook.com (2603:10b6:5:3b3::33)
 by DS7PR12MB5838.namprd12.prod.outlook.com (2603:10b6:8:79::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 15:11:19 +0000
Received: from DM3PEPF000265C2.namprd03.prod.outlook.com
 (2603:10b6:5:3b3:cafe::8a) by DS7PR03CA0268.outlook.office365.com
 (2603:10b6:5:3b3::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Wed,
 28 Oct 2026 15:11:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DM3PEPF000265C2.mail.protection.outlook.com (10.167.23.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Wed, 28 Oct 2026 15:11:18 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 28 Oct
 2026 10:11:18 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 28 Oct
 2026 10:11:18 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 28 Oct 2026 10:11:17 -0500
From: <ivan.lipski@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Alex
 Hung <alex.hung@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, "Linlin Yang"
	<yanglinlin@kylinos.cn>, Mario Limonciello <mario.limonciello@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>, <stable@vger.kernel.org>, "Dillon
 Varone" <dillon.varone@amd.com>
Subject: [PATCH] drm/amd/display: Fix __udivdi3 link error in DCN6 DML2
Date: Wed, 28 Oct 2026 11:11:11 -0400
Message-ID: <20261028151111.1888807-1-ivan.lipski@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: DM3PEPF000265C2:EE_|DS7PR12MB5838:EE_
X-MS-Office365-Filtering-Correlation-Id: 6acf663b-7068-461f-a5af-08df3505b816
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|36860700016|82310400026|261026140227099003|261021123027099003|56012099006|11063799006|261009223027099003|261022105027099003|10067099003|261021121427099003|261026121527099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	Hr3I8rqbsFuKyiVrxgYO4+GmXzDYiHviV1AdaActMDdz3LHADd6Tq8uEgJUYKBFtiovnR1HnLho1PllXjTSMM2Wt707OlmVtuN83CtI0qcXeOY8CJqnAFmdB9tZ3kN0PRzgdGFbSUZpwEOmTaoVQisLIp98njS3QfyVs5GRvDlQ4/KiVvxubbUtGtb3+W/X7PVgmcRnCVDBASprhS8tCzXt932EKUro9TAHrfGcc5SLazN0C3H+2AzfL7soqDqMCwZkHC+VBEP32gL/2CmW3br1gg0fR5GTec2aJbd1cJomL9bwc+zhl+4cyS1fWGbvExl8+2FNdv//OQRIurNcU6PHnz76WBoYoAofVFANy7Z0SMEidu8KOMHGXjoNv5ZqtsnMz8m5lYjjvEUPHixtkl/jwf3hBQoR53jEf+5WqFPqRofgQBdCCBo1LrZGbwfE1xI1Yd8xKVWNEYLIXS1IZyOcHmiNWda4/tMvMnv8BDzGqhMyGM30XR5QdHW4gMpNKnB1LwFbdIYcwd2DFQi0xlGH6MxuZnBUagSEVX/0+AVSDwUuRUCDwN2Y902hxDh0c8/ajgRt9KzrUvuEgPF4zoW8gjUfske7y8RIZSv5bt4uruGkw2UJO9sLG9lZDbObAadKu/bdzuQz641z+lvniPdJEBz6k9JpvAbGJQa46TEfzI64+8GtlKeFKfKnr56nGQ0BeUzLeyDY2OMIF92tbVw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(36860700016)(82310400026)(261026140227099003)(261021123027099003)(56012099006)(11063799006)(261009223027099003)(261022105027099003)(10067099003)(261021121427099003)(261026121527099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3ah3RPjleZCo6LPwIy6wuRolshB5wj0jK80fXmJlNF4b+NGSfgMCnz7SEEynHAKn6WzcWDuleRBuet/gyqt2poZXew4x5M8SA9l9zOKVIP+r7kntWT0BXYzhHGa6iD+v6WcjWKPh7HLhcyh14Vss7UlcF4RjRyt9FIOFaiE8nWFUHVD2kiNrKE5qwEoNXF8XPVQL+2Y5KAq+mk7VB1r5LDSwm4NXWhn1F4AYkhx+XPreEdDRmAIH7FJoL23E6OKtO+xTuafgje/qlPdOIdA5/LKMAK1kMVv/JcHgEQ5qrf+X7jxcbuOV0qKFbhr9aeN+WpPFnmPkiNHmYp0W/SGMy7F8EHdvwZ7LJqMNv22WZfpwqEby5mII5yoXAmFtRUBHCWCmQFhK9KaqNEs6khp3XX4tKknw6dN8iANgj+k1moC4rzY2sxRBVsRXw6kXrGp5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 15:11:18.8698
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6acf663b-7068-461f-a5af-08df3505b816
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM3PEPF000265C2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5838

From: Ivan Lipski <ivan.lipski@amd.com>

[Why&How]
dchub_v2_get_sop_total_available_bandwidth_KBps() and
dchub_v2_is_qos_bandwidth_supported_by_sop() divide 64-bit integers
by 100. On 32-bit builds this emits a call to __udivdi3, which the
kernel does not link.

Use double-cast division instead.

Fixes: 04d9a88decbc ("drm/amd/display: Add new sources for DCN6")

Cc: Linlin Yang <yanglinlin@kylinos.cn>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org

Cc: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../bounding_boxes/utm_qos_model_dchub_v2.h   | 32 +++++++++----------
 .../bounding_boxes/utm_qos_model_dchub_v3.h   |  2 +-
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/utm_qos_model_dchub_v2.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/utm_qos_model_dchub_v2.h
index ebca5ddda2848..32049c17c0802 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/utm_qos_model_dchub_v2.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/utm_qos_model_dchub_v2.h
@@ -58,27 +58,27 @@ static inline void dchub_v2_get_sop_total_available_bandwidth_KBps(
 {
 	const struct utm_soc_operating_point *sop = &model->sops[sop_index];
 	const struct utm_qos_model_socbb *socbb = &model->socbb;
-	uint64_t dram_available_bandwidth_KBps_nominal;
-	uint64_t fabric_available_bandwidth_KBps_nominal;
-	uint64_t dram_available_bandwidth_KBps_urgent;
-	uint64_t fabric_available_bandwidth_KBps_urgent;
+	double dram_available_bandwidth_KBps_nominal;
+	double fabric_available_bandwidth_KBps_nominal;
+	double dram_available_bandwidth_KBps_urgent;
+	double fabric_available_bandwidth_KBps_urgent;
 
-	dram_available_bandwidth_KBps_nominal = (uint64_t) sop->uclk_khz
+	dram_available_bandwidth_KBps_nominal = (double) sop->uclk_khz
 			* socbb->dram_channel_count
 			* socbb->dram_channel_width_bytes
 			* socbb->dram_transactions_per_clock
-			* socbb->dram_derate_percent_nominal / 100;
-	dram_available_bandwidth_KBps_urgent = (uint64_t) sop->uclk_khz
+			* socbb->dram_derate_percent_nominal / 100.0;
+	dram_available_bandwidth_KBps_urgent = (double) sop->uclk_khz
 			* socbb->dram_channel_count
 			* socbb->dram_channel_width_bytes
 			* socbb->dram_transactions_per_clock
-			* socbb->dram_derate_percent_urgent / 100;
-	fabric_available_bandwidth_KBps_nominal = (uint64_t) sop->fclk_khz
+			* socbb->dram_derate_percent_urgent / 100.0;
+	fabric_available_bandwidth_KBps_nominal = (double) sop->fclk_khz
 			* socbb->fabric_datapath_to_dcn_data_return_bytes
-			* socbb->fabric_derate_percent_nominal / 100;
-	fabric_available_bandwidth_KBps_urgent = (uint64_t) sop->fclk_khz
+			* socbb->fabric_derate_percent_nominal / 100.0;
+	fabric_available_bandwidth_KBps_urgent = (double) sop->fclk_khz
 			* socbb->fabric_datapath_to_dcn_data_return_bytes
-			* socbb->fabric_derate_percent_urgent / 100;
+			* socbb->fabric_derate_percent_urgent / 100.0;
 
 	total_available_bandwidth->nominal_bandwidth_KBps =
 			dram_available_bandwidth_KBps_nominal < fabric_available_bandwidth_KBps_nominal ?
@@ -99,8 +99,8 @@ static inline bool dchub_v2_is_qos_bandwidth_supported_by_sop(
 {
 	struct utm_qos_model_dchub_memory_path_bandwidth_v2 available_bandwidth = {0};
 	const struct utm_qos_model_dchub_v2 *dchub = model->dchub_v2;
-	uint64_t nominal_available_bandwidth_KBps;
-	uint64_t urgent_available_bandwidth_KBps;
+	double nominal_available_bandwidth_KBps;
+	double urgent_available_bandwidth_KBps;
 
 	if (nominal_utm_budget_percent > dchub->max_nominal_utm_budget_percent ||
 			nominal_utm_budget_percent < dchub->min_nominal_utm_budget_percent ||
@@ -112,9 +112,9 @@ static inline bool dchub_v2_is_qos_bandwidth_supported_by_sop(
 	nominal_available_bandwidth_KBps = available_bandwidth.nominal_bandwidth_KBps;
 	urgent_available_bandwidth_KBps = available_bandwidth.urgent_bandwidth_KBps;
 
-	if ((nominal_available_bandwidth_KBps * nominal_utm_budget_percent / 100) < qos_bandwidth->nominal_bandwidth_KBps)
+	if ((nominal_available_bandwidth_KBps * nominal_utm_budget_percent / 100.0) < qos_bandwidth->nominal_bandwidth_KBps)
 		return false;
-	else if ((urgent_available_bandwidth_KBps * urgent_utm_budget_percent / 100) < qos_bandwidth->urgent_bandwidth_KBps)
+	else if ((urgent_available_bandwidth_KBps * urgent_utm_budget_percent / 100.0) < qos_bandwidth->urgent_bandwidth_KBps)
 		return false;
 	else
 		return true;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/utm_qos_model_dchub_v3.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/utm_qos_model_dchub_v3.h
index 9390cad316914..fef7b1dc3060b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/utm_qos_model_dchub_v3.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/utm_qos_model_dchub_v3.h
@@ -50,4 +50,4 @@ struct utm_qos_model_dchub_v3 {
 		sops[UTM_QOS_MODEL_V3_MAX_LOAD_LEVEL_COUNT][UTM_QOS_MODEL_V3_MAX_SOP_COUNT];
 };
 
-#endif /* #ifndef UTM_QOS_MODEL_DCHUB_V3_H */
\ No newline at end of file
+#endif /* #ifndef UTM_QOS_MODEL_DCHUB_V3_H */
-- 
2.43.0

