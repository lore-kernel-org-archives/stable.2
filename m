Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046568;
	b=upG+CYAUkcqtXcP3t8frNLAEGFWGmmLLnRmgPB/qi71vs04On4aV8dJdB+t1GNbURFkF
	 YBnMw1eBb4FfOnpDhRRyDuyUSAo9BDBmJRgiMcHkUl1BCc7OgxgAf+Nln0ejq0UBOEYn9
	 HJWWae3PiveFy0E7FLTAZ7RHzVIRPwqpKlBO5fQ0Q8KfrygdDl06emDq/UL006tFMzuz+
	 dwkZ7zWgUVb0FLFVMbv/+5bb/UGbiZZdWhceioVR53Lv8dBqkJgyYdi7bf6+TLqa/ld9H
	 UxjEUOUsfghWH0NzUspjwogk1e3bdVCv3qtp6+kWQUIAwkRuOIo8YCr0IkJT7pCk6pQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046568;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=5Eu0ky/4OqxxeJea8ZLZyeq0WbBvPhzFBNsjYqP3Xho=;
	b=Vclc+y/2TWvUlVDfuRcWSbTizBi3MQY12HjhwQKrnYvwoXHHWD0QG/Ss4EQlnHhjwlKH
	 fqMLVcswKmAS7/VBqRiB1vRlPOR5E6gJHqvxiuwHhxQtdDrifnqWD3PY9NZ/HIjn/dJ2q
	 zDYHdPMVSGQEIEPXh0B0LS7GSyvKDfpGwWNNRGDaZFrSWPGlgSAK70zuP4nkph6rsSDnX
	 Ej4xHo4rqLMYAGEAJR6l2jF79g/9l5A5XUwsSHSXuT8Z85Ud8QPrEZ3KROnzW4YW6p6iI
	 fQfh5DPT2fe3HH+xm3uiQI4uv84QPfFi1X1VDAb9QyQNOra5BdAQswbv6Dz+nGC5Paw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HeAjdRiI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8449606A331
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HeAjdRiI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 300941F008A1;
	Sat,  7 Nov 2026 10:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046567;
	bh=5Eu0ky/4OqxxeJea8ZLZyeq0WbBvPhzFBNsjYqP3Xho=;
	h=From:To:Cc:Subject:Date;
	b=HeAjdRiIjBW33+A0g/Ocu/V1G2JHmEtIEYNLFf2yuWpN4j8NCAYr5BJyXZemn46/i
	 bjnTq6ZtKpconxQiJFI/V/gr5rkP/LSmmFfQyX2Hv97dTUdnUHCuE5yCe12eHkEmgk
	 xM05wgBW6dTug+2svNPV1qQ3ESmeBDOoHTMZocij8sSua44t4bZXy5O3WpLiwyuECm
	 nbYDNnWT1xjJaljuIAmpop5l+OivVQ8YN0xp6n5D5fOTCvMUBKjb8curiYou17mYUj
	 ERH7QpyhtK/I0CrydPskvnU1nYd7ZG8vJTxjUpmlGouv1x0wTk404538BSwDv7e4Z7
	 UtRXixJmltivw==
From: Sasha Levin <sashal@kernel.org>
To: nemesa.garg@intel.com,
	jouni.hogander@intel.com,
	animesh.manna@intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/i915/display: Clear SEL_FETCH_PLANE_CTL on plane disable" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:16:06 -0500
Message-ID: <20261107051606-failed-6.12-600a7c9d40e5@kernel.org>
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
git cherry-pick -x 600a7c9d40e5e0c5544f42d1c9592c8d15224dc0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051606-failed-6.12-600a7c9d40e5@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 600a7c9d40e5e0c5544f42d1c9592c8d15224dc0 Mon Sep 17 00:00:00 2001
From: Nemesa Garg <nemesa.garg@intel.com>
Date: Tue, 18 Aug 2026 15:21:49 +0530
Subject: [PATCH] drm/i915/display: Clear SEL_FETCH_PLANE_CTL on plane disable
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

icl_plane_disable_sel_fetch_arm() wrote SEL_FETCH_PLANE_CTL = 0 only when
crtc_state->enable_psr2_sel_fetch was set. If a plane was disabled after
selective fetch had been turned off, the guard fired early and left the
register's enable bit set in hardware.

The bit is harmless until selective fetch is re-enabled.  When it is, the
hardware resumes fetching for the now-disabled plane and keeps its old DDB
range reserved.

i9xx_cursor_disable_sel_fetch_arm() has the same guard on SEL_FETCH_CUR_CTL
and is fixed the same way.

v2: Add same check for cursor also. [sashiko]

Cc: stable@vger.kernel.org
Fixes: b1f5279b5981 ("drm/i915/psr: Move plane sel fetch configuration into plane source files")
Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8739
Assisted-by: GitHub-Copilot:claude-opus-4.6
Signed-off-by: Nemesa Garg <nemesa.garg@intel.com>
Reviewed-by: Jouni Högander <jouni.hogander@intel.com>
Signed-off-by: Animesh Manna <animesh.manna@intel.com>
Link: https://patch.msgid.link/20260818095149.2172935-1-nemesa.garg@intel.com
---
 drivers/gpu/drm/i915/display/intel_cursor.c       | 15 ++++++++++-----
 .../gpu/drm/i915/display/skl_universal_plane.c    | 15 ++++++++++-----
 2 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_cursor.c b/drivers/gpu/drm/i915/display/intel_cursor.c
index 0673f16f6fd0d..86bb96ac449b0 100644
--- a/drivers/gpu/drm/i915/display/intel_cursor.c
+++ b/drivers/gpu/drm/i915/display/intel_cursor.c
@@ -530,13 +530,18 @@ static int i9xx_check_cursor(struct intel_crtc_state *crtc_state,
 }
 
 static void i9xx_cursor_disable_sel_fetch_arm(struct intel_dsb *dsb,
-					      struct intel_plane *plane,
-					      const struct intel_crtc_state *crtc_state)
+					      struct intel_plane *plane)
 {
 	struct intel_display *display = to_intel_display(plane);
 	enum pipe pipe = plane->pipe;
 
-	if (!crtc_state->enable_psr2_sel_fetch)
+	/*
+	 * Clear this whenever the hardware has selective fetch, not just when
+	 * the current state uses it. The cursor may have been enabled with
+	 * selective fetch earlier and had its enable bit orphaned when the
+	 * feature was switched off.
+	 */
+	if (!HAS_PSR2_SEL_FETCH(display))
 		return;
 
 	intel_de_write_dsb(display, dsb, SEL_FETCH_CUR_CTL(pipe), 0);
@@ -586,7 +591,7 @@ static void i9xx_cursor_update_sel_fetch_arm(struct intel_dsb *dsb,
 		if (crtc_state->enable_psr2_su_region_et)
 			wa_16021440873(dsb, plane, crtc_state, plane_state);
 		else
-			i9xx_cursor_disable_sel_fetch_arm(dsb, plane, crtc_state);
+			i9xx_cursor_disable_sel_fetch_arm(dsb, plane);
 	}
 }
 
@@ -695,7 +700,7 @@ static void i9xx_cursor_update_arm(struct intel_dsb *dsb,
 	if (plane_state)
 		i9xx_cursor_update_sel_fetch_arm(dsb, plane, crtc_state, plane_state);
 	else
-		i9xx_cursor_disable_sel_fetch_arm(dsb, plane, crtc_state);
+		i9xx_cursor_disable_sel_fetch_arm(dsb, plane);
 
 	if (plane->cursor.base != base ||
 	    plane->cursor.size != fbc_ctl ||
diff --git a/drivers/gpu/drm/i915/display/skl_universal_plane.c b/drivers/gpu/drm/i915/display/skl_universal_plane.c
index 07a6832933521..5cda1ab90e40f 100644
--- a/drivers/gpu/drm/i915/display/skl_universal_plane.c
+++ b/drivers/gpu/drm/i915/display/skl_universal_plane.c
@@ -879,13 +879,18 @@ skl_plane_disable_arm(struct intel_dsb *dsb,
 }
 
 static void icl_plane_disable_sel_fetch_arm(struct intel_dsb *dsb,
-					    struct intel_plane *plane,
-					    const struct intel_crtc_state *crtc_state)
+					    struct intel_plane *plane)
 {
 	struct intel_display *display = to_intel_display(plane);
 	enum pipe pipe = plane->pipe;
 
-	if (!crtc_state->enable_psr2_sel_fetch)
+	/*
+	 * Clear this whenever the hardware has selective fetch, not just when
+	 * the current state uses it. The plane may have been enabled with
+	 * selective fetch earlier and had its enable bit orphaned when the
+	 * feature was switched off.
+	 */
+	if (!HAS_PSR2_SEL_FETCH(display))
 		return;
 
 	intel_de_write_dsb(display, dsb, SEL_FETCH_PLANE_CTL(pipe, plane->id), 0);
@@ -921,7 +926,7 @@ icl_plane_disable_arm(struct intel_dsb *dsb,
 
 	skl_write_plane_wm(dsb, plane, crtc_state);
 
-	icl_plane_disable_sel_fetch_arm(dsb, plane, crtc_state);
+	icl_plane_disable_sel_fetch_arm(dsb, plane);
 
 	if (plane_has_normalizer(plane))
 		intel_de_write_dsb(display, dsb,
@@ -1641,7 +1646,7 @@ static void icl_plane_update_sel_fetch_arm(struct intel_dsb *dsb,
 		intel_de_write_dsb(display, dsb, SEL_FETCH_PLANE_CTL(pipe, plane->id),
 				   SEL_FETCH_PLANE_CTL_ENABLE);
 	else
-		icl_plane_disable_sel_fetch_arm(dsb, plane, crtc_state);
+		icl_plane_disable_sel_fetch_arm(dsb, plane);
 }
 
 static void
-- 
2.53.0




