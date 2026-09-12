Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE41345EDF
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 14:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789223037; cv=none; b=boF+DX6715mpt6ItcSXik6Upckltfe3V00ThFISlDBLO+ZHeFk6GS069emw93GI+VieqZjBZGndesTrB6fv6JhbCzui5WVUsYEDSx9/wHjvDfLYXG67t+XBcYZzkCthSpiZd4UkYiMHuoi19GnoWoY56E75mzdQTKba+Po8ualo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789223037; c=relaxed/simple;
	bh=ol1664MreL4ZD744kDlGDiiv4nsc8heXto4YCOF6PSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UarKte0/p7V3Q4QBub3lq2wnUeyoPWwmdejReCP75hIahbzVS5Z0MwV4Bshh7lqoZOrY5BGhwTFARhB63AJ4ESMOnNVPcY2EDFllO/hLttkQ2HY3q/ed9Xgs+6JpUPrcKQNKMzydJXK0YxBhUvHboP4xCAtz/7TKTwhSshaaaqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A3Uk3Mb4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A3Uk3Mb4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A33791F00893;
	Sat, 12 Sep 2026 14:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789223035;
	bh=2mRKmjntnG3QktKP/1aQxnPP3s+HMkLSeMuWg21zqY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A3Uk3Mb4DocSryEJZPZ+BrWQ5LTrVtCopfbR50rKQ1kCgwtjPE/kVLeD0u8BviKY/
	 InQF5IEaqaJRFuyiUif/CSYDGZhn7FJXl9qXWDPHEaZ29ncVANSjRuXqQspJWhPlS8
	 EejBwvJGImGn24vz0p1YhNC089sm0LrHha3BbNeqCT3WvMCdrMsncYQad/xv7FdE45
	 vZjJ2B0xedDWlRaB7ZQWlAbGdRl7Kh4vah2bdoWXVkTv3KEkwpSRoI2n0JynM099Qo
	 4zAVlhWhdcytXuyDJfnTvZ1dIONeKLMiVCozD4uzk4JejcfBtK+jlpLZV4D9D310Fa
	 aKpGJ/oH9p88Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nemesa Garg <nemesa.garg@intel.com>,
	=?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
	Animesh Manna <animesh.manna@intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] drm/i915/display: Clear SEL_FETCH_PLANE_CTL on plane disable
Date: Sat, 12 Sep 2026 10:23:53 -0400
Message-ID: <20260912142353.2927508-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090953-gravel-panama-02e2@gregkh>
References: <2026090953-gravel-panama-02e2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Nemesa Garg <nemesa.garg@intel.com>

[ Upstream commit 7f1172a2ac0d7e50850785e2e65789c8aac8411a ]

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
[ Adjusted context for missing pixel-normalizer code in icl_plane_disable_arm(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/display/intel_cursor.c       | 15 ++++++++++-----
 .../gpu/drm/i915/display/skl_universal_plane.c    | 15 ++++++++++-----
 2 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_cursor.c b/drivers/gpu/drm/i915/display/intel_cursor.c
index aeadb834d3328..104009cf5f412 100644
--- a/drivers/gpu/drm/i915/display/intel_cursor.c
+++ b/drivers/gpu/drm/i915/display/intel_cursor.c
@@ -530,13 +530,18 @@ static int i9xx_check_cursor(struct intel_crtc_state *crtc_state,
 }
 
 static void i9xx_cursor_disable_sel_fetch_arm(struct intel_dsb *dsb,
-					      struct intel_plane *plane,
-					      const struct intel_crtc_state *crtc_state)
+					      struct intel_plane *plane)
 {
 	struct intel_display *display = to_intel_display(plane->base.dev);
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
@@ -588,7 +593,7 @@ static void i9xx_cursor_update_sel_fetch_arm(struct intel_dsb *dsb,
 		if (crtc_state->enable_psr2_su_region_et)
 			wa_16021440873(dsb, plane, crtc_state, plane_state);
 		else
-			i9xx_cursor_disable_sel_fetch_arm(dsb, plane, crtc_state);
+			i9xx_cursor_disable_sel_fetch_arm(dsb, plane);
 	}
 }
 
@@ -699,7 +704,7 @@ static void i9xx_cursor_update_arm(struct intel_dsb *dsb,
 	if (plane_state)
 		i9xx_cursor_update_sel_fetch_arm(dsb, plane, crtc_state, plane_state);
 	else
-		i9xx_cursor_disable_sel_fetch_arm(dsb, plane, crtc_state);
+		i9xx_cursor_disable_sel_fetch_arm(dsb, plane);
 
 	if (plane->cursor.base != base ||
 	    plane->cursor.size != fbc_ctl ||
diff --git a/drivers/gpu/drm/i915/display/skl_universal_plane.c b/drivers/gpu/drm/i915/display/skl_universal_plane.c
index 7f77a76309bd5..52a38d3ada24d 100644
--- a/drivers/gpu/drm/i915/display/skl_universal_plane.c
+++ b/drivers/gpu/drm/i915/display/skl_universal_plane.c
@@ -770,13 +770,18 @@ skl_plane_disable_arm(struct intel_dsb *dsb,
 }
 
 static void icl_plane_disable_sel_fetch_arm(struct intel_dsb *dsb,
-					    struct intel_plane *plane,
-					    const struct intel_crtc_state *crtc_state)
+					    struct intel_plane *plane)
 {
 	struct intel_display *display = to_intel_display(plane->base.dev);
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
@@ -797,7 +802,7 @@ icl_plane_disable_arm(struct intel_dsb *dsb,
 
 	skl_write_plane_wm(dsb, plane, crtc_state);
 
-	icl_plane_disable_sel_fetch_arm(dsb, plane, crtc_state);
+	icl_plane_disable_sel_fetch_arm(dsb, plane);
 	intel_de_write_dsb(display, dsb, PLANE_CTL(pipe, plane_id), 0);
 	intel_de_write_dsb(display, dsb, PLANE_SURF(pipe, plane_id), 0);
 }
@@ -1512,7 +1517,7 @@ static void icl_plane_update_sel_fetch_arm(struct intel_dsb *dsb,
 		intel_de_write_dsb(display, dsb, SEL_FETCH_PLANE_CTL(pipe, plane->id),
 				   SEL_FETCH_PLANE_CTL_ENABLE);
 	else
-		icl_plane_disable_sel_fetch_arm(dsb, plane, crtc_state);
+		icl_plane_disable_sel_fetch_arm(dsb, plane);
 }
 
 static void
-- 
2.53.0

