Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.59
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794361511;
	b=XFQ0yfUb4ztGNTpfn5qc4p3oT4SyPslycB3fXd1V3X1g5C5/VZXyDQITQdBiGv2KnOzU
	 u+QPUTYoHa3KK/rbm02shp6DeIVBEuuc8Avo4rrbxVqoSZTjYviGA3P9szhQrfuAN3rxx
	 1Dj4O5D28oGQ7h8QwUAaPJu0bcRA0SREneFBn1O1/R/ov233ccjPcKsMLHMC1AY1eUN55
	 Jv413w0rtqIYoL5AJtmKKXDJl8aa0axIuGMMcV49FApKkMRuO8BfYZiuSvI8EZrL9TC3M
	 q3E+T48hnzI/zaxM17zN5EFLohoDZ3+hLXrnMaITc5BGsk2XV8D1+Yso6Yp6lA85swg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794361511;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	bh=Y61sRVXQA3pX/c6VMVdRIrSDRQAytX3ntVJ+XXO/q18=;
	b=TKGELyyGXwFrsk1KGWrmgd6sCTv+I+9IE0tXdo6IwZyPfuzOZX7KvLsQHHBmCD6iUgPm
	 QVF4+9r+avC9JEovztD2sNjeyh+U3R2Eul5UKxPkarEnxgJf44bBHCbCR3UuLgmV/2SvY
	 uDiDafrKrQ6jVPawO2Ey+9EN1m65acrjuAVfkecLgD2AjRrXOvWoVfVFVyoK2eLfy9CxM
	 QBhD+UI97RSjjhDAUHv64xRsssZNPKx408+0Z4FpKcQZb0yys18f7x6fGM+tv6RYj/rjp
	 hnu4It7dJWE2O/gZDhxrTB5sJRjcHSoveTLaPUlQXNpquftq0ARAiWAfQOdkvkMIdIA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=T+YahmS0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.59
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011059.outbound.protection.outlook.com [40.93.194.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B705606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 01:45:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B705606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=T+YahmS0
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M0HtccEOnCIrHUWFrinqaOZMzTELjL/2TuqOi4XBhyInstttBIS/NgkJHusIjNuqV7pssrRbFMxH6BlzsrlErYTVAe8IpDUZ33MTGszHu0cZyVoe6/2AOQnBdSXRO57fQ0D8JL6DKELqRt4bvDyBanDbw/CLz3ldF9QJ/Rf0drtZ+4YUKYUxMDOXuk80u0hIycITcQPLoHy4Mm2xxAlxNA8wacxSjiqSD7NhUbo+hzeOE0ycCu9nX50Cq0bWx5B1fHy/vcVdeboeXr1l60du7JsotyfAcQgxGjK+xnQ45ou/goQhDJlVdo3UPeSodAcjrETGjOhqKbUBe1K/xkn00w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y61sRVXQA3pX/c6VMVdRIrSDRQAytX3ntVJ+XXO/q18=;
 b=CigtduSlplOJO7CP7VfutbhwWfElV5cAsIToIDsTkC7MT7GctALp6bIW8IQJZKWMxtyJ/3OqY+kAousjpDsifwUBIxFSBJM4RYIh9WkaP6sMU8AsknWiSmskUFpmnZw7VU20b7efgsG/Nmcea2pDuYsiIdYDeoDqQAZ1CU6/5Y4usmgeduISS2zWWNPyrZthZcTADKj5qRr//euGTiEOeVSEZn9x1dwUpIxRQI1n/K/vykZHqY6IGnK7LgZvT9uUaIAwQurRocHBIBh1DhKkPv0Vdz+Yq2lW9CNQcsRg/2JlTmGUNuHJ9LOJapRxZo4HB2mN+4sWWscv03RIK//2tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y61sRVXQA3pX/c6VMVdRIrSDRQAytX3ntVJ+XXO/q18=;
 b=T+YahmS0lwjosOoUy52BzKCjsCeinfjHfthgKm2NajJvkBXs6gwabJnvJM37h+nNI+GOvRH2obvyiCYS+mhIhs88CHkBxkCM2nWUA+CfwYCtJpuXC/taBMcyLvsVH8bYMvJdB/GZjfzlzGF3R794mnDwyhEu4PMSAeRqN2E90+E=
Received: from MW4PR03CA0301.namprd03.prod.outlook.com (2603:10b6:303:dd::6)
 by MW4PR12MB5644.namprd12.prod.outlook.com (2603:10b6:303:189::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 01:45:04 +0000
Received: from EA8PEPF00000008.namprd05.prod.outlook.com
 (2603:10b6:303:dd:cafe::81) by MW4PR03CA0301.outlook.office365.com
 (2603:10b6:303:dd::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.16 via Frontend Transport; Wed,
 11 Nov 2026 01:45:04 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 EA8PEPF00000008.mail.protection.outlook.com (10.167.249.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 01:45:04 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:45:00 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:45:00 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 19:44:51 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
	Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
	<Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
	<alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
	<Chen-Yu.Chen@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, Alvin Lee
	<alvin.lee2@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, <stable@vger.kernel.org>, Wayne Lin
	<Wayne.Lin@amd.com>
Subject: [PATCH 64/74] drm/amd/display: Report QoS latency bounds and request
Date: Wed, 11 Nov 2026 09:29:10 +0800
Message-ID: <20261111014100.3596072-65-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111014100.3596072-1-Wayne.Lin@amd.com>
References: <20261111014100.3596072-1-Wayne.Lin@amd.com>
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
X-MS-TrafficTypeDiagnostic: EA8PEPF00000008:EE_|MW4PR12MB5644:EE_
X-MS-Office365-Filtering-Correlation-Id: 9920a13c-1c46-4e78-55b0-08df3f95684c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|23010399003|1800799024|30052699003|36860700016|261009223027099003|10067099003|261022115727099003|3023799007|261028144727099003|261102123227099003|261026135527099003|261026140227099003|261026121527099003|261026130827099003|261021133027099003|261021135927099003|261022113327099003|261021123027099003|261021121427099003|261022075727099003|261021130227099003|261022105027099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	dp3Ez/70JNyhQ8x8t8KRss3a6Fxa7+lmF7Wsq+t+JELyAW93VKiEv9tMOFNLOKCm3q8/Y1VoT3JW/8YBWVDLpho8yb3LkUuIIbfshsKmRkj9EJLHeGGNEH8o/5rtcXoQ2FOCuCWimoV/CMti0ktV+6CP9o1lU+swWJLHcHWf8Y51H64cdZH7HooBeKcknBoa/b5DIDgAVRS9O3vJqCMZGT/Kq06wCjyPU3WUJqp6bnH0vtj9fNKLOXFdIiA/ROiJfC9CWnSS9sFAdOwzxWzWgl99mAbNIBIZTReAPU+FLN0tEIlumMQS9VZPvc3Cq2uWDC7koB1zpM6Mn/tJ8z8/ge+iSL1+mSAadWIwfKb9qjGNVONj9L0NRb9bYv2kJHRAptnwWe3wj+puhJDZc3AIQhZLV/SuabUGGZfFzO+m2Cr6ZKDsoYG9tQRCwEiYPqi/a9Cr06VCZVNPoboEOjY3LvS4tNVm1B2QsQidBne9WRcGSaLNk9z3EZoUFCUpGzfAVDLpCHk/pn0N43RpvlAJT+K7v4+mWCC9kKkTlPm3WpMUdjpZnxjemwa7TIMUGMNVc0hi86FOzRTLpv1t4Osed+lVRd2VRggKsXdAiSKaFZQLs8VmoWKWueztCrvrNDneEa5AL1s6iDwGNEHJ2vZ0ttyYRz3wzKi/ADJvmGAnMNgsj9QiDnSJsp5169fO5OEoDvEHcIBIzOg6ja6i6Ci3sQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(23010399003)(1800799024)(30052699003)(36860700016)(261009223027099003)(10067099003)(261022115727099003)(3023799007)(261028144727099003)(261102123227099003)(261026135527099003)(261026140227099003)(261026121527099003)(261026130827099003)(261021133027099003)(261021135927099003)(261022113327099003)(261021123027099003)(261021121427099003)(261022075727099003)(261021130227099003)(261022105027099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QEt1T5ud0hoWy2rREWUcRYeXZs1MOReZ144GI4eoMNnLtAO6WgDfafi4unv8P8SCqwT4lcApC2c2oP/azRRtfbu/uE2PvxPAYM24wXophZxe6okD+PKQWPsq55mZVvmUZHnw1EQEOFog0QVD7c6NuhBIq/IUPsBIv1NYL4FUtTUatT/HoDetbx+/NogjHh5Qxa9q5e8F0pk/lkPij3V1bgPVC+9HDtmvBOYMp3dWvx59RB5cQEGYT6OJMDrxSU5Bz4Tue5sUvgcOIF5FibI78DsfsAG+0qLCEPzk5HuJ/o1yzlWhW787B/gUp1eU3DCI01jhf9J7piTx/QcDFDd5rzlXkRa2xs1byZzF321Ga5M5EI5hAt8Xa4xQMELueCCZW1rYlA3kIzvW0mM1dB7X8+TxmdpCX3v0aszdrXotGtgOc06zxA6CZQcx1No9z2pN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 01:45:04.1304
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9920a13c-1c46-4e78-55b0-08df3f95684c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	EA8PEPF00000008.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5644

From: Wenjing Liu <wenjing.liu@amd.com>

[Why]
The requested QoS values returned by the QoS query read zero. The
latency upper bounds and the calculated average bandwidth were never
filled, and clearing the memory bandwidth override zeroed the
bandwidth request instead of restoring the request of the committed
mode.

[How]
Fill the avg and max nominal latency upper bounds from the DML
qos_bound, converting from microseconds to nanoseconds. Fill the
average active bandwidth from the DML informative qos output,
converting from MBps to KBps. Report these from the committed state
in dc_get_qos_info(). Restore the bandwidth lower bounds from the
committed state when the override is cleared.

Cc: Alvin Lee <alvin.lee2@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
---
 .../drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c  |  7 +++++--
 drivers/gpu/drm/amd/display/dc/core/dc.c              |  8 +++++---
 .../dml21_wrapper/dml21_translation_helper.c          | 11 +++++++++++
 3 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c
index c5d56757eafd..f801f3337e5d 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c
@@ -1619,8 +1619,11 @@ static unsigned int dcn60_override_memory_bandwidth_request(
 	memcpy(&new_clocks, &clk_mgr_base->clks, sizeof(struct dc_clocks));
 
 	if (bw_kbps == 0) {
-		new_clocks.utm_nominal_bandwidth_lb_KBps = 0;
-		new_clocks.utm_urgent_bandwidth_lb_KBps  = 0;
+		/* Clearing the override restores the request of the committed mode. */
+		new_clocks.utm_nominal_bandwidth_lb_KBps =
+				dc->current_state->bw_ctx.bw.dcn.clk.utm_nominal_bandwidth_lb_KBps;
+		new_clocks.utm_urgent_bandwidth_lb_KBps =
+				dc->current_state->bw_ctx.bw.dcn.clk.utm_urgent_bandwidth_lb_KBps;
 	} else {
 		max_bw_kbps    = dcn60_get_max_active_utm_bandwidth_kbps(clk_mgr_base);
 		capped_bw_kbps = (bw_kbps > max_bw_kbps) ? max_bw_kbps : bw_kbps;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 656a941b1ba0..8a02bcbb9649 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -8105,12 +8105,14 @@ bool dc_get_qos_info(struct dc *dc, struct dc_qos_info *info)
 	if (dc->clk_mgr && dc->clk_mgr->funcs->get_requested_memory_qos) {
 		dc->clk_mgr->funcs->get_requested_memory_qos(dc->clk_mgr, &requested);
 		info->qos_bandwidth_lb_in_mbps    = requested.bandwidth_lb_in_mbps;
-		info->calculated_avg_bw_in_mbps   = requested.calculated_avg_bw_in_mbps;
-		info->qos_max_latency_ub_in_ns    = requested.max_latency_ub_in_ns;
-		info->qos_avg_latency_ub_in_ns    = requested.avg_latency_ub_in_ns;
 		info->qos_max_bw_budget_in_mbps   = requested.max_bw_budget_in_mbps;
 	}
 
+	/* The clk_mgr does not track these, so report the ones of the committed state. */
+	info->calculated_avg_bw_in_mbps = clk->required_avg_active_bandwidth_KBps / 1000;
+	info->qos_max_latency_ub_in_ns = clk->utm_nominal_max_latency_ub_ns;
+	info->qos_avg_latency_ub_in_ns = clk->utm_nominal_avg_latency_ub_ns;
+
 	return true;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml21_wrapper/dml21_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml21_wrapper/dml21_translation_helper.c
index a7d6ff59870a..31292a70a84e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml21_wrapper/dml21_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml21_wrapper/dml21_translation_helper.c
@@ -1036,6 +1036,14 @@ void dml21_copy_clocks_to_dc_state(struct dml2_context *in_ctx, struct dc_state
 	context->bw_ctx.bw.dcn.clk.utm_latency_ub_index = 0; /* TODO - derive from qos model */
 	context->bw_ctx.bw.dcn.clk.utm_nominal_bandwidth_lb_KBps = (unsigned int) in_ctx->v21.mode_programming.programming->qos_bound.bandwidth_lb.dcn5.non_urgent_bandwidth_kbps;
 	context->bw_ctx.bw.dcn.clk.utm_urgent_bandwidth_lb_KBps = (unsigned int) in_ctx->v21.mode_programming.programming->qos_bound.bandwidth_lb.dcn5.urgent_bandwidth_kbps;
+	/* DML latency upper bounds are in microseconds, the dc clocks fields are in nanoseconds. */
+	context->bw_ctx.bw.dcn.clk.utm_nominal_avg_latency_ub_ns = (unsigned int)(
+			in_ctx->v21.mode_programming.programming->qos_bound.latency_ub.dcn5.avg_req_latency_non_urg * 1000);
+	context->bw_ctx.bw.dcn.clk.utm_nominal_max_latency_ub_ns = (unsigned int)(
+			in_ctx->v21.mode_programming.programming->qos_bound.latency_ub.dcn5.max_req_latency_non_urg * 1000);
+	/* The average bandwidth DML calculated for the active state, converted from MBps to KBps. */
+	context->bw_ctx.bw.dcn.clk.required_avg_active_bandwidth_KBps = (unsigned int)(
+			in_ctx->v21.mode_programming.programming->informative.qos.avg_bw_required.sys_active.sdp_bw_mbps * 1000);
 	context->bw_ctx.bw.dcn.clk.stutter_efficiency.base_efficiency = (uint8_t)in_ctx->v21.mode_programming.programming->stutter.base_percent_efficiency;
 	context->bw_ctx.bw.dcn.clk.stutter_efficiency.low_power_efficiency = (uint8_t)in_ctx->v21.mode_programming.programming->stutter.low_power_percent_efficiency;
 	context->bw_ctx.bw.dcn.clk.stutter_efficiency.z8_stutter_efficiency = (uint8_t)in_ctx->v21.mode_programming.programming->informative.power_management.z8.stutter_efficiency;
@@ -1177,6 +1185,9 @@ void dml21_init_min_clocks_for_dc_state(struct dml2_context *in_ctx, struct dc_s
 	min_clocks->utm_latency_ub_index = 0; /* TODO - derive from qos model */
 	min_clocks->utm_nominal_bandwidth_lb_KBps = 0;
 	min_clocks->utm_urgent_bandwidth_lb_KBps = 0;
+	min_clocks->utm_nominal_max_latency_ub_ns = 0;
+	min_clocks->utm_nominal_avg_latency_ub_ns = 0;
+	min_clocks->required_avg_active_bandwidth_KBps = 0;
 	min_clocks->stutter_efficiency.base_efficiency = 1;
 	min_clocks->stutter_efficiency.low_power_efficiency = 1;
 	min_clocks->stutter_efficiency.z8_stutter_efficiency = 1;
-- 
2.43.0

