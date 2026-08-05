Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011023.outbound.protection.outlook.com [40.93.194.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1F439DBD3
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 16:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785947650; cv=fail; b=j/t5LxuEIyxc9geESiiD8saUmNOzdFFYYIxAhdh70mEvmqoJtn1kTzomL40Y6ETJKTd+dNpZ7jHD5a9HeKJxwFIOjAnwEdyrniI1TCCX95Hga4//I84r23OyzxxVRtbs6PI27KMTAWeuO65UfYFcjBn07V1UGkazD/uSyhglUSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785947650; c=relaxed/simple;
	bh=9ap5VAyQ2lgYAOMsBTjvDIl2aKLISiWSfnK3L73f6xc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nPTimegrzovmeb7QJQlL3UGQXqlamYTaDPvKllhyPjgvS9S52lF8x4dXOw9N5hiyFl/eCrhfPlbuKDFhOWEXpdx+tA0Twd3p2HUV+WZ01/HWS/1uwao5PsG590dVhmVgtUZePbKbGBYjedcInc6hxs0FiCpBfqwtseb0FoRuOtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2dHC9ayb; arc=fail smtp.client-ip=40.93.194.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2dHC9ayb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KWC9DrLCwCHnOLedaC4VksHIH++WWirHqlimnCN+GvlqwgzvM9n/Xv803wabFPodEMVwAz3eoBSAb5bXT7RWPfPuXr13NhtJVdXAUZkb6b466Oyb+bdQqvRalopaXembijx2IC2AY/MleoFhDbjHiWTFe9uSpSTCmD1rZAsqO7Njhk7tYwsSHlhIs+yLsgI31gye1gKisdGOFWRPeF10cS+jNRXE9SQdv/uClweSWH2N/tAPngYnqh7UySc3jAV528n9y/FBO2+z+5RFupEETzUr9BMppUUYTW2523sNEK7cD1Hq/4YuAJ8bS3u4JB/bN/Y7taRAZLWQBD46w22FCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+KWx52kZkMDvnMnxKXLuDLq7nlj+S40ZXaMq1EBi6+A=;
 b=swAJHH8gg0bYyQ6jq9Gwel4Z9tAU7fB2+9nFBskAamE+qZy9cbfIyDJoMSoPQHibPghcRYoDef6mSVfURhzCczwFnI69TPnuYtBp04nWnGJR4SH7WmPByPOcHTDgtkos3/Zav4KTHaT5HXFFYpNHz5ScoerXIL/rzzbvXdVh4mFNQT6ZQtG/u7mCDVeDnXdMw0xQA9VhRFqv23FvNtq6x/XTu8q1mFXnkQDO2mmaEJrdeksK74BZxGCaSHKgCSiEC0e9HU3qttt3zhhhLPIvhqVpEDVpDQ7sh4uw79KW3t/eFzNIFaqbCnsEx4f6tmEMOBIM1HZoAXgDxD4INU9QdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+KWx52kZkMDvnMnxKXLuDLq7nlj+S40ZXaMq1EBi6+A=;
 b=2dHC9aybAbKKXWpTu/eTiIOM6lPwTctpoMOFr5qYKKfebngz74JtJmzawICH77EIw0MBi4W5KP73PIWNzXA8kYD823QMfCZdYsrERy9b/AShhZWm77BPW/en4yp075XP4OPuilV5IEEpYSu254LF4MvB91xkKgt+N886nceOW44=
Received: from BN0PR04CA0208.namprd04.prod.outlook.com (2603:10b6:408:e9::33)
 by PH7PR12MB6764.namprd12.prod.outlook.com (2603:10b6:510:1ae::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 16:34:02 +0000
Received: from BL6PEPF00020E65.namprd04.prod.outlook.com
 (2603:10b6:408:e9:cafe::35) by BN0PR04CA0208.outlook.office365.com
 (2603:10b6:408:e9::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.19 via Frontend Transport; Wed, 5
 Aug 2026 16:34:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E65.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Wed, 5 Aug 2026 16:34:01 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 5 Aug
 2026 11:33:59 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 5 Aug
 2026 11:33:59 -0500
Received: from flamewok (10.180.168.240) by satlexmb08.amd.com (10.181.42.217)
 with Microsoft SMTP Server id 15.2.2562.41 via Frontend Transport; Wed, 5 Aug
 2026 11:33:58 -0500
From: <sunpeng.li@amd.com>
To: <stable@vger.kernel.org>
CC: <amd-gfx@lists.freedesktop.org>, Leo Li <sunpeng.li@amd.com>, David Weber
	<weber.aulendorf@gmail.com>, "Mario Limonciello (AMD)" <superm1@kernel.org>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 7.1.y] drm/amd/display: Exit idle optimizations before programming
Date: Wed, 5 Aug 2026 12:33:14 -0400
Message-ID: <20260805163314.214623-1-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <2026080547-scoff-that-5ce1@gregkh>
References: <2026080547-scoff-that-5ce1@gregkh>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E65:EE_|PH7PR12MB6764:EE_
X-MS-Office365-Filtering-Correlation-Id: 571239ac-d3b5-4999-8747-08def30f5b22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|18002099003|22082099003|11063799006|56012099006|13003099007|10067099003;
X-Microsoft-Antispam-Message-Info:
	FQFUOGibUaoJmIfVvgERChBDNE/j11Kvgmavc8w7eAWodo2q3H9nxpwPpyigSnJD3gOLuLsh3GKgjSkd9osKh61VszcWLABh1cizsynQcuoTSBvYPiv27T4OxxsZk1ChY1S3yU3Tm0yiXrEqMFh2wG/oR0grozVOC8qxyaltj0wua69H/kJfq30bamE2MSk5DVR8BfBCynX3B/YWJ3UjaaYBLw0UrSRVEjEELRD9vvj9DVWakD/yimgeLxN3RLRDvE1QfsUcBGP3qZJ5m+HTUMBXUNJ1dIAGFlDw9JshK4HNtttayoEjyicdWLU6TAL5B7x4fZr7wvK7eBoOhJcEM1nbujM0dAto14L7oLlRFrpV/r0dNAGhlqRr7gPPQj1PA2FZ+OEtffnuJTvNVWKtz0z7zx7KsG2XihbQgioEaOO9PFJ9eBu11lnFRahxCr9Oq/2U/SF9krn0bhyx6U5vepuS0WsGgLcNh9/34T+8j3vdBSkN0xalr3ZWv9lzeKprZLKhEw2A+DbsStcbk/O+ZWNPJpsyXPZnn5+OOgLbD5JFKIIHz7HF+HwppD4W1AMgrmQXeDGn3EI4H4DpGklaYLB4w3xmm/NTrou2vCNbVPLv36qKEl779tEL8H2biP8lBL/QAt24aLurGIffY533qMkToW+9JlP9+UVk92gxobUMyITPBO0B6ce+AsA5m6PaccRLerR+RLROaWi9ADNoHQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(13003099007)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5xeAAkntHy/XilCyoLnvo2lMpDV7G5nJndNE2yV1xD64VfgqgLV05YSjrws3RvB3v16WeVa0S/OiDUCaIByMGXZxsgoJUFmG6G2J1AuziauMBc5wn9qqQUWWwR1jeDWQzHQdZv1OzedDXEYnswJ0ra4FDcNmZmljLb5xmH+0HWqBp6plPOa1gaAh9U/AVGR1UQoJbZkPtMhFslOCXmZFhuJZyzKJwtkpfTlxSMC/b93Lq6teutI6zm8okK4CPnb8oayRd7u44VMK2EDxd11dHo3ZamN+YruaKxcJxIx7HVDol776AoE9Aqvp6aYIqUCwAyCBvRhgooUAgbcMWEfDBp01vrJpZz5VoDiaMePWq/LxWDkIuik6IZ+72IjulcX+5f0DlAuP9P8O6M+W34XRAYXNMQnarUYQaattOJL92WPPsCDo0UhucH5LyjmbFY9s
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 16:34:01.1808
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 571239ac-d3b5-4999-8747-08def30f5b22
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6764

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

v2: Fix checkpatch formatting warning on
    drm_arm_vblank_event_pre_programming() arg alignment.

Fixes: 48ab86360af1 ("drm/amd/display: check GRPH_FLIP status before sending event")
Cc: stable@vger.kernel.org
Link: https://gitlab.freedesktop.org/drm/amd/-/work_items/4141#note_3583205
Link: https://gitlab.freedesktop.org/drm/amd/-/work_items/5527
Assisted-by: Codex:gpt-5.6-sol
Assisted-by: Claude:opus-5
Suggested-by: David Weber <weber.aulendorf@gmail.com>
Signed-off-by: Leo Li <sunpeng.li@amd.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 05984e29520a28c27f5a2388742c957a6a87ee7a)
(cherry picked from commit 8419331e64d92a8de5fc4feef0e305f201fb8b33)
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 78 +++++++++++--------
 1 file changed, 46 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 11affddbb2650..40d82a3eeec05 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9656,25 +9656,6 @@ static void remove_stream(struct amdgpu_device *adev,
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
 static void update_freesync_state_on_stream(
 	struct amdgpu_display_manager *dm,
 	struct dm_crtc_state *new_crtc_state,
@@ -10023,17 +10004,47 @@ static void dm_arm_vblank_event(struct amdgpu_crtc *acrtc,
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
+static void dm_arm_vblank_event_pre_programming(struct amdgpu_crtc *acrtc,
+						struct dm_crtc_state *acrtc_state,
+						bool pflip_update,
+						bool cursor_update)
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
 static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 				    struct drm_device *dev,
 				    struct amdgpu_display_manager *dm,
@@ -10301,16 +10312,19 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
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

