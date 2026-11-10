Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272806;
	b=AwPBVrKiROQBA7w2PrTOiePgyfWVgURP1QPikEQ+MToBmvtsODaWOxgIdrftpquG6y00
	 GsO/lB9hQX3quMn+NHijYzHQCrMQ3ehj1b0q9pOeJi08X3DGMjsosobqT91iZLzcdOwb6
	 grZkcNorde7SpoIwAFG0BY4qIiu0oWBv0V7wTy9x5LBtUzKHtn+9bUNhUlTHoFyQuujp+
	 0KpR/ppzj18ZhD/euTDaStnAM6wNATxZ5Qjm10AYZA4L/2RdXFcOyMj1hJYVoF0mlhnlH
	 y1d99yiOrgUp8/wbABFJJcoB38WL78ZesRLshq1qwyRVq/8YhWvNKDKYKgm9pfFR8jA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272806;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=BlzSVB2I+i2Abvt8LaVT2aAIqHQV32ggmilFvM5jJK0=;
	b=3O7a3J91BiPOSfWXZJm6camrWSxf/x2iR7weUxJIY3qplImr1vtDun71mTIf8x6IjQcH
	 LfGO/JRs+pD3A85lFdNMAFIdc+A1QV85MRa1NjgpM/6htLvCtG/5gYfO9AfvN4OcVmo3+
	 NO1G59UclfvWnx6tmOgb0uYXlu68HRF6rNQENGW+fXyWuAvJZm0jFtxPecSiW24evR0Xk
	 P+ZiO434oDE5ZPO2YXpHhjiPSqKfSo6wlBWS3YPb8e15zj5zkIqA6oz0ks/qY/8sXaTJn
	 3mWOcQm9KiOfd1iZca5qrHUPoQ2cSq1zhg4mMxW8EjbK7VDnDr/2aRQcEwhVC4wvmBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QBaGlb0K;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A8B606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QBaGlb0K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 568A91F0089F;
	Tue, 10 Nov 2026 01:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272805;
	bh=BlzSVB2I+i2Abvt8LaVT2aAIqHQV32ggmilFvM5jJK0=;
	h=From:To:Cc:Subject:Date;
	b=QBaGlb0KVyaqkWRVVhTc7UZtqPGGIxI+t1h9XBOj3NcQPnDRLmC6Bip3Mbfvz3zp1
	 I8H6BDcE21MrTZ1Ul+VmUSzZj3AS+ibKqR9QTsIr2ZCC0TCy/lxHl+TjN5QYY8yNIF
	 Hvixvwng5q8ygHC180UIHGJgcgJWA5TxqhquU38fRySdyc29/Z09DhaxSbRkphipds
	 PqBTXh19UQV7VVztGGj1sa7VCRuONhw1SpGMSN1dm/v3rT1UeIxhPYq/lliXwcYtP9
	 9qCcVOBWFUYnFn+5OJwPE0D64OlDMvrmsAmBS0Q9bwUPAtf4zdoekeoebWGfiRHCZP
	 OvVnGM+1e0lSQ==
From: Sasha Levin <sashal@kernel.org>
To: jouni.hogander@intel.com,
	mika.kahola@intel.com,
	joonas.lahtinen@linux.intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/i915/psr: Disable linked plane sel fetch as well" failed to apply to 6.12-stable tree
Date: Mon,  9 Nov 2026 20:06:44 -0500
Message-ID: <20261109200644-failed-6.12-b56721c32eb3@kernel.org>
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
git cherry-pick -x b56721c32eb3ad0f086fdc0f33479be395e43bb9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200644-failed-6.12-b56721c32eb3@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From b56721c32eb3ad0f086fdc0f33479be395e43bb9 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>
Date: Tue, 29 Sep 2026 12:44:29 +0300
Subject: [PATCH] drm/i915/psr: Disable linked plane sel fetch as well
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently we are not setting linked plane selective area when selective
fetch is about to be disabled for the UV plane. Fix this by simplifying the
loop by just handling plane selective fetch disable and area setting same
way.

Also set the update_planes bit based on comparing old and new plane
selective fetch area. This way both the plane and its linked Y plane are
updated only when their selective fetch area changed.

Fixes: a4f477e6ac17 ("drm/i915/psr: Add proper handling for disabling sel fetch for planes")
Cc: <stable@vger.kernel.org> # v6.8+
Assisted-by: GitHub-Copilot:claude-opus-5
Signed-off-by: Jouni Högander <jouni.hogander@intel.com>
Reviewed-by: Mika Kahola <mika.kahola@intel.com>
Link: https://patch.msgid.link/20260929094434.77129-4-jouni.hogander@intel.com
(cherry picked from commit b10c83af60cbc00ce4112742fd297581233e43cd)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
---
 drivers/gpu/drm/i915/display/intel_psr.c | 27 ++++++++++++------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index d4338e978dba9..dd50f10332fc6 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -3068,21 +3068,14 @@ int intel_psr2_sel_fetch_update(struct intel_atomic_state *state,
 
 		inter = crtc_state->psr2_su_area;
 		sel_fetch_area = &new_plane_state->psr2_sel_fetch_area;
-		if (!drm_rect_intersect(&inter, &new_plane_state->uapi.dst)) {
-			/*
-			 * if plane sel fetch was previously enabled ->
-			 * disable it
-			 */
-			if (drm_rect_height(&old_plane_state->psr2_sel_fetch_area) > 0)
-				crtc_state->update_planes |= BIT(plane->id);
-
-			continue;
+		if (drm_rect_intersect(&inter, &new_plane_state->uapi.dst)) {
+			sel_fetch_area->y1 = inter.y1 - new_plane_state->uapi.dst.y1;
+			sel_fetch_area->y2 = inter.y2 - new_plane_state->uapi.dst.y1;
 		}
 
-		sel_fetch_area = &new_plane_state->psr2_sel_fetch_area;
-		sel_fetch_area->y1 = inter.y1 - new_plane_state->uapi.dst.y1;
-		sel_fetch_area->y2 = inter.y2 - new_plane_state->uapi.dst.y1;
-		crtc_state->update_planes |= BIT(plane->id);
+		if (!drm_rect_equals(&old_plane_state->psr2_sel_fetch_area,
+				     sel_fetch_area))
+			crtc_state->update_planes |= BIT(plane->id);
 
 		/*
 		 * Sel_fetch_area is calculated for UV plane. Use
@@ -3090,16 +3083,22 @@ int intel_psr2_sel_fetch_update(struct intel_atomic_state *state,
 		 */
 		if (linked) {
 			struct intel_plane_state *linked_new_plane_state;
+			struct intel_plane_state *linked_old_plane_state;
 			struct drm_rect *linked_sel_fetch_area;
 
 			linked_new_plane_state = intel_atomic_get_new_plane_state(state, linked);
 			if (!linked_new_plane_state)
 				return -EINVAL;
 
+			linked_old_plane_state = intel_atomic_get_old_plane_state(state, linked);
+
 			linked_sel_fetch_area = &linked_new_plane_state->psr2_sel_fetch_area;
 			linked_sel_fetch_area->y1 = sel_fetch_area->y1;
 			linked_sel_fetch_area->y2 = sel_fetch_area->y2;
-			crtc_state->update_planes |= BIT(linked->id);
+
+			if (!drm_rect_equals(&linked_old_plane_state->psr2_sel_fetch_area,
+					     linked_sel_fetch_area))
+				crtc_state->update_planes |= BIT(linked->id);
 		}
 	}
 
-- 
2.53.0




