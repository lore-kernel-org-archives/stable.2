Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272808;
	b=uvLe/sD5nSIvh0Emepx/NDEuCDp+zAY4n+MSfpbtdE1UFKJfFz6VjB916Big2kJ4ZN8G
	 NjYOkzU/yu7MPqgDnPPuDnaHJgMGUuxWqq2e/OuV+AJAIAE4hA2CsE4MW+mDtLt0ba5Q5
	 laWnzLef1+XVGQud798oMg4vuZ0XeYW0ltqHXI/m7tc257ef6y/gP2aR9wjywJDo/HOXU
	 Sn8D/onlnufcf8r0aOaur5XiC62rAn92Eh/LENPjAv4as8To8zbleEknl33+9ZAgU+BQs
	 nVMtjcYE53gL+Cr3M+JToIic8k+tgdLDUT/AsSg92nZI8Nd7mleqLn9oMHsX+sOWGrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272808;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=KsivmEQPIeIKtseRvHWcW9dY9UT2qkY1kDB7i/sopA8=;
	b=3lQxGC3YHWsQoJA2IsyDmNxuqUjx1knmHGak5Gan5GnvIlqOzubgBvrcgL2mnj1vJZ2G
	 lT8vc9JTgEuHPBss8HFDAakSbOZbutjx2oVloLQ0TpX4NYafuYXhBRqj5BaeN4VQmNGym
	 i+RwWalCHAupV6Wu/g8dWNvAfxoZP6ile5oMSomi1mGO06CS+/lKcu/0y5egKTZlcHoFt
	 YC2UtOfgohTCYRXox0Nml5ec1TepXcUz4pPfsneKFDuI+a66dRZwM4h1eml0+PYEjrmqB
	 Dn91o96pSE3T6VnxoPtQBHYi70yrPneW7ws85qx2x3P8dYG1yCe+wkO4p9NtLB8hFbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MlQN5rxe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510F4606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MlQN5rxe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8BED1F0089F;
	Tue, 10 Nov 2026 01:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272808;
	bh=KsivmEQPIeIKtseRvHWcW9dY9UT2qkY1kDB7i/sopA8=;
	h=From:To:Cc:Subject:Date;
	b=MlQN5rxec7zCRCu5LVgO/+LtM6fns+XKruW7CTkD3g/Jc6KNrI9oAnqO1WkP2D4Kv
	 RJB6sVvJHvSz2+SP9AjOykcwoiC5Ux8/HtMFDQ1Lq2yqzz1qSgZ6x1NSRbhT6ZPk20
	 kghfReikRTY+exPunygGFY1m85RnpK2Njtwa7drApjyQ8ipV+1MW1LnpxLHJeGrdut
	 9HaPbBprTM3HDTv+53CEuybH9HTWOMllJDvPWjLNqqd5GMNyMfl6ZVZS3Da8MewTeR
	 orVFMPfBUjCAdEGQUeqrcQ9P8grdsyaP4U/cFo+Mjiw5uQnHvGTacD6X++kFjzyWfX
	 lZf2OWEWHPIYQ==
From: Sasha Levin <sashal@kernel.org>
To: jouni.hogander@intel.com,
	mika.kahola@intel.com,
	joonas.lahtinen@linux.intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/i915/display: Add enabled pipe planes into state for selective fetch" failed to apply to 6.12-stable tree
Date: Mon,  9 Nov 2026 20:06:46 -0500
Message-ID: <20261109200646-failed-6.12-94cb1f08b197@kernel.org>
X-Mailer: git-send-email 2.53.0
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 94cb1f08b197d9ae932ff98c741bd0dbc96e17e8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200646-failed-6.12-94cb1f08b197@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 94cb1f08b197d9ae932ff98c741bd0dbc96e17e8 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>
Date: Tue, 29 Sep 2026 12:44:28 +0300
Subject: [PATCH] drm/i915/display: Add enabled pipe planes into state for
 selective fetch
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
---
 drivers/gpu/drm/i915/display/intel_plane.c | 10 +++++++++
 drivers/gpu/drm/i915/display/intel_psr.c   | 25 +++++++---------------
 2 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_plane.c b/drivers/gpu/drm/i915/display/intel_plane.c
index f908eabe604bb..d23de0f34e4b6 100644
--- a/drivers/gpu/drm/i915/display/intel_plane.c
+++ b/drivers/gpu/drm/i915/display/intel_plane.c
@@ -1980,6 +1980,16 @@ static int intel_add_affected_planes(struct intel_atomic_state *state)
 		ret = intel_joiner_add_affected_planes(state, intel_crtc_joined_pipe_mask(crtc_state));
 		if (ret)
 			return ret;
+
+		/*
+		 * Add affected plane here to ensure UV and Y plane linking is
+		 * in place if UV plane is added as a part of selective update.
+		 */
+		if (crtc_state->enable_psr2_sel_fetch) {
+			ret = intel_plane_add_affected(state, crtc);
+			if (ret)
+				return ret;
+		}
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index e58a4ac2e06aa..d4338e978dba9 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -2905,7 +2905,7 @@ int intel_psr2_sel_fetch_update(struct intel_atomic_state *state,
 		.y2 = crtc_state->hw.adjusted_mode.crtc_vdisplay,
 	};
 	bool full_update = false, su_area_changed;
-	int i, ret;
+	int i;
 
 	/*
 	 * Selective fetch is not always usable, for instance it is dropped
@@ -3020,19 +3020,15 @@ int intel_psr2_sel_fetch_update(struct intel_atomic_state *state,
 
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
@@ -3083,11 +3079,6 @@ int intel_psr2_sel_fetch_update(struct intel_atomic_state *state,
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
@@ -3101,9 +3092,9 @@ int intel_psr2_sel_fetch_update(struct intel_atomic_state *state,
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




