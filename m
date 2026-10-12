Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BF248EC6A
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 15:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819267; cv=none; b=hdyEvuKNMTGR4ScpkUf5dN6DoVzWiYn2UsoZ8g3X+KSkgLo7TECcbClSbdSstVzWsrXVy728xSlFeWm4NJcVL6qEZd0QPm1X3E5gmeM3TozREwsXnRCtUpJ9ArD7rxcIt4fqN9vLwlulPwLMc5730mGsDkVw42B32Igiy+VpQTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819267; c=relaxed/simple;
	bh=ABzENvp2KHpGb45r1IQ+k1ACPjDyZjzkobDDfHpbZc0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=TtKCBa8D3eHrvyjYvK7LL0POpGtDOO7ZoUisAY/UAj9wuH3sXN16WZ82JUK0lAH0rfEDd85CoY9y4SsRnfYitV50QhywrHncIHcZG0awYr7BhzIGv7aCTMHQavDOIvKWiVsipvX6oEAgOPi8OdmdNyedN+xoH9Eohccbe/QjIlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mEzUuxAs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mEzUuxAs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AE6D1F0089B;
	Mon, 12 Oct 2026 15:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791819265;
	bh=aO4sFCGacN0DZZxb82pyHxP6zMx77A/clXOC9gBwyL0=;
	h=Subject:To:Cc:From:Date;
	b=mEzUuxAsAiq+6FGlPhSNeiuEGR+pKDMMkjx16bsZCLrTz6LrngPejTH+rN6GjzV9T
	 7Q8c0aIzTVQD6nRuLMAd1JA1bs5Sisiy9Gba8Srv1TRbuy2jLTNn1rHHs8yzjuR1Zz
	 TRYCm64cD0AyTizARsBgrUVYBStbNU3cv7e7IMUY=
Subject: FAILED: patch "[PATCH] drm/amd/display: Don't replace a sink mode that shares the" failed to apply to 5.10-stable tree
To: adrian.betschart@cinemaone.ch,alexander.deucher@amd.com,daniel.wheeler@amd.com,roman.li@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Oct 2026 17:34:20 +0200
Message-ID: <2026101220-quiver-actress-7a16@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 54c998c55fc9cbc391b350d67b86e0c2a0748f1a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026101220-quiver-actress-7a16@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 54c998c55fc9cbc391b350d67b86e0c2a0748f1a Mon Sep 17 00:00:00 2001
From: Adrian Betschart <adrian.betschart@cinemaone.ch>
Date: Fri, 25 Sep 2026 09:48:29 +0200
Subject: [PATCH] drm/amd/display: Don't replace a sink mode that shares the
 native totals

decide_crtc_timing_for_drm_display_mode() copies the native mode's CRTC
timing into the requested mode when clock, htotal and vtotal match.
That is meant for the modes amdgpu inserts itself:
amdgpu_dm_create_common_mode() duplicates the native mode and changes
only hdisplay and vdisplay, so those are sent with the native timing
and scaled.

A sink can also offer a real mode with the same clock and totals as
its native mode. CTA-861 VIC 102 (4096x2160@60) and VIC 97
(3840x2160@60) both use 594 MHz and 4400x2250. With 3840x2160@60 as
the preferred mode, a 4096x2160@60 request goes out with the 3840x2160
timing and the framebuffer scaled into it (dst 3840x2025 at y=67),
while the AVI InfoFrame still carries VIC 102. A JVC projector then
reports 3840x2160 and shows a corrupted right edge. 4096x2160@24,
whose totals differ, is sent and displayed correctly.

Inserted modes keep the native sync positions; a real mode with its
own active width does not. Compare those too, so only inserted modes
are patched.

Fixes: 4562236b3bc0 ("drm/amd/dc: Add dc display driver (v2)")
Signed-off-by: Adrian Betschart <adrian.betschart@cinemaone.ch>
Assisted-by: Claude-Code:claude-opus-5-5
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
Reviewed-by: Roman Li <roman.li@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 22f9a2da101c37f821cd00954f81dc598754f4d5)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index d386bb1475bb..45a69bf43971 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -1012,10 +1012,15 @@ decide_crtc_timing_for_drm_display_mode(struct drm_display_mode *drm_mode,
 					const struct drm_display_mode *native_mode,
 					bool scale_enabled)
 {
+	/* Inserted modes copy the native sync; a sink mode with equal totals may not */
 	if (scale_enabled || (
 	    native_mode->clock == drm_mode->clock &&
 	    native_mode->htotal == drm_mode->htotal &&
-	    native_mode->vtotal == drm_mode->vtotal)) {
+	    native_mode->vtotal == drm_mode->vtotal &&
+	    native_mode->hsync_start == drm_mode->hsync_start &&
+	    native_mode->hsync_end == drm_mode->hsync_end &&
+	    native_mode->vsync_start == drm_mode->vsync_start &&
+	    native_mode->vsync_end == drm_mode->vsync_end)) {
 		if (native_mode->crtc_clock)
 			copy_crtc_timing_for_drm_display_mode(native_mode, drm_mode);
 	} else {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index 59ce682f491b..b61771749ca0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -1572,6 +1572,46 @@ static void dm_test_decide_crtc_timing_no_crtc_clock(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, drm_mode.crtc_hdisplay, 0);
 }
 
+static void dm_test_decide_crtc_timing_sink_mode_same_totals(struct kunit *test)
+{
+	struct drm_display_mode native_mode = {
+		DRM_MODE("3840x2160", DRM_MODE_TYPE_DRIVER, 594000, 3840, 4016, 4104,
+			 4400, 0, 2160, 2168, 2178, 2250, 0,
+			 DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC) };
+	struct drm_display_mode drm_mode = {
+		DRM_MODE("4096x2160", DRM_MODE_TYPE_DRIVER, 594000, 4096, 4184, 4272,
+			 4400, 0, 2160, 2168, 2178, 2250, 0,
+			 DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC) };
+
+	drm_mode_set_crtcinfo(&native_mode, 0);
+	drm_mode_set_crtcinfo(&drm_mode, 0);
+
+	decide_crtc_timing_for_drm_display_mode(&drm_mode, &native_mode, false);
+
+	KUNIT_EXPECT_EQ(test, drm_mode.crtc_hdisplay, 4096);
+	KUNIT_EXPECT_EQ(test, drm_mode.crtc_hsync_start, 4184);
+}
+
+static void dm_test_decide_crtc_timing_inserted_mode(struct kunit *test)
+{
+	struct drm_display_mode native_mode = {
+		DRM_MODE("3840x2160", DRM_MODE_TYPE_DRIVER, 594000, 3840, 4016, 4104,
+			 4400, 0, 2160, 2168, 2178, 2250, 0,
+			 DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC) };
+	struct drm_display_mode drm_mode;
+
+	drm_mode_set_crtcinfo(&native_mode, 0);
+	drm_mode = native_mode;
+	drm_mode.hdisplay = 1920;
+	drm_mode.vdisplay = 1080;
+	drm_mode_set_crtcinfo(&drm_mode, 0);
+
+	decide_crtc_timing_for_drm_display_mode(&drm_mode, &native_mode, false);
+
+	KUNIT_EXPECT_EQ(test, drm_mode.crtc_hdisplay, 3840);
+	KUNIT_EXPECT_EQ(test, drm_mode.crtc_vdisplay, 2160);
+}
+
 /* Tests for amdgpu_dm_connector_funcs_reset() */
 
 static const struct drm_connector_funcs dm_test_connector_funcs = {
@@ -5635,6 +5675,8 @@ static struct kunit_case amdgpu_dm_connector_tests[] = {
 	KUNIT_CASE(dm_test_decide_crtc_timing_matching_mode),
 	KUNIT_CASE(dm_test_decide_crtc_timing_no_copy),
 	KUNIT_CASE(dm_test_decide_crtc_timing_no_crtc_clock),
+	KUNIT_CASE(dm_test_decide_crtc_timing_sink_mode_same_totals),
+	KUNIT_CASE(dm_test_decide_crtc_timing_inserted_mode),
 	/* amdgpu_dm_connector_funcs_reset */
 	KUNIT_CASE(dm_test_funcs_reset_sets_defaults),
 	KUNIT_CASE(dm_test_funcs_reset_edp_abm_level),

