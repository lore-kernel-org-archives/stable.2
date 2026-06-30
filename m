Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011024.outbound.protection.outlook.com [40.107.208.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177152DB794
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 18:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782842623; cv=fail; b=RqUomhmFNtgQ+ZslFj22TDIsgijQGt12KpEAleVQ4D66RreMpaSRsyoA7zjUZ3NfjcjOYq1sN78tWf1Fn01Yv2jL7cYtWuNJ3CC0h32yb4q77BLIUV7ZGn/Qlz8qaBHiyWJlPnY9slQi0In+RZcJuW8glh4sB+ugXCsvnJcwLgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782842623; c=relaxed/simple;
	bh=bl2+o/WkQkGCSk15GNjJiRdpMmRAtmnRLdbT6d3j4Oo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pECPGOPzgI4lb+llZWXTieu1TBe6ib5M1pzu+TzKjpUlVZzDfoE4aSr7x/Rog4F60GpLV8zIaiolbQiacTEXkezP/1t0EuQdtl84wND4GTspqMYBwnxCv6alLtK94Xh3poeGHGrWTJM4a4G9BkOBTZ8Uz9/vgUf5arObt1h2WdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JdLiC/u5; arc=fail smtp.client-ip=40.107.208.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JdLiC/u5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VsGBIDdgfsWpOAL05hjeEENWAEGgkMWcA36ATCZe3+ZEAGLGEVMujkI3cRA9cxD1JvQpgfQbaYf9a/VDdKdFAZHbhACfMh2jezB3OIBkTlf6fYJit0nt2x4paHnsMYSPk5YgPHC5Ryfeq4D05GeQHDpyRHCzHLMET2cDu4Y+SO9kiLscZEe9wy4yEMtkjaqqkP9gGnj59rsOIgOvy342fo7gDl9vl5n5/5N3mJbmX80KzDiS5DSCBPZMzX6uL1U2a7rCtK3/O5EhevarYIXci55AQJr2zGJo0ACCNBY/2vJ6OzDmj4o0oYbt4oUxTEj58h78DxR64ENSNuMvuxkrag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PpMiZxdXp/ZU1Ze5ZUVb0dQfTZEgN3qiON+rDJ9Dm6Y=;
 b=WEpb4srxRGuQ58kKoGwfXhvOxmMaywTUwrGEb1o9gZLVIkpRKDKrJcY/ejjmdBqub/mKoIJLiFWCYHh44QXZmw1WG7XkqWUT/ueUEUK0aKBQK44Z8zcK1GlryLQWDSnKfOgNBZljTd+4kF83DooVgNg1vM/IsVefVQH0KHym85PkXFioOisltghDM3/NWoImJ832QHDtek4GaeaM+McR0aghsTJJXMrZZZ6qzsmCW8tILySiN9mQsNDK8hyrWl8O5gyfgRk5/i/TWVLuzReS20IhelkcI5EEC0p3+UI0dBB5vOHHL+J3CuZTVXBlOSRdae4XkEemI5mTVay6p6q3qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PpMiZxdXp/ZU1Ze5ZUVb0dQfTZEgN3qiON+rDJ9Dm6Y=;
 b=JdLiC/u5Ac7b9+H9UE6HKntHt0XYRmVhWXMH8087af/8HgxMrt//uqlt/sN/i0ZS0S1bjbRcPlN+qKhokv9AWLRFl7jxeiwRi24hI4b7GNmhrWxqaPpVHFI6eVxO4dATP2a52HvHTXsmJkL5TN2/cnJNxrQDOtzISTWtysbBnwY=
Received: from DS1PR02CA0007.namprd02.prod.outlook.com (2603:10b6:8:452::11)
 by DS1PR12MB999188.namprd12.prod.outlook.com (2603:10b6:8:495::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Tue, 30 Jun
 2026 18:03:39 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:8:452:cafe::36) by DS1PR02CA0007.outlook.office365.com
 (2603:10b6:8:452::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Tue, 30
 Jun 2026 18:03:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 18:03:39 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 30 Jun
 2026 13:03:36 -0500
Received: from flamewok (10.180.168.240) by satlexmb07.amd.com (10.181.42.216)
 with Microsoft SMTP Server id 15.2.2562.41 via Frontend Transport; Tue, 30
 Jun 2026 13:03:35 -0500
From: <sunpeng.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <mario.limonciello@amd.com>,
	<wiagn233@outlook.com>, <sysdadmin@m1k.cloud>, <timur.kristof@gmail.com>,
	<xaver.hugl@kde.org>, <mario.kleiner.de@gmail.com>,
	<michel.daenzer@mailbox.org>, <matthew.schwartz@linux.dev>,
	<chris@kode54.net>, Leo Li <sunpeng.li@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH v3 2/3] drm/amd/display: check GRPH_FLIP status before sending event
Date: Tue, 30 Jun 2026 14:03:00 -0400
Message-ID: <20260630180301.362070-3-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260630180301.362070-1-sunpeng.li@amd.com>
References: <20260630180301.362070-1-sunpeng.li@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|DS1PR12MB999188:EE_
X-MS-Office365-Filtering-Correlation-Id: 92712aef-b568-41d5-70de-08ded6d1e9e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|32650700020|23010399003|36860700016|82310400026|1800799024|376014|7416014|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	7ytR8EIzfX3sOG71u3tv0ARSWRqAIw0Ji++uFvGx5XHBBEXGoERCq1JfF2vBK4CFdjhWYTSHmIb+sacuLWe6B67AHIVpRF1P4ezX1ilf7VmB5tMfr+hTV+3+NssJ5jutoeoB9mf0ihjfsqfCCYEa8N1D7uYYZoa25MQIaNpC/R1bFOwMj4w8qT5ub/hwKD1txSnYBVnjM9X50Z0hN1+nXRd8EE4ByVh6zje6j5FeHKrmBMMNC99IL4A+ilrZv/e2ZK3gY+kERK5mTe7vyWGvKXDqoeXTRouH1hBwiOSwONhR0UIowQ7yzgBNpe0wepbRZtt5Rlepj00g9OdgLd4ciSiWXw14twecY2h8k8vUYpbXN8mUdxwzJaJlpF6NspqpOi5qN46vIajqTA+RvNjmx1iaKL6h4WR2n8VLObmtBcQzQHRjYKOHc8bqLmWTntyCikpjX++pB6DcmVjt/Ugl0v3xhzsuyBj3wCs5ohLb7eh7oo1vIkyQ+iaSIt6bgoR71ATqWy1tXz0N+M7Hq7MK0qAt+Bk7fgaBf6x4trQfth7tV9lJ+P+l+rs1+pgPyFZKw9AXjc7fp5oaT3pdobBtM8NTpI1iMuV25h/mKjvdXdPA93xj2yPh3IWFqLhBiBXxVOR7aEB4uz4aPCI1XO5qHkEXm/gjW45huSnJnBGUGZXgFeEHJJ5qpQP7NcjjxZYk/EToGW7QVWL+ksz+Bok6JA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(32650700020)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(7416014)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hBLP2a//VMV29YjHL41/RIFZn5iP1OanGBrMgJotEdAlYpC009p5m8+AohK0Oes9QzgsI9ZF28SPmVsuyZ8cDVRXTt7QZfjugTu8QlI7oET7adNbbkHlNoHq/5mabpcuYuSIzDDmkLQt1zkJWvSHcS2JQ37xo3HDbXaidJ0xDCOg2B4HNcdnnxd0W5gR6mPihUnd45U02OzQs5ukJhPJn+TEVo6a1lk1xHEK9X8vK1U7OXkrbTuqm9zUo8G875D2nkFn/s5sumMZXZSvSlIUJOE6nAfTgInT6syFayiqwlDqcxrlOnSp/bb/6Bhbbx1xK/jcWv8Rm7lh17UheKOwqJuxdKrMoqDqEVJ/v228HkCaDRQg8bbpdJMGJ2RCsGvtLer7vVeq/tc/RvTR7tXpRQqLPb8JuAcfVqiNgTekgTYi/9prug+IR8wFHPI5OJzt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 18:03:39.2962
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92712aef-b568-41d5-70de-08ded6d1e9e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR12MB999188

From: Leo Li <sunpeng.li@amd.com>

[Why]

After unifying DCN interrupt sources under VUPDATE_NO_LOCK, we have two
remaining issues to clean up:

1. On DCN, flip completion is now delivered from VUPDATE_NO_LOCK
   (dm_crtc_high_irq_handler) instead of GRPH_PFLIP. But VUPDATE_NO_LOCK
   fires every frame, regardless of whether a flip has latched.

2. There is a window during commit where a flip is armed (pflip_status =
   SUBMITTED) but not yet programmed into HW. If the VUPDATE_NO_LOCK
   fires in that window, its handler would deliver a flip event to
   userspace before HW has latched to it. If userspace then renders to
   what it believes is now the back buffer (but HW is still latched to
   it!), it will cause display corruption. This issue seemed to have
   been introduced by:
   commit 1159898a88db ("drm/amd/display: Handle commit plane with no FB.")
   Enabling replay or psr extended the duration of this window, and
   hence made corruption more likely to be observed.

[How]

* Move acrtc->event/pflip_status arming to after
  update_planes_and_stream_adapter() has programmed the flip into HW.
  This closes the window where pflip_status is SUBMITTED but the flip is
  not yet programmed.

* Add dc_get_flip_pending_on_otg(), which reads the HUBP flip-pending
  status straight from HW for the pipe(s) bound to an OTG instance. It
  is keyed only by otg_inst and does not take or mutate a
  dc_plane_state, so it is safe to call from the OTG interrupt handler
  without racing a concurrent commit that may be modifying plane state.

* Optimistically query for flip-pending after programming, in the event
  that HW latched to the new fb between programming start and arming
  event. If it latched, send the vblank event immediately, rather than
  wait for the next vblank IRQ.

* In the VUPDATE_NO_LOCK handler, only deliver flip completion once
  dc_get_flip_pending_on_otg() reports the flip is no longer pending.
  Otherwise leave the flip armed and retry on the next vupdate.

* For DCE, maintain the existing behavior of arming flips before
  programming, and relying on GRPH_FLIP to fire at HW latch.

v2:
* Drop flip_programmed completion object, instead move
  event/pflip_status arming after programming.
* For DCN, optimistically query for flip pending immediately after
  programming, and if it latched, send event right away.

v3:
* Fix event timestamps on optimistic flip latch detection, where it's
  possible for it to run *before* the vupdate IRQ updates the timestamp.
* Add more docstrings for DCN vblank handling.
* Clean up if conditions in dm_arm_vblank_event().
* Code style cleanup on braces surrounding multi-line statements.

Cc: stable@vger.kernel.org
Fixes: 9b47278cec98 ("drm/amd/display: temp w/a for dGPU to enter idle optimizations")
Link: https://gitlab.freedesktop.org/drm/amd/-/work_items/3787
Link: https://gitlab.freedesktop.org/drm/amd/-/work_items/4141
Assisted-by: Copilot:claude-opus-4.8
Signed-off-by: Leo Li <sunpeng.li@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 164 ++++++++++++++----
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c |  27 ++-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  45 +++++
 drivers/gpu/drm/amd/display/dc/dc.h           |   1 +
 4 files changed, 197 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 2a64012295521..754fedbdd7460 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4126,6 +4126,28 @@ static void amdgpu_dm_enable_self_refresh(struct amdgpu_display_manager *dm,
 	}
 }
 
+static void dm_arm_vblank_event(struct amdgpu_crtc *acrtc,
+				struct dm_crtc_state *acrtc_state,
+				bool pflip_update,
+				bool cursor_update)
+{
+	assert_spin_locked(&acrtc->base.dev->event_lock);
+
+	if (!acrtc->base.state->event || acrtc_state->active_planes == 0)
+		return;
+
+	if (pflip_update) {
+		drm_crtc_vblank_get(&acrtc->base);
+		WARN_ON(acrtc->pflip_status != AMDGPU_FLIP_NONE);
+		/* Arm flip completion handling and event delivery after programming. */
+		prepare_flip_isr(acrtc);
+	} else if (cursor_update) {
+		drm_crtc_vblank_get(&acrtc->base);
+		acrtc->event = acrtc->base.state->event;
+		acrtc->base.state->event = NULL;
+	}
+}
+
 static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 				    struct drm_device *dev,
 				    struct amdgpu_display_manager *dm,
@@ -4149,6 +4171,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 	bool cursor_update = false;
 	bool pflip_present = false;
 	bool immediate_flip = false;
+	bool flip_latched_during_prog = false;
 	bool dirty_rects_changed = false;
 	bool updated_planes_and_streams = false;
 	struct {
@@ -4381,39 +4404,24 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 			usleep_range(1000, 1100);
 		}
 
-		/**
-		 * Prepare the flip event for the pageflip interrupt to handle.
-		 *
-		 * This only works in the case where we've already turned on the
-		 * appropriate hardware blocks (eg. HUBP) so in the transition case
-		 * from 0 -> n planes we have to skip a hardware generated event
-		 * and rely on sending it from software.
-		 */
-		if (acrtc_attach->base.state->event &&
-		    acrtc_state->active_planes > 0) {
-			drm_crtc_vblank_get(pcrtc);
-
-			spin_lock_irqsave(&pcrtc->dev->event_lock, flags);
-
-			WARN_ON(acrtc_attach->pflip_status != AMDGPU_FLIP_NONE);
-			prepare_flip_isr(acrtc_attach);
-
-			spin_unlock_irqrestore(&pcrtc->dev->event_lock, flags);
-		}
-
 		if (acrtc_state->stream) {
 			if (acrtc_state->freesync_vrr_info_changed)
 				bundle->stream_update.vrr_infopacket =
 					&acrtc_state->stream->vrr_infopacket;
 		}
-	} else if (cursor_update && acrtc_state->active_planes > 0) {
-		spin_lock_irqsave(&pcrtc->dev->event_lock, flags);
-		if (acrtc_attach->base.state->event) {
-			drm_crtc_vblank_get(pcrtc);
-			acrtc_attach->event = acrtc_attach->base.state->event;
-			acrtc_attach->base.state->event = NULL;
+	}
+
+	/*
+	 * DCE depends on a combination of GRPH_FLIP, VLINE0, and VUPDATE for
+	 * event delivery. Only GRPH_FLIP handler can send pflip events, and it
+	 * only fires if HW latched to the flip. Maintain legacy behavior by
+	 * arming event before programming.
+	 */
+	if (amdgpu_ip_version(dm->adev, DCE_HWIP, 0) == 0) {
+		scoped_guard(spinlock_irqsave, &pcrtc->dev->event_lock) {
+			dm_arm_vblank_event(acrtc_attach, acrtc_state,
+					pflip_present, cursor_update);
 		}
-		spin_unlock_irqrestore(&pcrtc->dev->event_lock, flags);
 	}
 
 	/* Update the planes if changed or disable if we don't have any. */
@@ -4506,17 +4514,103 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 		amdgpu_dm_commit_cursors(state);
 
 	/*
-	 * On DCN, flip completion is normally delivered from VUPDATE_NO_LOCK.
-	 * However, an immediate (tearing / async) flip is latched by HW right
-	 * away and does not wait for the next vupdate, so deliver its
-	 * completion event here after programming.
+	 * DCN specific vblank handling
+	 * ============================
+	 *
+	 * With the event_lock held, arm the vblank event, and determine whether
+	 * deliver it immediately, or in VUPDATE_NO_LOCK IRQ (i.e. HW latch
+	 * point) handler. Do this *after* programming so that the IRQ handler
+	 * will not deliver the event before HW laches onto the programmed
+	 * values:
+	 *
+	 *     Commit thread      IRQ handler                       HW
+	 *     -----------------------------------------------------------------
+	 *     arm_vblank_event()
+	 *                                                          vupdate()
+	 *                        vupdate_handler()
+	 *                          cook_timestamp()
+	 *                          # prev flip already latched,
+	 *                          # so flip_latched == true.
+	 *                          if event_armed && flip_latched:
+	 *                            send_vblank_event()
+	 *                            # sent before latch, **BAD!**
+	 *     hw_program()
+	 *                                                          vupdate()
+	 *                                                          **latch**
+	 *
+	 * There's a consequence of arming after: it's possible for HW to latch
+	 * between start of HW programming and acrtc->event/pflip_status arming.
+	 * When this happens, the IRQ handler will send the event on the next
+	 * immediate latch point, even though HW has already latched. This is
+	 * handled by optimistically checking for HW latch after programming,
+	 * and if latched, send the event immediately:
+	 *
+	 *     Commit thread             IRQ handler                HW
+	 *     -----------------------------------------------------------------
+	 *     hw_program()
+	 *                                                          vupdate()
+	 *                                                          **latch**
+	 *                               vupdate_handler()
+	 *                                 cook_timestamp()
+	 *                                 # event_armed == false
+	 *                                 # **no event sent!**
+	 *     arm_vblank_event()
+	 *     if flip_latched:
+	 *       **send_vblank_event()**
+	 *       disarm_vblank_event()
+	 *
+	 * The IRQ handler is expected to cook the timestamp, but we need to
+	 * cook the timestamp before optimistic sending as well. That's because
+	 * the following sequence is possible:
 	 *
-	 * On DCE, GRPH_PFLIP already fires immediately for immediate flips, so
-	 * this is DCN-only.
+	 *     Commit thread              IRQ handler              HW
+	 *     -----------------------------------------------------------------
+	 *     hw_program()
+	 *     arm_vblank_event()
+	 *                                                         vupdate()
+	 *                                                         **latch**
+	 *     if flip_latched:
+	 *       # Need cook before send!
+	 *       **cook_timestamp()**
+	 *       send_vblank_event()
+	 *       disarm_vblank_event()
+	 *                                vupdate_handler()
+	 *                                  cook_timestamp()
+	 *                                  # event_armed == false
+	 *                                  # no event sent!
+	 *
+	 * Cooking twice is OK, since DRM scanout accurate timestamps report A)
+	 * the previous vactive start if currently in vactive, or B) the next
+	 * vactive start if currently in vblank (see &get_vblank_counter). 'A)'
+	 * is what we want for the optimistic send, and for 'B)', we'll cook a
+	 * timestamp no later than the next IRQ handler run.
+	 *
+	 * The more correct fix is to wrap programming and arming with the
+	 * event_lock and thus serializing it with the IRQ handler. However,
+	 * there are various sleep-waits within
+	 * update_planes_and_stream_adapter() that makes spin locking illegal.
+	 * And on full updates, it can take 1-2 frame-times to return (see
+	 * commit_planes_for_stream).
+	 *
+	 * On DCE, GRPH_PFLIP IRQ is used and takes care of this.
 	 */
-	if (immediate_flip && amdgpu_ip_version(dm->adev, DCE_HWIP, 0) != 0) {
+	if (amdgpu_ip_version(dm->adev, DCE_HWIP, 0) != 0) {
 		spin_lock_irqsave(&pcrtc->dev->event_lock, flags);
-		if (acrtc_attach->pflip_status == AMDGPU_FLIP_SUBMITTED &&
+
+		if (updated_planes_and_streams) {
+			flip_latched_during_prog =
+				!dc_get_flip_pending_on_otg(dm->dc, acrtc_attach->otg_inst);
+		}
+
+		dm_arm_vblank_event(acrtc_attach, acrtc_state,
+				    pflip_present, cursor_update);
+
+		/*
+		 * Deliver the event immediately on immediate flip, or on a
+		 * update that has already latched.
+		 */
+		if ((immediate_flip || flip_latched_during_prog) &&
+		    acrtc_attach->pflip_status == AMDGPU_FLIP_SUBMITTED &&
 		    acrtc_attach->event) {
 			drm_crtc_accurate_vblank_count(&acrtc_attach->base);
 			drm_crtc_send_vblank_event(&acrtc_attach->base,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
index 5c0ff345150d3..06708051d051c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
@@ -1982,13 +1982,30 @@ static void dm_crtc_high_irq_handler(struct amdgpu_device *adev,
 	 * Deliver pageflip completion events (DCN only).
 	 *
 	 * Since GRPH_PFLIP is not used, VUPDATE_NO_LOCK is the flip latch
-	 * point. Deliver any pending pageflip completion event from here.
+	 * point. Deliver any pending pageflip completion event from here,
+	 * once HW has consumed the new address (the OTG no longer reports a
+	 * pending flip).
 	 *
-	 * NOTE: This can deliver an event for a flip that was armed but not yet
-	 * programmed into HW; that race is closed in a follow-up change by
-	 * checking the programmed flip status.
+	 * Also handle the case here where there aren't any active planes and
+	 * DCN HUBP may be clock-gated, so the flip-pending status may be
+	 * undefined.
 	 */
-	if (is_dcn && acrtc->pflip_status == AMDGPU_FLIP_SUBMITTED) {
+	if (is_dcn && acrtc->pflip_status == AMDGPU_FLIP_SUBMITTED &&
+	    acrtc->event) {
+
+		if (!dc_get_flip_pending_on_otg(adev->dm.dc, acrtc->otg_inst)) {
+			drm_crtc_send_vblank_event(&acrtc->base, acrtc->event);
+			acrtc->event = NULL;
+			drm_crtc_vblank_put(&acrtc->base);
+			acrtc->pflip_status = AMDGPU_FLIP_NONE;
+		}
+		/*
+		 * If the flip is still pending, leave it armed and
+		 * retry on the next vupdate.
+		 */
+	} else if (is_dcn && acrtc->pflip_status == AMDGPU_FLIP_SUBMITTED &&
+		   acrtc->dm_irq_params.active_planes == 0) {
+
 		if (acrtc->event) {
 			drm_crtc_send_vblank_event(&acrtc->base, acrtc->event);
 			acrtc->event = NULL;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 7a635f906f037..a77e56fc2fb2d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -6220,6 +6220,51 @@ void dc_interrupt_ack(struct dc *dc, enum dc_irq_source src)
 	dal_irq_service_ack(dc->res_pool->irqs, src);
 }
 
+/*
+ * dc_get_flip_pending_on_otg() - Check if a GRPH_FLIP is still pending on OTG
+ *
+ * @dc: display core context @otg_inst: OTG instance to query
+ *
+ * Reads the HUBP flip-pending status for the pipe(s) bound to @otg_inst,
+ * returning true if any of them has not yet latched its programmed surface
+ * address.
+ *
+ * Unlike dc_plane_get_status(), this does not take or mutate a dc_plane_state,
+ * so it is safe to call from interrupt context without racing a concurrent
+ * commit that may be updating plane state.
+ *
+ * Return: true if a flip is still pending on the OTG, false otherwise.
+ */
+bool dc_get_flip_pending_on_otg(struct dc *dc, int otg_inst)
+{
+	bool flip_pending = false;
+	int i;
+
+	if (!dc || !dc->current_state)
+		return false;
+
+	dc_exit_ips_for_hw_access(dc);
+
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe_ctx = &dc->current_state->res_ctx.pipe_ctx[i];
+		struct hubp *hubp = pipe_ctx->plane_res.hubp;
+
+		if (!pipe_ctx->plane_state || !pipe_ctx->stream_res.tg)
+			continue;
+
+		if (pipe_ctx->stream_res.tg->inst != otg_inst)
+			continue;
+
+		if (hubp && hubp->funcs->hubp_is_flip_pending &&
+		    hubp->funcs->hubp_is_flip_pending(hubp)) {
+			flip_pending = true;
+			break;
+		}
+	}
+
+	return flip_pending;
+}
+
 void dc_power_down_on_boot(struct dc *dc)
 {
 	if (dc->ctx->dce_environment != DCE_ENV_VIRTUAL_HW &&
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 13c1f7cd9d7d3..94028f18dbdfe 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -2993,6 +2993,7 @@ enum dc_irq_source dc_interrupt_to_irq_source(
 		uint32_t ext_id);
 bool dc_interrupt_set(struct dc *dc, enum dc_irq_source src, bool enable);
 void dc_interrupt_ack(struct dc *dc, enum dc_irq_source src);
+bool dc_get_flip_pending_on_otg(struct dc *dc, int otg_inst);
 enum dc_irq_source dc_get_hpd_irq_source_at_index(
 		struct dc *dc, uint32_t link_index);
 
-- 
2.54.0

