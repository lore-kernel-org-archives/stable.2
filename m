Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012051.outbound.protection.outlook.com [40.107.209.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EFB36CDF8
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 17:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785258382; cv=fail; b=OADeX+hYprQ831sg2PyHTHSDGuYy60Lb0+5hf4yxaQiTZn6UDVzUvNHgXp0FbXcNVaUd2IwfCsDCf3rzmX6C51JVgZ0tRWDGk7BNSVakJjm5tY4OygYfMCq8bdqnzfIMwPfIpvv+O6a0pq5i3/YmfHSAPaMOuLtwMh0rJTE/usA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785258382; c=relaxed/simple;
	bh=d7K3IKwy0xH879DfRhmj8mk9af/qLiGPV409MuhHjck=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bcSQAGPTTvXWzQRL9fAPB2LTXxwyKIi+w3/+XIhjBp88em3bmdEkhiM8ZiQTxNwDi68eMhqT3HkNgN6yZeS2kGSWh5ELTbTzIXAOpnqJeGk6qgI+sLHFt4uLT8eYyIpWhbAvVBHyhAJGJuiQfuLm8XNUUDuJQFkfbFlzzfdMrmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=q3ud8b8p; arc=fail smtp.client-ip=40.107.209.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="q3ud8b8p"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tRGHB0JCR9p4mMJp3m7OGLOnJo54wpQCgtS05mCo9DxY5yQYwgMxhWcAaK2KNNtlp0Iwzs2pG6rb6yuKnhZ11vIsmN/2Y7gksc7/LCt8fq/0/zqMrBdoIJikYeBRq9zxoW75xiUEjDQxK/V7kOyyf6Z+7O2DPYApApLjUbA5jFc6FOqZHXqg7LWpG8orJjVqDKJlidsUAVlHuNExZiFKAjp25J/JpWmCSjVPQdS4omED4y268gJrgAWZeT9W0v57vDqPv8KBsGQH2EIJug4mum2nOhE99Kx849ZNaKEuLf9X4nXWyhjAVWUjxA//9IBJhAc3rDZ8u7E2q4fkFSkVGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xaW5T01rISEAYxwrFfv4X4ENhGnLbHAUTdmfgTfyS1I=;
 b=QPThfn0LX4WAKNmGHyX1oUQS/hY3Gapq1dMxAEBVyi0VRa/IqNKbh7/fiZMMWZFBQ/JR0QbS5OjMlFU7kPWRC5H26tbGr7Q/GVjtgiumR+BqXGhqvesMBfXqow3pwdU96qW2wzrQjcG1+Vh/Ykq/1rdkzdoPPNlbQUq1Vc+Xs3e67N68V/ADZ7UrbTCL45NHZHBjsqjffJnje6Bn2wGkodc2bkx+t36qMHwpesujnK/Gse9xJCyxDwF0tpofjAw/k1IWf6XB1bdbEx3r6ln2Jr0prBMEBPaKZ53cFJtGRFZKwtsy6aK1SK+LmKnjbtbtu+sxeL4WIypJuOQrq9u/Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xaW5T01rISEAYxwrFfv4X4ENhGnLbHAUTdmfgTfyS1I=;
 b=q3ud8b8pNsXyzwr9zm5052iigLx9B3B4owQnsscM1hWkP4e4uNocVIQpFHwWsjhmFYWXi7Dxc/3e+U64BujyLKTA1uTUpzASW2TCiTBIYr9yEGlSzfGX4flxiGVCh0wybTSPq/qPPHoKHvyBN3oB3pninvF7tsoLxyfXvnhKoPA=
Received: from CH2PR12CA0008.namprd12.prod.outlook.com (2603:10b6:610:57::18)
 by LV2PR12MB5894.namprd12.prod.outlook.com (2603:10b6:408:174::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 17:06:17 +0000
Received: from CH1PEPF0000AD7F.namprd04.prod.outlook.com
 (2603:10b6:610:57:cafe::53) by CH2PR12CA0008.outlook.office365.com
 (2603:10b6:610:57::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12 via Frontend
 Transport; Tue, 28 Jul 2026 17:06:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7F.mail.protection.outlook.com (10.167.244.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Tue, 28 Jul 2026 17:06:16 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 28 Jul
 2026 12:06:16 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 28 Jul
 2026 12:06:16 -0500
Received: from flamewok (10.180.168.240) by satlexmb07.amd.com (10.181.42.216)
 with Microsoft SMTP Server id 15.2.2562.41 via Frontend Transport; Tue, 28
 Jul 2026 12:06:15 -0500
From: <sunpeng.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <mario.limonciello@amd.com>,
	<alexander.deucher@amd.com>, Leo Li <sunpeng.li@amd.com>,
	<stable@vger.kernel.org>
Subject: [PATCH] drm/amd/display: Exit idle optimizations before programming
Date: Tue, 28 Jul 2026 13:02:47 -0400
Message-ID: <20260728170550.40908-1-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.54.0
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7F:EE_|LV2PR12MB5894:EE_
X-MS-Office365-Filtering-Correlation-Id: de0ab328-157e-4bd5-9fb0-08deecca8975
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700016|23010399003|11063799006|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	m19teAwrK9JoYO00WDbe8j+Ki+PfVflqGWYhdBS/DOWDe/NEX4lcLWWAvGhTz+U52F9eT+GUDeYG2OH386uKH4CBYwXVCoLkSxlKQZxZDoFwbhc0op1t1HIHPd2rj1boNdoplggqiO1KcHrMw+w3OJcwt5xLAmPwUhv9GagMET5LWJr2xqJ2qBeo8uJh4+GrGLMJfYrAaxcSaaHiUcWoYOAVbB4ook88S8HhVmb+BEtYd6rwEuemZ+hom27uG/6TdVIZMMXuDzDB4fdTmIJvsJReY8OgtZ9uWIjmDng3vPtjwZz2tyJbZjq/spdCrOVz9koPVknpH5dUYVuDzXrYXY2VA3XslRy3BWaxka6ffIsvbdAr+erG/F/tyaCGJjA7/udoZSZgZovLi8vgwz8rcZDNFHTgmFbaqld3yEGltq6FsciiLqFXr3a8yxy+kAxWAzHybOIt9t/iA6oCL1PQXZUzr+CrpiVZvFLqH4YWAeuDYBFIxuXrqoUwwjJkcA6BVWjKZeVpkv9OkcED759LgmTqwbsXtN4HNKdd89oruwUk9Fvv6Y5wJrIubc4cY62afzqaosS5ZmyhJ694M04e/xk1+OnkGTOrJyFT069xE7bYj/idthe2e9+9X8pijTpJQTJXtLl7r2UqGhinD4O5Gw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(23010399003)(11063799006)(56012099006)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nl9+L7R5onSYswlS5wp1twz7ms9Ri6ONCSpMkG+0drB6k93eukNhRGdLaxAkMkIY3OiGdKReFh2nRsla8qkbsA30Iv3eRWnYcgod1X/zDLYfhCL1GFaYsAdURhhitwwYsY4g2zl5xgWmc8IW5xFvjlvqhYiGSnkXmIzyMsxwmdiXXM0glrhkNpp5+a4/wKIVENK785Aui/kgBGo/7w0EFJj4i0BpdJy9IBzA7oDWJCnDXx3My70HVmxKqAsFyndXRc55eNjU3TeDnySK5/fw0ujUureOdIA62KcVc4VJODOQ1Xu79ee1gvapcTbFwjOhv3udzjxCq+uJXNfrFIjZUF1fC52Jk3pvUTzVy54FAXXQZFxbHFf8S808MwkwwujT8dcXZBsGxyjyvO/kKBjnx0pE4ZSKR9wnSnK/PZ6spG2Z5HqyvGDqjll+ME6Axdro
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 17:06:16.6388
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de0ab328-157e-4bd5-9fb0-08deecca8975
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5894

From: Leo Li <sunpeng.li@amd.com>

[Why]

We need to exit PSR/IPS before programming. Before calling DC for
programming in amdgpu_dm_commit_planes(), there's a
vblank_control_workqueue flush. This waits for IPS and PSR exit. (See
drm_vblank_on/off() > amdgpu_dm_crtc_set_vblank() --queue_work()->
amdgpu_dm_crtc_vblank_control_worker())

Prior to the tagged "Fixes:" change, drm_vblank_get() was called before
the workqueue flush. This ordering ensures that PSR exit occurred before
programming. After the "Fixes:" change, drm_vblank_get() is called after
the workqueue flush, leading to programming while idle optimizations are
still active. This can lead to incorrect flip_pending detection used by
vblank event delivery.

[How]

Split the vblank_get() component of `dm_arm_vblank_event()` into
`dm_arm_vblank_event_pre_programming()`, which is called before
programming. Call it before the vblank_control_workqueue flush.

Includes a drive-by cleanup of prepare_flip_isr(): the only caller is
dm_arm_vblank_event() and it's simple enough to roll-in.

Signed-off-by: Leo Li <sunpeng.li@amd.com>
Fixes: 48ab86360af1 ("drm/amd/display: check GRPH_FLIP status before sending event")
Cc: stable@vger.kernel.org
Link: https://gitlab.freedesktop.org/drm/amd/-/work_items/4141#note_3583205
Link: https://gitlab.freedesktop.org/drm/amd/-/work_items/5527
Assisted-by: Codex:gpt-5.6-sol
Assisted-by: Claude:opus-5
---
Rebased patch for applying on 7.2-rc5:
https://gitlab.freedesktop.org/leoli/linux-asdn/-/commit/f05db644126540f1d237f846cc0512088551eb73

Thanks,
Leo

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 79 +++++++++++--------
 1 file changed, 47 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index df6b59fb8d0d4..784587697bac8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3576,25 +3576,6 @@ static void remove_stream(struct amdgpu_device *adev,
 	acrtc->enabled = false;
 }
 
-static void prepare_flip_isr(struct amdgpu_crtc *acrtc)
-{
-
-	assert_spin_locked(&acrtc->base.dev->event_lock);
-	WARN_ON(acrtc->event);
-
-	acrtc->event = acrtc->base.state->event;
-
-	/* Set the flip status */
-	acrtc->pflip_status = AMDGPU_FLIP_SUBMITTED;
-
-	/* Mark this event as consumed */
-	acrtc->base.state->event = NULL;
-
-	drm_dbg_state(acrtc->base.dev,
-		      "crtc:%d, pflip_stat:AMDGPU_FLIP_SUBMITTED\n",
-		      acrtc->crtc_id);
-}
-
 static void amdgpu_dm_commit_cursors(struct drm_atomic_commit *state)
 {
 	struct drm_plane *plane;
@@ -3740,17 +3721,48 @@ static void dm_arm_vblank_event(struct amdgpu_crtc *acrtc,
 		return;
 
 	if (pflip_update) {
-		drm_crtc_vblank_get(&acrtc->base);
 		WARN_ON(acrtc->pflip_status != AMDGPU_FLIP_NONE);
-		/* Arm flip completion handling and event delivery after programming. */
-		prepare_flip_isr(acrtc);
+		WARN_ON(acrtc->event);
+
+		acrtc->pflip_status = AMDGPU_FLIP_SUBMITTED;
+		acrtc->event = acrtc->base.state->event;
+		acrtc->base.state->event = NULL;
+
+		drm_dbg_state(acrtc->base.dev,
+			      "crtc:%d, pflip_stat:AMDGPU_FLIP_SUBMITTED\n",
+			      acrtc->crtc_id);
 	} else if (cursor_update) {
-		drm_crtc_vblank_get(&acrtc->base);
 		acrtc->event = acrtc->base.state->event;
 		acrtc->base.state->event = NULL;
 	}
 }
 
+/**
+ * dm_arm_vblank_event_pre_programming - Prepare for programming
+ * @acrtc: The amdgpu CRTC to prepare
+ * @acrtc_state: The new CRTC state
+ * @pflip_update: Whether a page flip is being programmed
+ * @cursor_update: Whether a cursor update is being programmed
+ *
+ * Grab a reference on the vblank counter if a page flip or cursor update is to
+ * be programmed. Do this before programming so the HW is not in any
+ * idle-optimized state (such as PSR).
+ */
+static void dm_arm_vblank_event_pre_programming(
+	struct amdgpu_crtc *acrtc,
+	struct dm_crtc_state *acrtc_state,
+	bool pflip_update,
+	bool cursor_update)
+{
+	assert_spin_locked(&acrtc->base.dev->event_lock);
+
+	if (!acrtc->base.state->event || acrtc_state->active_planes == 0)
+		return;
+
+	if (pflip_update || cursor_update)
+		drm_crtc_vblank_get(&acrtc->base);
+}
+
 static void amdgpu_dm_commit_planes(struct drm_atomic_commit *state,
 				    struct drm_device *dev,
 				    struct amdgpu_display_manager *dm,
@@ -4013,16 +4025,19 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_commit *state,
 		}
 	}
 
-	/*
-	 * DCE depends on a combination of GRPH_FLIP, VLINE0, and VUPDATE for
-	 * event delivery. Only GRPH_FLIP handler can send pflip events, and it
-	 * only fires if HW latched to the flip. Maintain legacy behavior by
-	 * arming event before programming.
-	 */
-	if (amdgpu_ip_version(dm->adev, DCE_HWIP, 0) == 0) {
-		scoped_guard(spinlock_irqsave, &pcrtc->dev->event_lock) {
+	scoped_guard(spinlock_irqsave, &pcrtc->dev->event_lock) {
+		dm_arm_vblank_event_pre_programming(acrtc_attach, acrtc_state,
+						    pflip_present,
+						    cursor_update);
+		/*
+		 * DCE depends on a combination of GRPH_FLIP, VLINE0, and
+		 * VUPDATE for event delivery. Only GRPH_FLIP handler can send
+		 * pflip events, and it only fires if HW latched to the flip.
+		 * Maintain legacy behavior by arming event before programming.
+		 */
+		if (amdgpu_ip_version(dm->adev, DCE_HWIP, 0) == 0) {
 			dm_arm_vblank_event(acrtc_attach, acrtc_state,
-					pflip_present, cursor_update);
+					    pflip_present, cursor_update);
 		}
 	}
 
-- 
2.54.0

