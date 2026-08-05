Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3F046C836
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 12:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785931926; cv=none; b=XuvNg7tdDGQE4ULwAIzSNPfkc3PPZzBsGjdvk3O3fSwIzGiWxwY8EyZNWtmmidlTQFfsPFyxiyP3nN6hcePk9zA2a0+Az9AwE9HSM4/DAvTY7H5sF+UIolv96NeciXEXX+UzRkq22tWMcvRw/+85+T+WW5qhZKXxLKcTOQn2orw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785931926; c=relaxed/simple;
	bh=ZxUD5Dh0rhHKFhkqxlgdOItHvespUjm8IAZrFRa6gpo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YbZTQvGvclX8alWUw7S61e++J5PtfNsU/NOnbntu7xUaPeRwUtI9SSdubp8cyVAgdG9WgZwB2rHG60ygT/Zqniy4uOk8TWdZTi+9R8xtgPicRwkuuUMx2XbjyCfYb95d7gofZy69f2/Xixp6lgUN7lXE72Vfckee65jziVrVjvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y5SOixiw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y5SOixiw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 366E11F00ACF;
	Wed,  5 Aug 2026 12:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785931924;
	bh=x4rXu5FAmqn9nPaIK1goScakMvXXSf1lnGrBlqoOhug=;
	h=Subject:To:Cc:From:Date;
	b=y5SOixiwIos1AEYIoaXSOiOpf8cc0O60Vc8EFtfP6+g5NwwyFnwqAy7GdkfBNhLj5
	 csqeUzXVODoAJe7WU8Ns1BLiIT2KaoGdpTa3EgqBbJL6YOXhtsBndvVp6ORo0xBgrt
	 WKGmB2HoIQC3AXZ2N48eLbHYwx1ENlsJ7P4w4lIM=
Subject: FAILED: patch "[PATCH] drm/amd/display: Exit idle optimizations before programming" failed to apply to 7.1-stable tree
To: sunpeng.li@amd.com,alexander.deucher@amd.com,superm1@kernel.org,weber.aulendorf@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 14:11:47 +0200
Message-ID: <2026080547-scoff-that-5ce1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.1.y
git checkout FETCH_HEAD
git cherry-pick -x 8419331e64d92a8de5fc4feef0e305f201fb8b33
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080547-scoff-that-5ce1@gregkh' --subject-prefix 'PATCH 7.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8419331e64d92a8de5fc4feef0e305f201fb8b33 Mon Sep 17 00:00:00 2001
From: Leo Li <sunpeng.li@amd.com>
Date: Tue, 28 Jul 2026 13:02:47 -0400
Subject: [PATCH] drm/amd/display: Exit idle optimizations before programming

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

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index eaf19ec843e8..1820547b1dde 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9903,25 +9903,6 @@ static void remove_stream(struct amdgpu_device *adev,
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
@@ -10274,17 +10255,47 @@ static void dm_arm_vblank_event(struct amdgpu_crtc *acrtc,
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
 static void amdgpu_dm_commit_planes(struct drm_atomic_commit *state,
 				    struct drm_device *dev,
 				    struct amdgpu_display_manager *dm,
@@ -10550,16 +10561,19 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_commit *state,
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
 

