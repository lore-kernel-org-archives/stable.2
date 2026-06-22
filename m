Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012043.outbound.protection.outlook.com [40.107.200.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B6E2E7F39
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 17:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782148701; cv=fail; b=t9ZA+7Ly2FqsHC0FeGUN1WbDOGE1JddrXrYL977uFsNYzATVVUY4OCkwIkiDbm602DR8rit00KH6oBq0WRp6HrhDbbS/gramnoHe1YD/aj5muySCelCI+UFeC8MfRcAkxzHTXiyF/zsEYbcdcDhZShHvNM8wwd8U73dnjwp30ac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782148701; c=relaxed/simple;
	bh=yPKLyzPJxqQOLu/heO2YX57fwwA22Kz9D3cb6SH90uA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cim1kELetw8L7BqlIfH9IfIvuXmnzIh+G3+Sur1p+krxbONyXxfggrwt4O2nkRyydfgHLEY9CcNuxQk/orNdrToVQSlmhxVY9meqy8ap8YPX5YzS6s/3sGtrlo9EhhaUnV4+EgMalBQmn/2ppVHTTArpewF1Qdiju+svmkAB0as=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qVYWk6nh; arc=fail smtp.client-ip=40.107.200.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qVYWk6nh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s3WzOOAeLgPKdgqNm7IkY8M0dkVqeQckdEe+9lqPyBcwJM3E3xpEpplDG/sXxExHaJNHIqjm66U9Vtvkp+GOTW6808Va1ggv/YatlWu7dFMg8+2x6x6Zcrlt7KHloCyy3mCuAksKGR3Sv+HztlrAOs11RGY6MJ+qNpJhorglCS2sj5d92L4XWtTadM3wlKYF1vfzlPByjGHcyjC1cPbQrx0oSPePrgRRblQoDB9q6fr8dBCNDH3NanmZWQ4SSQJJP8jrNqD9acn/Wf6+021acb8hPDjuge6mYJW52torewPRVXgP8ZgS3BBjdlTTAyxV5QAPZ9b3Gbc8+Vq6YU4xog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JDyi6CbggafWHlBnSAOg2b4VCQMoGyq3X8P36+Pwjh0=;
 b=K/aZ/5BZeNJf4Taoakp+F5TZToDCkCvsYF9BHSvWZ4a3nSpxZAwQE3juJ2MVhMZ6WxrzsQC2wZ3nNgQhKk8ZEssKjddSMV8WxdYc3PUZ803Pbgd4kAsmJGkWhHendD9lvCGirfVsyB3qFshUmSgL/FvKsehi9XDU71iw/SIVuKiFGN7RCXcvwsgKamAIFoGCK3OgbxghTywDSFgQfT1H6qrF81Pe0Z+Kj9GcKXWu8JI743CUU4dVFdtF6LleUuFOSem21nTWxqpmiyIG24Xbxz4jURlL0/yZjcWxhx0QIcLNcqnBJgZmvoNZmy0bPx7bnA0HGMz87mJz/wl27wqz8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JDyi6CbggafWHlBnSAOg2b4VCQMoGyq3X8P36+Pwjh0=;
 b=qVYWk6nhKHUTQk1ZYI/r4lsm+d9R3ZbBisemMb9ZzJR9vXWSJMIVh8pseLIMk2a3Qh9knjEb1xnjarQWvOzTGQytElQr2uCiwDKH8cynqnagxt/flJ8PqOMC4KYiiWxzekFYF296v+GGYKo5TwD0Oe/9jWxmDQw/QIWinBvNwLE=
Received: from CH2PR14CA0044.namprd14.prod.outlook.com (2603:10b6:610:56::24)
 by MW4PR12MB7261.namprd12.prod.outlook.com (2603:10b6:303:229::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 22 Jun
 2026 17:18:05 +0000
Received: from CH1PEPF0000AD76.namprd04.prod.outlook.com
 (2603:10b6:610:56:cafe::50) by CH2PR14CA0044.outlook.office365.com
 (2603:10b6:610:56::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Mon,
 22 Jun 2026 17:18:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD76.mail.protection.outlook.com (10.167.244.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 17:18:04 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 22 Jun
 2026 12:18:04 -0500
Received: from flamewok (10.180.168.240) by satlexmb07.amd.com (10.181.42.216)
 with Microsoft SMTP Server id 15.2.2562.41 via Frontend Transport; Mon, 22
 Jun 2026 12:18:03 -0500
From: <sunpeng.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <mario.limonciello@amd.com>,
	<wiagn233@outlook.com>, <sysdadmin@m1k.cloud>, <timur.kristof@gmail.com>,
	<xaver.hugl@kde.org>, <mario.kleiner.de@gmail.com>,
	<michel.daenzer@mailbox.org>, <matthew.schwartz@linux.dev>,
	<chris@kode54.net>, Leo Li <sunpeng.li@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH v2 2/3] drm/amd/display: check GRPH_FLIP status before sending event
Date: Mon, 22 Jun 2026 13:17:49 -0400
Message-ID: <20260622171752.73374-3-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260622171752.73374-1-sunpeng.li@amd.com>
References: <20260622171752.73374-1-sunpeng.li@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD76:EE_|MW4PR12MB7261:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ea43641-03bf-4081-033e-08ded08238c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|7416014|376014|23010399003|1800799024|32650700020|22082099003|18002099003|11063799006|56012099006|13003099007;
X-Microsoft-Antispam-Message-Info:
	/G4emsDa1K5p3g9+mDgGxK3t8KGVCL0R3kkOdvKFP1ulsxpRS/D6rUb9xKfLr3GgTU8+f3bAo02y+zi+44mKIH0Kk7+LAWaMYXZlvTVSJdTkLdVbRCA9CgxPLIhuR6jIi3AUHxVOhE4hIS85BEIV1tQeb1EWbrpkLEB7A1Ljm5s+AtyYZ0NIrZ7SRlR0Mgni2K14irwJFdSMvC4RKeZ2f1/Pr4fKyLeEN2u+OIQgfuEkEYc1iFVBHz20z9q60sqDz2WkstqwYuQmZfi3lwo9tmN1g+nwsyPYXlCVjD29BYhTPy7W5pTCWsRLu6BOlEFQznRyF5Lrkd+k7k6fIdepExsLHJv1Q4Glx37wCPge4QynqKZuLpNDOyYYN1T85XT+d8MINuAOm3OiJ4dZ+YkmS/y7gGlXJMwDSmVfu1ypfa4oReYC1WY2gHiKO7R91zdq3VrfyhQfE/obKfSR3IyhOGbqQQGEVI/INMPWuvNh0q7YPOL5IclOnJouV8PDUJza1fHZPOPfPqHtwuw/JlqnvsLOvafhVxH8PrZDGv+QckNWxA2Z702SUga7BLLCu4pSrKLbZy8DWmy5oxR60BWkUHfgU7oo49es8rDY4sgzser3d4oK4DMQZO5Vf8H9549QEIgQvIlLBz0Hk1YiGT4JQQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(7416014)(376014)(23010399003)(1800799024)(32650700020)(22082099003)(18002099003)(11063799006)(56012099006)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+1m6HcIMc7GlsCDAFEniGAkec73O3VkUJG1QrlzVUNLD8cNscQRpwfNKOf4HsV/66objnqyrzm0135Dij4ZEnz/nxtyyWoq8/03q0PI6xe93AmofdaSIqMS9BNXTzox0EMhCc7ChmDrbR16tWwEf+aE/vz6lMO1r05g1DwgSKr129uJvVBO3ujtlcECC8agE+W/V0e4qHiF0CtZBziWhCwYdzMT57dfp/NDf3ZnQDnP11mV2C8hs1ZXKKQbqii1yE+klmfHfnLIKVXyOTsjlBIrueqNosbQVD5c0frGTsjeVrIjKyWg7nzdn8ozUcSl4+eT5SJ1Ihg6pmR3vXuhCZGHjp7KT27gSQ0ORZ9/EQTWZojb5DLJECMayIQfDuzmfVlQLn0FpPJm8DQNWJ1+/5BJWG66eLUYX58holuy6Djd1VdsTqJT2H+rjb0cAxGGF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 17:18:04.9450
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ea43641-03bf-4081-033e-08ded08238c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD76.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7261

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

Cc: stable@vger.kernel.org
Fixes: 9b47278cec98 ("drm/amd/display: temp w/a for dGPU to enter idle optimizations")
Link: https://gitlab.freedesktop.org/drm/amd/-/work_items/3787
Link: https://gitlab.freedesktop.org/drm/amd/-/work_items/4141
Assisted-by: Copilot:claude-opus-4.8
Signed-off-by: Leo Li <sunpeng.li@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 125 ++++++++++++------
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c |  27 +++-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  45 +++++++
 drivers/gpu/drm/amd/display/dc/dc.h           |   1 +
 4 files changed, 156 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index da118377b73a8..732ddafb5cfea 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4135,6 +4135,28 @@ static void amdgpu_dm_enable_self_refresh(struct amdgpu_display_manager *dm,
 	}
 }
 
+static void dm_arm_vblank_event(struct amdgpu_crtc *acrtc,
+				struct dm_crtc_state *acrtc_state,
+				bool pflip_update,
+				bool cursor_update)
+{
+	assert_spin_locked(&acrtc->base.dev->event_lock);
+
+	if (pflip_update && acrtc->base.state->event &&
+	acrtc_state->active_planes > 0) {
+		drm_crtc_vblank_get(&acrtc->base);
+		WARN_ON(acrtc->pflip_status != AMDGPU_FLIP_NONE);
+		/* Arm flip completion handling and event delivery after programming. */
+		prepare_flip_isr(acrtc);
+	} else if (cursor_update && acrtc_state->active_planes > 0) {
+		if (acrtc->base.state->event) {
+			drm_crtc_vblank_get(&acrtc->base);
+			acrtc->event = acrtc->base.state->event;
+			acrtc->base.state->event = NULL;
+		}
+	}
+}
+
 static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 				    struct drm_device *dev,
 				    struct amdgpu_display_manager *dm,
@@ -4158,6 +4180,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 	bool cursor_update = false;
 	bool pflip_present = false;
 	bool immediate_flip = false;
+	bool flip_latched_during_prog = false;
 	bool dirty_rects_changed = false;
 	bool updated_planes_and_streams = false;
 	struct {
@@ -4390,39 +4413,23 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
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
-		}
-		spin_unlock_irqrestore(&pcrtc->dev->event_lock, flags);
+	}
+
+	/*
+	 * DCE depends on a combination of GRPH_FLIP, VLINE0, and VUPDATE for
+	 * event delivery. Only GRPH_FLIP handler can send pflip events, and it
+	 * only fires if HW latched to the flip. Maintain legacy behavior by
+	 * arming event before programming.
+	 */
+	if (amdgpu_ip_version(dm->adev, DCE_HWIP, 0) == 0) {
+		scoped_guard(spinlock_irqsave, &pcrtc->dev->event_lock)
+			dm_arm_vblank_event(acrtc_attach, acrtc_state,
+					pflip_present, cursor_update);
 	}
 
 	/* Update the planes if changed or disable if we don't have any. */
@@ -4515,19 +4522,63 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 		amdgpu_dm_commit_cursors(state);
 
 	/*
-	 * On DCN, flip completion is normally delivered from VUPDATE_NO_LOCK.
-	 * However, an immediate (tearing / async) flip is latched by HW right
-	 * away and does not wait for the next vupdate, so deliver its
-	 * completion event here after programming.
+	 * DCN specific vblank handling:
+	 *
+	 * With the event_lock held, arm the vblank event, and determine whether
+	 * deliver it immediately, or in VUPDATE_NO_LOCK IRQ handler. Do this
+	 * *after* programming so that vblank IRQ(s) will not deliver the event
+	 * before HW consumes it.
+	 *
+	 * There's a consequence of arming after: it's possible for the IRQ to
+	 * fire between HW programming and acrtc->event/pflip_status arming
+	 * below. When this happens, the handler will skip event sending and
+	 * flip_done signaling, even though HW has latched onto the programmed
+	 * values, and send it on the next vblank.
+	 *
+	 * The more correct fix is to wrap programming and arming with the
+	 * event_lock and thus serializing it with the IRQ handler. However,
+	 * there are various sleep-waits on within
+	 * update_planes_and_stream_adapter() that makes spin locking illegal.
+	 * And on full updates, it can take 1-2 frame-times to return (see
+	 * commit_planes_for_stream).
 	 *
-	 * On DCE, GRPH_PFLIP already fires immediately for immediate flips, so
-	 * this is DCN-only.
+	 * Details of how this is handled are in comments below.
 	 */
-	if (immediate_flip && amdgpu_ip_version(dm->adev, DCE_HWIP, 0) != 0) {
+	if (amdgpu_ip_version(dm->adev, DCE_HWIP, 0) != 0) {
 		spin_lock_irqsave(&pcrtc->dev->event_lock, flags);
-		if (acrtc_attach->pflip_status == AMDGPU_FLIP_SUBMITTED &&
+		/*
+		 * By the time programming returns, it's possible that HW has
+		 * already latched. So, optimistically query whether HW latching
+		 * has occurred, and if so, send out the event immediately
+		 * rather than wait for the next IRQ.
+		 */
+		if (updated_planes_and_streams)
+			flip_latched_during_prog =
+				!dc_get_flip_pending_on_otg(dm->dc, acrtc_attach->otg_inst);
+
+		dm_arm_vblank_event(acrtc_attach, acrtc_state,
+				    pflip_present, cursor_update);
+
+		/*
+		 * Deliver the event immediately on immediate flip, or on a
+		 * update that has already latched.
+		 *
+		 * Since drm_send_vblank_event() uses cooked values from the
+		 * last drm_update_vblank_count(), which the VUPDATE_NO_LOCK irq
+		 * handler hits via drm_crtc_handle_vblank(), the count and
+		 * timestamp correctly reflect the most recent HW latch point.
+		 *
+		 * However, for immediate flips, the HW latch point is
+		 * immediately after programming; the vblank count and timestamp
+		 * need to be cooked again before sending.
+		 *
+		 * On DCE, GRPH_PFLIP used and takes care of this.
+		 */
+		if ((immediate_flip || flip_latched_during_prog) &&
+		    acrtc_attach->pflip_status == AMDGPU_FLIP_SUBMITTED &&
 		    acrtc_attach->event) {
-			drm_crtc_accurate_vblank_count(&acrtc_attach->base);
+			if (immediate_flip)
+				drm_crtc_accurate_vblank_count(&acrtc_attach->base);
 			drm_crtc_send_vblank_event(&acrtc_attach->base,
 						   acrtc_attach->event);
 			acrtc_attach->event = NULL;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
index d0181c797b71e..6018bccba7e5b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
@@ -1991,13 +1991,30 @@ static void dm_crtc_high_irq_handler(struct amdgpu_device *adev,
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
index ae776519e6ea6..330f31578cb03 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -6219,6 +6219,51 @@ void dc_interrupt_ack(struct dc *dc, enum dc_irq_source src)
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
index 0e115b1aac5f7..81076d6287922 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -2992,6 +2992,7 @@ enum dc_irq_source dc_interrupt_to_irq_source(
 		uint32_t ext_id);
 bool dc_interrupt_set(struct dc *dc, enum dc_irq_source src, bool enable);
 void dc_interrupt_ack(struct dc *dc, enum dc_irq_source src);
+bool dc_get_flip_pending_on_otg(struct dc *dc, int otg_inst);
 enum dc_irq_source dc_get_hpd_irq_source_at_index(
 		struct dc *dc, uint32_t link_index);
 
-- 
2.54.0

