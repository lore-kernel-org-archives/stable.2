Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38405542810
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788954763; cv=none; b=bbsybIqGRCBuZRurKOBUBoRfUVbMw2MEU4c4DjxMQnX5HQMa2n74mL948ow0zyIM+moq2pPsy9hswL5bGHrSYZb19rzx0N3Qa61kuftQ9Wc3hZhZbHlJb5iKRrftegn00WRcVsSeVob0RC2xcnJFl6CJqIznYEtnmd8gsbBkY0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788954763; c=relaxed/simple;
	bh=L+2sKEEdQH5tl/0Opop2GQcyt5CFlf7RL6ZHHb1i7eI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CNRwCnqaQzSqwbgEl2C63uvpRd6F4YqrfNCj0WOKZdqMaaBc0+jbl+TnCY+bWRokTKzRaMjwU2FLm1uj8YIeRA5Wu7LlAzJ1FDeNhasjTsk28H6JkViWRvlaw8ucc87UtIrJNt/EsNJvOl6ZLEhc5rEUGwSHglTVtgIc86eWimA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IrQ3PrZB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IrQ3PrZB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 957AD1F00A3A;
	Wed,  9 Sep 2026 11:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788954762;
	bh=IUnOTeNRpsJyWHOEDyt4n6Fuv5y94VUieTCt54+oCn0=;
	h=Subject:To:Cc:From:Date;
	b=IrQ3PrZBbtCLDgenL3ufezuNzg38MNOa+V0czez62QaXd5FQFOIXtqzC9uH4iJJ5Z
	 1LZqGbSO6oIp2AYPWE4pGxiUg7MNU3pvN4s2LxLbC6+Dl6AllFb0h5tLL9Pet5J7+i
	 IeYg1QBToKN5d875ELEKZYOe8KlDoFOB5dz11atM=
Subject: FAILED: patch "[PATCH] drm/hibmc: Use drm_atomic_helper_check_plane_state()" failed to apply to 5.10-stable tree
To: tzimmermann@suse.de,libaihan@huawei.com,lumag@kernel.org,seanpaul@chromium.org,shiyongbang@huawei.com,stable@vger.kernel.org,xinliang.liu@linaro.org,zourongrong@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 13:51:53 +0200
Message-ID: <2026090953-parka-swoop-b3c1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 715c5db68bdbd4a524b79ebf20fb61e880fffea0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090953-parka-swoop-b3c1@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 715c5db68bdbd4a524b79ebf20fb61e880fffea0 Mon Sep 17 00:00:00 2001
From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Thu, 18 Jun 2026 14:28:39 +0200
Subject: [PATCH] drm/hibmc: Use drm_atomic_helper_check_plane_state()

Call drm_atomic_helper_check_plane_state() from the primary plane's
atomic-check helper and replace the custom implementation.

All plane's implementations of atomic_check should call the shared
_check_plane_state() helper first. It adjusts the plane state for
correct positioning, rotation and scaling of the plane. Do this
even if the plane's CRTC has been disabled by setting the parameter
can_update_disabled. The original code returned early in this case,
but it's safe to so and cleaner to have all plane state initialized.

As we don't set can_position, drm_atomic_helper_check_plane_state()'s
visibility check tests if the plane covers all of the CRTC. This is
a small change from the original code, which tested if the plane is
exactly the size of the CRTC. With the new test, the plane still has
to cover all of the CRTC, but can be larger than the CRTC's size. A
later patch can fully implement this feature in hibmc.

If the plane is disabled, the helper clears the visibility flag in the
plane state. On errors or if the plane is not visible, the atomic-check
helper can return early. Implement all this in hibmc and drop the custom
code that does some of it.

v2:
- extend the commit description (Yongbang)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: da52605eea8f ("drm/hisilicon/hibmc: Add support for display engine")
Reviewed-by: Yongbang Shi <shiyongbang@huawei.com>
Cc: Rongrong Zou <zourongrong@gmail.com>
Cc: Sean Paul <seanpaul@chromium.org>
Cc: Xinliang Liu <xinliang.liu@linaro.org>
Cc: Dmitry Baryshkov <lumag@kernel.org>
Cc: Baihan Li <libaihan@huawei.com>
Cc: Yongbang Shi <shiyongbang@huawei.com>
Cc: <stable@vger.kernel.org> # v4.10+
Link: https://patch.msgid.link/20260618123142.92298-2-tzimmermann@suse.de

diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
index 3066dc9ebc64..7c0b88c774b5 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
@@ -72,46 +72,28 @@ static int hibmc_get_best_clock_idx(const struct drm_display_mode *mode)
 static int hibmc_plane_atomic_check(struct drm_plane *plane,
 				    struct drm_atomic_commit *state)
 {
-	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
-										 plane);
-	struct drm_framebuffer *fb = new_plane_state->fb;
-	struct drm_crtc *crtc = new_plane_state->crtc;
-	struct drm_crtc_state *crtc_state;
-	u32 src_w = new_plane_state->src_w >> 16;
-	u32 src_h = new_plane_state->src_h >> 16;
+	struct drm_plane_state *new_plane_state =
+		drm_atomic_get_new_plane_state(state, plane);
+	struct drm_crtc_state *new_crtc_state = NULL;
+	int ret;
 
-	if (!crtc || !fb)
+	if (new_plane_state->crtc)
+		new_crtc_state = drm_atomic_get_new_crtc_state(state, new_plane_state->crtc);
+
+	ret = drm_atomic_helper_check_plane_state(new_plane_state, new_crtc_state,
+						  DRM_PLANE_NO_SCALING,
+						  DRM_PLANE_NO_SCALING,
+						  false, true);
+	if (ret)
+		return ret;
+	else if (!new_plane_state->visible)
 		return 0;
 
-	crtc_state = drm_atomic_get_crtc_state(state, crtc);
-	if (IS_ERR(crtc_state))
-		return PTR_ERR(crtc_state);
-
-	if (src_w != new_plane_state->crtc_w || src_h != new_plane_state->crtc_h) {
-		drm_dbg_atomic(plane->dev, "scale not support\n");
-		return -EINVAL;
-	}
-
-	if (new_plane_state->crtc_x < 0 || new_plane_state->crtc_y < 0) {
-		drm_dbg_atomic(plane->dev, "crtc_x/y of drm_plane state is invalid\n");
-		return -EINVAL;
-	}
-
-	if (!crtc_state->enable)
-		return 0;
-
-	if (new_plane_state->crtc_x + new_plane_state->crtc_w >
-	    crtc_state->adjusted_mode.hdisplay ||
-	    new_plane_state->crtc_y + new_plane_state->crtc_h >
-	    crtc_state->adjusted_mode.vdisplay) {
-		drm_dbg_atomic(plane->dev, "visible portion of plane is invalid\n");
-		return -EINVAL;
-	}
-
 	if (new_plane_state->fb->pitches[0] % 128 != 0) {
 		drm_dbg_atomic(plane->dev, "wrong stride with 128-byte aligned\n");
 		return -EINVAL;
 	}
+
 	return 0;
 }
 

