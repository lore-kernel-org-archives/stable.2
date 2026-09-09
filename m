Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116295328A3
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788954650; cv=none; b=auEVtMlEfOCb43xHJhurFXl8mysAYwnK/AzubGzIS9ELUctk/l45wBN68tVGU7f4KeqEnAsTFBI0uvRNP4iafLcuKcPo1lbEQptTZa8yqHpQ1TlyN5etS4xh39jNzywVFL0l0i7hzA4At3ZoH4JVOkDvMTHMUAdLHmN/Hn7IK8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788954650; c=relaxed/simple;
	bh=G50bMRq7B0Tm7/V3QWHOXprHQUzPIOV4/L2+3amNdbk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pJrzRw8DoS8L2K/81/JBPrN2uBTv037q1f4IXq/0eg2klXnsJQWEr20RkxcHYUjVLWr6fauqYXws3vDGGlELHLd6UB0wPP+7Z6hcxXI8OdNKIiJrpnAg1a3FziVu2JlN8U8Me6msl5S0Nm0DAFEX/KlME98uWeLgvbI+cUmgrAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N/MU2ibw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N/MU2ibw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AF4F1F00A3A;
	Wed,  9 Sep 2026 11:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788954648;
	bh=99SQTw0Qr5r9XsXeD1/lh6LivpsYRa3W3rrB2tjLmAY=;
	h=Subject:To:Cc:From:Date;
	b=N/MU2ibw9zDUjP8o8BnQxf2+JhinbsDXL30uZ1PHmS/b2WmQKZ5HUkZBAU31zOe1H
	 +KL3w5fXsmhudD7scl4PHePhqMELNPTFMawvj3JFGBacavE8ejM/eAC38ii0wsJ/KH
	 bqPYkZz+1dMirR7J7dfX8l7cNirKi8LV3Uo8FNnA=
Subject: FAILED: patch "[PATCH] drm/i915/display: Clear SEL_FETCH_PLANE_CTL on plane disable" failed to apply to 6.12-stable tree
To: nemesa.garg@intel.com,animesh.manna@intel.com,jani.nikula@intel.com,jouni.hogander@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 13:40:53 +0200
Message-ID: <2026090953-gravel-panama-02e2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x 7f1172a2ac0d7e50850785e2e65789c8aac8411a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090953-gravel-panama-02e2@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7f1172a2ac0d7e50850785e2e65789c8aac8411a Mon Sep 17 00:00:00 2001
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
(cherry picked from commit 600a7c9d40e5e0c5544f42d1c9592c8d15224dc0)
Signed-off-by: Jani Nikula <jani.nikula@intel.com>

diff --git a/drivers/gpu/drm/i915/display/intel_cursor.c b/drivers/gpu/drm/i915/display/intel_cursor.c
index 0673f16f6fd0..86bb96ac449b 100644
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
index 07a683293352..5cda1ab90e40 100644
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

