Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599740;
	b=Lv1biYmtQHUbMmvESpSVm3KeR+RtE2hrf8ZzTzNV1RyZBHG1U9h38shDGBpNrfQi5RGl
	 PrRV6BZGFMcqdyQ5boOBNwfrEo2mLH96QDF5DII/LmVW3WUf+04ld1O1Es+s8HMEt7gEt
	 GEFH1zMUd0lt0SyUdpqUmNPW72dmbyVxzV+1/vz+dpuwXQAVpeKSwbPzaA/fBbYnCHp3x
	 snjh9g0PdC/xhtM6pAqXtaizCfPP4ZqyiHbVvVvxX0vMg9mxTaCTnOPi/CVdY9aR0z9kz
	 N4WygMWA9Slc9twBEWSLyU448lKz8tL4p06PeIUpkIOVmiZuscw8LnZzeuATrdx5adw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599740;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=LMoEF7w8L8Od9vwJXhrUO0hQkBufqQs/ao4oC1jLC+Y=;
	b=BHvxBEPzzHis6pyqfKHBHLh+4JBMK5R64Av2i/ocwCvetDuAWL911/vy80iRN5KK/L71
	 Grv16CUdQptCubJKclz/CbnO8TyJ7texL3sd4+MryMIezyT5Prz+cHxGd9/dK3OOEUTEn
	 p9OJjGGtkWYnSZbQG7iLSP30W3MOZZ0S2tqgG2fMlImBOohCLBG03glJ4uLcZQQkOEmz8
	 cAH7KwhrF+IcYeNjyPipjfg7RJwCQOQhp3y5yV+MfQtWyKeRgq2rE+/dPGtgtsT/KxvlC
	 GvySlucJkB87i1wKmsm3VRIe8/81VwDW+PcXlancJAwTU9uuRsi8fA/tDQvNkXdmoWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QD8sLgdf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2746606A88E
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 19:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QD8sLgdf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 451491F000C4;
	Fri, 13 Nov 2026 19:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794599739;
	bh=LMoEF7w8L8Od9vwJXhrUO0hQkBufqQs/ao4oC1jLC+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QD8sLgdfdlWUaLxaoXQPjRFHtg+PU8VWWAN9OGURV4KmLbzz2FiaL88gd23EHDsQR
	 tU1sMq+6D0rWQQBxy5rNJmcZlb2sa6ta0MBikwbobzK6eGEfDjZMFk1OtDneVS9QwX
	 SF1FsiYkV3cxU+ip2Qq6kCuX4olWqVIIQOiIAK2+22PzzWK6Tec6DQXeJtMGObrf6N
	 SKaeTA5EyKisEdaHepwq+1Y5AFyPRSW2dr5mZm7tv2iGeXfM+kMq7ADKq6gxP8UVO/
	 O8lw1ykVX66tDvFpuvWe9KKfuvOxDW4MwA3GpWNoLoHwfKYYV24bdR5FY9I8i2LoZ7
	 +yCyDNt6N98tg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
	Mika Kahola <mika.kahola@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] drm/i915/display: Add enabled pipe planes into state for selective fetch
Date: Fri, 13 Nov 2026 14:55:38 -0500
Message-ID: <20261113195238.2279432-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200646-failed-6.12-94cb1f08b197@kernel.org>
References: <20261109200646-failed-6.12-94cb1f08b197@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jouni Högander <jouni.hogander@intel.com>

[ Upstream commit 94cb1f08b197d9ae932ff98c741bd0dbc96e17e8 ]

Selective fetch support for biplanar formats relies on linking of UV and
the Y planes. Planes that are not part of the atomic state are pulled in by
the drm_atomic_add_affected_planes. If the UV plane is added into the state
by drm_atomic_add_affected_planes in the selective fetch calculation, the
linking isn't done anymore and the Y plane is left disabled.

Fix this by adding affected planes already in intel_add_affected_planes if
selective fetch is enabled.

Remove redundant drm_atomic_add_affected_planes from
intel_psr2_sel_fetch_update and redundant check for plane selective fetch
support that is not needed as all planes are already in atomic state on
first loop iterating them. Also switch to intel_atomic_get_new_plane_state
for linked plane new plane state.

Fixes: 3809991ff5f4 ("drm/i915/display: Add initial selective fetch support for biplanar formats")
Cc: <stable@vger.kernel.org> # v5.17+
Signed-off-by: Jouni Högander <jouni.hogander@intel.com>
Reviewed-by: Mika Kahola <mika.kahola@intel.com>
Link: https://patch.msgid.link/20260929094434.77129-3-jouni.hogander@intel.com
(cherry picked from commit 0d173898b11157d37de3e5f01ef28a48582167d8)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
[ sashal: adapted the collection loop to intel_atomic_check_planes() using the existing intel_atomic_add_affected_planes() helper ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/display/intel_display.c | 12 ++++++++++
 drivers/gpu/drm/i915/display/intel_psr.c     | 25 +++++++-------------
 2 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
index 4a3cc3369180b..841a2129bdd3a 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -5879,6 +5879,18 @@ static int intel_atomic_check_planes(struct intel_atomic_state *state)
 	struct intel_crtc *crtc;
 	int i, ret;
 
+	for_each_new_intel_crtc_in_state(state, crtc, new_crtc_state, i) {
+		/*
+		 * Add affected plane here to ensure UV and Y plane linking is
+		 * in place if UV plane is added as a part of selective update.
+		 */
+		if (new_crtc_state->enable_psr2_sel_fetch) {
+			ret = intel_atomic_add_affected_planes(state, crtc);
+			if (ret)
+				return ret;
+		}
+	}
+
 	ret = icl_add_linked_planes(state);
 	if (ret)
 		return ret;
diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index 97f82949a3a51..7856d50064ab6 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -2561,7 +2561,7 @@ int intel_psr2_sel_fetch_update(struct intel_atomic_state *state,
 		.y2 = crtc_state->hw.adjusted_mode.crtc_vdisplay,
 	};
 	bool full_update = false, su_area_changed;
-	int i, ret;
+	int i;
 
 	/*
 	 * Selective fetch is not always usable, for instance it is dropped
@@ -2676,19 +2676,15 @@ int intel_psr2_sel_fetch_update(struct intel_atomic_state *state,
 
 	intel_psr_apply_su_area_workarounds(crtc_state);
 
-	ret = drm_atomic_add_affected_planes(&state->base, &crtc->base);
-	if (ret)
-		return ret;
-
 	do {
 		bool cursor_in_su_area = false;
 
 		/*
 		 * Adjust su area to cover cursor fully as necessary
-		 * (early transport). This needs to be done after
-		 * drm_atomic_add_affected_planes to ensure visible
-		 * cursor is added into affected planes even when
-		 * cursor is not updated by itself.
+		 * (early transport). A visible cursor is in the state
+		 * even when it is not updated by itself as all planes
+		 * of the pipe are added into the state before the plane
+		 * checks when selective fetch is enabled.
 		 */
 		intel_psr2_sel_fetch_et_alignment(state, crtc, &display_area,
 						  &cursor_in_su_area);
@@ -2736,11 +2732,6 @@ int intel_psr2_sel_fetch_update(struct intel_atomic_state *state,
 			continue;
 		}
 
-		if (!psr2_sel_fetch_plane_state_supported(new_plane_state)) {
-			full_update = true;
-			break;
-		}
-
 		sel_fetch_area = &new_plane_state->psr2_sel_fetch_area;
 		sel_fetch_area->y1 = inter.y1 - new_plane_state->uapi.dst.y1;
 		sel_fetch_area->y2 = inter.y2 - new_plane_state->uapi.dst.y1;
@@ -2754,9 +2745,9 @@ int intel_psr2_sel_fetch_update(struct intel_atomic_state *state,
 			struct intel_plane_state *linked_new_plane_state;
 			struct drm_rect *linked_sel_fetch_area;
 
-			linked_new_plane_state = intel_atomic_get_plane_state(state, linked);
-			if (IS_ERR(linked_new_plane_state))
-				return PTR_ERR(linked_new_plane_state);
+			linked_new_plane_state = intel_atomic_get_new_plane_state(state, linked);
+			if (!linked_new_plane_state)
+				return -EINVAL;
 
 			linked_sel_fetch_area = &linked_new_plane_state->psr2_sel_fetch_area;
 			linked_sel_fetch_area->y1 = sel_fetch_area->y1;
-- 
2.53.0

