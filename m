Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A89345EB9
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 16:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789230253; cv=none; b=XO8YYAW3wNC6A7cTnAR4kRYduNAwb/yu1E/+KPf4valm8LaScCptJJeNo0SFBz4f8Sdt9YI3HHf23rEiTAj5fFxwJU7nCQcoSBxiwOFs74Bw07fnvj8AUZsURKVZmiHz26GmVq3vzoY6VP8FwwSqr08Mkf3Fxj/Q8AAIh7e5Zo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789230253; c=relaxed/simple;
	bh=MiBvgyc1LGH5RkRPW93g2e8p/ZcwkLi9tin+Qa7WQyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lAzW7IFWeq8m72VrZ91sK5zMKfUBhJRvrcDKhD7CPREqhjirwZ94QjXu8qu/upwNR6WHusaSzqG6ZirKK+vHlt406QkOzs9ukVQ++Kv9YWLajMFdLCkKYacgBFB5UyERdLOzARNZzExC0BwZaBvyIdBAZKjfh0KbNMAsz4MKkqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q5OBHaOc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q5OBHaOc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BE101F000FF;
	Sat, 12 Sep 2026 16:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789230252;
	bh=CJ+JLlyFM+PlWoFXK96kOCxBMx6tuDSP6tahYqPsk7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q5OBHaOcSeSGYEEwLwIE1a9y7fpBANW0IOoV1PwGiiE0wM528oq3T+gcDWkyFDOjp
	 ag2yzDEVD0xR99s+Oo4Gi+iWAAt80F8LTL9B/ucLkcTscuoezmomzsUl0Xy7Kd/bRt
	 Xj1jIoZDZhew5qNaZvd2d184XOpGhnvyECPlgD3NnhHW95+TZN1g8JDFbMIgxTEfxi
	 CokcdCIlSYF3N7c5xgHWBRo4rA8GCWI5lag6YPMKdtmRj1YLoefTjmWI1WhKoYxxBW
	 Lzeo5agV8t5A4eAwqElmIEBUCky3csBjM1yQIXOEaj21sUM4tftIrERFqbbW1ZOVCj
	 lAN3o7UmbOqzw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Jocelyn Falempe <jfalempe@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/3] drm/atomic-helper: Add helper drm_atomic_helper_check_crtc_state()
Date: Sat, 12 Sep 2026 12:24:07 -0400
Message-ID: <20260912162409.3654862-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090953-parka-swoop-b3c1@gregkh>
References: <2026090953-parka-swoop-b3c1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Zimmermann <tzimmermann@suse.de>

[ Upstream commit d6b9af1097fefa7e6509a4b2f03af45f9eaddae9 ]

Add drm_atomic_helper_check_crtc_state(), which contains tests common
to many CRTCs. The first added test verifies that an enabled CRTC has
at least one enabled primary plane.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Acked-by: Jocelyn Falempe <jfalempe@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20220617103226.25617-2-tzimmermann@suse.de
Stable-dep-of: 715c5db68bdb ("drm/hibmc: Use drm_atomic_helper_check_plane_state()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_atomic_helper.c | 55 +++++++++++++++++++++++++++++
 include/drm/drm_atomic_helper.h     |  2 ++
 2 files changed, 57 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 8612dd552d392..0ff208876b853 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -890,6 +890,61 @@ int drm_atomic_helper_check_plane_state(struct drm_plane_state *plane_state,
 }
 EXPORT_SYMBOL(drm_atomic_helper_check_plane_state);
 
+/**
+ * drm_atomic_helper_check_crtc_state() - Check CRTC state for validity
+ * @crtc_state: CRTC state to check
+ * @can_disable_primary_planes: can the CRTC be enabled without a primary plane?
+ *
+ * Checks that a desired CRTC update is valid. Drivers that provide
+ * their own CRTC handling rather than helper-provided implementations may
+ * still wish to call this function to avoid duplication of error checking
+ * code.
+ *
+ * Note that @can_disable_primary_planes only tests if the CRTC can be
+ * enabled without a primary plane. To test if a primary plane can be updated
+ * without a CRTC, use drm_atomic_helper_check_plane_state() in the plane's
+ * atomic check.
+ *
+ * RETURNS:
+ * Zero if update appears valid, error code on failure
+ */
+int drm_atomic_helper_check_crtc_state(struct drm_crtc_state *crtc_state,
+				       bool can_disable_primary_planes)
+{
+	struct drm_device *dev = crtc_state->crtc->dev;
+	struct drm_atomic_state *state = crtc_state->state;
+
+	if (!crtc_state->enable)
+		return 0;
+
+	/* needs at least one primary plane to be enabled */
+	if (!can_disable_primary_planes) {
+		bool has_primary_plane = false;
+		struct drm_plane *plane;
+
+		drm_for_each_plane_mask(plane, dev, crtc_state->plane_mask) {
+			struct drm_plane_state *plane_state;
+
+			if (plane->type != DRM_PLANE_TYPE_PRIMARY)
+				continue;
+			plane_state = drm_atomic_get_plane_state(state, plane);
+			if (IS_ERR(plane_state))
+				return PTR_ERR(plane_state);
+			if (plane_state->fb && plane_state->crtc) {
+				has_primary_plane = true;
+				break;
+			}
+		}
+		if (!has_primary_plane) {
+			drm_dbg_kms(dev, "Cannot enable CRTC without a primary plane.\n");
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_atomic_helper_check_crtc_state);
+
 /**
  * drm_atomic_helper_check_planes - validate state object for planes changes
  * @dev: DRM device
diff --git a/include/drm/drm_atomic_helper.h b/include/drm/drm_atomic_helper.h
index 85df04c8e62f8..908ee3f417825 100644
--- a/include/drm/drm_atomic_helper.h
+++ b/include/drm/drm_atomic_helper.h
@@ -46,6 +46,8 @@ int drm_atomic_helper_check_plane_state(struct drm_plane_state *plane_state,
 					int max_scale,
 					bool can_position,
 					bool can_update_disabled);
+int drm_atomic_helper_check_crtc_state(struct drm_crtc_state *crtc_state,
+				       bool can_disable_primary_plane);
 int drm_atomic_helper_check_planes(struct drm_device *dev,
 			       struct drm_atomic_state *state);
 int drm_atomic_helper_check(struct drm_device *dev,
-- 
2.53.0

