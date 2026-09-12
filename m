Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40EA32B13F
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 16:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789230254; cv=none; b=qPYIvOw5O65TQzm83rAYeWRaPUt3bykcHa/Tyo94VtAK4crZs6u54o1RWm1nq5B8RG1+T0ZWshDVMIvpMAzPz9QFK1yiuDO5hUr+v60GeRpxrCrzhNcZugiFBOcgpKuyKu9VLPKdMvi68NHv+0wznKtGS8cdtFR+/3CxisnLUwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789230254; c=relaxed/simple;
	bh=BvQey/MdJ/SWlvz6rS+VQT0glfkJWcFYwbJh9AGHgGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FyPa4FPTjTVDC+pmVzs/MTCGazcTHZs1nGJaRy18H3GEF5bmcDF/+VDcnPkMOe3UKJhoKGeiGSc6k/AOV0XBvkeFjB8fytdL7TBpFIkssjSSk4jk6nMkPRder7tSnEjO+s0+M3EuZRelKXEilq2eF+qDvkV5woEFwDN301tqvmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=onQCAhNg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="onQCAhNg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48CCC1F00893;
	Sat, 12 Sep 2026 16:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789230252;
	bh=czOVBfnKOiiVnsr7LDnxPCCLOJRyWay19z7d6IzUQF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=onQCAhNgxrVXTQJs9gl7n4qUc+VTpRXt97Ij++dM4UNCqRadfaLS37zEukT8khQmd
	 UrygLe29XMmZBXz9wjqfPyc2UVljR83cMs96LOWP8pu5qfsteYNVatloYTeJR34egL
	 g2aeaIMJebHTLTbWvhwaM2PDbchZOqQCT7+mjAUp1XUmLtoiBil3zEcziSurW0PU5w
	 lNHx62WuZI/pnbdhOs0ob+kpFDpJSwUPYxzj6uZnzBQIjtN1jO7/yNDcUcxuySzRDB
	 a/N7xJ17M3gA2LNKA5ULUrzAKfI/tbvBpHc76pODElEumrLzvJldkXlUbE6pqBkmC+
	 dLZbXDhGFdmpg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Sam Ravnborg <sam@ravnborg.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/3] drm/atomic-helper: Move DRM_PLANE_HELPER_NO_SCALING to atomic helpers
Date: Sat, 12 Sep 2026 12:24:08 -0400
Message-ID: <20260912162409.3654862-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912162409.3654862-1-sashal@kernel.org>
References: <2026090953-parka-swoop-b3c1@gregkh>
 <20260912162409.3654862-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Zimmermann <tzimmermann@suse.de>

[ Upstream commit 382fc1f681324bb38bedfe763107a60256c4ddc8 ]

The macro DRM_PLANE_HELPER_NO_SCALING is only useful with the interfaces
in drm_atomic_helper.h, but defined in drm_plane_helper.h. So half of
DRM includes the latter header file for using this macro. Move the macro
and remove the include statements.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20220720083058.15371-3-tzimmermann@suse.de

Stable adaptation for 5.10 and target 715c5db68bdb:

Keep the macro move but omit the optional driver include cleanup. Several
upstream drivers do not exist in 5.10 and others still have older header
dependencies. Define DRM_PLANE_NO_SCALING as an alias so the target can use
the newer spelling without renaming existing callers.

The target also expects HIBMC's plane check to receive the full atomic
state. Add an optional atomic_check_state member to the existing plane
helper table and dispatch it from drm_atomic_helper_check_planes(), with
the legacy atomic_check path retained for all other drivers. Convert only
HIBMC's existing check to this entry and match the target's local state
names. Its validation behavior is unchanged until the target is applied.
Use 5.10's struct drm_atomic_state rather than the later drm_atomic_commit
name. No function definitions are added.

[ sashal: Reduced backport -- upstream 382fc1f681324 touches 31 file(s), this
  backport carries 5. Not backported here:
  drivers/gpu/drm/arm/hdlcd_crtc.c
  drivers/gpu/drm/ast/ast_mode.c
  drivers/gpu/drm/drm_simple_kms_helper.c
  drivers/gpu/drm/i915/display/i9xx_plane.c
  drivers/gpu/drm/i915/display/intel_cursor.c
  drivers/gpu/drm/i915/display/intel_sprite.c
  drivers/gpu/drm/i915/display/skl_universal_plane.c
  drivers/gpu/drm/imx/ipuv3-plane.c
  ... and 21 more
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: 715c5db68bdb ("drm/hibmc: Use drm_atomic_helper_check_plane_state()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_atomic_helper.c           |  9 +++++--
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_de.c    | 26 ++++++++++---------
 include/drm/drm_atomic_helper.h               | 10 +++++++
 include/drm/drm_modeset_helper_vtables.h      | 11 ++++++++
 include/drm/drm_plane_helper.h                |  9 -------
 5 files changed, 42 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 0ff208876b853..d6d7099f1ac7f 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -982,10 +982,15 @@ drm_atomic_helper_check_planes(struct drm_device *dev,
 
 		drm_atomic_helper_check_plane_damage(state, new_plane_state);
 
-		if (!funcs || !funcs->atomic_check)
+		if (!funcs)
 			continue;
 
-		ret = funcs->atomic_check(plane, new_plane_state);
+		if (funcs->atomic_check_state)
+			ret = funcs->atomic_check_state(plane, state);
+		else if (funcs->atomic_check)
+			ret = funcs->atomic_check(plane, new_plane_state);
+		else
+			continue;
 		if (ret) {
 			DRM_DEBUG_ATOMIC("[PLANE:%d:%s] atomic driver check failed\n",
 					 plane->base.id, plane->name);
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
index 4d57ec688f827..1d235dbe51ab4 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
@@ -55,27 +55,29 @@ static const struct hibmc_dislay_pll_config hibmc_pll_table[] = {
 #define PADDING(align, data) (((data) + (align) - 1) & (~((align) - 1)))
 
 static int hibmc_plane_atomic_check(struct drm_plane *plane,
-				    struct drm_plane_state *state)
+				    struct drm_atomic_state *state)
 {
-	struct drm_framebuffer *fb = state->fb;
-	struct drm_crtc *crtc = state->crtc;
+	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
+										 plane);
+	struct drm_framebuffer *fb = new_plane_state->fb;
+	struct drm_crtc *crtc = new_plane_state->crtc;
 	struct drm_crtc_state *crtc_state;
-	u32 src_w = state->src_w >> 16;
-	u32 src_h = state->src_h >> 16;
+	u32 src_w = new_plane_state->src_w >> 16;
+	u32 src_h = new_plane_state->src_h >> 16;
 
 	if (!crtc || !fb)
 		return 0;
 
-	crtc_state = drm_atomic_get_crtc_state(state->state, crtc);
+	crtc_state = drm_atomic_get_crtc_state(state, crtc);
 	if (IS_ERR(crtc_state))
 		return PTR_ERR(crtc_state);
 
-	if (src_w != state->crtc_w || src_h != state->crtc_h) {
+	if (src_w != new_plane_state->crtc_w || src_h != new_plane_state->crtc_h) {
 		drm_dbg_atomic(plane->dev, "scale not support\n");
 		return -EINVAL;
 	}
 
-	if (state->crtc_x < 0 || state->crtc_y < 0) {
+	if (new_plane_state->crtc_x < 0 || new_plane_state->crtc_y < 0) {
 		drm_dbg_atomic(plane->dev, "crtc_x/y of drm_plane state is invalid\n");
 		return -EINVAL;
 	}
@@ -83,15 +85,15 @@ static int hibmc_plane_atomic_check(struct drm_plane *plane,
 	if (!crtc_state->enable)
 		return 0;
 
-	if (state->crtc_x + state->crtc_w >
+	if (new_plane_state->crtc_x + new_plane_state->crtc_w >
 	    crtc_state->adjusted_mode.hdisplay ||
-	    state->crtc_y + state->crtc_h >
+	    new_plane_state->crtc_y + new_plane_state->crtc_h >
 	    crtc_state->adjusted_mode.vdisplay) {
 		drm_dbg_atomic(plane->dev, "visible portion of plane is invalid\n");
 		return -EINVAL;
 	}
 
-	if (state->fb->pitches[0] % 128 != 0) {
+	if (new_plane_state->fb->pitches[0] % 128 != 0) {
 		drm_dbg_atomic(plane->dev, "wrong stride with 128-byte aligned\n");
 		return -EINVAL;
 	}
@@ -153,7 +155,7 @@ static struct drm_plane_funcs hibmc_plane_funcs = {
 static const struct drm_plane_helper_funcs hibmc_plane_helper_funcs = {
 	.prepare_fb	= drm_gem_vram_plane_helper_prepare_fb,
 	.cleanup_fb	= drm_gem_vram_plane_helper_cleanup_fb,
-	.atomic_check = hibmc_plane_atomic_check,
+	.atomic_check_state = hibmc_plane_atomic_check,
 	.atomic_update = hibmc_plane_atomic_update,
 };
 
diff --git a/include/drm/drm_atomic_helper.h b/include/drm/drm_atomic_helper.h
index 908ee3f417825..c33d852cd9d7f 100644
--- a/include/drm/drm_atomic_helper.h
+++ b/include/drm/drm_atomic_helper.h
@@ -34,6 +34,16 @@
 #include <drm/drm_atomic_state_helper.h>
 #include <drm/drm_util.h>
 
+/*
+ * Drivers that don't allow primary plane scaling may pass this macro in place
+ * of the min/max scale parameters of the plane-state checker function.
+ *
+ * Due to src being in 16.16 fixed point and dest being in integer pixels,
+ * 1<<16 represents no scaling.
+ */
+#define DRM_PLANE_HELPER_NO_SCALING (1<<16)
+#define DRM_PLANE_NO_SCALING DRM_PLANE_HELPER_NO_SCALING
+
 struct drm_atomic_state;
 struct drm_private_obj;
 struct drm_private_state;
diff --git a/include/drm/drm_modeset_helper_vtables.h b/include/drm/drm_modeset_helper_vtables.h
index 4efec30f8badc..e6574a6219a3a 100644
--- a/include/drm/drm_modeset_helper_vtables.h
+++ b/include/drm/drm_modeset_helper_vtables.h
@@ -1252,6 +1252,17 @@ struct drm_plane_helper_funcs {
 	int (*atomic_check)(struct drm_plane *plane,
 			    struct drm_plane_state *state);
 
+	/**
+	 * @atomic_check_state:
+	 *
+	 * This hook is equivalent to @atomic_check, but receives the full
+	 * atomic state. Drivers should implement only one of these hooks.
+	 * drm_atomic_helper_check_planes() calls this hook in preference to
+	 * @atomic_check when both are set.
+	 */
+	int (*atomic_check_state)(struct drm_plane *plane,
+				  struct drm_atomic_state *state);
+
 	/**
 	 * @atomic_update:
 	 *
diff --git a/include/drm/drm_plane_helper.h b/include/drm/drm_plane_helper.h
index 331ebd60b3a39..ff85ef41cb332 100644
--- a/include/drm/drm_plane_helper.h
+++ b/include/drm/drm_plane_helper.h
@@ -29,15 +29,6 @@
 #include <drm/drm_modeset_helper_vtables.h>
 #include <drm/drm_modeset_helper.h>
 
-/*
- * Drivers that don't allow primary plane scaling may pass this macro in place
- * of the min/max scale parameters of the update checker function.
- *
- * Due to src being in 16.16 fixed point and dest being in integer pixels,
- * 1<<16 represents no scaling.
- */
-#define DRM_PLANE_HELPER_NO_SCALING (1<<16)
-
 void drm_primary_helper_destroy(struct drm_plane *plane);
 extern const struct drm_plane_funcs drm_primary_helper_funcs;
 
-- 
2.53.0

