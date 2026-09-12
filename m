Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AD632E757
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 15:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789225726; cv=none; b=h8ue+ExHnMhIxLwPqDtQkAsUQD8lVRe+L+wT8qTrca1WzjIAr8c7EYDkPVnpczGix3N0jsm90+H0kCnwvlBXT6yOOKH8tb0c6z8NxbpQWvsdi3GwHrgJUvXkhSUFVg2U3UJblEusufJhhmHB8HOMAX7MdKUveQ68v2+PltP2rhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789225726; c=relaxed/simple;
	bh=4emaHt+skKImllJm813iqP0i5mKXSLEaaRFwHtzvCnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T3bzRfStSOvTRgjLS2ifFb0MEG4xJ2hasrq0CR45TY1MvhXoL61ihAVw6YtrJyyfvbVyUIyGIIECx08PqYWcRZAaUce4w5TsYjFr3QViV4NfZFZ+WKny/G+LL86VC705a9tGrotpQNWSya5aco6qYglEszUbdZ1m+sKzhSJVXtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EflxYgQ6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EflxYgQ6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B2DE1F00893;
	Sat, 12 Sep 2026 15:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789225725;
	bh=wdDKwZD2UUJ+M7Ct6a3P8dxCOKUxdROcLHE+M7YTGtg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EflxYgQ6VSabOFoE10qBDZl7K5MIeYsYOkSQ4O9A8E1H8jd8kJj71EYk0cCBOJYNe
	 dp95ZJM1RURaXC8UMjWWo4ygiqwJ78QgoLOI9Yxq5V1z2UkiC7up/zp8YdeHJSSTP7
	 vHTZ1ffXZwuGU3dB7BiPh/cZLjhJhlRSsAjdXcjBYH8NHP4tZY8KROE+P+9HOx4WCM
	 779OpAzE9rFhC+Jvsxu0zyAj6sJY18N1OF8TWzk5DhjAd8E3bb4IMEUsC4mEpAZE9O
	 rMXC1264MZlJ0BgmJOBKgSvggdBJySW8vOKaBrKwYJCcyQv6pvvbBXv0NrZveNvwDL
	 IXtplW78bYp2A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Yongbang Shi <shiyongbang@huawei.com>,
	Rongrong Zou <zourongrong@gmail.com>,
	Sean Paul <seanpaul@chromium.org>,
	Xinliang Liu <xinliang.liu@linaro.org>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Baihan Li <libaihan@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] drm/hibmc: Use drm_atomic_helper_check_plane_state()
Date: Sat, 12 Sep 2026 11:08:42 -0400
Message-ID: <20260912150842.3054257-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090953-parka-swoop-b3c1@gregkh>
References: <2026090953-parka-swoop-b3c1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Thomas Zimmermann <tzimmermann@suse.de>

[ Upstream commit 715c5db68bdbd4a524b79ebf20fb61e880fffea0 ]

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
[ adapted atomic checks to Linux 5.10’s drm_plane_state callback API and DRM_PLANE_HELPER_NO_SCALING constant. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_de.c    | 43 ++++++-------------
 1 file changed, 13 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
index 4d57ec688f827..f8321c1db7122 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
@@ -17,6 +17,7 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_gem_vram_helper.h>
+#include <drm/drm_plane_helper.h>
 #include <drm/drm_vblank.h>
 
 #include "hibmc_drm_drv.h"
@@ -57,44 +58,26 @@ static const struct hibmc_dislay_pll_config hibmc_pll_table[] = {
 static int hibmc_plane_atomic_check(struct drm_plane *plane,
 				    struct drm_plane_state *state)
 {
-	struct drm_framebuffer *fb = state->fb;
-	struct drm_crtc *crtc = state->crtc;
-	struct drm_crtc_state *crtc_state;
-	u32 src_w = state->src_w >> 16;
-	u32 src_h = state->src_h >> 16;
-
-	if (!crtc || !fb)
-		return 0;
-
-	crtc_state = drm_atomic_get_crtc_state(state->state, crtc);
-	if (IS_ERR(crtc_state))
-		return PTR_ERR(crtc_state);
-
-	if (src_w != state->crtc_w || src_h != state->crtc_h) {
-		drm_dbg_atomic(plane->dev, "scale not support\n");
-		return -EINVAL;
-	}
+	struct drm_crtc_state *new_crtc_state = NULL;
+	int ret;
 
-	if (state->crtc_x < 0 || state->crtc_y < 0) {
-		drm_dbg_atomic(plane->dev, "crtc_x/y of drm_plane state is invalid\n");
-		return -EINVAL;
-	}
+	if (state->crtc)
+		new_crtc_state = drm_atomic_get_new_crtc_state(state->state, state->crtc);
 
-	if (!crtc_state->enable)
+	ret = drm_atomic_helper_check_plane_state(state, new_crtc_state,
+						  DRM_PLANE_HELPER_NO_SCALING,
+						  DRM_PLANE_HELPER_NO_SCALING,
+						  false, true);
+	if (ret)
+		return ret;
+	else if (!state->visible)
 		return 0;
 
-	if (state->crtc_x + state->crtc_w >
-	    crtc_state->adjusted_mode.hdisplay ||
-	    state->crtc_y + state->crtc_h >
-	    crtc_state->adjusted_mode.vdisplay) {
-		drm_dbg_atomic(plane->dev, "visible portion of plane is invalid\n");
-		return -EINVAL;
-	}
-
 	if (state->fb->pitches[0] % 128 != 0) {
 		drm_dbg_atomic(plane->dev, "wrong stride with 128-byte aligned\n");
 		return -EINVAL;
 	}
+
 	return 0;
 }
 
-- 
2.53.0

