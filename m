Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88341A6808
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 11:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787570537; cv=none; b=SpqkUPEZCBnm5e5w9dgpR/djxHY+5rc4MimH+2teUK/7FJ/mQfGrqo6L1o2AxYmaMPT4+RkMMw47n13nzH+Ch5HDCeLUMoN1wel1a6ZifXAVbU4FDE2OwpN9xgFXaOSPItnV8nrFzxLS9E7DXN2pfEONWEG9LEkpKvrepRY2Urk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787570537; c=relaxed/simple;
	bh=z4C6MmTn+CGAnrxQFU2jdp9N+FDLTLtdYE9HpnaW1+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z+HulW2umfond+8tg0c/g0OX2w71AWZMakWvNulPPpi1vVeC/H90hR1sU35QdhRqZ7Q6YwRt8JBjbPX84C1k0tq15QlAXmp/HcTCwTebxjRClbGy2koAYQSHXl7r0GdZNxv+mfdb8sI1Va9mNhzLhkMFqSmIAd7Isjwqbsne8lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iqm2wMRY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iqm2wMRY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B1331F00A3D;
	Mon, 24 Aug 2026 11:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787570535;
	bh=mMTJshFvuh3IqH6p9lOrDC3H7EFOwF6vZG1PRLn7vF4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Iqm2wMRYwLTuCn7TK/bqGxcbiA5Hbp6M9ulwANpOcQRd6OUckFGhxWaqCAj8dqH1o
	 5clnQ896XVYDnkupASi5Rq6bx8SLiI25reiHXM+Qx+a5qFY35ppUMyuP6pJu3TSdDL
	 zaRxsKsdw+5zlfOUF585xXZwveaWIK3W3p5ALCuXCU196mDI3C3URPNwdqaxDDkdYc
	 AIvc1xaR97rjO5veR7bGav6OPX1d5UXxpJErCTUtB45+F8uVvWJ7GW3Ed9fAmXiiog
	 GDf72wdGeD03zld/ZkHssDNrKcBlQe5X0SG6HQkI2TJPBtvCeyyCrfzDn5VkdqNK6K
	 WIgdwY4QAr5Dg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y 2/4] drm/i915: Track fence region ID in plane state
Date: Mon, 24 Aug 2026 07:22:09 -0400
Message-ID: <20260824112212.417899-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824112212.417899-1-sashal@kernel.org>
References: <2026082003-mountain-flaccid-179a@gregkh>
 <20260824112212.417899-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

[ Upstream commit eb3dd9640731ae3ace871190f80474a8e7bae121 ]

Get rid of the needlessly complicated PLANE_HAS_FENCE +
intel_parent_vma_fence_id() dance by simply tracking the
fence_id directly in the plane state.

v2: Don't request the redundant fence for fbdev (Jani)
    Assign *out_fence_id with '=' instead of '|=' (Sashiko,Jani)

Reviewed-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patch.msgid.link/20260407170942.16515-1-ville.syrjala@linux.intel.com
Stable-dep-of: fc6487579083 ("drm/xe: Fix DPT allocation paths.")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../drm/i915/display/intel_display_types.h    |  5 +--
 drivers/gpu/drm/i915/display/intel_fb_pin.c   | 33 ++++++++++---------
 drivers/gpu/drm/i915/display/intel_fb_pin.h   |  5 ++-
 drivers/gpu/drm/i915/display/intel_fbc.c      | 11 ++-----
 drivers/gpu/drm/i915/display/intel_fbdev.c    |  9 ++---
 drivers/gpu/drm/i915/display/intel_plane.c    |  3 +-
 drivers/gpu/drm/i915/i915_initial_plane.c     |  2 +-
 drivers/gpu/drm/xe/display/xe_fb_pin.c        |  8 ++---
 drivers/gpu/drm/xe/display/xe_initial_plane.c |  2 +-
 9 files changed, 37 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h b/drivers/gpu/drm/i915/display/intel_display_types.h
index 2e6a857085558..804257660fae4 100644
--- a/drivers/gpu/drm/i915/display/intel_display_types.h
+++ b/drivers/gpu/drm/i915/display/intel_display_types.h
@@ -684,14 +684,15 @@ struct intel_plane_state {
 
 	struct i915_vma *ggtt_vma;
 	struct i915_vma *dpt_vma;
-	unsigned long flags;
-#define PLANE_HAS_FENCE BIT(0)
 
 	struct intel_fb_view view;
 
 	/* for legacy cursor fb unpin */
 	struct drm_vblank_work unpin_work;
 
+	/* fenced region ID (-1 if none) */
+	s8 fence_id;
+
 	/* Plane pxp decryption state */
 	bool decrypt;
 
diff --git a/drivers/gpu/drm/i915/display/intel_fb_pin.c b/drivers/gpu/drm/i915/display/intel_fb_pin.c
index c003b4c3c4cbe..aaee8072d2497 100644
--- a/drivers/gpu/drm/i915/display/intel_fb_pin.c
+++ b/drivers/gpu/drm/i915/display/intel_fb_pin.c
@@ -26,7 +26,6 @@ static struct i915_vma *
 intel_fb_pin_to_dpt(const struct drm_framebuffer *fb,
 		    const struct i915_gtt_view *view,
 		    unsigned int alignment,
-		    unsigned long *out_flags,
 		    struct intel_dpt *dpt)
 {
 	struct intel_display *display = to_intel_display(fb->dev);
@@ -114,8 +113,7 @@ intel_fb_pin_to_ggtt(const struct drm_framebuffer *fb,
 		     unsigned int alignment,
 		     unsigned int phys_alignment,
 		     unsigned int vtd_guard,
-		     bool uses_fence,
-		     unsigned long *out_flags)
+		     int *out_fence_id)
 {
 	struct intel_display *display = to_intel_display(fb->dev);
 	struct drm_i915_private *i915 = to_i915(fb->dev);
@@ -175,7 +173,10 @@ intel_fb_pin_to_ggtt(const struct drm_framebuffer *fb,
 		goto err_unpin;
 	}
 
-	if (uses_fence && i915_vma_is_map_and_fenceable(vma)) {
+	if (out_fence_id)
+		*out_fence_id = -1;
+
+	if (out_fence_id && i915_vma_is_map_and_fenceable(vma)) {
 		/*
 		 * Install a fence for tiled scan-out. Pre-i965 always needs a
 		 * fence, whereas 965+ only requires a fence if using
@@ -201,7 +202,7 @@ intel_fb_pin_to_ggtt(const struct drm_framebuffer *fb,
 		ret = 0;
 
 		if (vma->fence)
-			*out_flags |= PLANE_HAS_FENCE;
+			*out_fence_id = vma->fence->id;
 	}
 
 	i915_vma_get(vma);
@@ -223,9 +224,9 @@ intel_fb_pin_to_ggtt(const struct drm_framebuffer *fb,
 	return vma;
 }
 
-void intel_fb_unpin_vma(struct i915_vma *vma, unsigned long flags)
+void intel_fb_unpin_vma(struct i915_vma *vma, int fence_id)
 {
-	if (flags & PLANE_HAS_FENCE)
+	if (fence_id >= 0)
 		i915_vma_unpin_fence(vma);
 	i915_vma_unpin(vma);
 	i915_vma_put(vma);
@@ -269,17 +270,18 @@ int intel_plane_pin_fb(struct intel_plane_state *plane_state,
 	struct i915_vma *vma;
 
 	if (!intel_fb_uses_dpt(&fb->base)) {
+		int fence_id = -1;
+
 		vma = intel_fb_pin_to_ggtt(&fb->base, &plane_state->view.gtt,
 					   intel_plane_fb_min_alignment(plane_state),
 					   intel_plane_fb_min_phys_alignment(plane_state),
 					   intel_plane_fb_vtd_guard(plane_state),
-					   intel_plane_uses_fence(plane_state),
-					   &plane_state->flags);
+					   intel_plane_uses_fence(plane_state) ? &fence_id : NULL);
 		if (IS_ERR(vma))
 			return PTR_ERR(vma);
 
 		plane_state->ggtt_vma = vma;
-
+		plane_state->fence_id = fence_id;
 	} else {
 		unsigned int alignment = intel_plane_fb_min_alignment(plane_state);
 
@@ -290,8 +292,7 @@ int intel_plane_pin_fb(struct intel_plane_state *plane_state,
 		plane_state->ggtt_vma = vma;
 
 		vma = intel_fb_pin_to_dpt(&fb->base, &plane_state->view.gtt,
-					  alignment, &plane_state->flags,
-					  fb->dpt);
+					  alignment, fb->dpt);
 		if (IS_ERR(vma)) {
 			i915_dpt_unpin_from_ggtt(fb->dpt);
 			plane_state->ggtt_vma = NULL;
@@ -336,12 +337,14 @@ void intel_plane_unpin_fb(struct intel_plane_state *old_plane_state)
 
 	if (!intel_fb_uses_dpt(&fb->base)) {
 		vma = fetch_and_zero(&old_plane_state->ggtt_vma);
-		if (vma)
-			intel_fb_unpin_vma(vma, old_plane_state->flags);
+		if (vma) {
+			intel_fb_unpin_vma(vma, old_plane_state->fence_id);
+			old_plane_state->fence_id = -1;
+		}
 	} else {
 		vma = fetch_and_zero(&old_plane_state->dpt_vma);
 		if (vma)
-			intel_fb_unpin_vma(vma, old_plane_state->flags);
+			intel_fb_unpin_vma(vma, -1);
 
 		vma = fetch_and_zero(&old_plane_state->ggtt_vma);
 		if (vma)
diff --git a/drivers/gpu/drm/i915/display/intel_fb_pin.h b/drivers/gpu/drm/i915/display/intel_fb_pin.h
index 81ab79da1af74..2eca42b74c4ac 100644
--- a/drivers/gpu/drm/i915/display/intel_fb_pin.h
+++ b/drivers/gpu/drm/i915/display/intel_fb_pin.h
@@ -20,10 +20,9 @@ intel_fb_pin_to_ggtt(const struct drm_framebuffer *fb,
 		     unsigned int alignment,
 		     unsigned int phys_alignment,
 		     unsigned int vtd_guard,
-		     bool uses_fence,
-		     unsigned long *out_flags);
+		     int *out_fence_id);
 
-void intel_fb_unpin_vma(struct i915_vma *vma, unsigned long flags);
+void intel_fb_unpin_vma(struct i915_vma *vma, int fence_id);
 
 int intel_plane_pin_fb(struct intel_plane_state *new_plane_state,
 		       const struct intel_plane_state *old_plane_state);
diff --git a/drivers/gpu/drm/i915/display/intel_fbc.c b/drivers/gpu/drm/i915/display/intel_fbc.c
index ea0ce00c84743..677ac5be749b3 100644
--- a/drivers/gpu/drm/i915/display/intel_fbc.c
+++ b/drivers/gpu/drm/i915/display/intel_fbc.c
@@ -1458,13 +1458,10 @@ static void intel_fbc_update_state(struct intel_atomic_state *state,
 
 	fbc_state->fence_y_offset = intel_plane_fence_y_offset(plane_state);
 
-	drm_WARN_ON(display->drm, plane_state->flags & PLANE_HAS_FENCE &&
+	drm_WARN_ON(display->drm, plane_state->fence_id >= 0 &&
 		    !intel_fbc_has_fences(display));
 
-	if (plane_state->flags & PLANE_HAS_FENCE)
-		fbc_state->fence_id = intel_parent_vma_fence_id(display, plane_state->ggtt_vma);
-	else
-		fbc_state->fence_id = -1;
+	fbc_state->fence_id = plane_state->fence_id;
 
 	fbc_state->cfb_stride = intel_fbc_cfb_stride(plane_state);
 	fbc_state->cfb_size = intel_fbc_cfb_size(plane_state);
@@ -1487,9 +1484,7 @@ static bool intel_fbc_is_fence_ok(const struct intel_plane_state *plane_state)
 	 * so have no fence associated with it) due to aperture constraints
 	 * at the time of pinning.
 	 */
-	return DISPLAY_VER(display) >= 9 ||
-		(plane_state->flags & PLANE_HAS_FENCE &&
-		 intel_parent_vma_fence_id(display, plane_state->ggtt_vma) != -1);
+	return DISPLAY_VER(display) >= 9 || plane_state->fence_id >= 0;
 }
 
 static bool intel_fbc_is_cfb_ok(const struct intel_plane_state *plane_state)
diff --git a/drivers/gpu/drm/i915/display/intel_fbdev.c b/drivers/gpu/drm/i915/display/intel_fbdev.c
index bdaaf3edba0cb..063cc619afc4c 100644
--- a/drivers/gpu/drm/i915/display/intel_fbdev.c
+++ b/drivers/gpu/drm/i915/display/intel_fbdev.c
@@ -60,7 +60,6 @@
 struct intel_fbdev {
 	struct intel_framebuffer *fb;
 	struct i915_vma *vma;
-	unsigned long vma_flags;
 };
 
 static struct intel_fbdev *to_intel_fbdev(struct drm_fb_helper *fb_helper)
@@ -141,7 +140,7 @@ static void intel_fbdev_fb_destroy(struct fb_info *info)
 	 * the info->screen_base mmaping. Leaking the VMA is simpler than
 	 * trying to rectify all the possible error paths leading here.
 	 */
-	intel_fb_unpin_vma(ifbdev->vma, ifbdev->vma_flags);
+	intel_fb_unpin_vma(ifbdev->vma, -1);
 	drm_framebuffer_remove(fb_helper->fb);
 
 	drm_client_release(&fb_helper->client);
@@ -269,7 +268,6 @@ int intel_fbdev_driver_fbdev_probe(struct drm_fb_helper *helper,
 	struct fb_info *info = helper->info;
 	struct ref_tracker *wakeref;
 	struct i915_vma *vma;
-	unsigned long flags = 0;
 	bool prealloc = false;
 	struct drm_gem_object *obj;
 	int ret;
@@ -314,7 +312,7 @@ int intel_fbdev_driver_fbdev_probe(struct drm_fb_helper *helper,
 				   fb->min_alignment, 0,
 				   intel_fb_view_vtd_guard(&fb->base, &fb->normal_view,
 							   DRM_MODE_ROTATE_0),
-				   false, &flags);
+				   NULL);
 	if (IS_ERR(vma)) {
 		ret = PTR_ERR(vma);
 		goto out_unlock;
@@ -345,14 +343,13 @@ int intel_fbdev_driver_fbdev_probe(struct drm_fb_helper *helper,
 	drm_dbg_kms(display->drm, "allocated %dx%d fb\n", fb->base.width, fb->base.height);
 	ifbdev->fb = fb;
 	ifbdev->vma = vma;
-	ifbdev->vma_flags = flags;
 
 	intel_display_rpm_put(display, wakeref);
 
 	return 0;
 
 out_unpin:
-	intel_fb_unpin_vma(vma, flags);
+	intel_fb_unpin_vma(vma, -1);
 out_unlock:
 	intel_display_rpm_put(display, wakeref);
 
diff --git a/drivers/gpu/drm/i915/display/intel_plane.c b/drivers/gpu/drm/i915/display/intel_plane.c
index 07eae4176dad2..da68f6e650a40 100644
--- a/drivers/gpu/drm/i915/display/intel_plane.c
+++ b/drivers/gpu/drm/i915/display/intel_plane.c
@@ -70,6 +70,7 @@ static void intel_plane_state_reset(struct intel_plane_state *plane_state,
 	__drm_atomic_helper_plane_state_reset(&plane_state->uapi, &plane->base);
 
 	plane_state->scaler_id = -1;
+	plane_state->fence_id = -1;
 }
 
 struct intel_plane *intel_plane_alloc(void)
@@ -137,7 +138,7 @@ intel_plane_duplicate_state(struct drm_plane *plane)
 
 	intel_state->ggtt_vma = NULL;
 	intel_state->dpt_vma = NULL;
-	intel_state->flags = 0;
+	intel_state->fence_id = -1;
 	intel_state->damage = DRM_RECT_INIT(0, 0, 0, 0);
 
 	/* add reference to fb */
diff --git a/drivers/gpu/drm/i915/i915_initial_plane.c b/drivers/gpu/drm/i915/i915_initial_plane.c
index 390a9248d6314..db51a468ddd40 100644
--- a/drivers/gpu/drm/i915/i915_initial_plane.c
+++ b/drivers/gpu/drm/i915/i915_initial_plane.c
@@ -268,7 +268,7 @@ i915_initial_plane_setup(struct drm_plane_state *_plane_state,
 	plane_state->ggtt_vma = i915_vma_get(vma);
 	if (intel_plane_uses_fence(plane_state) &&
 	    i915_vma_pin_fence(vma) == 0 && vma->fence)
-		plane_state->flags |= PLANE_HAS_FENCE;
+		plane_state->fence_id = vma->fence->id;
 
 	plane_state->surf = i915_ggtt_offset(plane_state->ggtt_vma);
 
diff --git a/drivers/gpu/drm/xe/display/xe_fb_pin.c b/drivers/gpu/drm/xe/display/xe_fb_pin.c
index bfbe3e44e78d5..05e6642dddec9 100644
--- a/drivers/gpu/drm/xe/display/xe_fb_pin.c
+++ b/drivers/gpu/drm/xe/display/xe_fb_pin.c
@@ -418,15 +418,15 @@ intel_fb_pin_to_ggtt(const struct drm_framebuffer *fb,
 		     unsigned int alignment,
 		     unsigned int phys_alignment,
 		     unsigned int vtd_guard,
-		     bool uses_fence,
-		     unsigned long *out_flags)
+		     int *out_fence_id)
 {
-	*out_flags = 0;
+	if (out_fence_id)
+		*out_fence_id = -1;
 
 	return __xe_pin_fb_vma(to_intel_framebuffer(fb), view, alignment);
 }
 
-void intel_fb_unpin_vma(struct i915_vma *vma, unsigned long flags)
+void intel_fb_unpin_vma(struct i915_vma *vma, int fence_id)
 {
 	__xe_unpin_fb_vma(vma);
 }
diff --git a/drivers/gpu/drm/xe/display/xe_initial_plane.c b/drivers/gpu/drm/xe/display/xe_initial_plane.c
index 8bcae552dddcf..09ec8f94bf578 100644
--- a/drivers/gpu/drm/xe/display/xe_initial_plane.c
+++ b/drivers/gpu/drm/xe/display/xe_initial_plane.c
@@ -153,7 +153,7 @@ xe_initial_plane_setup(struct drm_plane_state *_plane_state,
 	struct i915_vma *vma;
 
 	vma = intel_fb_pin_to_ggtt(fb, &plane_state->view.gtt,
-				   0, 0, 0, false, &plane_state->flags);
+				   0, 0, 0, NULL);
 	if (IS_ERR(vma))
 		return PTR_ERR(vma);
 
-- 
2.53.0

