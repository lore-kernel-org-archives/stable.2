Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E227397923
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 11:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787570536; cv=none; b=fYEEXfwMqS7EJMqfOLbrxvSVkEzuETzkij33DGyCIYa/pjGyqBxlZr5RpYQjq4iLup3o5NgE3DgDBjvOowJwJ6qDOfBSgBH1k2tjX45MFgXFc4/BvHcKIhdnfWosynBUm7stGU2KENh5VJnv2wmRpNJSgIwKdWUehalyx8D8Fug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787570536; c=relaxed/simple;
	bh=YVcTr6WyqZJpo7TWWgUNdNZYRejc3QmYNe9nI6WCHwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HiH3Ra5I5xGQPYx5SUNmSCYo6CO84DNx8PO1/2njZzhR+xXDWzfndeC+byXda+uUqbYgyPjueR0djCKzjGbvVaAEB3TYnoCUsHF0PJQ/+JkdoYMZ/EtccrjgJm0xrjex0SSlxc32otPu2uWpJxzAAppSzsvujdID5QEfAYJSLCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oz1IHVE2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oz1IHVE2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C6901F000E9;
	Mon, 24 Aug 2026 11:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787570534;
	bh=Oird/leDCQ2evECbnoEADW/UwU42r7p3PM+9ujTpPp4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oz1IHVE287zvF0s9Ju4LJK5OrceU2GiBirU5SwQhCNPQBDUhtQ+cv4mJg5tMVraSf
	 IGPgzZ/SYwR0JTPEKs7PUWDWQo+EUHL9mWXQBeQmVhgTmel4Jr2IB+Nphls9GAFyiK
	 TfnnzJzI0+LWING+fIicdyOQ+or4oGmEZpeU1RfrCVwgdEwFf6ReHkmVIRjxerUh7N
	 AQfWEAoyfIRXtgjalaSEL6CQmH/XhIGHicQZ4v2OSKzrMd3FQcn+yJo5aJmRp9Eg/x
	 aiiXkk1dz+Q2uJXIlXhXXiKMsdKOL5VAvTeN+rM9x3v7vMDhKfEbqpp7QxWZ3jBTDc
	 qgGZ4/9IMcz0Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jani Nikula <jani.nikula@intel.com>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y 1/4] drm/i915/pin: s/dev_priv/i915/ and drop struct drm_device usage
Date: Mon, 24 Aug 2026 07:22:08 -0400
Message-ID: <20260824112212.417899-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082003-mountain-flaccid-179a@gregkh>
References: <2026082003-mountain-flaccid-179a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jani Nikula <jani.nikula@intel.com>

[ Upstream commit 3823bf019d3b31ccd3e79860b7a3e20c719a1db4 ]

Improve consistency within i915_fb_pin.c by replacing dev_priv naming
with i915, and dropping struct drm_device usage.

Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patch.msgid.link/3a4ac0a732a561a487e46838bde6327cff5ccb38.1775556190.git.jani.nikula@intel.com
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Stable-dep-of: fc6487579083 ("drm/xe: Fix DPT allocation paths.")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/display/intel_fb_pin.c | 24 ++++++++++-----------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_fb_pin.c b/drivers/gpu/drm/i915/display/intel_fb_pin.c
index 738d77a1468a5..c003b4c3c4cbe 100644
--- a/drivers/gpu/drm/i915/display/intel_fb_pin.c
+++ b/drivers/gpu/drm/i915/display/intel_fb_pin.c
@@ -29,9 +29,8 @@ intel_fb_pin_to_dpt(const struct drm_framebuffer *fb,
 		    unsigned long *out_flags,
 		    struct intel_dpt *dpt)
 {
-	struct drm_device *dev = fb->dev;
-	struct intel_display *display = to_intel_display(dev);
-	struct drm_i915_private *dev_priv = to_i915(dev);
+	struct intel_display *display = to_intel_display(fb->dev);
+	struct drm_i915_private *i915 = to_i915(fb->dev);
 	struct drm_gem_object *_obj = intel_fb_bo(fb);
 	struct drm_i915_gem_object *obj = to_intel_bo(_obj);
 	struct i915_address_space *vm = i915_dpt_to_vm(dpt);
@@ -43,7 +42,7 @@ intel_fb_pin_to_dpt(const struct drm_framebuffer *fb,
 	 * We are not syncing against the binding (and potential migrations)
 	 * below, so this vm must never be async.
 	 */
-	if (drm_WARN_ON(&dev_priv->drm, vm->bind_async_flags))
+	if (drm_WARN_ON(&i915->drm, vm->bind_async_flags))
 		return ERR_PTR(-EINVAL);
 
 	if (WARN_ON(!i915_gem_object_is_framebuffer(obj)))
@@ -56,7 +55,7 @@ intel_fb_pin_to_dpt(const struct drm_framebuffer *fb,
 		if (ret)
 			continue;
 
-		if (HAS_LMEM(dev_priv)) {
+		if (HAS_LMEM(i915)) {
 			unsigned int flags = obj->flags;
 
 			/*
@@ -118,9 +117,8 @@ intel_fb_pin_to_ggtt(const struct drm_framebuffer *fb,
 		     bool uses_fence,
 		     unsigned long *out_flags)
 {
-	struct drm_device *dev = fb->dev;
-	struct intel_display *display = to_intel_display(dev);
-	struct drm_i915_private *dev_priv = to_i915(dev);
+	struct intel_display *display = to_intel_display(fb->dev);
+	struct drm_i915_private *i915 = to_i915(fb->dev);
 	struct drm_gem_object *_obj = intel_fb_bo(fb);
 	struct drm_i915_gem_object *obj = to_intel_bo(_obj);
 	struct ref_tracker *wakeref;
@@ -129,10 +127,10 @@ intel_fb_pin_to_ggtt(const struct drm_framebuffer *fb,
 	unsigned int pinctl;
 	int ret;
 
-	if (drm_WARN_ON(dev, !i915_gem_object_is_framebuffer(obj)))
+	if (drm_WARN_ON(&i915->drm, !i915_gem_object_is_framebuffer(obj)))
 		return ERR_PTR(-EINVAL);
 
-	if (drm_WARN_ON(dev, alignment && !is_power_of_2(alignment)))
+	if (drm_WARN_ON(&i915->drm, alignment && !is_power_of_2(alignment)))
 		return ERR_PTR(-EINVAL);
 
 	/*
@@ -163,7 +161,7 @@ intel_fb_pin_to_ggtt(const struct drm_framebuffer *fb,
 	ret = i915_gem_object_lock(obj, &ww);
 	if (!ret && phys_alignment)
 		ret = i915_gem_object_attach_phys(obj, phys_alignment);
-	else if (!ret && HAS_LMEM(dev_priv))
+	else if (!ret && HAS_LMEM(i915))
 		ret = i915_gem_object_migrate(obj, &ww, INTEL_REGION_LMEM_0);
 	if (!ret)
 		ret = i915_gem_object_pin_pages(obj);
@@ -264,7 +262,7 @@ intel_plane_fb_vtd_guard(const struct intel_plane_state *plane_state)
 int intel_plane_pin_fb(struct intel_plane_state *plane_state,
 		       const struct intel_plane_state *old_plane_state)
 {
-	struct intel_display *display = to_intel_display(plane_state);
+	struct drm_i915_private *i915 = to_i915(plane_state->uapi.plane->dev);
 	struct intel_plane *plane = to_intel_plane(plane_state->uapi.plane);
 	const struct intel_framebuffer *fb =
 		to_intel_framebuffer(plane_state->hw.fb);
@@ -308,7 +306,7 @@ int intel_plane_pin_fb(struct intel_plane_state *plane_state,
 		 * The DPT object contains only one vma, and there is no VT-d
 		 * guard, so the VMA's offset within the DPT is always 0.
 		 */
-		drm_WARN_ON(display->drm, i915_dpt_offset(plane_state->dpt_vma));
+		drm_WARN_ON(&i915->drm, i915_dpt_offset(plane_state->dpt_vma));
 	}
 
 	/*
-- 
2.53.0

