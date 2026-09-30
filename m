Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012015.outbound.protection.outlook.com [52.101.43.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221583AFB11
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 16:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790785960; cv=fail; b=YN1TchF36bdeOK1BS37EI6GXp7WRB3nsbmmT1y2+/NqINpl2jWTkK2NH1/11Be3ZHR9an5TH4G7H3gndofd25iXRTuPeMB8OwP0J9vEqgPD7sKPKz67QJ+KwmE1V4CVeCiyzabcw0HVooSg4lAufDtXi3smc3RJkfAOtqmLdqG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790785960; c=relaxed/simple;
	bh=eixMRCsk+8TNh7cN89oCvP9CeDWGFjcXa63nhieqGQE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZTZOtWQK7PdP9S4OXLFY1QUEwfN3fq8BkPp5kBZy0dxYlMfh6+7YbSY+U/2feMnzuz2XAhDunZ9Ew8bJE4eg7YOSZXK+2vfC0xR9RbvEOVQjwSd+6Ce8M0+NxPgvOyKpYmp6pZHXTXwkDtABBLSXRSCRk0hHGkHUaZtVDFdo7w4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RVh4FDDs; arc=fail smtp.client-ip=52.101.43.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RVh4FDDs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v1K8+lE3oOy7uunUR12ABZdjFLYhPdN3Yo+Y5evD5uTy0GHVfPzn13kmPvRyCsA9cbpNldHSvtE3JPBtBz6j64AvISDgHCP+r19QFvFzPtYWOwVZ0I5cP+ml9/HciCoQV5V+MmvRufbYO//w63de9ppy6cQo3MjeGZYT1x7e4d211jlTJm/aka+z464+Lt+HvTvdPTZlOPNj1P6EnbOf8pomCsEkArz4lw5bYRMKwaUzNu+xgB8JAerG6jsXiWj13Fq2y9Fjq5VD+206eI3/gGazEVICZdUDbK77OLJeXH52rUl+jCgfJFwYxpIoi4ue3QuOvk86W+Ccqq+w51tXqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZI90vnogzR1qrp808WIA+H50UyoMwvM0pTv1dPvtfmw=;
 b=XBWzNxNNCnDHbjAqj08GaV88M8T35pY7qL1yYZsGt/Icn2JWjcabn4ouT0Q888RGCTNyMJce4P/7a3q+APvZSIbmZbfwD3mFhDlS/Xu6jQ/6RgSin9alu5Oc6WCzbYHC1v3lM0UXmMbXfLFOcc4l7yyHEFNOG2SUgNB3zi/X5RVYHZ+BG5Ab5t+td1MiPWpPph3GVGQWSaDcrFxMxYyju6giGhkzcZfmOEt8P2n0KT95DkfqEROWb8PNJkQwx/J73IMWrfCNCc8YbQ3bfN8ncdoNsHIvsBAtiSd3StRldB31OBhWh8mlU3D8bl8Z7cnPEo75p9q4Qd82cRlbxluiQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZI90vnogzR1qrp808WIA+H50UyoMwvM0pTv1dPvtfmw=;
 b=RVh4FDDsQgbhJXGXwMXAfLKllE/11jh4UHyOsY4yydxYp4Jb9uZrfJLpVmyKIe2e08C484ZdM9do1CT97GLP9S9vrMzEaRL4PULgaV5BwuNXIdaWhmasQrnBTnsksTXOoeyq6GIcJDnbaLJ4Bdk6mini4RzJyPhZlJYEzqQtmt4=
Received: from BL1PR13CA0112.namprd13.prod.outlook.com (2603:10b6:208:2b9::27)
 by CY5PR12MB6226.namprd12.prod.outlook.com (2603:10b6:930:22::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 30 Sep
 2026 16:32:36 +0000
Received: from LV8PEPF00000067.namprd03.prod.outlook.com
 (2603:10b6:208:2b9::4) by BL1PR13CA0112.outlook.office365.com
 (2603:10b6:208:2b9::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Wed,
 30 Sep 2026 16:32:35 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 LV8PEPF00000067.mail.protection.outlook.com (10.167.248.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 16:32:35 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 11:32:30 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 11:32:30 -0500
Received: from flamewok (10.180.168.240) by satlexmb07.amd.com (10.181.42.216)
 with Microsoft SMTP Server id 15.2.2562.49 via Frontend Transport; Wed, 30
 Sep 2026 11:32:29 -0500
From: <sunpeng.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <timur.kristof@gmail.com>, <harry.wentland@amd.com>, <alex.hung@amd.com>,
	<chiahsuan.chung@amd.com>, <ray.wu@amd.com>, Leo Li <sunpeng.li@amd.com>,
	<stable@vger.kernel.org>
Subject: [PATCH] drm/amd/display: disable self-refresh on tearing flips
Date: Wed, 30 Sep 2026 12:30:52 -0400
Message-ID: <20260930163222.557757-1-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.55.0
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
X-MS-TrafficTypeDiagnostic: LV8PEPF00000067:EE_|CY5PR12MB6226:EE_
X-MS-Office365-Filtering-Correlation-Id: 93ee62e8-f772-4699-209b-08df1f106f23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|82310400026|36860700016|376014|11063799006|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	r3AH9f0l45Q46GIHmGO9VpY+YoZOlopxjosTHOxYsKbQsaLIBsVbNbRilPNlO5qAL0qL9R98kFlh6JcZKF068Ru6SBsg1fIvEHv35cTUAgH6eSdqo7qjkCJyoy3cfT5RnhOz6xb1QtGoWNZq9T0Tl1BFxit7V517m3Qs33CbJO+6c2vrGM6OfbhK1tOnQIt85Y4Icl/08qaLW8udePJLQmjAIDZ3foyBrYlk3giX/1gtcP5/t6LCOdCWkw6JD/oZZikXon6RnOO2/wlWWW15nVyyS1t8+vkRPWsDBYtgJQtCJhNiBULWnnmDm2ytf8tdcJdvIg3aN3lzQkc9bu2br+PP8fUs07cZz5P0D+M5qEhDVUxHW4oyLPziC+XrS54EXXlXuyp0uITz61ePGVIG484B4YnZeQcCjYvhfzlNNl3qlCEPg6zSJQbnP1vN6q+psPy0czFtJk9QSA4FnPqlFmUYbhHE0hqkEZGKxKQoflLQEujazKyB+Q9n5l0aH0KkGw3CdhPLGo9MpNag/bVqmaMyicajvmHzS9dhGh2pbJweORkii+XBQjRQAyb3jbEIqAL6YaCbdSD4JpYxd/Lx3ojhZXvZdHrw77YF/582vbcbV92Fo/djIz+4uvpLq7cLo3/iE6KMOpo5fwvBOmhDdxx9dOl4gwI5J7W7RLN1nr3u5Sjc3XN7UIyYOJWjt7Di
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(82310400026)(36860700016)(376014)(11063799006)(10067099003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ac81XrjfTYyZSJthC/myoZVBeJqvAJujRe1rMfe7oRCCAEPVzW7MJ+fBlJQeTCJKcE7jQ5jbQ8Pq17vEXOvGZp3Z88B0gm2jXSMK00s0udNqfo1cQb7V0b7trnSHoLYUCfhrtyztOjRmghjlvKQiZ7mAp7D0ZWesc4FbymDFNOjil2WwBgaU2zu8S58+0N5lMFEpEBYSFp1UXLS/8hGeAKuGzIkxv3wBGR/kZyVd/3BsIS/rkTRr6EM+ghylwBGOr8cV7H1f7T5P2gyC3E82+3Kwj1gTe7R3lUpHtgFHohunNHTkUD1Qwb/3rF0JaTvGxW9cZGU7XOJ/npK4HipBdWNvWIG0VaN+jLz7aA1tkUklsxwjupI/og0ruTK78d9HwE4MzUyRB+BkK9aoxcVrFcAdb3dA5+XipF3Eh/Y/y6JmkdWMkZapOzo39pzjeZJE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 16:32:35.3983
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93ee62e8-f772-4699-209b-08df1f106f23
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	LV8PEPF00000067.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6226

From: Leo Li <sunpeng.li@amd.com>

[Why & How]

Immediate (tearing) flips breaks self refresh state machine assumptions,
so disable PSR/Replay for them.

Cc: stable@vger.kernel.org
Signed-off-by: Leo Li <sunpeng.li@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 6e5dbe0bd82e5..d4c814eeb56d6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3764,6 +3764,13 @@ VISIBLE_IF_KUNIT void amdgpu_dm_enable_self_refresh(struct amdgpu_display_manage
 	struct amdgpu_dm_connector *aconn =
 		(struct amdgpu_dm_connector *)acrtc_state->stream->dm_stream_context;
 
+	if (!acrtc_state->base.async_flip) {
+		amdgpu_dm_psr_set_event(dm, acrtc_state->stream, false,
+			psr_event_immediate_flip, false);
+		amdgpu_dm_replay_set_event(dm, acrtc_state->stream, false,
+			replay_event_immediate_flip, false);
+	}
+
 	/* Decrement skip count when SR is enabled and we're doing fast updates. */
 	if (acrtc_state->update_type == UPDATE_TYPE_FAST &&
 	    (psr->psr_feature_enabled || pr->replay_feature_enabled)) {
@@ -4218,6 +4225,18 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_commit *state,
 			spin_unlock_irqrestore(&pcrtc->dev->event_lock, flags);
 		}
 		mutex_lock(&dm->dc_lock);
+		/*
+		 * Tearing (immediate) flips cannot work with panel self-refresh
+		 * features. The event is cleared by
+		 * amdgpu_dm_enable_self_refresh() once async flips stop.
+		 */
+		if (immediate_flip) {
+			dc_exit_ips_for_hw_access(dm->dc);
+			amdgpu_dm_psr_set_event(dm, acrtc_state->stream, true,
+				psr_event_immediate_flip, true);
+			amdgpu_dm_replay_set_event(dm, acrtc_state->stream, true,
+				replay_event_immediate_flip, true);
+		}
 		update_planes_and_stream_adapter(dm->dc,
 					 planes_count,
 					 acrtc_state->stream,
-- 
2.55.0

