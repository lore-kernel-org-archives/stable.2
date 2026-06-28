Received: from mail.ptr1337.dev (mail.ptr1337.dev [202.61.224.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C943837646B
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 14:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.224.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782655681; cv=none; b=d58yXxkePJ3VxIuhM5tgmKaK2+qW4MHwwfJILTLBycGF8OPYPDO2FG5H3KAJJz8YA+F3DFImeIU4LThQh2Kl0h4EHkmXgBxVJXycIe6mGubVfomTsrJ2+tM7Q8qKaceVTnfRvtsAb5biaKoS+AL29d40upxaGZ7GckRDtR7Ra5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782655681; c=relaxed/simple;
	bh=F9ZuPe9nlMYcytmEspZD8sjsF8KU3UGuWNyKuW7KMlI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P4Zpiej8UD3nZFLpHn3/40Nnc6efXjikQHKlEOtwZvHJdMB2vy3gMaS0EwIs1PXEKqQYe1z/Vw5Wnj1joS+gXsm5MO6m/6/YTS5D/exCeWS9iGRGo8/MJEOBl1TY9kGvE8JQp/z1VAZwgqsBL25wBvYlx9A03hTEce+mr5ZPbHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ptr1337.dev; spf=pass smtp.mailfrom=ptr1337.dev; dkim=pass (2048-bit key) header.d=ptr1337.dev header.i=@ptr1337.dev header.b=gdIhKDZs; arc=none smtp.client-ip=202.61.224.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ptr1337.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ptr1337.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ptr1337.dev header.i=@ptr1337.dev header.b="gdIhKDZs"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 32997281B77;
	Sun, 28 Jun 2026 16:02:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ptr1337.dev; s=dkim;
	t=1782655366; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=tWKGlT6wB5yIkBQ1IVMQpAlFUJImHkHUwhQrv3J4WdM=;
	b=gdIhKDZsokGzQkXsqhoOcrahLCQaF3QbF8tpBbelw8P5FOt/hes0a87S6KLSwviGHPLj1G
	+8BRuRJQmVZXgMWng2yLjG1MxVryJQw+37fXXMp4SVXTQn7z/0zpXH5qohA4q3yLlKI91B
	0IU1RgqFm5sJanWGzg5LB8bP2LzMJpy893ZBURrktuD6UCUu+UsVjghDfgr+0J9bi+R2hR
	oLY5MeMKundDWbc/BG4+jH8VTV6U5anTPj9Dv0UsAlYa+cr2I3dsoXYeaQixcQGPEWhjY7
	3OyyofglmMSXpFqF6CSZlzryZz9zDqVIAKqcWA3luo9C8JioZEgjG+en6wDMWg==
From: Peter Jung <admin@ptr1337.dev>
To: stable@vger.kernel.org
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	alexander.deucher@amd.com,
	ray.wu@amd.com,
	superm1@kernel.org,
	"Sun peng (Leo) Li" <sunpeng.li@amd.com>,
	Ivan Lipski <ivan.lipski@amd.com>,
	Dan Wheeler <daniel.wheeler@amd.com>,
	Peter Jung <admin@ptr1337.dev>
Subject: [PATCH 7.1.y] drm/amd/display: Fix ISM dc_lock deadlock during suspend
Date: Sun, 28 Jun 2026 16:01:48 +0200
Message-ID: <20260628140148.59923-1-admin@ptr1337.dev>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Ray Wu <ray.wu@amd.com>

[ Upstream commit 3714fe242592e3699ac5e2c19d68b275a210be7d ]

CachyOS users reported a regression in shutdown/reboot behavior on 7.1
kernels: the display turns off, but the machine does not power down.
Reverting ISM fixes the regression, and this upstream fix addresses the
same ISM dc_lock/workqueue deadlock in the suspend/shutdown paths.

[Why]
System hang observed during suspend/resume while video is playing.
amdgpu_dm_ism_disable() is called under dc_lock and waits for ISM
delayed work via disable_delayed_work_sync(). The work handlers
themselves take dc_lock, producing an ABBA deadlock when a worker is
in flight at suspend time.

[How]
Split the disable path into two phases with opposite locking
contracts:
  1. amdgpu_dm_ism_disable() -- quiesces workers, must NOT hold
     dc_lock.
  2. amdgpu_dm_ism_force_full_power() (new) -- drives the ISM FSM
     back to FULL_POWER_RUNNING, must hold dc_lock.

Fixes: 754003486c3c ("drm/amd/display: Add Idle state manager(ISM)")
Link: https://github.com/CachyOS/linux-cachyos/issues/900
Cc: stable@vger.kernel.org # 7.1.y
Reviewed-by: Sun peng (Leo) Li <sunpeng.li@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Peter Jung <admin@ptr1337.dev>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 25 +++++++--
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c | 56 ++++++++++++++++---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_ism.h |  1 +
 3 files changed, 70 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index f8c13bad4ac2..560ab3298911 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2260,9 +2260,16 @@ static void amdgpu_dm_fini(struct amdgpu_device *adev)
 		adev->dm.idle_workqueue = NULL;
 	}
 
-	/* Disable ISM before dc_destroy() invalidates dm->dc */
+	/*
+	 * Disable ISM before dc_destroy() invalidates dm->dc.
+	 *
+	 * Quiesce workers first without dc_lock (they take dc_lock
+	 * themselves, so syncing under it would deadlock), then drive the
+	 * FSM back to FULL_POWER_RUNNING under dc_lock.
+	 */
+	amdgpu_dm_ism_disable(&adev->dm);
 	scoped_guard(mutex, &adev->dm.dc_lock)
-		amdgpu_dm_ism_disable(&adev->dm);
+		amdgpu_dm_ism_force_full_power(&adev->dm);
 
 	amdgpu_dm_destroy_drm_device(&adev->dm);
 
@@ -3290,9 +3297,14 @@ static int dm_suspend(struct amdgpu_ip_block *ip_block)
 	if (amdgpu_in_reset(adev)) {
 		enum dc_status res;
 
+		/* Quiesce ISM workers before taking dc_lock (workers take
+		 * dc_lock themselves; syncing under it would deadlock).
+		 */
+		amdgpu_dm_ism_disable(dm);
+
 		mutex_lock(&dm->dc_lock);
 
-		amdgpu_dm_ism_disable(dm);
+		amdgpu_dm_ism_force_full_power(dm);
 		dc_allow_idle_optimizations(adev->dm.dc, false);
 
 		dm->cached_dc_state = dc_state_create_copy(dm->dc->current_state);
@@ -3326,8 +3338,13 @@ static int dm_suspend(struct amdgpu_ip_block *ip_block)
 
 	amdgpu_dm_irq_suspend(adev);
 
+	/*
+	 * Quiesce ISM workers before taking dc_lock (workers take dc_lock
+	 * themselves; syncing under it would deadlock).
+	 */
+	amdgpu_dm_ism_disable(dm);
 	scoped_guard(mutex, &dm->dc_lock)
-		amdgpu_dm_ism_disable(dm);
+		amdgpu_dm_ism_force_full_power(dm);
 
 	hpd_rx_irq_work_suspend(dm);
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
index a64e95860e99..b32c8d3ac152 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
@@ -524,13 +524,20 @@ static void dm_ism_sso_delayed_work_func(struct work_struct *work)
 }
 
 /**
- * amdgpu_dm_ism_disable - Disable the ISM
+ * amdgpu_dm_ism_disable - Quiesce ISM workers
  *
  * @dm: The amdgpu display manager
  *
- * Disable the idle state manager by disabling any ISM work, canceling pending
- * work, and waiting for in-progress work to finish. After disabling, the system
- * is left in DM_ISM_STATE_FULL_POWER_RUNNING state.
+ * Cancels and disables any pending or in-flight ISM delayed work and waits
+ * for in-progress work to finish. After this returns, no ISM worker can run
+ * and subsequent mod_delayed_work() calls become no-ops via
+ * clear_pending_if_disabled().
+ *
+ * Must NOT be called with dc_lock held: the workers themselves take dc_lock,
+ * so a synchronous wait under dc_lock would deadlock.
+ *
+ * The caller is responsible for driving the FSM back to FULL_POWER_RUNNING
+ * (under dc_lock) by calling amdgpu_dm_ism_force_full_power().
  */
 void amdgpu_dm_ism_disable(struct amdgpu_display_manager *dm)
 {
@@ -538,21 +545,54 @@ void amdgpu_dm_ism_disable(struct amdgpu_display_manager *dm)
 	struct amdgpu_crtc *acrtc;
 	struct amdgpu_dm_ism *ism;
 
-	ASSERT(mutex_is_locked(&dm->dc_lock));
+	/*
+	 * Caller must NOT hold dc_lock: the ISM delayed work handlers
+	 * acquire dc_lock themselves, so waiting for them via
+	 * disable_delayed_work_sync() while holding dc_lock would
+	 * self-deadlock against an in-flight worker.
+	 */
+	lockdep_assert_not_held(&dm->dc_lock);
 
 	drm_for_each_crtc(crtc, dm->ddev) {
 		acrtc = to_amdgpu_crtc(crtc);
 		ism = &acrtc->ism;
 
-		/* Cancel and disable any pending work */
 		disable_delayed_work_sync(&ism->delayed_work);
 		disable_delayed_work_sync(&ism->sso_delayed_work);
+	}
+}
+
+/**
+ * amdgpu_dm_ism_force_full_power - Force every CRTC's ISM FSM to FULL_POWER
+ *
+ * @dm: The amdgpu display manager
+ *
+ * Sends DM_ISM_EVENT_EXIT_IDLE_REQUESTED to every CRTC's ISM, leaving each
+ * FSM in FULL_POWER_RUNNING. Intended to be paired with
+ * amdgpu_dm_ism_disable(): callers should first quiesce workers (without
+ * dc_lock), then take dc_lock and call this helper.
+ *
+ * Must be called with dc_lock held.
+ */
+void amdgpu_dm_ism_force_full_power(struct amdgpu_display_manager *dm)
+{
+	struct drm_crtc *crtc;
+	struct amdgpu_crtc *acrtc;
+
+	/*
+	 * Caller must hold dc_lock: commit_event() drives the FSM and
+	 * may touch dc state via dc_allow_idle_optimizations() etc.
+	 */
+	lockdep_assert_held(&dm->dc_lock);
+
+	drm_for_each_crtc(crtc, dm->ddev) {
+		acrtc = to_amdgpu_crtc(crtc);
 
 		/*
 		 * When disabled, leave in FULL_POWER_RUNNING state.
-		 * EXIT_IDLE will not queue any work
+		 * EXIT_IDLE will not queue any work.
 		 */
-		amdgpu_dm_ism_commit_event(ism,
+		amdgpu_dm_ism_commit_event(&acrtc->ism,
 					   DM_ISM_EVENT_EXIT_IDLE_REQUESTED);
 	}
 }
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.h
index fde0ddc8d4e4..964408cd9a83 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.h
@@ -146,6 +146,7 @@ void amdgpu_dm_ism_fini(struct amdgpu_dm_ism *ism);
 void amdgpu_dm_ism_commit_event(struct amdgpu_dm_ism *ism,
 				enum amdgpu_dm_ism_event event);
 void amdgpu_dm_ism_disable(struct amdgpu_display_manager *dm);
+void amdgpu_dm_ism_force_full_power(struct amdgpu_display_manager *dm);
 void amdgpu_dm_ism_enable(struct amdgpu_display_manager *dm);
 
 #endif
-- 
2.54.0

