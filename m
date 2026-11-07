Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045792;
	b=u66qg3ajBYCD3K46jlriTk2e2CeFQAguJBY1NgvHXPyFkjV1POmq6ZXMImnGsRD+uWYE
	 v+8bcGEps8eX2Ay9CTNfF2ZYw6q3UbEUgOFBhFBPCcxVLCEuBLsOdJnRm7Nhi/HD/x29J
	 MSAXapl3vvjRhtWN3eCPu1AnEIDcG8dYXR6A3uzSVgvwJraNUxquoV7E+n8Y3/h0kSiFN
	 TiNmIRIvC5PdlxsDmvGGWNvCLbPghKnmdi1MR3+DWI8r62IOEyiahZnw/G+pCse1hxQ5d
	 Jv4DUvvhKYQlG5E1xInAG/TrNjEzIJYB2lLFUgP9why+t2x79kbiEpemWkWg+KfHztw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045792;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=P1YImaThlcHXEwxmgoS3h80sdI90+eoVG2410OEnRe4=;
	b=MBOOVzwte4m2Wec008IO+arzrjbAguGYtGWdTTc36iug2A8dSDrm4FUlXZO1zwa/lNDj
	 R6Q7+5FVzLNfxW6N7SoIwnU653Ucd6J0FMrrVJzNq8Ly/pnUeo6WwjqKXGwf8/ZI3nFMj
	 QY/ddlmFhlmNbdzC5yx4VKU0LlDCbMwHtQIgut1YqrqVcyx7MewR7Fkwa7UKwC+PlqRw+
	 KT9NK/XnEwZMQkZoz2oVIYZWgYZ18vfU7ntJQanUTUJbTWbOx9phWOgtGlBuvR+ci1q0W
	 HU28SvDWwbiqBh7JeH5tN6NuenxGwdaMNCYSoY2cxOeKbiEALd/t8nm1M+K19sEEBkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fLWfLuPX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1D1606A32E
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fLWfLuPX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B16BE1F0089F;
	Sat,  7 Nov 2026 10:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794045791;
	bh=P1YImaThlcHXEwxmgoS3h80sdI90+eoVG2410OEnRe4=;
	h=From:To:Cc:Subject:Date;
	b=fLWfLuPXVowFN6swBPUH45hQb5tnRNmGNgYidMGSEv2FZwaX+ZHXUKW2sbK7NoO8o
	 Fp6CsvK61B9fCQjUo/FIKdIW4vET4vaqKo1Eys4DDOtC4MCURXeaUsqP56H8tKi9iv
	 X5O+oMU9FwuzfZfKeGZnhWAbkdrljjDEU4oEY/t9cO1y+8V4AmORarGHqCWEha5wEW
	 B1/DHbWO/21fKeyx5+d+qwQwNxxlqrgJq716NxRnlQQaLfox/IoDFzWVoYs9uraJuL
	 bu4ipb8aR0MjBd4xaxBoWWO/6hAznHzRF/KHpUKlSIetOcbTuSHs7Cebo24wzn2uER
	 EFERomexkZeCA==
From: Sasha Levin <sashal@kernel.org>
To: nemesa.garg@intel.com,
	jouni.hogander@intel.com,
	suraj.kandpal@intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] Revert "drm/i915/display: Clear SEL_FETCH_PLANE_CTL on plane disable"" failed to apply to 7.3-stable tree
Date: Sat,  7 Nov 2026 05:03:09 -0500
Message-ID: <20261107050309-failed-7.3-d39352939416@kernel.org>
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

The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x d393529394167e0f5f706657eebe84d8529ce4fc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050309-failed-7.3-d39352939416@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From d393529394167e0f5f706657eebe84d8529ce4fc Mon Sep 17 00:00:00 2001
From: Nemesa Garg <nemesa.garg@intel.com>
Date: Wed, 9 Sep 2026 16:33:31 +0530
Subject: [PATCH] Revert "drm/i915/display: Clear SEL_FETCH_PLANE_CTL on plane
 disable"
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This reverts commit 7f1172a2ac0d7e50850785e2e65789c8aac8411a.

This commit replaced the crtc_state->enable_psr2_sel_fetch guard in
icl_plane_disable_sel_fetch_arm() and i9xx_cursor_disable_sel_fetch_arm()
with HAS_PSR2_SEL_FETCH(). This is a display version check and
says nothing about the pipe, so every plane and cursor disable on a
display 12+ platform started writing SEL_FETCH_PLANE_CTL() /
SEL_FETCH_CUR_CTL(), including on pipes that do not implement them.
It shows up as an unclaimed register access on pipes driving HDMI where
selective fetch was never enabled.

The stale selective fetch enable bit that commit addressed is handled
in the next patch.

Fixes: 7f1172a2ac0d ("drm/i915/display: Clear SEL_FETCH_PLANE_CTL on plane disable")
Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/16876
Cc: stable@vger.kernel.org
Signed-off-by: Nemesa Garg <nemesa.garg@intel.com>
Reviewed-by: Jouni Högander <jouni.hogander@intel.com>
Signed-off-by: Suraj Kandpal <suraj.kandpal@intel.com>
Link: https://patch.msgid.link/20260909110332.3528029-2-nemesa.garg@intel.com
---
 drivers/gpu/drm/i915/display/intel_cursor.c       | 15 +++++----------
 .../gpu/drm/i915/display/skl_universal_plane.c    | 15 +++++----------
 2 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_cursor.c b/drivers/gpu/drm/i915/display/intel_cursor.c
index cce041e1da51d..90173040d8253 100644
--- a/drivers/gpu/drm/i915/display/intel_cursor.c
+++ b/drivers/gpu/drm/i915/display/intel_cursor.c
@@ -531,18 +531,13 @@ static int i9xx_check_cursor(struct intel_crtc_state *crtc_state,
 }
 
 static void i9xx_cursor_disable_sel_fetch_arm(struct intel_dsb *dsb,
-					      struct intel_plane *plane)
+					      struct intel_plane *plane,
+					      const struct intel_crtc_state *crtc_state)
 {
 	struct intel_display *display = to_intel_display(plane);
 	enum pipe pipe = plane->pipe;
 
-	/*
-	 * Clear this whenever the hardware has selective fetch, not just when
-	 * the current state uses it. The cursor may have been enabled with
-	 * selective fetch earlier and had its enable bit orphaned when the
-	 * feature was switched off.
-	 */
-	if (!HAS_PSR2_SEL_FETCH(display))
+	if (!crtc_state->enable_psr2_sel_fetch)
 		return;
 
 	intel_de_write_dsb(display, dsb, SEL_FETCH_CUR_CTL(pipe), 0);
@@ -592,7 +587,7 @@ static void i9xx_cursor_update_sel_fetch_arm(struct intel_dsb *dsb,
 		if (crtc_state->enable_psr2_su_region_et)
 			wa_16021440873(dsb, plane, crtc_state, plane_state);
 		else
-			i9xx_cursor_disable_sel_fetch_arm(dsb, plane);
+			i9xx_cursor_disable_sel_fetch_arm(dsb, plane, crtc_state);
 	}
 }
 
@@ -701,7 +696,7 @@ static void i9xx_cursor_update_arm(struct intel_dsb *dsb,
 	if (plane_state)
 		i9xx_cursor_update_sel_fetch_arm(dsb, plane, crtc_state, plane_state);
 	else
-		i9xx_cursor_disable_sel_fetch_arm(dsb, plane);
+		i9xx_cursor_disable_sel_fetch_arm(dsb, plane, crtc_state);
 
 	if (plane->cursor.base != base ||
 	    plane->cursor.size != fbc_ctl ||
diff --git a/drivers/gpu/drm/i915/display/skl_universal_plane.c b/drivers/gpu/drm/i915/display/skl_universal_plane.c
index 5cda1ab90e40f..07a6832933521 100644
--- a/drivers/gpu/drm/i915/display/skl_universal_plane.c
+++ b/drivers/gpu/drm/i915/display/skl_universal_plane.c
@@ -879,18 +879,13 @@ skl_plane_disable_arm(struct intel_dsb *dsb,
 }
 
 static void icl_plane_disable_sel_fetch_arm(struct intel_dsb *dsb,
-					    struct intel_plane *plane)
+					    struct intel_plane *plane,
+					    const struct intel_crtc_state *crtc_state)
 {
 	struct intel_display *display = to_intel_display(plane);
 	enum pipe pipe = plane->pipe;
 
-	/*
-	 * Clear this whenever the hardware has selective fetch, not just when
-	 * the current state uses it. The plane may have been enabled with
-	 * selective fetch earlier and had its enable bit orphaned when the
-	 * feature was switched off.
-	 */
-	if (!HAS_PSR2_SEL_FETCH(display))
+	if (!crtc_state->enable_psr2_sel_fetch)
 		return;
 
 	intel_de_write_dsb(display, dsb, SEL_FETCH_PLANE_CTL(pipe, plane->id), 0);
@@ -926,7 +921,7 @@ icl_plane_disable_arm(struct intel_dsb *dsb,
 
 	skl_write_plane_wm(dsb, plane, crtc_state);
 
-	icl_plane_disable_sel_fetch_arm(dsb, plane);
+	icl_plane_disable_sel_fetch_arm(dsb, plane, crtc_state);
 
 	if (plane_has_normalizer(plane))
 		intel_de_write_dsb(display, dsb,
@@ -1646,7 +1641,7 @@ static void icl_plane_update_sel_fetch_arm(struct intel_dsb *dsb,
 		intel_de_write_dsb(display, dsb, SEL_FETCH_PLANE_CTL(pipe, plane->id),
 				   SEL_FETCH_PLANE_CTL_ENABLE);
 	else
-		icl_plane_disable_sel_fetch_arm(dsb, plane);
+		icl_plane_disable_sel_fetch_arm(dsb, plane, crtc_state);
 }
 
 static void
-- 
2.53.0




