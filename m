Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.24
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794361527;
	b=nWPA/sVqiiQay4iBMsA2xkvzK27yL4P8z2shpdBExRNGQgLor4znE1GU+iEPXxLGT9Oz
	 o1Dk0zh4BeYNaj5nLNAmZpqsXulkmpgRQpqg2dNE/iow5B7MOgUSfFioMUXa24Ce0IEWK
	 liKxbnIG1SXji9meSNOgg1chqHoIG9QrNvx9wxqWqFbZbwUEPHoylngLfBGEKt6BoS2s4
	 RwOOGgp3yQH57SgTkOw/jjl4g+4Fm9yOWNy+iPVz0aZr2B/1WNLX33eMrngWZbT6r5ygZ
	 C41YR8PUKLOwf8LE+H84Cvj9H90DhjaJeWSr7jOghnbFWdk92TCjJVBJJxBNmlJURyQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794361527;
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
	bh=tHeOvtNM3OPhAMkH5MbqWd9Kp7NHN8iCKPCZrdEFssg=;
	b=cROcXXoXHJU7/0X6l6aUG+Wag0DD+ZIufdjEPGUbQNi6XHhAP5hHoUpz0ZkxZi3x6Nel
	 Tb5UYtqVqnslGUpzQdSw78c+wp1RMUHxBBqXcjKYmQNAH7SgCQrTX01aBF5WgzJ23zv0o
	 8EWUt7SEELZohM5gAX8AKi+zVYnOlpTU67eni07sKw8lY0TJxLnxJLgb1MEIverAq07L1
	 z+clMzgwReD9a6eeAVyOXHcBKQvo6hMTsUF47MMXFn81Os2K2s5m9zy/7jGOU/CiOb30g
	 FxG0neX3/UM+SE1rC+riMvmEy0omAhIRSxr0he2B1VWzyMYIw2CE6vR7Q7Z9s0RU/4A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ieCYXJPz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.24
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010024.outbound.protection.outlook.com [52.101.46.24])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660AE606A33B
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 01:45:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 660AE606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ieCYXJPz
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j5eKUZlXZ/nKqf9Ij20q6BXneoRlj/0PGGe2psmqi81PZdUuEOFLBG2Znz3CaeYSrx04KzmLdHLFUsEc+8rSV+SA+EFtCygX4cW8hdXbgdGPPF9Gbki7hx9z2tACFxDkRs9veF2Oo6IE1BfuSFzJj9XDUmIE4wEy84vpaD157t7LMuMFmPbdBmnuP6UheWs5LbHRe/MPjhVlrsYAYvHL5LUfwpuVEjJD/cR7k5AzLs1wQCFwxQDgF/npQCljItfroGMKMN0kQANIqhQs8rxdCjAO/UDM7bkcRIxiOtjnvKJi5mj8MUL8gqbCc0PGsZW1q+svioBtIWmeeTFrWSfiGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tHeOvtNM3OPhAMkH5MbqWd9Kp7NHN8iCKPCZrdEFssg=;
 b=hs/HR9UT9asruBsPD3Y8xbtb06idgD8hYqVZirSgQzMm+C0j54PBSQ7orLjoHOys/VwlSbKq6IpdJvGZrrIdhvL+T1eGwxGJ1M0uTlL9Q8sjK9lB9teFFBTl9fhDh2Z/Q/Gb3QTv5QCv25aMOZ9V5OLyoIP/vDa5VNDSl+1xeq40MKovRFQtiRNSdwyFrrGNjIU27O3Wb1YC9zn8aCeScUoTh0uYISsv5GW5UjCHXPLAQh4slZ5hQ0ubCx/xY1UXhasOnM+6h8L2kN349xtDfLWZ00L7Z9QljGFZaNl1VlgkkIjy1aF2KSj+BmFZu3U45XvQxkmrH3GNgNHaWoFinw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tHeOvtNM3OPhAMkH5MbqWd9Kp7NHN8iCKPCZrdEFssg=;
 b=ieCYXJPzUZO8zPzqZ+hfweWxTbkNS2qx+0aImCLm/KHE0dRXgTwFMHA3oJ94c/MnHIwUqTWGX/aPrs/ciyCn+OMqiI6JTJTw/nGIddZcfjGS3vt6FLANmnHEKlhL/WjcOmmaqbdmsKvvonO6LCgOcBZqFlI73wuD/eKiPCT6f5U=
Received: from MW4P220CA0030.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::35)
 by CH3PR12MB7738.namprd12.prod.outlook.com (2603:10b6:610:14e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 01:45:23 +0000
Received: from SJ5PEPF00000204.namprd05.prod.outlook.com
 (2603:10b6:303:115:cafe::37) by MW4P220CA0030.outlook.office365.com
 (2603:10b6:303:115::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 01:45:23 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000204.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 01:45:22 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:45:22 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:45:21 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 19:45:12 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
	Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
	<Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
	<alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
	<Chen-Yu.Chen@amd.com>, Jing Zhou <Jing.Zhou@amd.com>, Nicholas Kazlauskas
	<nicholas.kazlauskas@amd.com>, Charlene Liu <charlene.liu@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Alex Deucher
	<alexander.deucher@amd.com>, <stable@vger.kernel.org>, Wayne Lin
	<Wayne.Lin@amd.com>
Subject: [PATCH 68/74] drm/amd/display: Seed boot clocks to avoid lowering pre-OS display clocks
Date: Wed, 11 Nov 2026 09:29:14 +0800
Message-ID: <20261111014100.3596072-69-Wayne.Lin@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000204:EE_|CH3PR12MB7738:EE_
X-MS-Office365-Filtering-Correlation-Id: 07b4db1e-8c1e-40c1-6b64-08df3f957367
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|10067099003|11063799006|56012099006|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261026121527099003|261026140227099003|261021135927099003|261028144727099003|261102123227099003|261009223027099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	ytZBM2Bw1xv1WwvM/RW+gels2jk80dkp8Dt4e6K5ORkQjP6UfOWMznS0gAae3aCUHQMnWjHQPy8gtgEW6FGzUTH4Iq//P/4H2qy6v2/w+KISjQS8/5hya1671L7r2+Z8nvLnv1i+rFYviyi4M0cnbpWSOrLZt83xHcK98wjDiPUawPZRtIeTCUFr+6Z64W70IEj55vqZuxnC1i9z40jS7OGZHDzMzW6X9V3V3YnKxL6aXERpGTUrfmCkB9OVvIjFUTOfj+diNQk9IXaPRHYRthsTE5vX8pTpthdHGHLp/vI/xz0NNSOdi3aZQOw1o6RLL/sZmoktZD+ug5DLexw22MPJgH6IxOsAiiA1INk7ivbL9wws+XbMCqDKQAIlia4I0BnA+4SJJlq7qenQ60QRqFoSsMA3cJ0reS4cl7Rc6jD4/Icpo3PfHNdfoIA72yjNc4wM0LAkrmX3nlH7cc1qZue09YmLup6Kyr5+j/NeIcEcOT3bf4N7rBc3e5F7TtjiF/ZE6KLsbHJPQSL7T8jLKD+tStGqfb7+qPfnXImXLaWjSseH740rVNMB1QtSQTh49qMSIRqCsKWy71PkKgiADEmi+T26cS0JI+CWtcbRQsNG3Uswndd3eXTSdXY618Miv75dw2IaVmXWhlXjbW+cZWlqC0s3evvhg32okKO9MbXLhcuaBzezEFHxyMQM8KOpY2h64AIBIbI8qrcMlliajw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(10067099003)(11063799006)(56012099006)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261021135927099003)(261028144727099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MQe5thjIsv+pMS+5dRbGqKDuQkdyQy2Ae+mvrZDAntChuWkCca79C+Cac9qALIb7hZhSufiEw9tMcbkcZzuQiH3VG3bUJfFeDWA6m7yHAg4qscoDjt0yhjnDIwNmaTQoOJJ2JkJg5Ir7u7cjiKPbnzdbIEwi509EXmVgvL5Cd+jeBZJbGDbli2Zo05DExi+SqJYY05MlqCOtFEFFzMjQqIqAIfb54THilc5XPsuSluKQnOfr69sysrBdEAcCsVEZ9P0FsYy6hGaP5uPfvMmTuKJttnuhYx6ai+ucD+SJdyiE0b603TgILqB8S9mUqipJNpZhm8mwrMd7Zv8SQ1780X7Z/tGerhtG1jN0ILXEQJ5HTV8SL0w1l8jdOEaiXzv+0LIc0a7qoL2ER+IlNsAgFjDWI1hqvkXdpFW2/+svYdJtrEMkwW9dUPluEawq5QNJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 01:45:22.7451
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07b4db1e-8c1e-40c1-6b64-08df3f957367
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000204.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7738

From: Jing Zhou <Jing.Zhou@amd.com>

[WHY]
USB4 DPIA HPD can arrive early in boot, before the first stream commit.
Its link detection runs prepare_phy_clocks(), which goes through
clk_mgr_exit_optimized_pwr_state() and clk_mgr_optimize_pwr_state()
and calls update_clocks(dc->current_state).

At that point both dc->current_state->bw_ctx.bw.dcn.clk and
clk_mgr->clks are still zero, because init_clocks() memsets them. On the
safe_to_lower path, dcn42_update_clocks() clamps the requested DPPCLK to
the 100MHz floor and programs it. This drops DPPCLK below what the
GOP-lit eDP pipe needs, and the panel flashes white.

[HOW]
1. In dcn42_init_clocks() and dcn42b_init_clocks(), seed clk_mgr->clks
   dispclk/dppclk from the boot snapshot(10kHz units, x10).
2. Add a DC core helper, sync_current_state_clocks_from_clk_mgr().
   After every hwss.init_hw() call (legacy_hardware_init, D0 entry in
   dc_set_power_state, and dc_reinitialize_hardware), it copies
   clk_mgr->clks into dc->current_state->bw_ctx.bw.dcn.clk for DCN.
   A later update_clocks() before the first commit then sees the real
   pre-OS clocks and does not lower them. Raising clocks is still
   allowed and does not cause a flash.

Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Cc: Charlene Liu <charlene.liu@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jing Zhou <Jing.Zhou@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
---
 .../amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c |  3 +++
 .../display/dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c   |  4 ++++
 drivers/gpu/drm/amd/display/dc/core/dc.c         | 16 +++++++++++++++-
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
index b1fbadd0d885..054eab1e0cb9 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
@@ -643,6 +643,9 @@ DC_LOGGER_INIT(clk_mgr_base->ctx->logger);
 	DC_LOG_SMU("dp_dto_source_clock %d, dprefclk %d\n", clk_mgr_base->dp_dto_source_clock_in_khz, clk_mgr_base->dprefclk_khz);
 	dcn42_dump_clk_registers(&clk_mgr_base->boot_snapshot, clk_mgr);
 
+	/* Snapshot is in 10kHz units; seed clks so update_clocks() does not lower the pre-OS clocks */
+	clk_mgr_base->clks.dispclk_khz = clk_mgr_base->boot_snapshot.dispclk * 10;
+	clk_mgr_base->clks.dppclk_khz = clk_mgr_base->boot_snapshot.dppclk * 10;
 	clk_mgr_base->clks.ref_dtbclk_khz =  clk_mgr_base->boot_snapshot.dtbclk * 10;
 	clk_mgr_base->clks.dtbclk_en = clk_mgr_base->boot_snapshot.dtbclk > 59000;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c
index 57291c10c917..5e8a65f1ee68 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c
@@ -251,6 +251,10 @@ DC_LOGGER_INIT(clk_mgr_base->ctx->logger);
 
 	DC_LOG_SMU("dp_dto_source_clock %d, dprefclk %d\n", clk_mgr_base->dp_dto_source_clock_in_khz, clk_mgr_base->dprefclk_khz);
 	dcn42b_dump_clk_registers(&clk_mgr_base->boot_snapshot, clk_mgr);
+
+	/* Snapshot is in 10kHz units; seed clks so update_clocks() does not lower the pre-OS clocks */
+	clk_mgr_base->clks.dispclk_khz = clk_mgr_base->boot_snapshot.dispclk * 10;
+	clk_mgr_base->clks.dppclk_khz = clk_mgr_base->boot_snapshot.dppclk * 10;
 }
 
 static struct clk_bw_params dcn42b_bw_params = {
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 8a02bcbb9649..463a3fc2d8c2 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1728,12 +1728,25 @@ static void detect_edp_presence(struct dc *dc)
 	}
 }
 
+static void sync_current_state_clocks_from_clk_mgr(struct dc *dc)
+{
+	if (!dc->current_state || !dc->clk_mgr)
+		return;
+
+	if (!(dc->ctx->dce_version == DCN_VERSION_4_2 || dc->ctx->dce_version == DCN_VERSION_4_2B))
+		return;
+
+	dc->current_state->bw_ctx.bw.dcn.clk = dc->clk_mgr->clks;
+}
+
 void legacy_hardware_init(struct dc *dc)
 {
 
 	detect_edp_presence(dc);
-	if (dc->ctx->dce_environment != DCE_ENV_VIRTUAL_HW)
+	if (dc->ctx->dce_environment != DCE_ENV_VIRTUAL_HW) {
 		dc->hwss.init_hw(dc);
+		sync_current_state_clocks_from_clk_mgr(dc);
+	}
 	dc_dmub_srv_notify_fw_dc_power_state(dc->ctx->dmub_srv, DC_ACPI_CM_POWER_STATE_D0);
 }
 
@@ -6435,6 +6448,7 @@ void dc_set_power_state(struct dc *dc, enum dc_acpi_cm_power_state power_state)
 		dc_dmub_srv_notify_fw_dc_power_state(dc->ctx->dmub_srv, power_state);
 
 		dc->hwss.init_hw(dc);
+		sync_current_state_clocks_from_clk_mgr(dc);
 
 		invalidate_drr_adjust(dc);
 
-- 
2.43.0

