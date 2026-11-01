Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.112
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793536201;
	b=FEbgiUwkoEAdKIiMvhxXiEIeRauULcsGWVzY750aa+ZaIlBxTkYgEzQl4XDw6mfHgdMY
	 538OwW1cDB6ZENpZCI4bH+zsmL4d1YFF4u9MYKNCnQkKsCkHqIJwTk9OtCr4aUJR3Dgtl
	 HlDyrXdiwgxmC4sUo5CH2GfNILMJRP0G2fF50afQ6r/KJnROr4kTbHLmQCrOJWIgZVLRT
	 TzRh4qNCpjJiE4dCh21UfdvyjWsh9ZJ2KsEO+Ilp89AZtapOwhmXh7r2pFgtZcZE98+Dg
	 0TrEqAN/jfrqtFej4Bg8HMQbqjJ4pT/Hf8MxpWbXQtQ6peRfFbkPS1omx61HS4NvWIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793536201;
	h=DMARC-Filter:DKIM-Signature:X-Pm-Submission-Id:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MXG9XxsNUYUBQFUk2jiqmUkACxCXCveVoiDIppG6/JI=;
	b=3yN57YzKneEdx31dFSGpNj2sqRBGj3zc/G7SPRS0uhC1iUUSMKKkT9c6mTKLrRl3myRs
	 zE6MmE79CzPVmbv6WKWzxUd/v13kQ1kpVzgek7jVlc2yt07vI1EUbaqP+N0L87EaM/yRp
	 qkLfLvktkXkfYQ1AiBri/MT6ggb4XFrJsdKCMsRjTh6DCJgUuDwvtvQfqRB+t12van7zg
	 M7wVf7lN0ABYJwURwea3Dc6jt8cMyBNR80FF5JJnM8gdd6Wg3tOitvjM6XA1SCntwgeD8
	 7KRT+dgwM+HMkoVeYnQ8mVqIstq3LvFwJyy15kAhdiB2aCEq2Su+W09fEmhCx2zsHMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=softbase.tech;
	spf=pass smtp.mailfrom=softbase.tech;
	dkim=pass header.d=softbase.tech header.i=@softbase.tech header.a=rsa-sha256 header.s=protonmail3 header.b=EXzKOxkl;
	arc=none smtp.remote-ip=79.135.106.112
Received: from mail-106112.protonmail.ch (mail-106112.protonmail.ch [79.135.106.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B62606A32E
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 12:30:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55B62606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=softbase.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=softbase.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=softbase.tech header.i=@softbase.tech header.a=rsa-sha256 header.s=protonmail3 header.b=EXzKOxkl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=softbase.tech;
	s=protonmail3; t=1793536198; x=1793795398;
	bh=MXG9XxsNUYUBQFUk2jiqmUkACxCXCveVoiDIppG6/JI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=EXzKOxkl70OCmui4jy79De7H6k0YKei3U0Ft+swv/5PlZ2gHA6piffFlnWhap8wAl
	 fP6x7bS1Wsmot3KsrCjic1noBx2lnJvLmIqPqECq3ccCnLizh12NZYrbX4rWZxaffm
	 9R/LTfqnoIAwPQ/XqcfEpNW07uh/0ZNKzWB0bMOcwuKZKtWXlmrTX4WjrQKiozLM1c
	 5yhSg1buHg2m5kYJ7lYFPtWI0NCX3xbGv/2T3hXsAX3uvg6q+ix8EhTQaZ3fZF5x95
	 50LPN3wRq5+OZzlKytWMJImMjLGCftSSMJ3uiyz6/9JqORD+7c9gSgkZ3TCBhfVVcX
	 v+ARvmqWti2Kg==
X-Pm-Submission-Id: 4jHZ0g3FNKz2Sd2v
From: "Beat M. Liechti" <beat@softbase.tech>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
	Dmitry Baryshkov <lumag@kernel.org>
Cc: Abhinav Kumar <abhinav.kumar@linux.dev>,
	Jessica Zhang <jesszhan0024@gmail.com>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Federico Amedeo Izzo <federico@izzo.pro>,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	"Beat M. Liechti" <beat@softbase.tech>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] drm/msm/dpu: don't reassign resources on color management changes
Date: Sun,  1 Nov 2026 13:26:57 +0100
Message-ID: <20261101122943.8155-2-beat@softbase.tech>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261101122943.8155-1-beat@softbase.tech>
References: <20261101095754.33840-1-beat@softbase.tech>
 <20261101122943.8155-1-beat@softbase.tech>
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

Since commit 39a750ff5fc9 ("drm/msm/dpu: Add DSPP GC driver to provide
GAMMA_LUT DRM property"), dpu_crtc_atomic_check() releases and reserves
the hardware blocks of a CRTC whenever color_mgmt_changed is set, not
only on a modeset. A commit that merely replaces the GAMMA_LUT or CTM
blob of an active CRTC can therefore move that CRTC to a different
CTL/LM pair without disabling and re-enabling the pipeline, and the
hardware keeps scanning out through blocks the driver no longer
considers in use.

This is easy to hit with GNOME/mutter on a laptop driving an external
display: closing the lid disables the eDP CRTC, and in the same atomic
commit mutter sets new color blobs on the still active HDMI CRTC. With
drm.debug enabled, dpu_rm_reserve() moves the HDMI CRTC from CTL_1 to
the just released CTL_0 while its encoder is neither disabled nor
re-enabled. A few seconds later the display SMMU reports context faults
at the refresh rate and the external screen fills with garbage. Opening
the lid again leads to a stream of "vblank timeout" and "frame done
timeout" errors and the machine has to be power cycled.

Color management affects the topology in only one way: DSPP blocks are
requested when either CTM or GAMMA_LUT is set. Handle that case in
dpu_crtc_check_mode_changed() by requiring a full modeset when the
presence of CTM/GAMMA_LUT changes, and stop reallocating resources on a
bare color_mgmt_changed. Don't set allow_modeset here: if userspace
did not allow a modeset, the atomic core rejects the commit instead of
the CRTC being silently moved to other blocks.

Fixes: 39a750ff5fc9 ("drm/msm/dpu: Add DSPP GC driver to provide GAMMA_LUT DRM property")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Beat M. Liechti <beat@softbase.tech>
---

Notes:
    Changes in v2:
    - Don't set allow_modeset on behalf of userspace; only set mode_changed
      and let drm_atomic_check_only() reject commits that did not allow a
      modeset (Dmitry)
    - New patch 2/2 removes the CTM-only allow_modeset hack from
      msm_atomic_check(), which is redundant with this check (Sashiko review)
    - Link to v1: https://lore.kernel.org/r/20261101095754.33840-1-beat@softbase.tech
    
    Testing: ThinkPad T14s Gen 6 (X1E78100), GNOME 50 / mutter on Wayland,
    LG 4K60 monitor on the HDMI port (DP to HDMI bridge), logind set to not
    suspend on lid close while on external power. Without this patch every
    lid close reproduces the corruption and hang described above. With it,
    closing and opening the lid produces no SMMU faults, vblank timeouts or
    frame done timeouts, and both displays keep working.
    
    v2 was retested on the same kernel with both patches applied: lid
    close/open, Night Light toggled repeatedly with the lid open and closed,
    and a color profile change. No SMMU faults or timeouts, no visual
    problems, and with drm.debug=0x16 no commit was rejected for requiring
    a modeset, so mutter is not affected by the stricter check.
    
    On msm-next the patch has only been compile tested (W=1, no new
    warnings), not run.
    
    The RFC "drm/msm/dpu: Force modeset if new CTLs have been reserved"
    (https://lists.freedesktop.org/archives/freedreno/2025-March/036824.html)
    addresses reassignment without a modeset in general. This patch only
    removes the color management trigger.
    
    The root cause analysis of the drm.debug trace, the fix and the
    changelog were developed with an AI coding assistant (Claude by
    Anthropic). I reviewed the change and tested it on the hardware above.

 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 25 +++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index 42d0a529b..cfcc3556a 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -1516,6 +1516,19 @@ int dpu_crtc_check_mode_changed(struct drm_crtc_state *old_crtc_state,
 	    (!clone_mode_requested && clone_mode_enabled))
 		new_crtc_state->mode_changed = true;
 
+	/*
+	 * DSPP blocks are reserved only when CTM or GAMMA_LUT is set (see
+	 * dpu_crtc_get_topology()), so enabling or disabling color management
+	 * changes the hardware topology. Changing resources on an active CRTC
+	 * requires a full modeset; otherwise the CTL/LM blocks get swapped
+	 * underneath a running pipeline. If userspace did not allow a modeset,
+	 * drm_atomic_check_only() rejects the commit.
+	 */
+	if (new_crtc_state->enable &&
+	    (!!(old_crtc_state->ctm || old_crtc_state->gamma_lut) !=
+	     !!(new_crtc_state->ctm || new_crtc_state->gamma_lut)))
+		new_crtc_state->mode_changed = true;
+
 	return 0;
 }
 
@@ -1534,9 +1547,15 @@ static int dpu_crtc_atomic_check(struct drm_crtc *crtc,
 
 	bool needs_dirtyfb = dpu_crtc_needs_dirtyfb(crtc_state);
 
-	/* don't reallocate resources if only ACTIVE has beeen changed */
-	if (crtc_state->mode_changed || crtc_state->connectors_changed ||
-	    crtc_state->color_mgmt_changed) {
+	/*
+	 * Don't reallocate resources if only ACTIVE or color management
+	 * values have changed. A change in DSPP requirements is turned into a
+	 * modeset by dpu_crtc_check_mode_changed(). Reallocating on a plain
+	 * color_mgmt_changed would move an active CRTC to different CTL/LM
+	 * blocks without a modeset, leaving the hardware scanning out through
+	 * stale CTL/LM state (SMMU faults, corrupted output, vblank timeouts).
+	 */
+	if (crtc_state->mode_changed || crtc_state->connectors_changed) {
 		rc = dpu_crtc_assign_resources(crtc, crtc_state);
 		if (rc < 0)
 			return rc;
-- 
2.53.0

