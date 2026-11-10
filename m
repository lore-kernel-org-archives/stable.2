Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273344;
	b=dlsSTh7T/ZGgTayYGhYycC1yonKqIGusolKjIePhQptQIacpW2wJQ5CxpGTeV62QyaV7
	 yadE7JFd2zXRH1nyBJPPuOhgftrd8zgKZM0msWmxeDQQ0VR0qxy/vyZo64dAhb4nYMZTm
	 np7AqUOqvbmhivkPjnSjsci5nZm6jw0U1vdn2s54we9cosVoJGv/bd8hiOHzRKjUDMOjJ
	 iKVP/ncf406gnCtmZ8eXajZU5SWtOwtacr3k+ybebond46YUtMDJttCICvHmXVAdIxKjw
	 geN9T23DSgwlYIOG/0T+hVmvs76Rk9tHwlmTsRH6goU5XbWc2d6xXa3XrodrbEnsxHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273344;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=2OB+m/Xr3ExspG68HrehbpCzujZfKd5HFpdL9T5t1ko=;
	b=buer2vHSoPhlXngV4FVx8g8+vIOctEDpXyccLsBSfwn9bVJR0OlIYfaQUl8P43NPMvcn
	 Pwq6k4ScgUc4EWnrS6P112HSjbxM8KJvGOEjTQp4xKregYLvTmW9pHUmQKoMRGJP0qFFe
	 aKqnYo3maFErsbJN3SZF5RsyRpkbyvBzDg2W2vhZ8EEWvdaRIqmLm40YIhOdNur00e4cc
	 O3MgpPBC3+f81796vbaiVwpxU1cSm8txtpVAzBTjGWRT2pjqM8sLb3jtu+oqpKxf5mPag
	 if2+MzVEP7UsW3y+dSzyS2p22qn4wRm766uJ/PGwb0IpIk3kZL3aIXFQAgzF3nPd9WQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fJENHAhX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49206606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fJENHAhX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B9991F0089F;
	Tue, 10 Nov 2026 01:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273344;
	bh=2OB+m/Xr3ExspG68HrehbpCzujZfKd5HFpdL9T5t1ko=;
	h=From:To:Cc:Subject:Date;
	b=fJENHAhXlZNmVaaX80J60+LiOG6jfWGfyYLFB/etaAaLr9BsLTIdFy8Ulks9smr62
	 xXe/CHQyEBNfY3RlzNBYyVj/0SNozRQI94hdC73YKiJX+bvEabxR6wgmA4Zhl7jmhg
	 6UraFvnloHboIcYpUH5AvjYn0btf00g9gi36SnQsiPcw8yq6RReGZYvcmTAYkJyOfy
	 T8pMeqOFYqpglVUq0Wk1DXf7YzeQD3clrnuCvhWUSNbc0A4Br/WJ3I4mBz6hZlLRd+
	 PmOw3f+JGpKBNxIhHyK9Pbpr9kTx+LucTtWtCelcQsle99oFkmHFGTk3Hob4/yl2jD
	 +DGLo4bjkxkJw==
From: Sasha Levin <sashal@kernel.org>
To: jouni.hogander@intel.com,
	mika.kahola@intel.com,
	joonas.lahtinen@linux.intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/i915/display: Add enabled pipe planes into state for selective fetch" failed to apply to 6.1-stable tree
Date: Mon,  9 Nov 2026 20:15:42 -0500
Message-ID: <20261109201542-failed-6.1-94cb1f08b197@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 94cb1f08b197d9ae932ff98c741bd0dbc96e17e8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201542-failed-6.1-94cb1f08b197@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




