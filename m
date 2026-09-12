Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1881F345EB9
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 16:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789230255; cv=none; b=HMPDXiyJzHXrVb+tch5xSZAroHw5qRSe+8E0uChgIwm8wDR1czaXpTPpQblL89Q+VmRYDxyQVGJYqheeOwjuGdMpkzDvtq1QJTEEWUB2G7sOArcVtMB+C/FPJ/PlC9IQnM4IpDOAlL5oJArMEIYWWaK1W0xgSCFoBUs4QZwIulY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789230255; c=relaxed/simple;
	bh=uwzwRCuUCDDNS5MiePM5hL0bAEebKUzYJ+WZK7guF3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DRcLsJNIuQgbI/xhkF+80JJnA9LkMZM7XxCjoCwg4HTi+0dmtesO/1YJ3aCHQ0/l1h77cXqqP2yc79Gps7pKyPjjQSFVwLp7CAVuSoKNeimcNMLL77GdLdKyL6CfZs6jmS/O8OB9PH4oGiCerHtblyUQ8RwkVFr42iwbcKcGbmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/WwYWMi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/WwYWMi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06A661F0089A;
	Sat, 12 Sep 2026 16:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789230253;
	bh=xwtktjmxaMG1z5z4kCRNFVg0XMMrvTWz6bhBvFeDNAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L/WwYWMiCRqpZGbPK0CqrCAdtcjbJ6dmSFu4EI3hlzXpbBTmld5sTy64USEq3ILz9
	 NIy8b0ynHdS0zgjoVlz9H95z7fcQI6WKaw62J9Zq6SwJqiy8oRmkch92j00NDowT44
	 rGeqeLk/pZv+61jhurQA7ce6lelbGshe7p8096CtKTX01WbSncJUVq3tDDpPkg38Lc
	 3vZJsPr39wtlEbZYVb1Rv70Dgzc90DowH+Iwalx2O8BCP0mINjtX0KTr1AqvMGsiDo
	 QuF9lAMT9sj+HAy4jmRtyxyyrPYbUiBrvf2N7MTJyGui2T1FIdQfxWhSRZW6czQP5s
	 uwEt/hdl7KRFA==
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
Subject: [PATCH 5.10.y 3/3] drm/hibmc: Use drm_atomic_helper_check_plane_state()
Date: Sat, 12 Sep 2026 12:24:09 -0400
Message-ID: <20260912162409.3654862-3-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_de.c    | 46 ++++++-------------
 1 file changed, 14 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
index 1d235dbe51ab4..d5a70164b3ee2 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
@@ -57,46 +57,28 @@ static const struct hibmc_dislay_pll_config hibmc_pll_table[] = {
 static int hibmc_plane_atomic_check(struct drm_plane *plane,
 				    struct drm_atomic_state *state)
 {
-	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
-										 plane);
-	struct drm_framebuffer *fb = new_plane_state->fb;
-	struct drm_crtc *crtc = new_plane_state->crtc;
-	struct drm_crtc_state *crtc_state;
-	u32 src_w = new_plane_state->src_w >> 16;
-	u32 src_h = new_plane_state->src_h >> 16;
-
-	if (!crtc || !fb)
-		return 0;
+	struct drm_plane_state *new_plane_state =
+		drm_atomic_get_new_plane_state(state, plane);
+	struct drm_crtc_state *new_crtc_state = NULL;
+	int ret;
 
-	crtc_state = drm_atomic_get_crtc_state(state, crtc);
-	if (IS_ERR(crtc_state))
-		return PTR_ERR(crtc_state);
+	if (new_plane_state->crtc)
+		new_crtc_state = drm_atomic_get_new_crtc_state(state, new_plane_state->crtc);
 
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
+	ret = drm_atomic_helper_check_plane_state(new_plane_state, new_crtc_state,
+						  DRM_PLANE_NO_SCALING,
+						  DRM_PLANE_NO_SCALING,
+						  false, true);
+	if (ret)
+		return ret;
+	else if (!new_plane_state->visible)
 		return 0;
 
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
 
-- 
2.53.0

