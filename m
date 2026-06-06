Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25FD1AF4E9
	for <stable@vger.kernel.org>; Sat,  6 Jun 2026 02:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780712324; cv=none; b=kIRaETWQk8acR0feIjMj7XBtOemjETixLhaIc0IaBXmoRqYt28t20o4MdWJcjQOTvoZfVUVRGyzfQxKz57SNu2mjBBaFoVUm5SVv7YjQxU0CC8xEBw02Hl1lkO/2j5KIGt9eZqkJvWevlUW1/SCS8mPrH1zbDXCIIUCLeoh3bsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780712324; c=relaxed/simple;
	bh=fpfLaxOnfx2p+7wHIbKVisirkuNlVXhWV3aMvjn1WM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F3kOlCvC5wuoQVZYXsCvQwuEsdpMUCs5vqzGKitdd8pdmd4g9phhNnrAu7VCwitk9NrJo0t28PnkcEvnmBqyFdkvQkrv/Ci3TlrpnxgssRCHfPse97hZ7VH+WdwDef53sLkBOTtg3Pg1ORGP4t4jKouEpD/NMvkoixOQzfnV3dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G04EB6fV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G04EB6fV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 507151F00898;
	Sat,  6 Jun 2026 02:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780712322;
	bh=fXlvfw79LWiZTzm82Dbmcr6vorx3bQHPwWKVNHhVfKg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G04EB6fVfYR+DV4EFkGLQEH1i9bE+V6Kukmb3k2pLH581XDF485FUS7eqn6OeP+DL
	 qvB0EgIzS4ARiE9vlEkfgqEz0FSiFDVTaLOhWkboih8WOfpTZVy85KNnbE/Sp2wkE0
	 7RNET063RF/MEj26fZahp61Qp6vdALQpnnJ9vSCxs5XjqUgvQlxU+33TJ6GvsYxP2v
	 Hvcz06Hp7x/Mt/4Daex7xO2mrU/mf0nac86MFoONY0ToxQGzHTLD6dSUZZtjLId4k1
	 RmmhNloA34y1vcyGakwQkzy+UVlCZ09PB2m67AEQH/iPJgw59aLUuBQxtx54siQ67e
	 Ui4NnDGw5SIew==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
	=?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] drm/i915/psr: Use DC_OFF wake reference to block DC6 on vblank enable
Date: Fri,  5 Jun 2026 22:18:39 -0400
Message-ID: <20260606021839.2487627-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260606021839.2487627-1-sashal@kernel.org>
References: <2026060434-tattoo-wise-091f@gregkh>
 <20260606021839.2487627-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jouni Högander <jouni.hogander@intel.com>

[ Upstream commit 3549a9649dc7c5fc586ab12f675279283cdcb2a7 ]

We are observing following warnings:

*ERROR* power well DC_off state mismatch (refcount 0/enabled 1)

gen9_dc_off_power_well_enabled is considering target state DC_STATE_DISABLE
as DC_OFF power well being enabled. Fix this by using wakeref for the
purpose.

To achieve this we need to modify notification code as well. Currently it
is possible that PSR gets notified vblank enable/disable twice on same
status. This is currently not a problem as it is just triggering call to
intel_display_power_set_target_dc_state with same target state as a
parameter. When using wakeref this becomes a problem due to reference
counting. Fix this storing vbank status on last notification and use that
to ensure there are no more than one notification with same vblank status.

v2: ensure there is no subsequent notifications with same status

Fixes: aa451abcffb5 ("drm/i915/display: Prevent DC6 while vblank is enabled for Panel Replay")
Cc: <stable@vger.kernel.org> # v6.13+
Signed-off-by: Jouni Högander <jouni.hogander@intel.com>
Reviewed-by: Michał Grzelak <michal.grzelak@intel.com>
Link: https://patch.msgid.link/20260520104944.239797-2-jouni.hogander@intel.com
(cherry picked from commit 35485ac56d878192a3829a58cb26503125ec7104)
Signed-off-by: Tvrtko Ursulin <tursulin@ursulin.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/i915/display/intel_display_core.h |  1 +
 .../gpu/drm/i915/display/intel_display_irq.c  |  8 +++++--
 .../drm/i915/display/intel_display_types.h    |  2 ++
 drivers/gpu/drm/i915/display/intel_psr.c      | 24 +++++++------------
 4 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display_core.h b/drivers/gpu/drm/i915/display/intel_display_core.h
index 8c226406c5cd0a..800a30b8bcd8a5 100644
--- a/drivers/gpu/drm/i915/display/intel_display_core.h
+++ b/drivers/gpu/drm/i915/display/intel_display_core.h
@@ -472,6 +472,7 @@ struct intel_display {
 		u8 vblank_enabled;
 
 		int vblank_enable_count;
+		bool vblank_status_last_notified;
 
 		struct work_struct vblank_notify_work;
 
diff --git a/drivers/gpu/drm/i915/display/intel_display_irq.c b/drivers/gpu/drm/i915/display/intel_display_irq.c
index 123e054affbe9f..21b2a193bb2157 100644
--- a/drivers/gpu/drm/i915/display/intel_display_irq.c
+++ b/drivers/gpu/drm/i915/display/intel_display_irq.c
@@ -1707,8 +1707,12 @@ static void intel_display_vblank_notify_work(struct work_struct *work)
 	struct intel_display *display =
 		container_of(work, typeof(*display), irq.vblank_notify_work);
 	int vblank_enable_count = READ_ONCE(display->irq.vblank_enable_count);
+	bool vblank_status = !!vblank_enable_count;
 
-	intel_psr_notify_vblank_enable_disable(display, vblank_enable_count);
+	if (display->irq.vblank_status_last_notified != vblank_status) {
+		intel_psr_notify_vblank_enable_disable(display, vblank_status);
+		display->irq.vblank_status_last_notified = vblank_status;
+	}
 }
 
 int bdw_enable_vblank(struct drm_crtc *_crtc)
@@ -1721,10 +1725,10 @@ int bdw_enable_vblank(struct drm_crtc *_crtc)
 	if (gen11_dsi_configure_te(crtc, true))
 		return 0;
 
+	spin_lock_irqsave(&display->irq.lock, irqflags);
 	if (crtc->vblank_psr_notify && display->irq.vblank_enable_count++ == 0)
 		schedule_work(&display->irq.vblank_notify_work);
 
-	spin_lock_irqsave(&display->irq.lock, irqflags);
 	bdw_enable_pipe_irq(display, pipe, GEN8_PIPE_VBLANK);
 	spin_unlock_irqrestore(&display->irq.lock, irqflags);
 
diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h b/drivers/gpu/drm/i915/display/intel_display_types.h
index 39dd7389f1a71a..ce9a69b6e3ee9d 100644
--- a/drivers/gpu/drm/i915/display/intel_display_types.h
+++ b/drivers/gpu/drm/i915/display/intel_display_types.h
@@ -1690,6 +1690,8 @@ struct intel_psr {
 	bool pkg_c_latency_used;
 
 	u8 active_non_psr_pipes;
+
+	struct ref_tracker *vblank_wakeref;
 };
 
 struct intel_dp {
diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index 138717cf664529..62d2bcd17002e1 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -3949,14 +3949,20 @@ void intel_psr_notify_vblank_enable_disable(struct intel_display *display,
 					    bool enable)
 {
 	struct intel_encoder *encoder;
-	bool block_dc_states = false;
 
 	for_each_intel_encoder_with_psr(display->drm, encoder) {
 		struct intel_dp *intel_dp = enc_to_intel_dp(encoder);
 
 		mutex_lock(&intel_dp->psr.lock);
-		if (CAN_PANEL_REPLAY(intel_dp))
-			block_dc_states = true;
+		if (CAN_PANEL_REPLAY(intel_dp)) {
+			if (enable)
+				intel_dp->psr.vblank_wakeref =
+					intel_display_power_get(display,
+								POWER_DOMAIN_DC_OFF);
+			else
+				intel_display_power_put(display, POWER_DOMAIN_DC_OFF,
+							intel_dp->psr.vblank_wakeref);
+		}
 
 		if (intel_dp->psr.enabled && !intel_dp->psr.panel_replay_enabled &&
 		    intel_dp->psr.pkg_c_latency_used)
@@ -3964,18 +3970,6 @@ void intel_psr_notify_vblank_enable_disable(struct intel_display *display,
 
 		mutex_unlock(&intel_dp->psr.lock);
 	}
-
-	/*
-	 * NOTE: intel_display_power_set_target_dc_state is used
-	 * only by PSR code for DC3CO handling. DC3CO target
-	 * state is currently disabled in * PSR code. If DC3CO
-	 * is taken into use we need take that into account here
-	 * as well.
-	 */
-	if (block_dc_states)
-		intel_display_power_set_target_dc_state(display, enable ?
-							DC_STATE_DISABLE :
-							DC_STATE_EN_UPTO_DC6);
 }
 
 static void
-- 
2.53.0

